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
        int_value = int(value) #int(value, 2) if all(c in '01' for c in value) else int(value)
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

def generate_instruction(instr, rD, rA, rB, imm=None, wwwpp="00000"):
    if instr not in instruction_set:
        raise ValueError(f"Instruction '{instr}' not recognized.")

    data = instruction_set[instr]
    opcode = data["opcode"]
    alu_op = data["alu_op"]

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

            www = www_map.get(www_label.get(), "000")
            pp = pp_map.get(pp_label.get(), "00")
            wwwpp = www + pp

            if instr not in ["VLD", "VSD", "VBEZ", "VBNEZ"]:
                if len(www) != 3 or any(c not in '01' for c in www):
                    raise ValueError("WWW must be a 3-bit binary string (e.g., 101)")
                if len(pp) != 2 or any(c not in '01' for c in pp):
                    raise ValueError("PP must be a 2-bit binary string (e.g., 11)")
                wwwpp = www + pp
            else:
                wwwpp = "00000"

            result, bin1, bin2, bin3 = generate_instruction(instr, rD, rA, rB, imm, wwwpp)
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
            history_listbox.insert(tk.END, hex_result)
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def on_instr_change(event):
        instr = instr_var.get()
        is_imm = instr in ["VLD", "VSD", "VBEZ", "VBNEZ"]
        imm_entry.config(state="normal" if is_imm else "disabled")
        rB_spinbox.config(state="disabled" if is_imm else "normal")
        www_label.config(state="normal" if not is_imm else "disabled")
        pp_label.config(state="normal" if not is_imm else "disabled")

    def copy_to_clipboard():
        parts = [opcode_var.get(), field2_var.get(), field3_var.get(), field4_var.get(), field5_var.get(), field6_var.get()]
        clipboard_text = ' '.join(filter(None, parts))
        root.clipboard_clear()
        root.clipboard_append(clipboard_text)
        messagebox.showinfo("Copied", "Instruction copied to clipboard!")

    def clear_history():
        history_listbox.delete(0, tk.END)
        
    def attach_instruction():
        try:
            temp_file = open("temp_instruction.txt", "w")
            temp_file.write(f"{opcode_var.get()} {field2_var.get()} {field3_var.get()} {field4_var.get()} {field5_var.get()} {field6_var.get()}")
            temp_file.close()
        except Exception as e:
            messagebox.showerror("Error", str(e))

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

    def decode_instruction():
        try:
            hex_input = decode_entry.get().strip().lower()
            if hex_input.startswith("0x"):
                hex_input = hex_input[2:]

            instruction = int(hex_input, 16)
            bin_str = format(instruction, '032b')
            opcode = bin_str[0:6]

            opcode_var.set(opcode)

            if opcode in ["100000", "100001", "100010", "100011"]:
                # Memory/branch type
                rD = bin_str[6:11]
                rA = bin_str[11:16]
                imm = bin_str[16:]

                rD_bin_var.set(rD)
                rA_bin_var.set(rA)
                rB_bin_var.set(imm)

                field2_var.set(rD)
                field3_var.set(rA)
                field4_var.set(imm)
                field5_var.set("")
                field6_var.set("")

                #www_label.delete(0, tk.END)
                #pp_label.delete(0, tk.END)

            else:
                # ALU type
                rD = bin_str[6:11]
                rA = bin_str[11:16]
                rB = bin_str[16:21]
                wwwpp = bin_str[21:26]
                alu_op = bin_str[26:]

                www = wwwpp[:3]
                pp = wwwpp[3:]

                rD_bin_var.set(rD)
                rA_bin_var.set(rA)
                rB_bin_var.set(rB)

                field2_var.set(rD)
                field3_var.set(rA)
                field4_var.set(rB)
                field5_var.set(wwwpp)
                field6_var.set(alu_op)

                # Set dropdowns based on bits
                rev_www_map = {v: k for k, v in www_map.items()}
                rev_pp_map = {v: k for k, v in pp_map.items()}
                www_label.set(rev_www_map.get(www, "All Subfields"))
                pp_label.set(rev_pp_map.get(pp, "W=8"))

        except Exception as e:
            messagebox.showerror("Error", f"Failed to decode: {str(e)}")

    root = tk.Tk()
    root.title("Instruction Generator")

    # Instruction selector
    instr_var = tk.StringVar()
    tk.Label(root, text="Instruction:").grid(row=0, column=0, sticky="e")
    instr_menu = ttk.Combobox(root, textvariable=instr_var, values=list(instruction_set.keys()), state="readonly")
    instr_menu.grid(row=0, column=1, sticky="w")
    instr_menu.current(0)
    instr_menu.bind("<<ComboboxSelected>>", on_instr_change)

    # Register input
    rD_bin_var = tk.StringVar()
    rA_bin_var = tk.StringVar()
    rB_bin_var = tk.StringVar()

    tk.Label(root, text="rD (0-31):").grid(row=1, column=0, sticky="e")
    rD_spinbox = tk.Spinbox(root, from_=0, to=31, width=5)
    rD_spinbox.grid(row=1, column=1, sticky="w")
    tk.Label(root, text="rD Binary:").grid(row=1, column=2, sticky="e")
    tk.Entry(root, textvariable=rD_bin_var, width=10, state='readonly').grid(row=1, column=3)

    tk.Label(root, text="rA (0-31):").grid(row=2, column=0, sticky="e")
    rA_spinbox = tk.Spinbox(root, from_=0, to=31, width=5)
    rA_spinbox.grid(row=2, column=1, sticky="w")
    tk.Label(root, text="rA Binary:").grid(row=2, column=2, sticky="e")
    tk.Entry(root, textvariable=rA_bin_var, width=10, state='readonly').grid(row=2, column=3)

    tk.Label(root, text="rB (0-31):").grid(row=3, column=0, sticky="e")
    rB_spinbox = tk.Spinbox(root, from_=0, to=31, width=5)
    rB_spinbox.grid(row=3, column=1, sticky="w")
    tk.Label(root, text="rB/Imm Binary:").grid(row=3, column=2, sticky="e")
    tk.Entry(root, textvariable=rB_bin_var, width=16, state='readonly').grid(row=3, column=3)

    tk.Label(root, text="Immediate (0-65535):").grid(row=4, column=0, sticky="e")
    imm_entry = tk.Entry(root)
    imm_entry.grid(row=4, column=1, sticky="w")
    imm_entry.config(state="disabled")

        # WWW Dropdown
    tk.Label(root, text="PPP (Participation Field):").grid(row=5, column=0, sticky="e")
    www_map = {
        "All Subfields": "000", "Upper 32-bits": "001", "Lower 32-bits": "010", "Even Subfields": "011",
        "Odd Subfields": "100", "Reserved1": "101", "Reserved2": "110", "Reserved3": "111"
    }
    www_label = tk.StringVar(value="All Subfields")
    www_combo = ttk.Combobox(root, textvariable=www_label, values=list(www_map.keys()), state="readonly", width=10)
    www_combo.grid(row=5, column=1, sticky="w")

    # PP Dropdown
    tk.Label(root, text="WW (Width):").grid(row=6, column=0, sticky="e")
    pp_map = {
        "W=8": "00", "W=16": "01",
        "W=32": "10", "W=64": "11"
    }
    pp_label = tk.StringVar(value="Width=8")
    pp_combo = ttk.Combobox(root, textvariable=pp_label, values=list(pp_map.keys()), state="readonly", width=12)
    pp_combo.grid(row=6, column=1, sticky="w")


    tk.Button(root, text="Generate", command=on_generate).grid(row=7, column=0, columnspan=2, pady=10)

    # Output
    opcode_var = tk.StringVar()
    field2_var = tk.StringVar()
    field3_var = tk.StringVar()
    field4_var = tk.StringVar()
    field5_var = tk.StringVar()
    field6_var = tk.StringVar()

    output_labels = ["Opcode", "rD", "rA", "rB/Imm", "PPPWW", "ALU op"]
    output_vars = [opcode_var, field2_var, field3_var, field4_var, field5_var, field6_var]

    for i, (label, var) in enumerate(zip(output_labels, output_vars)):
        tk.Label(root, text=label + ":").grid(row=8, column=i, padx=5, pady=2)
        tk.Entry(root, textvariable=var, width=10, state='readonly').grid(row=9, column=i, padx=5, pady=2)

    tk.Button(root, text="Copy", command=copy_to_clipboard).grid(row=9, column=len(output_labels), padx=5)
    #tk.Button(root, text="Attach", command=attach_instruction).grid(row=9, column=len(output_labels), padx=5)

    tk.Label(root, text="Instruction History:").grid(row=10, column=0, columnspan=2)
    history_listbox = tk.Listbox(root, height=10, width=80)
    history_listbox.grid(row=11, column=0, columnspan=7, padx=5, pady=5)

    tk.Button(root, text="Clear History", command=clear_history).grid(row=12, column=0, pady=5)
    tk.Button(root, text="Export History", command=export_history).grid(row=12, column=1, pady=5)

    tk.Label(root, text="Decode Hex (e.g., 0xABCDEFFF):").grid(row=13, column=0, sticky="e")
    decode_entry = tk.Entry(root, width=20)
    decode_entry.grid(row=13, column=1, sticky="w")
    tk.Button(root, text="Decode", command=decode_instruction).grid(row=13, column=2, pady=5)

    root.mainloop()


if __name__ == "__main__":
    create_gui()
