import random
import tkinter as tk
from tkinter import ttk
from tkinter.scrolledtext import ScrolledText

# -------------------------------
# Test case generation helpers
# -------------------------------
def generate_chunk_simple(chunk_bits):
    patterns = [0x01, 0x03, 0x0F, 0x55, 0xAA]
    max_val = (1 << chunk_bits) - 1
    return random.choice([p & max_val for p in patterns])

def generate_chunk_random(chunk_bits):
    return random.randint(0, (1 << chunk_bits) - 1)

def generate_test_case(chunk_bits, shift_bits, simple=False):
    num_chunks = 64 // chunk_bits
    gen = generate_chunk_simple if simple else generate_chunk_random
    a_chunks = [gen(chunk_bits) for _ in range(num_chunks)]
    # For shift amounts, generate numbers in the valid range [0, (1<<shift_bits)-1]
    b_chunks = [random.randint(0, (1 << shift_bits) - 1) for _ in range(num_chunks)]
    return a_chunks, b_chunks

# -------------------------------
# Formatting utilities
# -------------------------------
def format_chunks_hex(chunks, chunk_bits):
    hex_len = (chunk_bits + 3) // 4
    return '[' + ', '.join(f"0x{val:0{hex_len}x}" for val in chunks) + ']'

def annotate_register_chunks(chunks, chunk_bits):
    return '_'.join(f"{chunk:0{chunk_bits}b}" for chunk in chunks)

def annotate_decimal_chunks(chunks):
    return '_'.join(str(x) for x in chunks)

def format_flat_hex(chunks, chunk_bits):
    val = 0
    for chunk in chunks:
        val = (val << chunk_bits) | chunk
    return f"{val:0{64//4}x}"

def annotate_result_chunks_grouped(result_val, group_bits):
    bin_str = f"{result_val:064b}"
    groups = [bin_str[i:i+group_bits] for i in range(0, 64, group_bits)]
    return '_'.join(groups)

# -------------------------------
# Helper: Arithmetic Right Shift (SRA)
# -------------------------------
def sra(value, shift, width):
    mask = (1 << width) - 1
    value = value & mask
    sign_bit = 1 << (width - 1)
    if value & sign_bit:
        value = value - (1 << width)
    result = value >> shift
    return result & mask

# -------------------------------
# Build expected 64-bit result for VSRA
# -------------------------------
def build_64bit_result_vsra(WW, a_chunks, b_chunks):
    if WW == '00':
        # 8-bit fields: process 8 fields, field 0 is MSB, field 7 is LSB.
        result_val = 0
        result_chunks = []
        for i in range(8):
            res = sra(a_chunks[i], b_chunks[i], 8)
            result_chunks.append(res)
            result_val |= (res << (56 - i * 8))
        return result_val, result_chunks

    elif WW == '01':
        # 16-bit fields: process 4 fields.
        result_val = 0
        result_chunks = []
        for i in range(4):
            res = sra(a_chunks[i], b_chunks[i], 16)
            result_chunks.append(res)
            result_val |= (res << (48 - i * 16))
        return result_val, result_chunks

    elif WW == '10':
        # 32-bit fields: process 2 fields.
        res0 = sra(a_chunks[0], b_chunks[0], 32)
        res1 = sra(a_chunks[1], b_chunks[1], 32)
        result_val = (res0 << 32) | res1
        return result_val, [res0, res1]

    elif WW == '11':
        # 64-bit field: assume a_chunks is a one-element list.
        a_val = a_chunks[0] if len(a_chunks) == 1 else 0
        b_val = b_chunks[0] if len(b_chunks) == 1 else 0
        result_val = sra(a_val, b_val, 64)
        return result_val, [result_val]
    else:
        return 0, []

# -------------------------------
# Run VSRA for a given width setting
# -------------------------------
def run_vsra_for_ww(WW, text_widget, simple=False, verbose=False, verilog_calls=None):
    log = lambda msg: text_widget.insert(tk.END, msg + '\n')

    # Determine chunk and shift bits per width
    if WW == '00':
        chunk_bits = 8; shift_bits = 3
    elif WW == '01':
        chunk_bits = 16; shift_bits = 4
    elif WW == '10':
        chunk_bits = 32; shift_bits = 5
    elif WW == '11':
        chunk_bits = 64; shift_bits = 6
    else:
        return

    a_chunks, b_chunks = generate_test_case(chunk_bits, shift_bits, simple=simple)
    log(f"\nWW = {WW} (chunk size = {chunk_bits} bits, shift field = {shift_bits} bits)")
    log(f"Register A: {format_chunks_hex(a_chunks, chunk_bits)}")
    log(f"Register B (shift amounts): {format_chunks_hex(b_chunks, shift_bits)}")
    
    result_val, result_chunks = build_64bit_result_vsra(WW, a_chunks, b_chunks)
    log(f"Final 64-bit result: 0x{result_val:016x}")
    
    if verbose:
        log("Verbose Bit Breakdown:")
        log("Register A: " + annotate_register_chunks(a_chunks, chunk_bits))
        log("Result    : " + annotate_result_chunks_grouped(result_val, chunk_bits))
        log("Register A (dec): " + annotate_decimal_chunks(a_chunks))
        log("Result    (dec): " + annotate_decimal_chunks(result_chunks))
    
    if verilog_calls is not None:
        ww_comment = {
            '00': "// WW = 00 → 8-bit fields, arithmetic shift right",
            '01': "// WW = 01 → 16-bit fields, arithmetic shift right",
            '10': "// WW = 10 → 32-bit fields, arithmetic shift right",
            '11': "// WW = 11 → 64-bit field, arithmetic shift right"
        }[WW]
        reg_a_hex = format_flat_hex(a_chunks, chunk_bits)
        reg_b_hex = format_flat_hex(b_chunks, shift_bits)
        result_hex = f"{result_val:016x}"
        verilog_calls.append((ww_comment, f"execute_vsra(\n"
                                          f"    64'h{reg_a_hex},\n"
                                          f"    64'h{reg_b_hex},\n"
                                          f"    64'h{result_hex},\n"
                                          f"    2'b{WW}\n);"))

# -------------------------------
# Run all width modes
# -------------------------------
def run_all_ww(text_widget, simple=False, verbose=False, generate_verilog=False):
    text_widget.delete(1.0, tk.END)
    verilog_calls = []
    for ww in ['00', '01', '10', '11']:
        run_vsra_for_ww(ww, text_widget, simple=simple, verbose=verbose,
                        verilog_calls=verilog_calls if generate_verilog else None)
    if generate_verilog and verilog_calls:
        text_widget.insert(tk.END, "\n// All Verilog Task Calls:\n")
        for comment, call in verilog_calls:
            text_widget.insert(tk.END, f"{comment}\n{call}\n\n")

# -------------------------------
# GUI
# -------------------------------
root = tk.Tk()
root.title("VSRA Visualizer")

frame = ttk.Frame(root, padding=10)
frame.pack(fill=tk.BOTH, expand=True)

controls = ttk.Frame(frame)
controls.pack(pady=5)

verbose_var = tk.BooleanVar()
verilog_var = tk.BooleanVar()

verbose_check = ttk.Checkbutton(controls, text="Verbose Output", variable=verbose_var)
verbose_check.grid(row=0, column=0, padx=10)

verilog_check = ttk.Checkbutton(controls, text="Generate Verilog", variable=verilog_var)
verilog_check.grid(row=0, column=1, padx=10)

simple_btn = ttk.Button(controls, text="Generate Simple", 
                        command=lambda: run_all_ww(output_box, simple=True, verbose=verbose_var.get(), generate_verilog=verilog_var.get()))
simple_btn.grid(row=0, column=2, padx=5)

random_btn = ttk.Button(controls, text="Generate Random", 
                        command=lambda: run_all_ww(output_box, simple=False, verbose=verbose_var.get(), generate_verilog=verilog_var.get()))
random_btn.grid(row=0, column=3, padx=5)

output_box = ScrolledText(frame, wrap=tk.WORD, height=30, width=120, font=("Courier", 10))
output_box.pack(fill=tk.BOTH, expand=True)

root.mainloop()
