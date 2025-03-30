import random
import tkinter as tk
from tkinter import ttk
from tkinter.scrolledtext import ScrolledText
from tabulate import tabulate

def generate_chunk_simple(chunk_bits):
    patterns = [0, 1, 3, 7, 15, 0x55, 0xAA]
    max_val = (1 << chunk_bits) - 1
    return random.choice([p & max_val for p in patterns])

def generate_random_chunk(chunk_bits):
    return random.randint(0, (1 << chunk_bits) - 1)

def generate_test_case(chunk_bits, simple=False):
    num_chunks = 64 // chunk_bits
    gen = generate_chunk_simple if simple else generate_random_chunk
    a_chunks = [gen(chunk_bits) for _ in range(num_chunks)]
    b_chunks = [gen(chunk_bits) for _ in range(num_chunks)]
    return a_chunks, b_chunks

def highlight_bits(bin_str, shift_len):
    prefix = bin_str[:-shift_len]
    highlight = bin_str[-shift_len:]
    return f"{prefix}[{highlight}]"

def explain_shift_extraction(b_chunks, chunk_bits, log_func):
    shift_vals = []
    if chunk_bits == 8: shift_len = 3
    elif chunk_bits == 16: shift_len = 4
    elif chunk_bits == 32: shift_len = 5
    elif chunk_bits == 64: shift_len = 6
    else: raise ValueError("Unsupported chunk width")

    log_func(f"\nShift extraction breakdown (B chunks):")
    log_func(f"Using last {shift_len} bits of each {chunk_bits}-bit chunk:")

    for i, chunk in enumerate(b_chunks):
        bin_str = f"{chunk:0{chunk_bits}b}"
        shift_bits = bin_str[-shift_len:]
        shift_val = int(shift_bits, 2)
        visual = highlight_bits(bin_str, shift_len)
        log_func(f"Chunk {i}: 0x{chunk:0{chunk_bits // 4}x} → {visual} → shift = {shift_val}")
        shift_vals.append(shift_val)

    return shift_vals

def shift_chunks(a_chunks, shift_vals, chunk_bits, disregard_bounds=False):
    mask = (1 << chunk_bits) - 1

    if disregard_bounds:
        # Combine all chunks into one 64-bit value (flattened view)
        full_result = 0
        for a, s in zip(a_chunks, shift_vals):
            full_result = (full_result << chunk_bits) | ((a << s) & mask)
        return [(full_result >> ((len(a_chunks) - 1 - i) * chunk_bits)) & mask for i in range(len(a_chunks))]
    else:
        # Respect chunk bounds — shift individually and apply mask
        return [(a << s) & mask for a, s in zip(a_chunks, shift_vals)]

def format_chunks_to_hex64(chunks, chunk_bits):
    hex_chunk_len = chunk_bits // 4
    return "64'bh" + '_'.join(f"{chunk:0{hex_chunk_len}x}" for chunk in chunks)

def format_chunks_inline(chunks, chunk_bits):
    return '[' + ', '.join(f"0x{chunk:0{chunk_bits // 4}x}" for chunk in chunks) + ']'

def format_binary_64(chunks, chunk_bits):
    full_val = 0
    for chunk in chunks:
        full_val = (full_val << chunk_bits) | chunk
    bin_str = f"{full_val:064b}"

    # Determine grouping based on chunk size
    if chunk_bits == 8:
        group = 8
    elif chunk_bits == 16:
        group = 16
    elif chunk_bits == 32:
        group = 32
    else:
        return bin_str  # WW = 11, no underscores

    return '_'.join([bin_str[i:i+group] for i in range(0, 64, group)])


def shift_registers_verbose(WW, summary_rows, log_func, simple=False, show_binary=False, generate_verilog=False, verilog_calls=None, disregard_bounds=False):
    if WW == '00': chunk_bits = 8
    elif WW == '01': chunk_bits = 16
    elif WW == '10': chunk_bits = 32
    elif WW == '11': chunk_bits = 64
    else: raise ValueError("Unsupported WW value")

    log_func(f"\nWW = {WW} (chunk size = {chunk_bits} bits)")
    a_chunks, b_chunks = generate_test_case(chunk_bits, simple=simple)
    reg_a = format_chunks_to_hex64(a_chunks, chunk_bits)
    reg_b = format_chunks_to_hex64(b_chunks, chunk_bits)

    log_func(f"register A = {reg_a}")
    log_func(f"register B = {reg_b}")

    shift_vals = explain_shift_extraction(b_chunks, chunk_bits, log_func)
    result_chunks = shift_chunks(a_chunks, shift_vals, chunk_bits, disregard_bounds=disregard_bounds)
    result = format_chunks_to_hex64(result_chunks, chunk_bits)

    log_func(f"\nParsed A chunks : {format_chunks_inline(a_chunks, chunk_bits)}")
    log_func(f"Parsed B chunks : {format_chunks_inline(b_chunks, chunk_bits)}")
    log_func(f"Shifted A chunks: {format_chunks_inline(result_chunks, chunk_bits)}")
    log_func(f"Final result     : {result}")

    if show_binary:
        log_func("\nBinary breakdown (64 bits, _ every 16 bits):")
        log_func(f"Register A (bin): {format_binary_64(a_chunks, chunk_bits)}")
        log_func(f"Register B (bin): {format_binary_64(b_chunks, chunk_bits)}")
        log_func(f"Result     (bin): {format_binary_64(result_chunks, chunk_bits)}")

    if generate_verilog and verilog_calls is not None:
        def to_flat_hex(chunks):
            val = 0
            for chunk in chunks:
                val = (val << chunk_bits) | chunk
            return f"{val:016x}"

        reg_a_flat = to_flat_hex(a_chunks)
        reg_b_flat = to_flat_hex(b_chunks)
        result_flat = to_flat_hex(result_chunks)

        task_call = (
            "execute_vsll(\n"
            f"    64'h{reg_a_flat}, // regA\n"
            f"    64'h{reg_b_flat}, // regB\n"
            f"    64'h{result_flat}, // expected\n"
            f"    2'b{WW}\n"
            ");"
        )
        verilog_calls.append((WW, task_call))

    log_func("-" * 60)

    summary_rows.append([
        WW, reg_a, reg_b, str(shift_vals), result
    ])

def run_all_tests(text_widget, simple=False, show_binary=False, generate_verilog=False, disregard_bounds=False):
    text_widget.delete(1.0, tk.END)
    summary = []
    verilog_calls = []

    def log(msg):
        text_widget.insert(tk.END, msg + "\n")
        text_widget.see(tk.END)

    for ww in ['00', '01', '10', '11']:
        shift_registers_verbose(
            ww, summary, log,
            simple=simple,
            show_binary=show_binary,
            generate_verilog=generate_verilog,
            verilog_calls=verilog_calls,
            disregard_bounds=disregard_bounds
        )

    headers = ["WW", "Register A", "Register B", "Shift Values", "Expected Output"]
    table = tabulate(summary, headers=headers, tablefmt="grid")
    log("\nSUMMARY TABLE:")
    log(table)

    if generate_verilog:
        log("\nVERILOG TASK CALLS:")
        ww_comments = {
            '00': '3 bit source shift',
            '01': '4 bit source shift',
            '10': '5 bit source shift',
            '11': '6 bit source shift'
        }
        current_ww = None
        for ww, task in verilog_calls:
            if ww != current_ww:
                log(f"// WW = {ww}, {ww_comments[ww]}\n")
                current_ww = ww
            log(task + "\n")

# === GUI Setup ===
root = tk.Tk()
root.title("Variable Shift Left Test Generator")

frame = ttk.Frame(root, padding=10)
frame.pack(fill=tk.BOTH, expand=True)

# Controls
button_frame = ttk.Frame(frame)
button_frame.pack()

verbose_var = tk.BooleanVar()
verilog_var = tk.BooleanVar()
chunk_bound_var = tk.BooleanVar(value=False)

simple_btn = ttk.Button(button_frame, text="Generate Simple", command=lambda: run_all_tests(
    output_box,
    simple=True,
    show_binary=verbose_var.get(),
    generate_verilog=verilog_var.get(),
    disregard_bounds=chunk_bound_var.get()
))
simple_btn.grid(row=0, column=0, padx=5, pady=5)

random_btn = ttk.Button(button_frame, text="Generate Random", command=lambda: run_all_tests(
    output_box,
    simple=False,
    show_binary=verbose_var.get(),
    generate_verilog=verilog_var.get(),
    disregard_bounds=chunk_bound_var.get()
))
random_btn.grid(row=0, column=1, padx=5, pady=5)

verbose_check = ttk.Checkbutton(button_frame, text="Generate Verbose", variable=verbose_var)
verbose_check.grid(row=0, column=2, padx=10, pady=5)

verilog_check = ttk.Checkbutton(button_frame, text="Generate Verilog", variable=verilog_var)
verilog_check.grid(row=0, column=3, padx=10, pady=5)

chunk_bound_check = ttk.Checkbutton(button_frame, text="Disregard Chunk Bounds (Not recommended)", variable=chunk_bound_var)
chunk_bound_check.grid(row=0, column=4, padx=10, pady=5)

# Output box
output_box = ScrolledText(frame, wrap=tk.WORD, height=30, width=120, font=("Courier", 10))
output_box.pack(fill=tk.BOTH, expand=True)

root.mainloop()
