import random
import tkinter as tk
from tkinter import ttk
from tkinter.scrolledtext import ScrolledText

def generate_chunk_simple(chunk_bits):
    patterns = [0x01, 0x03, 0x0F, 0x55, 0xAA]
    max_val = (1 << chunk_bits) - 1
    return random.choice([p & max_val for p in patterns])

def generate_test_case(chunk_bits, simple=False):
    num_chunks = 64 // chunk_bits
    gen = generate_chunk_simple if simple else lambda b: random.randint(0, (1 << b) - 1)
    a_chunks = [gen(chunk_bits) for _ in range(num_chunks)]
    b_chunks = [gen(chunk_bits) for _ in range(num_chunks)]
    return a_chunks, b_chunks

def format_chunks_hex(chunks, chunk_bits):
    hex_len = chunk_bits // 4
    return '[' + ', '.join(f"0x{val:0{hex_len}x}" for val in chunks) + ']'

def format_binary_64(chunks, chunk_bits):
    full_val = 0
    for chunk in chunks:
        full_val = (full_val << chunk_bits) | chunk
    bin_str = f"{full_val:064b}"
    if chunk_bits == 8:
        group = 8
    elif chunk_bits == 16:
        group = 16
    elif chunk_bits == 32:
        group = 32
    else:
        return bin_str
    return '_'.join([bin_str[i:i+group] for i in range(0, 64, group)])

def format_binary_result(result_val, WW):
    bin_str = f"{result_val:064b}"
    if WW == '00':
        group = 16
    elif WW == '01':
        group = 32
    elif WW == '10':
        return bin_str
    else:
        return bin_str
    return '_'.join([bin_str[i:i+group] for i in range(0, 64, group)])

def annotate_register_chunks(chunks, chunk_bits):
    annotated_chunks = []
    for i, chunk in enumerate(chunks):
        bin_chunk = f"{chunk:0{chunk_bits}b}"
        if i % 2 == 0:
            annotated_chunks.append(f"({bin_chunk})")
        else:
            annotated_chunks.append(bin_chunk)
    return '_'.join(annotated_chunks)

def format_flat_hex(chunks, chunk_bits):
    full_val = 0
    for chunk in chunks:
        full_val = (full_val << chunk_bits) | chunk
    return f"{full_val:016x}"

def run_vmuleu_for_ww(WW, text_widget, simple=False, verbose=False, generate_verilog=False):
    log = lambda msg: text_widget.insert(tk.END, msg + '\n')

    if WW == '00': chunk_bits = 8
    elif WW == '01': chunk_bits = 16
    elif WW == '10': chunk_bits = 32
    else:
        return

    a_chunks, b_chunks = generate_test_case(chunk_bits, simple=simple)
    log(f"\nWW = {WW} (chunk size = {chunk_bits} bits)")
    log(f"Register A: {format_chunks_hex(a_chunks, chunk_bits)}")
    log(f"Register B: {format_chunks_hex(b_chunks, chunk_bits)}")

    result_val = 0
    if WW == '00':
        result_chunks = []
        for i in range(len(a_chunks)):
            if i % 2 == 0:
                product = (a_chunks[i] * b_chunks[i]) & 0xFFFF
            else:
                product = 0
            result_chunks.append(product)
        for i, val in enumerate(result_chunks):
            shift = (len(result_chunks) - 1 - i) * 16
            result_val |= (val << shift)

    elif WW == '01':
        result_chunks = []
        for i in range(0, len(a_chunks), 2):
            product = (a_chunks[i] * b_chunks[i]) & 0xFFFFFFFF
            result_chunks.append(product)
        result_val = (result_chunks[0] << 32) | result_chunks[1]

    elif WW == '10':
        result_val = (a_chunks[0] * b_chunks[0]) & 0xFFFFFFFFFFFFFFFF

    log(f"Final 64-bit result: 0x{result_val:016x}")

    if verbose:
        log("Verbose Bit Breakdown:")
        log("Register A: " + annotate_register_chunks(a_chunks, chunk_bits))
        log("Register B: " + annotate_register_chunks(b_chunks, chunk_bits))
        log("Result    : " + format_binary_result(result_val, WW))

        if WW == '00':
            result_chunks = [(result_val >> (16 * (len(a_chunks) - 1 - i))) & 0xFFFF for i in range(len(a_chunks))]
        elif WW == '01':
            result_chunks = [(result_val >> 32) & 0xFFFFFFFF, result_val & 0xFFFFFFFF]
        elif WW == '10':
            result_chunks = [result_val]
        else:
            result_chunks = []

        log("Register A (dec): " + '_'.join(str(x) for x in a_chunks))
        log("Register B (dec): " + '_'.join(str(x) for x in b_chunks))
        log("Result    (dec): " + '_'.join(str(x) for x in result_chunks))

        if generate_verilog:
            reg_a_hex = format_flat_hex(a_chunks, chunk_bits)
            reg_b_hex = format_flat_hex(b_chunks, chunk_bits)
            result_hex = f"{result_val:016x}"
            log("\n// Verilog Task Call")
            log(f"execute_vmuleu(")
            log(f"    64'h{reg_a_hex},")
            log(f"    64'h{reg_b_hex},")
            log(f"    64'h{result_hex},")
            log(f"    2'b{WW}")
            log(");")

def run_all_ww(text_widget, simple=False, verbose=False, generate_verilog=False):
    text_widget.delete(1.0, tk.END)
    for ww in ['00', '01', '10']:
        run_vmuleu_for_ww(ww, text_widget, simple=simple, verbose=verbose, generate_verilog=generate_verilog)

# ==== GUI ====
root = tk.Tk()
root.title("VMULEU Visualizer")

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

simple_btn = ttk.Button(controls, text="Generate Simple", command=lambda: run_all_ww(
    output_box, simple=True, verbose=verbose_var.get(), generate_verilog=verilog_var.get()))
simple_btn.grid(row=0, column=2, padx=5)

random_btn = ttk.Button(controls, text="Generate Random", command=lambda: run_all_ww(
    output_box, simple=False, verbose=verbose_var.get(), generate_verilog=verilog_var.get()))
random_btn.grid(row=0, column=3, padx=5)

output_box = ScrolledText(frame, wrap=tk.WORD, height=30, width=120, font=("Courier", 10))
output_box.pack(fill=tk.BOTH, expand=True)

root.mainloop()
