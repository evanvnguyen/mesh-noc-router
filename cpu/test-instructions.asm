VADD.b R10, R2, R3 // Add r2 with r3 and store in r10
VNOP // NOP  // Program for single packet read and write from processor       
VLD R10, 0 // load datamem[0] into R10    			//load packet to be sent out in register file
VLD R20, 1 // load datamem[1] into R20    			//load packet to be sent out in register file
VLD R30, 2 // load datamem[2] into R30    			//load packet to be sent out in register file
VLD R1, 0xC003 // load NIC[3] into R1  					//read the output channel status register
VBNEZ R1, 4// VBNEZ r1, 4                    //if full, read again until empty
VSD R10, 0xC002 // store r10 into NIC[2]					//send packet out to NIC
VLD R1, 0xC003 // load NIC[3] into r1  					//read the output channel status register
VBNEZ R1, 7 // VBNEZ r1, 7                    //if full, read again until empty
VSD R20, 0xC002 // store r20 into NIC[2]					//send packet out to NIC
VLD R1, 0xC003 // load NIC[3] into r1  					//read the output channel status register
VBNEZ R1, 10 // VBNEZ R1, 10                   //if full, read again until empty
VSD R30, 0xC002 // store R30 into NIC[2]				//send packet out to NIC
// NOP End Program 