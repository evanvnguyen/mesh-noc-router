`timescale 1ps / 1ps

module alu (
    input [0:31] instruction,
    
    // + 5 bits for addressing
    output [0:68] alu_out
    );
    
    // last 6 bits operation status
    localparam [5:0] 
        VAND    = 6'b000001, // 1  - and
        VOR     = 6'b000010, // 2  - or
        VXOR    = 6'b000011, // 3  - xor
        VNOT    = 6'b000100, // 4  - not
        VMOV    = 6'b000101, // 5  - ------not used------
        VADD    = 6'b000110, // 6  - add
        VSUB    = 6'b000111, // 7  - sub
        VMULEU  = 6'b001000, // 8  - multiply even unsigned
        VMULOU  = 6'b001001, // 9  - mulitiply odd unsigned
        VSLL    = 6'b001010, // 10 - shift left logical
        VSRL    = 6'b001011, // 11 - shift right logical
        VSRA    = 6'b001100, // 12 - shift right arithmetic
        VRTTH   = 6'b001101, // 13 - rotate by half
        VDIV    = 6'b001110, // 14 - division integer unsigned
        VMOD    = 6'b001111, // 15 - modulo integer unsigned
        VSQEU   = 6'b010000, // 16 - square even unsigned
        VSQOU   = 6'b010001, // 17 - square odd unsigned
        VSQRT   = 6'b010010; // 18 - square root integer unsigned

    
    wire [0:5] opcode;
    wire [0:5] reg_A;
    wire [0:5] reg_B;
    wire [0:5] reg_D;
    
    // Affects shift/arithmetic operations
    // No impact on bit-wise operations
    wire [0:1] width;    
    
    reg [0:68] compute;
    
    // Go big endian
    assign opcode = instruction[26:31];

    // Points to a register index (address in the register file)
    // - 5-bit field allows addressing 32 registers (R0 to R31)
    // - Each register stores 64-bit values
    // - Actual operand size (8, 16, 32, or 64 bits) is determined by the WW field
    assign reg_A = instruction[11:15];
    assign reg_B = instruction[16:20]; 
    assign reg_D = instruction[6:10];

    // bit 24-25 (width should be 2 bits)
    assign width = instruction[24:25]; 
    
    // do that shit
    always @(*) begin
        case (opcode)
        
            // Bitwise ops
            VAND: compute = reg_A & reg_B;  // Bitwise AND (width-independent)
            VOR:  compute = reg_A | reg_B;  // Bitwise OR (width-independent)
            VXOR: compute = reg_A ^ reg_B;  // Bitwise XOR (width-independent)
            VNOT: compute = ~reg_A;         // Bitwise NOT (width-independent)

            // Arithmetic ops
            VADD: begin                     // Arithmetic ADD (width-dependent)
                case (width)
                // 8b addition (byte)
                    6'b000001: compute = {  
                        reg_A[63:56] + reg_B[63:56],
                        reg_A[55:48] + reg_B[55:48],
                        reg_A[47:40] + reg_B[47:40],
                        reg_A[39:32] + reg_B[39:32],
                        reg_A[31:24] + reg_B[31:24],
                        reg_A[23:16] + reg_B[23:16],
                        reg_A[15:8]  + reg_B[15:8],
                        reg_A[7:0]   + reg_B[7:0]
                    };
                    // 16b addition (half-word)
                    6'b000010: compute = {  
                        reg_A[63:48] + reg_B[63:48],
                        reg_A[47:32] + reg_B[47:32],
                        reg_A[31:16] + reg_B[31:16],
                        reg_A[15:0]  + reg_B[15:0]
                    };
                     // 32b addition (word)
                    6'b000100: compute = { 
                        reg_A[63:32] + reg_B[63:32],
                        reg_A[31:0]  + reg_B[31:0]
                    };
                    // 64b (double-word, keep the same)
                    6'b001000: compute = reg_A + reg_B;  
                    default:   compute = 64'b0;  
                endcase
            end

            VSUB: begin                     // Arithmetic SUB (width-dependent)
                case (width)
                    // 8b addition (byte)
                    2'b00: compute = {  
                        reg_A[63:56] - reg_B[63:56],
                        reg_A[55:48] - reg_B[55:48],
                        reg_A[47:40] - reg_B[47:40],
                        reg_A[39:32] - reg_B[39:32],
                        reg_A[31:24] - reg_B[31:24],
                        reg_A[23:16] - reg_B[23:16],
                        reg_A[15:8]  - reg_B[15:8],
                        reg_A[7:0]   - reg_B[7:0]
                    };
                    // 16b addition (half-word)
                    2'b01: compute = {  
                        reg_A[63:48] - reg_B[63:48],
                        reg_A[47:32] - reg_B[47:32],
                        reg_A[31:16] - reg_B[31:16],
                        reg_A[15:0]  - reg_B[15:0]
                    };
                    // 32b addition (word)
                    2'b10: compute = {  
                        reg_A[63:32] - reg_B[63:32],
                        reg_A[31:0]  - reg_B[31:0]
                    };
                    // 64b (double-word, keep the same)
                    2'b11: compute = reg_A - reg_B;  
                    default:   compute = 64'b0;  
                endcase
            end
            
            VMULEU: begin                     // Arithmetic EVEN index MUL (width-dependent)
                case (width)
                    // 8b multiplication // take even indice { even, odd, even, odd, even, odd }
                    2'b00: compute = { reg_A[0:7] * reg_B[0:7], reg_A[16:23] * reg_B[16:23], reg_A[32:39] * reg_B[32:39], reg_A[48:55] * reg_B[48:55] };
                    
                    // 16b multiplication (16b -> 32b result)
                    2'b01: compute = { reg_A[0:15] * reg_B[0:15], reg_A[32:47] * reg_B[32:47]  };
                    
                    // 32b multiplication (32b -> 64b result)
                    2'b10: compute = { reg_A[0:31] * reg_B[0:31] };
    
                    default: compute = 64'b0;
                endcase
            end
            
            VMULOU: begin                     // Arithmetic ODD index MUL (width-dependent)
                case (width)
                    // 8b multiplication (8-bit * 8-bit -> 16-bit result) - Odd indices { odd, even, odd, even, odd, even }
                    2'b00: compute = { reg_A[8:15] * reg_B[8:15], reg_A[24:31] * reg_B[24:31], reg_A[40:47] * reg_B[40:47], reg_A[56:63] * reg_B[56:63] };
                    
                    // 16b multiplication (16-bit * 16-bit -> 32-bit result) - Odd indices
                    2'b01: compute = { reg_A[16:31] * reg_B[16:31], reg_A[48:63] * reg_B[48:63] };
                    
                    // 32b multiplication (32-bit * 32-bit -> 64-bit result) - Odd indices
                    2'b10: compute = { reg_A[32:63] * reg_B[32:63] };
            
                    default: compute = 64'b0;
                endcase
            end


            default: compute = 64'b0;  
        endcase
    end
    
    
    // b =8
    // h =16
    // w =32
    // d =64
    
    // add the addressing to the comptued value
    // to be written back to regfile
    assign alu_out = {reg_D, compute};
    
endmodule
