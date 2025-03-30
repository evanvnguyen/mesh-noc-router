import tkinter as tk
from tkinter import ttk
from tkinter.scrolledtext import ScrolledText
import random

def simulate_dw_div_unsigned(regA: int, regB: int, chunk_bits: int):
    max_val = (1 << chunk_bits) - 1
    regA &= max_val
    regB &= max_val
    if regB == 0:
        return 0, 0
    return regA // regB, regA % regB


def chunk_and_divide(regA: int, regB: int, chunk_bits: int):
    num_chunks = 64 // chunk_bits
    quot_chunks, rem_chunks = [], []

    for i in range(num_chunks):
        shift = (num_chunks - 1 - i) * chunk_bits
        a_chunk = (regA >> shift) & ((1 << chunk_bits) - 1)
        b_chunk = (regB >> shift) & ((1 << chunk_bits) - 1)
        q, r = simulate_dw_div_unsigned(a_chunk, b_chunk, chunk_bits)
        quot_chunks.append(q)
        rem_chunks.append(r)

    quotient, remainder = 0, 0
    for q in quot_chunks:
        quotient = (quotient << chunk_bits) | q
    for r in rem_chunks:
        remainder = (remainder << chunk_bits) | r

    return quotient, remainder


def generate_random_inputs(chunk_bits):
    num_chunks = 64 // chunk_bits
    regA = 0
    regB = 0
    for _ in range(num_chunks):
        a = random.randint(0, (1 << chunk_bits) - 1)
        b = random.randint(1, (1 << chunk_bits) - 1)  # avoid zero
        regA = (regA << chunk_bits) | a
        regB = (regB << chunk_bits) | b
    return regA, regB


def format_hex_with_underscores(val):
    hex_str = f"{val:016X}"
    return '_'.join(hex_str[i:i+2] for i in range(0, 16, 2))


def run_random_division():
    output_box.delete(1.0, tk.END)
    verilog_snippets_div = []
    verilog_snippets_mod = []

    for width in ["00", "01", "10", "11"]:
        chunk_bits = {"00": 8, "01": 16, "10": 32, "11": 64}[width]
        regA, regB = generate_random_inputs(chunk_bits)
        quotient, remainder = chunk_and_divide(regA, regB, chunk_bits)

        output_box.insert(tk.END, f"WW = {width}\n")
        output_box.insert(tk.END, f"regA     = 0x{regA:016X}\n")
        output_box.insert(tk.END, f"regB     = 0x{regB:016X}\n")
        output_box.insert(tk.END, f"Quotient = 0x{quotient:016X}\n")
        output_box.insert(tk.END, f"Remainder= 0x{remainder:016X}\n\n")

        verilog_snippets_div.append(
            f"    execute_vdiv(\n"
            f"        64'h{format_hex_with_underscores(regA)},\n"
            f"        64'h{format_hex_with_underscores(regB)},\n"
            f"        64'h{format_hex_with_underscores(quotient)},\n"
            f"        2'b{width}\n"
            f"    );\n"
        )

        verilog_snippets_mod.append(
            f"    execute_vmod(\n"
            f"        64'h{format_hex_with_underscores(regA)},\n"
            f"        64'h{format_hex_with_underscores(regB)},\n"
            f"        64'h{format_hex_with_underscores(remainder)},\n"
            f"        2'b{width}\n"
            f"    );\n"
        )

    output_box.insert(tk.END, "================ Verilog VDIV Test Cases ================\n")
    for snippet in verilog_snippets_div:
        output_box.insert(tk.END, snippet + "\n")

    output_box.insert(tk.END, "================ Verilog VMOD Test Cases ================\n")
    for snippet in verilog_snippets_mod:
        output_box.insert(tk.END, snippet + "\n")


root = tk.Tk()
root.title("VDIV / VMOD Random Test Generator")

frame = ttk.Frame(root, padding=10)
frame.pack(fill=tk.BOTH, expand=True)

run_button = ttk.Button(frame, text="Generate Random VDIV/VMOD Tests", command=run_random_division)
run_button.pack(pady=10)

output_box = ScrolledText(frame, wrap=tk.WORD, width=70, height=30, font=("Courier", 10))
output_box.pack(fill=tk.BOTH, expand=True)

root.mainloop()