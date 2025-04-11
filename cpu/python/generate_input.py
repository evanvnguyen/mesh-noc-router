import tkinter as tk
from tkinter import messagebox, filedialog
import random
import subprocess
import sys
import os

INSTR_FILE = "instruction_data.txt"

root = tk.Tk()
root.title("64-bit Packet Builder")

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

def make_packet(vc, ns_dir, ew_dir, y_hop, x_hop, y_src, x_src, data):
    packet = (
        (vc     << 63) |
        (ns_dir << 62) |
        (ew_dir << 61) |
        (0      << 56) |
        (y_hop  << 52) |
        (x_hop  << 48) |
        (y_src  << 40) |
        (x_src  << 32) |
        data
    )
    return packet

def regenerate_data():
    random_val = random.randint(0, 2**32 - 1)
    entries['data'].delete(0, tk.END)
    entries['data'].insert(0, str(random_val))

def clear_packets():
    packet_listbox.delete(0, tk.END)

def save_to_file():
    file_path = filedialog.asksaveasfilename(defaultextension=".txt")
    if file_path:
        with open(file_path, 'w') as f:
            f.write("Packet Hex | Source | Destination\n")
            for i in range(packet_listbox.size()):
                f.write(f"{packet_listbox.get(i)}\n")

def on_button_click(row, col, is_source):
    global source, dest
    if is_source:
        source = (row, col)
        for btn in source_buttons.values(): btn.config(bg="SystemButtonFace")
        source_buttons[(row, col)].config(bg="lightblue")
        source_label.config(text=f"Source: ({row},{col})")
    else:
        dest = (row, col)
        for btn in dest_buttons.values(): btn.config(bg="SystemButtonFace")
        dest_buttons[(row, col)].config(bg="lightgreen")
        dest_label.config(text=f"Dest: ({row},{col})")
    update_hops_and_dirs()

def update_hops_and_dirs():
    if source and dest:
        sy, sx = source
        dy, dx = dest
        entries['y_src'].delete(0, tk.END)
        entries['y_src'].insert(0, sy)
        entries['x_src'].delete(0, tk.END)
        entries['x_src'].insert(0, sx)
        entries['y_hop'].delete(0, tk.END)
        entries['y_hop'].insert(0, 0 if abs(dy - sy) == 0 else 1 << abs(dy - sy))
        entries['x_hop'].delete(0, tk.END)
        entries['x_hop'].insert(0, 0 if abs(dx - sx) == 0 else 1 << abs(dx - sx))
        ns_dir = int(dy < sy)
        ew_dir = int(dx > sx)
        for k, v in dir_options.items():
            if v == (ns_dir, ew_dir):
                dir_var.set(k)

def generate_packet():
    if auto_data.get():
        regenerate_data()
    try:
        if source:
          sy, sx = source
          entries['y_src'].delete(0, tk.END)
          entries['y_src'].insert(0, sy)
          entries['x_src'].delete(0, tk.END)
          entries['x_src'].insert(0, sx)
            
        vc = int(entries['vc'].get(), 0)
        y_hop = int(entries['y_hop'].get(), 0)
        x_hop = int(entries['x_hop'].get(), 0)
        y_src = sy
        x_src = sx
        data = int(entries['data'].get(), 0)
        ns_dir, ew_dir = dir_options[dir_var.get()]
        packet = make_packet(vc, ns_dir, ew_dir, y_hop, x_hop, y_src, x_src, data)
        hex_value = f"{packet:016X}"
        hex_output.set(hex_value)
        packet_listbox.insert(tk.END, f"{hex_value}, {source}, {dest}")
        bitfield_output.set(
            f"VC: {vc}\n"
            f"NS Dir (62): {ns_dir}  |  EW Dir (61): {ew_dir}\n"
            f"Y-Hop (55-52): {y_hop:04b}  |  X-Hop (51-48): {x_hop:04b}\n"
            f"Y-Source (47-40): {y_src:08b}  |  X-Source (39-32): {x_src:08b}\n"
            f"Data (31-0): {data:032b}"
        )
    except Exception as e:
        messagebox.showerror("Error", str(e))

fields = ["vc", "y_hop", "x_hop", "y_src", "x_src", "data"]
entries = {}
for i, name in enumerate(fields):
    tk.Label(root, text=name).grid(row=i, column=0, sticky="e")
    ent = tk.Entry(root, width=20)
    ent.grid(row=i, column=1)
    entries[name] = ent

source_label = tk.Label(root, text="Source: (-,-)")
source_label.grid(row=0, column=2, columnspan=2)
dest_label = tk.Label(root, text="Dest: (-,-)")
dest_label.grid(row=1, column=2, columnspan=2)

source = dest = None
source_buttons = {}
dest_buttons = {}

for i in range(4):
    tk.Label(root, text=f"X={i}").grid(row=6, column=i+2)
    tk.Label(root, text=f"Y={3-i}").grid(row=i+2, column=1)

for r in range(4):
    for c in range(4):
        s_btn = tk.Button(root, text=f"S({r},{c})", width=5, command=lambda r=r, c=c: on_button_click(r, c, True))
        s_btn.grid(row=5 - r, column=c+2, padx=2, pady=2)
        source_buttons[(r, c)] = s_btn
        d_btn = tk.Button(root, text=f"D({r},{c})", width=5, command=lambda r=r, c=c: on_button_click(r, c, False))
        d_btn.grid(row=10 - r, column=c+2, padx=2, pady=2)
        dest_buttons[(r, c)] = d_btn

dir_var = tk.StringVar()
dir_options = {
    "N→S, E→W": (0, 0),
    "N→S, W→E": (0, 1),
    "S→N, E→W": (1, 0),
    "S→N, W→E": (1, 1)
}
dropdown = tk.OptionMenu(root, dir_var, *dir_options.keys())
dropdown.grid(row=7, column=0, columnspan=2)
dir_var.set("N→S, E→W")

tk.Button(root, text="Generate Packet", command=generate_packet).grid(row=8, column=0, columnspan=2, pady=5)
tk.Button(root, text="Attach Instruction", command=attach_instruction).grid(row=9, column=0, columnspan=2, pady=5)
tk.Button(root, text="Regenerate Data", command=regenerate_data).grid(row=10, column=0, columnspan=2, pady=(0, 5))
auto_data = tk.BooleanVar(value=False)
tk.Checkbutton(root, text="Auto-generate random data", variable=auto_data).grid(row=11, column=0, columnspan=2)

hex_output = tk.StringVar()
tk.Entry(root, textvariable=hex_output, state='readonly', width=30).grid(row=12, column=0, columnspan=2, pady=5)

bitfield_output = tk.StringVar()
tk.Label(root, textvariable=bitfield_output, justify='left').grid(row=13, column=0, columnspan=4)

packet_listbox = tk.Listbox(root, width=60, height=8)
packet_listbox.grid(row=30, column=0, columnspan=10, padx=10, pady=(10, 5))
tk.Button(root, text="Clear Packets", command=clear_packets).grid(row=31, column=4, pady=(0, 5))
tk.Button(root, text="Save to File", command=save_to_file).grid(row=31, column=5, pady=(0, 5))

regenerate_data()
root.mainloop()
