# Combined Packet Generator with Instruction Attachment (with Shared File IPC)
import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import random
import subprocess
import sys
import os

INSTR_FILE = "instruction_data.txt"

# --- Packet Builder Logic ---
def make_packet(vc, ns_dir, ew_dir, y_hop, x_hop, y_src, x_src, data):
    packet = (
        (vc     << 63) |
        (ns_dir << 62) |
        (ew_dir << 61) |
        (y_hop  << 52) |
        (x_hop  << 48) |
        (y_src  << 40) |
        (x_src  << 32) |
        data
    )
    return packet

# --- GUI ---
root = tk.Tk()
root.title("Packet Builder")

fields = ["vc", "y_hop", "x_hop", "y_src", "x_src", "data"]
entries = {}
for i, name in enumerate(fields):
    tk.Label(root, text=name).grid(row=i, column=0, sticky="e")
    ent = tk.Entry(root, width=10)
    ent.grid(row=i, column=1)
    entries[name] = ent

hex_output = tk.StringVar()
tk.Entry(root, textvariable=hex_output, state='readonly', width=30).grid(row=8, column=0, columnspan=4, pady=5)

output_listbox = tk.Listbox(root, width=60, height=8)
output_listbox.grid(row=9, column=0, columnspan=4)


def generate_packet():
    try:
        vc = int(entries['vc'].get(), 0)
        y_hop = int(entries['y_hop'].get(), 0)
        x_hop = int(entries['x_hop'].get(), 0)
        y_src = int(entries['y_src'].get(), 0)
        x_src = int(entries['x_src'].get(), 0)
        data = int(entries['data'].get(), 0)

        # dummy directions for demo
        ns_dir, ew_dir = 0, 1

        packet = make_packet(vc, ns_dir, ew_dir, y_hop, x_hop, y_src, x_src, data)
        hex_str = f"{packet:016X}"
        hex_output.set(hex_str)
        output_listbox.insert(tk.END, f"{hex_str} | Src=({y_src},{x_src})")

    except Exception as e:
        messagebox.showerror("Error", str(e))


def attach_instruction():
    try:
        # Remove old file
        if os.path.exists(INSTR_FILE):
            os.remove(INSTR_FILE)

        # Open instruction generator
        subprocess.Popen([sys.executable, "instruction_generator.py"])

        # Polling check for file
        root.after(500, poll_for_instruction)

    except Exception as e:
        messagebox.showerror("Error launching instruction generator", str(e))


def poll_for_instruction():
    if os.path.exists(INSTR_FILE):
        try:
            with open(INSTR_FILE, 'r') as f:
                hex_val = f.read().strip()
                data = int(hex_val, 16)
                entries['data'].delete(0, tk.END)
                entries['data'].insert(0, str(data))
                messagebox.showinfo("Instruction Attached", f"Instruction loaded into data: 0x{hex_val.upper()}")
        except Exception as e:
            messagebox.showerror("Error reading instruction", str(e))
    else:
        root.after(500, poll_for_instruction)


# --- Buttons ---
tk.Button(root, text="Generate Packet", command=generate_packet).grid(row=7, column=0, columnspan=2, pady=5)
tk.Button(root, text="Attach Instruction", command=attach_instruction).grid(row=7, column=2, columnspan=2, pady=5)

root.mainloop()