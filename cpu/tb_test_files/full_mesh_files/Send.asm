VNOP // NOP to start
VLD R1, 0 // Load dmem[0] to R1
VLD R2, 0xC003 // Read the output channel status register
VBNEZ R2, 2 // Branch if the output channel status register is not zero
VSD R1, 0xC002 // Send a packet out the NIC