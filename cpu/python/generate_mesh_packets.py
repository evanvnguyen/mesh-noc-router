# generate_packets.py
import random
from instruction_generator import generate_instruction
from packet_generator import make_packet

# Define source CPUs (y, x) excluding (3, 3)
sources = [
    (0, 0), (0, 1), (0, 2), (0, 3),
    (1, 0), (1, 1), (1, 2), (1, 3),
    (2, 0), (2, 1), (2, 2), (2, 3),
    (3, 0), (3, 1), (3, 2), (3, 3)
]

#dest_y, dest_x = 3, 3  # Fixed destination
vc = False
# Instruction config
instr_set = [
    "VAND", "VOR", "VXOR", "VNOT", "VMOV", "VADD", "VSUB",
    "VMULEU", "VMULOU", "VSLL", "VSRL", "VSRA", "VRTTH",
    "VDIV", "VMOD", "VSQEU", "VSQOU", "VSQRT"
]
wwwpp = "00000"

for dest_y in range(4):
    for dest_x in range(4):
        packets = []
        instrution_str = [["" for _ in range(4)] for _ in range(4)] 
        for src_y, src_x in sources:
          if (src_y, src_x) == (dest_y, dest_x):
              continue  # Skip the destination CPU
          vc = not vc
          y_hop = 0 if dest_y == src_y else 1 << (abs(dest_y - src_y) - 1)
          x_hop = 0 if dest_x == src_x else 1 << (abs(dest_x - src_x) - 1)
          ns_dir = int(dest_y > src_y)
          ew_dir = int(dest_x > src_x)
          
          instr = random.choice(instr_set)
          rD = random.randint(1, 31)
          rA = random.randint(1, 31)
          rB = random.randint(1, 31)

          instr_bin, *_ = generate_instruction(instr, rD, rA, rB, wwwpp=wwwpp)
          data = int(instr_bin, 2) & 0xFFFFFFFF

          packet = make_packet(int(vc), ns_dir, ew_dir, y_hop, x_hop, src_y, src_x, data)
          hex_packet = f"{packet:016X}"
          packets.append((src_x, src_y, hex_packet))
          instrution_str[src_x][src_y] += f"{instr} R{rD}, R{rA}, R{rB}"

        # Print all packets
        for y, x, packet in packets:
            print(f"Source CPU ({x},{y}) -> Target ({dest_x},{dest_y}): {packet}")

        # Optional: Write packets to a file
        for x, y, packet in packets:
            with open(f"./gen/{dest_x}_{dest_y}/d_mem_{x}_{y}.txt", "w") as f:
                f.write(f"{packet} // Source CPU ({x},{y}) -> Target ({dest_x},{dest_y}) | {instrution_str[x][y]}\n")
                for i in range(127):
                    f.write("0000000000000000\n")
        
        with open(f"./gen/{dest_x}_{dest_y}/d_mem_{dest_x}_{dest_y}.txt", "w") as f:
            for i in range(128):
                    f.write("0000000000000000\n")