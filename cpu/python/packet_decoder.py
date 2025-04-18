#!/usr/bin/env python3
import tkinter as tk
from tkinter import filedialog, messagebox

def decode_packet(val):
    return {
        'vc'     : (val >> 63) & 0x1,
        'ns_dir' : (val >> 62) & 0x1,
        'ew_dir' : (val >> 61) & 0x1,
        'y_hop'  : (val >> 52) & 0xF,
        'x_hop'  : (val >> 48) & 0xF,
        'y_src'  : (val >> 40) & 0xFF,
        'x_src'  : (val >> 32) & 0xFF,
        'data'   : val & 0xFFFFFFFF,
    }

def parse_hex_string(s):
    s = s.strip()
    if s.lower().startswith('0x'):
        s = s[2:]
    return int(s, 16)

def format_decoded(d):
    return (
        f"VC:       {d['vc']}\n"
        f"NS Dir:   {d['ns_dir']}   (0 = N→S, 1 = S→N)\n"
        f"EW Dir:   {d['ew_dir']}   (0 = E→W, 1 = W→E)\n"
        f"Y‑Hop:    {d['y_hop']}\n"
        f"X‑Hop:    {d['x_hop']}\n"
        f"Y‑Source: {d['y_src']}\n"
        f"X‑Source: {d['x_src']}\n"
        f"Data:     {d['data']} (0x{d['data']:08X})"
    )

def on_decode():
    hx = entry.get()
    if not hx:
        messagebox.showwarning("Input required", "Please enter a packet hex value.")
        return
    try:
        val = parse_hex_string(hx)
    except ValueError:
        messagebox.showerror("Invalid hex", f"Could not parse '{hx}' as hex.")
        return
    d = decode_packet(val)
    text.delete('1.0', tk.END)
    text.insert(tk.END, format_decoded(d))
    history.insert(tk.END, f"0x{val:016X}")

def on_clear():
    history.delete(0, tk.END)
    text.delete('1.0', tk.END)

def on_save():
    path = filedialog.asksaveasfilename(defaultextension=".txt")
    if not path:
        return
    try:
        with open(path, 'w') as f:
            for i in range(history.size()):
                f.write(history.get(i) + '\n')
        messagebox.showinfo("Saved", f"History saved to {path}")
    except OSError as e:
        messagebox.showerror("Save error", str(e))

def on_load():
    path = filedialog.askopenfilename(filetypes=[("Text files","*.txt"),("All files","*.*")])
    if not path:
        return
    try:
        with open(path, 'r') as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                history.insert(tk.END, line)
    except OSError as e:
        messagebox.showerror("Load error", str(e))

# --- Build GUI ---
root = tk.Tk()
root.title("64‑bit Packet Decoder")

frm = tk.Frame(root, padx=10, pady=10)
frm.pack(fill="both", expand=True)

tk.Label(frm, text="Packet Hex:").grid(row=0, column=0, sticky="e")
entry = tk.Entry(frm, width=30)
entry.grid(row=0, column=1, columnspan=3, sticky="we")

tk.Button(frm, text="Decode", command=on_decode).grid(row=0, column=4, padx=(5,0))

text = tk.Text(frm, width=50, height=8, state='normal')
text.grid(row=1, column=0, columnspan=5, pady=(10,0))

tk.Label(frm, text="History:").grid(row=2, column=0, sticky="nw", pady=(10,0))
history = tk.Listbox(frm, width=50, height=8)
history.grid(row=3, column=0, columnspan=5, pady=(0,10))

btn_frm = tk.Frame(frm)
btn_frm.grid(row=4, column=0, columnspan=5, sticky="e")
tk.Button(btn_frm, text="Load",   command=on_load).pack(side="left", padx=5)
tk.Button(btn_frm, text="Save",   command=on_save).pack(side="left", padx=5)
tk.Button(btn_frm, text="Clear",  command=on_clear).pack(side="left", padx=5)
tk.Button(btn_frm, text="Quit",   command=root.destroy).pack(side="left", padx=5)

root.mainloop()
