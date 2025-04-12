# decompiler.py
import argparse
import os

instruction_set = {
    "101010000001": "VAND", "101010000010": "VOR",  "101010000011": "VXOR",
    "101010000100": "VNOT", "101010000101": "VMOV", "101010000110": "VADD",
    "101010000111": "VSUB", "101010001000": "VMULEU", "101010001001": "VMULOU",
    "101010001010": "VSLL", "101010001011": "VSRL", "101010001100": "VSRA",
    "101010001101": "VRTTH", "101010001110": "VDIV", "101010001111": "VMOD",
    "101010010000": "VSQEU", "101010010001": "VSQOU", "101010010010": "VSQRT",
    "100000": "VLD", "100001": "VSD", "100010": "VBEZ", "100011": "VBNEZ",
    "111100000000": "VNOP", "000000": "// End of Program"
}

width_suffix = {
    "00": ".b", "01": ".h", "10": ".w", "11": ".d"
}

def decode_instruction(hex_code):
    bin_str = format(int(hex_code, 16), '032b')
    opcode = bin_str[:6]

    # Special case for memory / branch / VNOP
    if opcode in ["100000", "100001", "100010", "100011"]:
        rD = int(bin_str[6:11], 2)
        rA = int(bin_str[11:16], 2)
        imm = int(bin_str[16:], 2)
        mnemonic = instruction_set.get(opcode, "UNKNOWN")
        return f"{mnemonic} R{rD}, {imm}"

    elif opcode == "111100":
        mnemonic = instruction_set.get(bin_str[:12], "VNOP")
        return f"{mnemonic}"
    elif opcode == "000000":
        return instruction_set["000000"]

    # ALU
    rD = int(bin_str[6:11], 2)
    rA = int(bin_str[11:16], 2)
    rB = int(bin_str[16:21], 2)
    wwwpp = bin_str[21:26]
    alu_op = bin_str[26:]
    key = opcode + alu_op
    mnemonic = instruction_set.get(key, "UNKNOWN")
    suffix = width_suffix.get(wwwpp[3:], "")
    return f"{mnemonic}{suffix} R{rD}, R{rA}, R{rB}"


def main():
    parser = argparse.ArgumentParser(description="Decompiler for custom ISA")
    parser.add_argument("-i", "--input", required=True, help="Input file with hex instructions")
    parser.add_argument("-o", "--output", required=False, help="Output file")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose output")
    args = parser.parse_args()

    if not os.path.exists(args.input):
        print("Input file not found")
        exit(1)

    with open(args.input, 'r') as infile:
        lines = infile.readlines()

    output = []
    for line in lines:
        clean = line.strip().split("//")[0].strip()
        if len(clean) < 1:
            continue
        try:
            asm = decode_instruction(clean)
            output.append(asm)
        except Exception as e:
            output.append(f"ERROR decoding line: {line.strip()} ({e})")

    if args.output:
        with open(args.output, 'w') as outfile:
            outfile.write("\n".join(output))
    else:
        for out in output:
            print(out)


if __name__ == "__main__":
    main()
