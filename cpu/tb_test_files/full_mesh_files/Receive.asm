VNOP // NOP to start
// Read 1
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 1 // Store R5 back into dmem[5]

// Read 2
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 2 // Store R5 back into dmem[5]

// Read 3
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 3 // Store R5 back into dmem[5]

// Read 4
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 4 // Store R5 back into dmem[5]

// Read 5
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 5 // Store R5 back into dmem[5]

// Read 6
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 6 // Store R5 back into dmem[5]

// Read 7
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 7 // Store R5 back into dmem[5]

// Read 8
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 8 // Store R5 back into dmem[5]

// Read 9
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 9 // Store R5 back into dmem[5]

// Read 10
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 10 // Store R5 back into dmem[5]

// Read 11
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 11 // Store R5 back into dmem[5]

// Read 12
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 12 // Store R5 back into dmem[5]

// Read 13
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 13 // Store R5 back into dmem[5]

// Read 14
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 14 // Store R5 back into dmem[5]

// Read 15
VLD R1, 0xC001 // Read the input channel status register
VBEZ R1, 1 // Loop until we are not 0
VLD R2, 0xC000 // Load the Nic input into R5
VSD R2, 15 // Store R5 back into dmem[5]


