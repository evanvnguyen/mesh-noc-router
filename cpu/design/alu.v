`include "DW_div.v"
`include "DW_sqrt.v"

`timescale 1ps / 1ps

module alu (

    //
    input ld, sd,
    input alu, sfu,
    
    input [0:5] alu_op,
    
    // Affects shift/arithmetic operations
    // No impact on bit-wise operations
    input [0:1] width,
    input [0:15] immediate_address,
    input [0:63] reg_a_data, reg_b_data,
    
    input [0:165] instruction,
    
    // + 5 bits for addressing
    output [0:63] alu_out
    );
    
    // last 6 bits operation status
    localparam [5:0] 
        VAND    = 6'b000001, // 1  - and - done
        VOR     = 6'b000010, // 2  - or - done
        VXOR    = 6'b000011, // 3  - xor - done
        VNOT    = 6'b000100, // 4  - not - done
        //VMOV    = 6'b000101, // 5  - move - done
        VADD    = 6'b000110, // 6  - add - done
        VSUB    = 6'b000111, // 7  - sub - done
        VMULEU  = 6'b001000, // 8  - multiply even unsigned - done
        VMULOU  = 6'b001001, // 9  - mulitiply odd unsigned - done
        VSLL    = 6'b001010, // 10 - shift left logical - done
        VSRL    = 6'b001011, // 11 - shift right logical -  done
        VSRA    = 6'b001100, // 12 - shift right arithmetic - 
        VRTTH   = 6'b001101, // 13 - rotate by half - done
        VDIV    = 6'b001110, // 14 - division integer unsigned
        VMOD    = 6'b001111, // 15 - modulo integer unsigned
        VSQEU   = 6'b010000, // 16 - square even unsigned
        VSQOU   = 6'b010001, // 17 - square odd unsigned
        VSQRT   = 6'b010010, // 18 - square root integer unsigned
        //VLD     = 6'b010011, // 19 - load
        //VSD     = 6'b010100, // 20 - store
        //VBEZ    = 6'b010101, // 21 - branch if equal to zero
        //VBNEZ   = 6'b010110, // 22 - branch if not equal to zero
        VNOP    = 6'b010111; // 23 - no op

    reg [0:63] compute; // for output
    wire [0:63] quotient;
    
    wire [0:63] div_reg_a, div_reg_b;
    wire [0:63] remainder;

    reg div_byte_mode;        
    reg div_half_word_mode;   
    reg div_word_mode    ; 
    reg div_double_word_mode;

    reg rem_mode;
    
    reg mod_byte_mode;        
    reg mod_half_word_mode;   
    reg mod_word_mode    ; 
    reg mod_double_word_mode;

    // *******************
    //  - VDIV/VMOD operation
    // ******************
    // - if op is div, then bring the reg data to the div reg and do something with the dividers
    // otherwise, divider input will be 0 and it will not do anything (hopefully)
    //  - if we want the remainder, just pull compute to the remainder value as
    // rem_mode = 0 (modulus mode)_
//    always @(*) begin
//	case (alu_op)
//	    VDIV: begin
//		div_reg_a = reg_a_data;
//		div_reg_b = reg_b_data;
//		compute   = quotient;
//	    end
//	    VMOD: begin
//		div_reg_a = reg_a_data;
//		div_reg_b = reg_b_data;
//		compute   = remainder;
//	    end
//	    default: begin
//		div_reg_a = 64'b0;
//		div_reg_b = 64'b1;  // set to 1 to avoid divide-by-0
//	    end
//	endcase
    //end
    assign div_reg_a = reg_a_data;
    assign div_reg_b = reg_b_data; 
    wire [0:63] byte_quotient;
    wire [0:63] half_word_quotient;
    wire [0:63] word_quotient;
    wire [0:63] double_word_quotient;
    
    wire [0:63] byte_remainder;
    wire [0:63] half_word_remainder;
    wire [0:63] word_remainder;
    wire [0:63] double_word_remainder;


    // ************************** DW_DIV **********************************
    // 8-bit (byte) mode: Instantiate eight dividers (one per 8-bit slice)
    // rem_mode = 0 = modulus
    // rem_mode = 1 = division remainder
    // - keep at modulus mode and take the remainder when we need it (see
    // above always case)
    DW_div #(.a_width(8),  .b_width(8),  .tc_mode(0), .rem_mode(0)) DW_div_b_0 (.a(div_reg_a[0:7]),   .b(div_reg_b[0:7]),   .quotient(byte_quotient[0:7]),   .remainder(byte_remainder[0:7]), .divide_by_0());
    DW_div #(.a_width(8),  .b_width(8),  .tc_mode(0), .rem_mode(0)) DW_div_b_1 (.a(div_reg_a[8:15]),  .b(div_reg_b[8:15]),  .quotient(byte_quotient[8:15]),  .remainder(byte_remainder[8:15]), .divide_by_0());
    DW_div #(.a_width(8),  .b_width(8),  .tc_mode(0), .rem_mode(0)) DW_div_b_2 (.a(div_reg_a[16:23]), .b(div_reg_b[16:23]), .quotient(byte_quotient[16:23]), .remainder(byte_remainder[16:23]), .divide_by_0());
    DW_div #(.a_width(8),  .b_width(8),  .tc_mode(0), .rem_mode(0)) DW_div_b_3 (.a(div_reg_a[24:31]), .b(div_reg_b[24:31]), .quotient(byte_quotient[24:31]), .remainder(byte_remainder[24:31]), .divide_by_0());
    DW_div #(.a_width(8),  .b_width(8),  .tc_mode(0), .rem_mode(0)) DW_div_b_4 (.a(div_reg_a[32:39]), .b(div_reg_b[32:39]), .quotient(byte_quotient[32:39]), .remainder(byte_remainder[32:39]), .divide_by_0());
    DW_div #(.a_width(8),  .b_width(8),  .tc_mode(0), .rem_mode(0)) DW_div_b_5 (.a(div_reg_a[40:47]), .b(div_reg_b[40:47]), .quotient(byte_quotient[40:47]), .remainder(byte_remainder[40:47]), .divide_by_0());
    DW_div #(.a_width(8),  .b_width(8),  .tc_mode(0), .rem_mode(0)) DW_div_b_6 (.a(div_reg_a[48:55]), .b(div_reg_b[48:55]), .quotient(byte_quotient[48:55]), .remainder(byte_remainder[48:55]), .divide_by_0());
    DW_div #(.a_width(8),  .b_width(8),  .tc_mode(0), .rem_mode(0)) DW_div_b_7 (.a(div_reg_a[56:63]), .b(div_reg_b[56:63]), .quotient(byte_quotient[56:63]), .remainder(byte_remainder[56:63]), .divide_by_0());
    
    // 16-bit (half-word) mode: Instantiate four dividers (one per 16-bit slice)
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(0)) DW_div_h_0 (.a(div_reg_a[0:15]),   .b(div_reg_b[0:15]),   .quotient(half_word_quotient[0:15]),   .remainder(half_word_remainder[0:15]),  .divide_by_0());
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(0)) DW_div_h_1 (.a(div_reg_a[16:31]),  .b(div_reg_b[16:31]),  .quotient(half_word_quotient[16:31]),  .remainder(half_word_remainder[16:31]),  .divide_by_0());
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(0)) DW_div_h_2 (.a(div_reg_a[32:47]),  .b(div_reg_b[32:47]),  .quotient(half_word_quotient[32:47]),  .remainder(half_word_remainder[32:47]),  .divide_by_0());
    DW_div #(.a_width(16), .b_width(16), .tc_mode(0), .rem_mode(0)) DW_div_h_3 (.a(div_reg_a[48:63]),  .b(div_reg_b[48:63]),  .quotient(half_word_quotient[48:63]),  .remainder(half_word_remainder[48:63]),  .divide_by_0());
    
    // 32-bit (word) mode: Instantiate two dividers (one per 32-bit slice)
    DW_div #(.a_width(32), .b_width(32), .tc_mode(0), .rem_mode(0)) DW_div_w_0 (.a(div_reg_a[0:31]),  .b(div_reg_b[0:31]),  .quotient(word_quotient[0:31]),  .remainder(word_remainder[0:31]),  .divide_by_0());
    DW_div #(.a_width(32), .b_width(32), .tc_mode(0), .rem_mode(0)) DW_div_w_1 (.a(div_reg_a[32:63]), .b(div_reg_b[32:63]), .quotient(word_quotient[32:63]), .remainder(word_remainder[32:63]),  .divide_by_0());
    
    // 64-bit (double-word) mode: Instantiate one divider (entire 64-bit value)
    DW_div #(.a_width(64), .b_width(64), .tc_mode(0), .rem_mode(0)) DW_div_d_0 (.a(div_reg_a[0:63]),  .b(reg_b_data[0:63]),  .quotient(double_word_quotient[0:63]),  .remainder(double_word_remainder[0:63]),  .divide_by_0());
    
    
    wire [0:63] byte_root, half_word_root, word_root, double_word_root;
    
    DW_sqrt #(.width(8), .tc_mode(0)) DW_sqrt_b_0 (.a(div_reg_a[0:7]),   .root(byte_root[0:7]));
    DW_sqrt #(.width(8), .tc_mode(0)) DW_sqrt_b_1 (.a(div_reg_a[8:15]),  .root(byte_root[8:15])); 
    DW_sqrt #(.width(8), .tc_mode(0)) DW_sqrt_b_2 (.a(div_reg_a[16:23]), .root(byte_root[16:23]));
    DW_sqrt #(.width(8), .tc_mode(0)) DW_sqrt_b_3 (.a(div_reg_a[24:31]), .root(byte_root[24:31]));
    DW_sqrt #(.width(8), .tc_mode(0)) DW_sqrt_b_4 (.a(div_reg_a[32:39]), .root(byte_root[32:39]));
    DW_sqrt #(.width(8), .tc_mode(0)) DW_sqrt_b_5 (.a(div_reg_a[40:47]), .root(byte_root[40:47]));
    DW_sqrt #(.width(8), .tc_mode(0)) DW_sqrt_b_6 (.a(div_reg_a[48:55]), .root(byte_root[48:55]));
    DW_sqrt #(.width(8), .tc_mode(0)) DW_sqrt_b_7 (.a(div_reg_a[56:63]), .root(byte_root[56:63]));
    
    // pad left
    assign byte_root[0:3]   = 0;
    assign byte_root[8:11]  = 0;
    assign byte_root[16:19] = 0;
    assign byte_root[24:27] = 0;
    assign byte_root[32:35] = 0;
    assign byte_root[40:43] = 0; 
    assign byte_root[48:51] = 0; 
    assign byte_root[56:59] = 0; 

    DW_sqrt #(.width(16), .tc_mode(0)) DW_sqrt_h_0 (.a(div_reg_a[0:15]),  .root(half_word_root[0:15])); 
    DW_sqrt #(.width(16), .tc_mode(0)) DW_sqrt_h_1 (.a(div_reg_a[16:31]), .root(half_word_root[16:31]));
    DW_sqrt #(.width(16), .tc_mode(0)) DW_sqrt_h_2 (.a(div_reg_a[32:47]), .root(half_word_root[32:47]));
    DW_sqrt #(.width(16), .tc_mode(0)) DW_sqrt_h_3 (.a(div_reg_a[48:63]), .root(half_word_root[48:63]));
    
    // pad left
    assign half_word_root[0:7]   = 0; 
    assign half_word_root[16:23] = 0; 
    assign half_word_root[32:39] = 0; 
    assign half_word_root[48:55] = 0; 

    DW_sqrt #(.width(32), .tc_mode(0)) DW_sqrt_w_0 (.a(div_reg_a[0:31]),  .root(word_root[0:31]));
    DW_sqrt #(.width(32), .tc_mode(0)) DW_sqrt_w_1 (.a(div_reg_a[32:63]), .root(word_root[32:63]));
    assign word_root[0:15] = 0; 
    assign word_root[32:47] = 0; 

    DW_sqrt #(.width(64), .tc_mode(0)) DW_sqrt_d_0 (.a(div_reg_a[0:63]),  .root(double_word_root[0:63]));
    assign double_word_root[0:31] = 0; 


    // Do math shit
    always @(*) begin
        case (alu_op)
        
            // Bitwise ops
            VAND: compute = reg_a_data & reg_b_data;  // Bitwise AND (width-independent)
            VOR:  compute = reg_a_data | reg_b_data;  // Bitwise OR (width-independent)
            VXOR: compute = reg_a_data ^ reg_b_data;  // Bitwise XOR (width-independent)
            VNOT: compute = ~reg_a_data;         // Bitwise NOT (width-independent)

            // just take the the incoming reg_A data to be written back in the WB stage
            // maybe check PPP field?
            //VMOV: compute = reg_a_data;

            // Arithmetic ops
            VADD: begin                     // Arithmetic ADD (width-dependent)
                case (width)
                // 8b addition (byte)
                    2'b00: compute = {
                        reg_a_data[0:7]   + reg_b_data[0:7],
                        reg_a_data[8:15]  + reg_b_data[8:15],
                        reg_a_data[16:23] + reg_b_data[16:23],
                        reg_a_data[24:31] + reg_b_data[24:31],
                        reg_a_data[32:39] + reg_b_data[32:39],
                        reg_a_data[40:47] + reg_b_data[40:47],
                        reg_a_data[48:55] + reg_b_data[48:55],
                        reg_a_data[56:63] + reg_b_data[56:63]
                    };
                    // 16b addition (half-word)
                    2'b01: compute = {  
                        reg_a_data[0:15]  + reg_b_data[0:15],
                        reg_a_data[16:31] + reg_b_data[16:31],
                        reg_a_data[32:47] + reg_b_data[32:47],
                        reg_a_data[48:63] + reg_b_data[48:63]
                    };
                     // 32b addition (word)
                    2'b10: compute = {
                        reg_a_data[0:31]  + reg_b_data[0:31],
                        reg_a_data[32:63] + reg_b_data[32:63]
                    };
                    // 64b (double-word, keep the same)
                    2'b11: compute = reg_a_data + reg_b_data;  
                    default:   compute = 64'b0;  
                endcase
            end

            VSUB: begin                     // Arithmetic SUB (width-dependent)
                case (width)
                    // 8b addition (byte)
                    2'b00: compute = {  
                        reg_a_data[0:7]   - reg_b_data[0:7],
                        reg_a_data[8:15]  - reg_b_data[8:15],
                        reg_a_data[16:23] - reg_b_data[16:23],
                        reg_a_data[24:31] - reg_b_data[24:31],
                        reg_a_data[32:39] - reg_b_data[32:39],
                        reg_a_data[40:47] - reg_b_data[40:47],
                        reg_a_data[48:55] - reg_b_data[48:55],
                        reg_a_data[56:63] - reg_b_data[56:63]
                    };
                    // 16b addition (half-word)
                    2'b01: compute = {  
                        reg_a_data[0:15]  - reg_b_data[0:15],
                        reg_a_data[16:31] - reg_b_data[16:31],
                        reg_a_data[32:47] - reg_b_data[32:47],
                        reg_a_data[48:63] - reg_b_data[48:63]
                    };
                    // 32b addition (word)
                    2'b10: compute = {  
                        reg_a_data[0:31]  - reg_b_data[0:31],
                        reg_a_data[32:63] - reg_b_data[32:63]
                    };
                    // 64b (double-word, keep the same)
                    2'b11: compute = reg_a_data - reg_b_data;  
                    default:   compute = 64'b0;  
                endcase
            end
	    
	    VDIV: begin
            case (width)
                // 8b addition (byte)
                2'b00: compute = byte_quotient; 
                // 16b addition (half-word)
                2'b01: compute = half_word_quotient;
                // 32b addition (word)
                2'b10: compute = word_quotient;
                // 64b (double-word, keep the same)
                2'b11: compute = double_word_quotient; 
                default:   compute = 64'b0;  
            endcase
        end
	    VMOD: begin
            case (width)
                        // 8b addition (byte)
                        2'b00: compute = byte_remainder; 
                // 16b addition (half-word)
                        2'b01: compute = half_word_remainder;
                // 32b addition (word)
                        2'b10: compute = word_remainder;
                        // 64b (double-word, keep the same)
                        2'b11: compute = double_word_remainder; 
                        default:   compute = 64'b0;  
                    endcase
            end

            VMULEU: begin                     // Arithmetic EVEN index MUL (width-dependent)
                case (width)
                    // 8b multiplication // take even indice { even, odd, even, odd, even, odd }
                    2'b00: begin
                        compute[48:63] = reg_a_data[48:55] * reg_b_data[48:55]; // byte 6
                        compute[32:47] = reg_a_data[32:39] * reg_b_data[32:39]; // byte 4
                        compute[16:31] = reg_a_data[16:23] * reg_b_data[16:23]; // byte 2
                        compute[0:15]   = reg_a_data[0:7] * reg_b_data[0:7];     // byte 0
                    end
                    
                    // 16b multiplication (16b × 16b = 32b × 2 lanes)
                    2'b01: begin
                        compute[0:31]   = reg_a_data[0:15]   * reg_b_data[0:15];    
                        compute[32:63]  = reg_a_data[32:47]  * reg_b_data[32:47];   
                    end
                    
                    // 32b multiplication (32b × 32b = 64b result)
                    2'b10: begin
                        compute[0:63] = reg_a_data[0:31] * reg_b_data[0:31];
                    end
                    // 2'b11 not possible
                    default: compute = 64'b0;
                endcase
            end
            
            VMULOU: begin                     // Arithmetic ODD index MUL (width-dependent)
                case (width)
                    // 8b multiplication // take odd indice { even, odd, even, odd, even, odd }
                    2'b00: begin
                        compute[0:15]  = reg_a_data[8:15]  * reg_b_data[8:15];  // byte 1
                        compute[16:31] = reg_a_data[24:31] * reg_b_data[24:31]; // byte 3 
                        compute[32:47] = reg_a_data[40:47] * reg_b_data[40:47]; // byte 5
                        compute[48:63] = reg_a_data[56:63] * reg_b_data[56:63]; // byte 7
                    end

                    
                    // 16b multiplication (16b × 16b = 32b × 2 lanes)
                    2'b01: begin
                        compute[0:31]   = reg_a_data[16:31]   * reg_b_data[16:31];    
                        compute[32:63]  = reg_a_data[48:63]  * reg_b_data[48:63];   
                    end
                    
                    // 32b multiplication (32b × 32b = 64b result)
                    2'b10: begin
                        compute[0:63] = reg_a_data[32:63] * reg_b_data[32:63];
                    end
                    // 2'b11 not possible
                    default: compute = 64'b0;
                endcase
            end

            // VSLL op - 16b halfword (WW = 2'b01) - also applies to VSRL
            //  each 16-bit field in reg_A is shifted by its matching field in reg_B
            //
            // reg_A = 64'b
            //   0001_0010_0011_0100   // [0:15]   = 0x1234
            //   0101_0110_0111_1000   // [16:31]  = 0x5678
            //   1001_1010_1011_1100   // [32:47]  = 0x9ABC
            //   1101_1110_1111_0000   // [48:63]  = 0xDEF0
            //
            // reg_B = 64'b
            //   xxxx_xxxx_xxxx_0001   // [0:15]   = shift0 = 1  ? used for reg_A[0:15]
            //   xxxx_xxxx_xxxx_0010   // [16:31]  = shift1 = 2  ? used for reg_A[16:31]
            //   xxxx_xxxx_xxxx_0011   // [32:47]  = shift2 = 3  ? used for reg_A[32:47]
            //   xxxx_xxxx_xxxx_0100   // [48:63]  = shift3 = 4  ? used for reg_A[48:63]
            //
            // Result (compute):
            // compute[0:15]   = reg_A[0:15]   << reg_B[0:3];    // 0x1234 << 1 = 0x2468 = 0010_0100_0110_1000
            // compute[16:31]  = reg_A[16:31]  << reg_B[16:19];  // 0x5678 << 2 = 0x19C0 = 0001_1001_1100_0000
            // compute[32:47]  = reg_A[32:47]  << reg_B[32:35];  // 0x9ABC << 3 = 0xD5E0 = 1101_0101_1110_0000
            // compute[48:63]  = reg_A[48:63]  << reg_B[48:51];  // 0xDEF0 << 4 = 0xEF00 = 1110_1111_0000_0000
            //
            // Final compute value:
            // compute = 64'b
            //   0010_0100_0110_1000   // [0:15]   = 0x2468
            //   0001_1001_1100_0000   // [16:31]  = 0x19C0
            //   1101_0101_1110_0000   // [32:47]  = 0xD5E0
            //   1110_1111_0000_0000;  // [48:63]  = 0xEF00

            // << should not wrap or borrow bits from adjacent slices
            VSLL: begin
                case (width)
                // weird issue at 00
                    2'b00:  begin
                        compute[56:63] = reg_a_data[56:63] << reg_b_data[61:63]; // byte 0 (MSB)
                        compute[48:55] = reg_a_data[48:55] << reg_b_data[53:55]; // byte 1
                        compute[40:47] = reg_a_data[40:47] << reg_b_data[45:47]; // byte 2
                        compute[32:39] = reg_a_data[32:39] << reg_b_data[37:39]; // byte 3
                        compute[24:31] = reg_a_data[24:31] << reg_b_data[29:31]; // byte 4
                        compute[16:23] = reg_a_data[16:23] << reg_b_data[21:23]; // byte 5
                        compute[8:15]  = reg_a_data[8:15]  << reg_b_data[13:15]; // byte 6
                        compute[0:7]   = reg_a_data[0:7]   << reg_b_data[5:7];   // byte 7 (LSB)
                    end
            
                    2'b01: begin // Half-word (16b), shift = 4 bits
                        compute[0:15]  = reg_a_data[0:15]  << reg_b_data[12:15];   // halfword 3
                        compute[16:31] = reg_a_data[16:31] << reg_b_data[28:31]; // halfword 2
                        compute[32:47] = reg_a_data[32:47] << reg_b_data[44:47]; // halfword 1
                        compute[48:63] = reg_a_data[48:63] << reg_b_data[60:63]; // halfword 0
                    end
            
                    2'b10: begin // Word (32b), shift = 5 bits
                        compute[32:63]  = reg_a_data[32:63] << reg_b_data[59:63];   // LSB word
                        compute[0:31]   = reg_a_data[0:31]  << reg_b_data[27:31]; // MSB word
                    end
            
                    2'b11: begin // Double-word (64-bit), shift = 6 bits
                        compute[0:63] = reg_a_data[0:63] << reg_b_data[58:63];   // use MSB 6 bits
                    end
                endcase
            end
            
            VSRL: begin  
                case (width)
                    // Byte mode (8-bit fields), shift = 3 bits
                    // weird issue at 00
                    2'b00: begin
                        // For an 8-bit field, the shift amount s is taken from bits (i+8-3) to (i+8-1).
                        compute[56:63] = reg_a_data[56:63] >> reg_b_data[61:63]; // byte 0 (MSB)
                        compute[48:55] = reg_a_data[48:55] >> reg_b_data[53:55]; // byte 1
                        compute[40:47] = reg_a_data[40:47] >> reg_b_data[45:47]; // byte 2
                        compute[32:39] = reg_a_data[32:39] >> reg_b_data[37:39]; // byte 3
                        compute[24:31] = reg_a_data[24:31] >> reg_b_data[29:31]; // byte 4
                        compute[16:23] = reg_a_data[16:23] >> reg_b_data[21:23]; // byte 5
                        compute[8:15]  = reg_a_data[8:15]  >> reg_b_data[13:15]; // byte 6
                        compute[0:7]   = reg_a_data[0:7]   >> reg_b_data[5:7];   // byte 7 (LSB)
                    end

            
                    // Half-word mode (16-bit), shift = 4 bits
                    2'b01: begin
                        compute[0:15]  = reg_a_data[0:15]  >> reg_b_data[12:15];   // halfword 3
                        compute[16:31] = reg_a_data[16:31] >> reg_b_data[28:31]; // halfword 2
                        compute[32:47] = reg_a_data[32:47] >> reg_b_data[44:47]; // halfword 1
                        compute[48:63] = reg_a_data[48:63] >> reg_b_data[60:63]; // halfword 0
                    end
            
                    // Word mode (32-bit), shift = 5 bits
                    2'b10: begin // Word mode (32-bit), shift = 5 bits
                        compute[32:63]  = reg_a_data[32:63] >> reg_b_data[59:63];   // LSB word
                        compute[0:31]   = reg_a_data[0:31]  >> reg_b_data[27:31]; // MSB word
                    end
            
                    // Double-word (64-bit), shift = 6 bits
                    2'b11: begin
                        compute[0:63] = reg_a_data[0:63] >> reg_b_data[58:63];   // use MSB 6 bits
                    end
                endcase
            end

            VSRA  : begin  

            end
            
            VRTTH : begin  
                case (width)
                    // 8-bit (byte) - rotate upper/lower 4/4
                    2'b00: begin
                        compute[0:7]    = {reg_a_data[4:7],   reg_a_data[0:3]};
                        compute[8:15]   = {reg_a_data[12:15], reg_a_data[8:11]};
                        compute[16:23]  = {reg_a_data[20:23], reg_a_data[16:19]};
                        compute[24:31]  = {reg_a_data[28:31], reg_a_data[24:27]};
                        compute[32:39]  = {reg_a_data[36:39], reg_a_data[32:35]};
                        compute[40:47]  = {reg_a_data[44:47], reg_a_data[40:43]};
                        compute[48:55]  = {reg_a_data[52:55], reg_a_data[48:51]};
                        compute[56:63]  = {reg_a_data[60:63], reg_a_data[56:59]};
                    end
            
                    // 16-bit (halfword) - rotate upper/lower 8/8
                    2'b01: begin
                        compute[0:15]   = {reg_a_data[8:15],   reg_a_data[0:7]};
                        compute[16:31]  = {reg_a_data[24:31],  reg_a_data[16:23]};
                        compute[32:47]  = {reg_a_data[40:47],  reg_a_data[32:39]};
                        compute[48:63]  = {reg_a_data[56:63],  reg_a_data[48:55]};
                    end
            
                    // 32-bit (word) - rotate 16/16
                    2'b10: begin
                        compute[0:31]   = {reg_a_data[16:31],  reg_a_data[0:15]};
                        compute[32:63]  = {reg_a_data[48:63],  reg_a_data[32:47]};
                    end
            
                    // 64-bit (doubleword) - rotate upper/lower 32 bits
                    2'b11: begin
                        compute[0:63] = {reg_a_data[32:63], reg_a_data[0:31]};
                    end
            
                    default: begin
                        compute = 64'b0;
                    end
                endcase
            end
            
                        
            VSQEU : begin  // Arithmetic EVEN index SQUARE (width-dependent)
                case (width)
                    // 8b multiplication // take even indice { even, odd, even, odd, even, odd }
                    2'b00: begin
                        compute[48:63] = reg_a_data[48:55] * reg_a_data[48:55]; // byte 6
                        compute[32:47] = reg_a_data[32:39] * reg_a_data[32:39]; // byte 4
                        compute[16:31] = reg_a_data[16:23] * reg_a_data[16:23]; // byte 2
                        compute[0:15]  = reg_a_data[0:7]   * reg_a_data[0:7];     // byte 0
                    end
                    
                    // 16b multiplication (16b × 16b = 32b × 2 lanes)
                    2'b01: begin
                        compute[0:31]   = reg_a_data[0:15]   * reg_a_data[0:15];    
                        compute[32:63]  = reg_a_data[32:47]  * reg_a_data[32:47];   
                    end
                    
                    // 32b multiplication (32b × 32b = 64b result)
                    2'b10: begin
                        compute[0:63] = reg_a_data[0:31] * reg_a_data[0:31];
                    end
                    // 2'b11 not possible
                    default: compute = 64'b0;
                endcase
            end
            
            VSQOU : begin  
                case (width)
                    // 8b multiplication // take odd indice { even, odd, even, odd, even, odd }
                    2'b00: begin
                        compute[48:63] = reg_a_data[56:63] * reg_a_data[56:63]; // byte 7
                        compute[32:47] = reg_a_data[40:47] * reg_a_data[40:47]; // byte 5
                        compute[16:31] = reg_a_data[24:31] * reg_a_data[24:31]; // byte 3 
                        compute[0:15]  = reg_a_data[8:15]  * reg_a_data[8:15];  // byte 1
                    end

                    
                    // 16b multiplication (16b × 16b = 32b × 2 lanes) { even, odd, even, odd)
                    2'b01: begin
                        compute[0:31]   = reg_a_data[16:31]  * reg_a_data[16:31];    
                        compute[32:63]  = reg_a_data[48:63]  * reg_a_data[48:63];   
                    end
                    
                    // 32b multiplication (32b × 32b = 64b result) { even , odd }
                    2'b10: begin
                        compute[0:63] = reg_a_data[32:63] * reg_a_data[32:63];
                    end
                    // 2'b11 not possible
                    default: compute = 64'b0;
                endcase
            end
            
            VSQRT : begin 
                case (width)
                    // 8b addition (byte)
                    2'b00: compute = byte_root; 
                    // 16b addition (half-word)
                    2'b01: compute = half_word_root;
                    // 32b addition (word)
                    2'b10: compute = word_root;
                    // 64b (double-word, keep the same)
                    2'b11: compute = double_word_root; 
                    default:   compute = 64'b0;  
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
    assign alu_out = compute;
    
endmodule

