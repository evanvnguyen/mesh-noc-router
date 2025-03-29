# Re-running the full VDIVUX GUI script after kernel reset

import random
import tkinter as tk
from tkinter import ttk
from tkinter.scrolledtext import ScrolledText

def generate_chunk_simple(chunk_bits):
    patterns = [0x01, 0x03, 0x0F, 0x55, 0xAA]
    max_val = (1 << chunk_bits) - 1
    return random.choice([p & max_val for p in patterns if p != 0])

def generate_chunk_random(chunk_bits):
    val = 0
    while val == 0:
        val = random.randint(0, (1 << chunk_bits) - 1)
    return val

def generate_test_case(chunk_bits, simple=False):
    num_chunks = 64 // chunk_bits
    gen = generate_chunk_simple if simple else generate_chunk_random
    a_chunks = [gen(chunk_bits) for _ in range(num_chunks)]
    b_chunks = [gen(chunk_bits) for _ in range(num_chunks)]
    return a_chunks, b_chunks

def format_chunks_hex(chunks, chunk_bits):
    hex_len = chunk_bits // 4
    return '[' + ', '.join(f"0x{val:0{hex_len}x}" for val in chunks) + ']'

def format_binary_result(result_val, WW):
    bin_str = f"{result_val:064b}"
    group = {'00': 8, '01': 16, '10': 32, '11': 64}.get(WW, 64)
    return '_'.join([bin_str[i:i+group] for i in range(0, 64, group)])

def format_decimal_chunks(chunks):
    return '_'.join(str(x) for x in chunks)

def format_flat_hex(chunks, chunk_bits):
    val = 0
    for chunk in chunks:
        val = (val << chunk_bits) | chunk
    return f"{val:016x}"

def run_vdivux_for_ww(WW, text_widget, simple=False, verbose=False, verilog_calls=None):
    log = lambda msg: text_widget.insert(tk.END, msg + '\n')

    chunk_bits = {'00': 8, '01': 16, '10': 32, '11': 64}.get(WW)
    if chunk_bits is None:
        return

    a_chunks, b_chunks = generate_test_case(chunk_bits, simple=simple)
    log(f"\nWW = {WW} (chunk size = {chunk_bits} bits)")
    log(f"Register A: {format_chunks_hex(a_chunks, chunk_bits)}")
    log(f"Register B: {format_chunks_hex(b_chunks, chunk_bits)}")

    result_chunks = [(a_chunks[i] // b_chunks[i]) & ((1 << chunk_bits) - 1) for i in range(len(a_chunks))]

    result_val = 0
    for chunk in result_chunks:
        result_val = (result_val << chunk_bits) | chunk

    log(f"Final 64-bit result: 0x{result_val:016x}")

    if verbose:
        log("Verbose Bit Breakdown:")
        log("Register A: " + '_'.join(f"{val:0{chunk_bits}b}" for val in a_chunks))
        log("Register B: " + '_'.join(f"{val:0{chunk_bits}b}" for val in b_chunks))
        log("Result    : " + format_binary_result(result_val, WW))
        log("Register A (dec): " + format_decimal_chunks(a_chunks))
        log("Register B (dec): " + format_decimal_chunks(b_chunks))
        log("Result    (dec): " + format_decimal_chunks(result_chunks))

    if verilog_calls is not None:
        ww_comment = {
            '00': "// WW = 00 → 8b chunks, result = 8b chunks",
            '01': "// WW = 01 → 16b chunks, result = 16b chunks",
            '10': "// WW = 10 → 32b chunks, result = 32b chunks",
            '11': "// WW = 11 → 64b chunk, result = 64b chunk"
        }[WW]

        reg_a_hex = format_flat_hex(a_chunks, chunk_bits)
        reg_b_hex = format_flat_hex(b_chunks, chunk_bits)
        result_hex = f"{result_val:016x}"
        verilog_calls.append((ww_comment, f"execute_vdivux(\n"
                                          f"    64'h{reg_a_hex},\n"
                                          f"    64'h{reg_b_hex},\n"
                                          f"    64'h{result_hex},\n"
                                          f"    2'b{WW}\n);"))

def run_all_ww(text_widget, simple=False, verbose=False, generate_verilog=False):
    text_widget.delete(1.0, tk.END)
    verilog_calls = []

    for ww in ['00', '01', '10', '11']:
        run_vdivux_for_ww(ww, text_widget, simple=simple, verbose=verbose, verilog_calls=verilog_calls if generate_verilog else None)

    if generate_verilog and verilog_calls:
        text_widget.insert(tk.END, "\n// All Verilog Task Calls:\n")
        for comment, call in verilog_calls:
            text_widget.insert(tk.END, f"{comment}\n{call}\n\n")

# ==== GUI ====
root = tk.Tk()
root.title("VDIVUX Visualizer")

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
