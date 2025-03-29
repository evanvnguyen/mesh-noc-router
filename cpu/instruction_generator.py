import tkinter as tk
from tkinter import ttk, messagebox, filedialog

# Define the instruction set
instruction_set = {
    "VAND": {"opcode": "101010", "alu_op": "000001"},
    "VOR":  {"opcode": "101010", "alu_op": "000010"},
    "VXOR": {"opcode": "101010", "alu_op": "000011"},
    "VNOT": {"opcode": "101010", "alu_op": "000100"},
    "VMOV": {"opcode": "101010", "alu_op": "000101"},
    "VADD": {"opcode": "101010", "alu_op": "000110"},
    "VSUB": {"opcode": "101010", "alu_op": "000111"},
    "VMULEU": {"opcode": "101010", "alu_op": "001000"},
    "VMULOU": {"opcode": "101010", "alu_op": "001001"},
    "VSLL": {"opcode": "101010", "alu_op": "001010"},
    "VSRL": {"opcode": "101010", "alu_op": "001011"},
    "VSRA": {"opcode": "101010", "alu_op": "001100"},
    "VRTTH": {"opcode": "101010", "alu_op": "001101"},
    "VDIV": {"opcode": "101010", "alu_op": "001110"},
    "VMOD": {"opcode": "101010", "alu_op": "001111"},
    "VSQEU": {"opcode": "101010", "alu_op": "010000"},
    "VSQOU": {"opcode": "101010", "alu_op": "010001"},
    "VSQRT": {"opcode": "101010", "alu_op": "010010"},
    "VLD": {"opcode": "100000", "alu_op": ""},
    "VSD": {"opcode": "100001", "alu_op": ""},
    "VBEZ": {"opcode": "100010", "alu_op": ""},
    "VBNEZ": {"opcode": "100011", "alu_op": ""},
    "VNOP": {"opcode": "111100", "alu_op": "000000"}    
}

def to_binary(value, bits=5):
    try:
        int_value = int(value, 2) if all(c in '01' for c in value) else int(value)
        if not (0 <= int_value <= 31):
            raise ValueError("Register values must be between 0 and 31")
        return format(int_value, f'0{bits}b')
    except Exception:
        raise ValueError("Register values must be integers or binary strings between 0 and 31")

def to_imm_binary(value, bits=16):
    try:
        int_value = int(value)
        if not (0 <= int_value < 2**bits):
            raise ValueError(f"Immediate must be between 0 and {2**bits - 1}")
        return format(int_value, f'0{bits}b')
    except Exception:
        raise ValueError("Immediate must be an integer between 0 and 65535")

def generate_instruction(instr, rD, rA, rB, imm=None):
    if instr not in instruction_set:
        raise ValueError(f"Instruction '{instr}' not recognized.")

    data = instruction_set[instr]
    opcode = data["opcode"]
    alu_op = data["alu_op"]
    wwwpp = "00000"  # Placeholder

    rD_bin = to_binary(rD)
    rA_bin = to_binary(rA)
    rB_bin = to_binary(rB)

    if instr in ["VLD", "VSD", "VBEZ", "VBNEZ"]:
        if imm is None:
            raise ValueError("Immediate address required for this instruction")
        imm_bin = to_imm_binary(imm)
        return f"{opcode}{rD_bin}{rA_bin}{imm_bin}", rD_bin, rA_bin, imm_bin
    else:
        return f"{opcode}{rD_bin}{rA_bin}{rB_bin}{wwwpp}{alu_op}", rD_bin, rA_bin, rB_bin

# GUI App
def create_gui():
    def on_generate():
        try:
            instr = instr_var.get()
            rD = rD_spinbox.get()
            rA = rA_spinbox.get()
            rB = rB_spinbox.get()
            imm = imm_entry.get() if instr in ["VLD", "VSD", "VBEZ", "VBNEZ"] else None
            result, bin1, bin2, bin3 = generate_instruction(instr, rD, rA, rB, imm)
            rD_bin_var.set(bin1)
            rA_bin_var.set(bin2)
            rB_bin_var.set(bin3)
            if instr in ["VLD", "VSD", "VBEZ", "VBNEZ"]:
                opcode_var.set(result[:6])
                field2_var.set(result[6:11])
                field3_var.set(result[11:16])
                field4_var.set(result[16:])
                field5_var.set("")
                field6_var.set("")
            else:
                opcode_var.set(result[:6])
                field2_var.set(result[6:11])
                field3_var.set(result[11:16])
                field4_var.set(result[16:21])
                field5_var.set(result[21:26])
                field6_var.set(result[26:])
            byte_array = int(result, 2).to_bytes(len(result) // 8, byteorder='big')
            hex_result = byte_array.hex().upper()
            history_listbox.insert(tk.END, hex_result.upper())
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def on_instr_change(event):
        instr = instr_var.get()
        if instr in ["VLD", "VSD", "VBEZ", "VBNEZ"]:
            imm_entry.config(state="normal")
            rB_spinbox.config(state="disabled")
        else:
            imm_entry.config(state="disabled")
            rB_spinbox.config(state="normal")

    def copy_to_clipboard():
        parts = [opcode_var.get(), field2_var.get(), field3_var.get(), field4_var.get(), field5_var.get(), field6_var.get()]
        clipboard_text = ' '.join(filter(None, parts))
        root.clipboard_clear()
        root.clipboard_append(clipboard_text)
        messagebox.showinfo("Copied", "Instruction copied to clipboard!")

    def clear_history():
        history_listbox.delete(0, tk.END)

    def export_history():
        file_path = filedialog.asksaveasfilename(defaultextension=".txt", filetypes=[("Text files", "*.txt")])
        if file_path:
            try:
                with open(file_path, "w") as f:
                    for item in history_listbox.get(0, tk.END):
                        f.write(item + "\n")
                messagebox.showinfo("Exported", f"History saved to {file_path}")
            except Exception as e:
                messagebox.showerror("Error", str(e))

    root = tk.Tk()
    root.title("Instruction Generator")

    # Instruction row
    instr_var = tk.StringVar()
    tk.Label(root, text="Instruction:").grid(row=0, column=0, sticky="e")
    instr_menu = ttk.Combobox(root, textvariable=instr_var, values=list(instruction_set.keys()), state="readonly")
    instr_menu.grid(row=0, column=1, sticky="w")
    instr_menu.current(0)
    instr_menu.bind("<<ComboboxSelected>>", on_instr_change)

    # Register inputs
    rD_bin_var = tk.StringVar()
    rA_bin_var = tk.StringVar()
    rB_bin_var = tk.StringVar()

    tk.Label(root, text="rD (0-31):").grid(row=1, column=0, sticky="e")
    rD_spinbox = tk.Spinbox(root, from_=0, to=31, width=5)
    rD_spinbox.grid(row=1, column=1, sticky="w")
    tk.Label(root, text="rD Binary:").grid(row=1, column=2, sticky="e")
    tk.Entry(root, textvariable=rD_bin_var, width=10, state='readonly').grid(row=1, column=3, sticky="w")

    tk.Label(root, text="rA (0-31):").grid(row=2, column=0, sticky="e")
    rA_spinbox = tk.Spinbox(root, from_=0, to=31, width=5)
    rA_spinbox.grid(row=2, column=1, sticky="w")
    tk.Label(root, text="rA Binary:").grid(row=2, column=2, sticky="e")
    tk.Entry(root, textvariable=rA_bin_var, width=10, state='readonly').grid(row=2, column=3, sticky="w")

    tk.Label(root, text="rB (0-31):").grid(row=3, column=0, sticky="e")
    rB_spinbox = tk.Spinbox(root, from_=0, to=31, width=5)
    rB_spinbox.grid(row=3, column=1, sticky="w")
    tk.Label(root, text="rB/Imm Binary:").grid(row=3, column=2, sticky="e")
    tk.Entry(root, textvariable=rB_bin_var, width=16, state='readonly').grid(row=3, column=3, sticky="w")

    tk.Label(root, text="Immediate (0-65535):").grid(row=4, column=0, sticky="e")
    imm_entry = tk.Entry(root)
    imm_entry.grid(row=4, column=1, sticky="w")
    imm_entry.config(state="disabled")

    tk.Button(root, text="Generate", command=on_generate).grid(row=5, column=0, columnspan=2, pady=10)

    # Output fields neatly grouped
    opcode_var = tk.StringVar()
    field2_var = tk.StringVar()
    field3_var = tk.StringVar()
    field4_var = tk.StringVar()
    field5_var = tk.StringVar()
    field6_var = tk.StringVar()

    output_labels = ["Opcode", "rD", "rA", "rB/Imm", "WWWPP", "ALU op"]
    output_vars = [opcode_var, field2_var, field3_var, field4_var, field5_var, field6_var]

    for i, (label, var) in enumerate(zip(output_labels, output_vars)):
        tk.Label(root, text=label + ":").grid(row=6, column=i, padx=5, pady=2, sticky="ew")
        tk.Entry(root, textvariable=var, width=10, state='readonly').grid(row=7, column=i, padx=5, pady=2, sticky="ew")

    tk.Button(root, text="Copy", command=copy_to_clipboard).grid(row=7, column=len(output_labels), padx=5)

    tk.Label(root, text="Instruction History:").grid(row=8, column=0, columnspan=2)
    history_listbox = tk.Listbox(root, height=10, width=80)
    history_listbox.grid(row=9, column=0, columnspan=7, padx=5, pady=5)

    tk.Button(root, text="Clear History", command=clear_history).grid(row=10, column=0, pady=5)
    tk.Button(root, text="Export History", command=export_history).grid(row=10, column=1, pady=5)

    root.mainloop()

if __name__ == "__main__":
    create_gui()
