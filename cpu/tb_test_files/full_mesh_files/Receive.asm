VNOP // NOP to start
// Read 1
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 1 // Store R5 back into dmem[5]

// Read 2
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 5 // Loop until we are not 0
VLD R3, 0xC000 // Load the Nic input into R5
VSD R3, 2 // Store R5 back into dmem[5]

// Read 3
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 9 // Loop until we are not 0
VLD R4, 0xC000 // Load the Nic input into R5
VSD R4, 3 // Store R5 back into dmem[5]

// Read 4
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 13 // Loop until we are not 0
VLD R5, 0xC000 // Load the Nic input into R5
VSD R5, 4 // Store R5 back into dmem[5]

// Read 5
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 17 // Loop until we are not 0
VLD R6, 0xC000 // Load the Nic input into R5
VSD R6, 5 // Store R5 back into dmem[5]

// Read 6
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 21 // Loop until we are not 0
VLD R7, 0xC000 // Load the Nic input into R5
VSD R7, 6 // Store R5 back into dmem[5]

// Read 7
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 25 // Loop until we are not 0
VLD R8, 0xC000 // Load the Nic input into R5
VSD R8, 7 // Store R5 back into dmem[5]

// Read 8
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 29 // Loop until we are not 0
VLD R9, 0xC000 // Load the Nic input into R5
VSD R9, 8 // Store R5 back into dmem[5]

// Read 9
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 33 // Loop until we are not 0
VLD R10, 0xC000 // Load the Nic input into R5
VSD R10, 9 // Store R5 back into dmem[5]

// Read 10
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 37 // Loop until we are not 0
VLD R11, 0xC000 // Load the Nic input into R5
VSD R11, 10 // Store R5 back into dmem[5]

// Read 11
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 41 // Loop until we are not 0
VLD R12, 0xC000 // Load the Nic input into R5
VSD R12, 11 // Store R5 back into dmem[5]

// Read 12
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 45 // Loop until we are not 0
VLD R13, 0xC000 // Load the Nic input into R5
VSD R13, 12 // Store R5 back into dmem[5]

// Read 13
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 49 // Loop until we are not 0
VLD R14, 0xC000 // Load the Nic input into R5
VSD R14, 13 // Store R5 back into dmem[5]

// Read 14
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 53 // Loop until we are not 0
VLD R15, 0xC000 // Load the Nic input into R5
VSD R15, 14 // Store R5 back into dmem[5]

// Read 15
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 57 // Loop until we are not 0
VLD R16, 0xC000 // Load the Nic input into R5
VSD R16, 15 // Store R5 back into dmem[5]


