`timescale 1ps / 1ps

module tb; 

    // Inputs
    reg ld, sd;
    reg alu, sfu;
    reg [0:5] alu_op;
    reg [0:1] width;
    reg [0:15] immediate_address;
    reg [0:63] reg_a_data, reg_b_data;
    reg [0:165] instruction;

    // Output
    wire [0:63] alu_out;

    alu uut (
        .ld(ld),
        .sd(sd),
        .alu(alu),
        .sfu(sfu),
        .alu_op(alu_op),
        .width(width),
        .immediate_address(immediate_address),
        .reg_a_data(reg_a_data),
        .reg_b_data(reg_b_data),
        .instruction(instruction),
        .alu_out(alu_out)
    );
    task execute_vand;
        input [0:63] regA;
        input [0:63] regB;
        input [0:63] expected;
        input [1:0] width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b000001; // VAND
            width = width_setting;
            reg_a_data = regA;
            reg_b_data = regB;
            #10;
            if (alu_out === expected)
                $display("(PASS) VAND - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
            else
                $display("(VAIL) VAND - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
        end
    endtask

    task execute_vxor;
        input [0:63] regA;
        input [0:63] regB;
        input [0:63] expected;
        input [1:0] width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b000011; // VXOR
            width = width_setting;
            reg_a_data = regA;
            reg_b_data = regB;
            #10;
            if (alu_out === expected)
                $display("(PASS) VXOR - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
            else
                $display("(FAIL) VXOR - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
        end
    endtask
    
    
    task execute_vor;
        input [0:63] regA;
        input [0:63] regB;
        input [0:63] expected;
        input [1:0] width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b000010; // VOR
            width = width_setting;
            reg_a_data = regA;
            reg_b_data = regB;
            #10;
            if (alu_out === expected)
                $display("(PASS) VOR  - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
            else
                $display("(FAIL) VOR  - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
        end
    endtask


    task execute_vnot;
        input [0:63] regA;
        input [0:63] expected;
        input [1:0] width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b000100; // VNOT
            width = width_setting;
            reg_a_data = regA;
            reg_b_data = 64'hDEADBEEFCAFEBABE; // ignored
            #10;
            if (alu_out === expected)
                $display("(PASS) VNOT - Width %b: regA = %h, compute = %h (expected %h)", width, regA, alu_out, expected);
            else
                $display("(FAIL) VNOT- Width %b: regA = %h, compute = %h (expected %h)", width, regA, alu_out, expected);
        end
    endtask


    task execute_vadd;
        input [0:63] regA;
        input [0:63] regB;
        input [0:63] expected;
        input [1:0] width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b000110; // VADD
            width = width_setting;
            reg_a_data = regA;
            reg_b_data = regB;
            #10;
            if (alu_out === expected)
                $display("(PASS) VADD - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
            else
                $display("(FAIL) VADD - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
        end
    endtask

    task execute_vsub;
        input [0:63] regA;
        input [0:63] regB;
        input [0:63] expected;
        input [1:0] width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b000111; // VSUB
            width = width_setting;
            reg_a_data = regA;
            reg_b_data = regB;
            #10;
            if (alu_out === expected)
                $display("(PASS) VSUB - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
            else
                $display("(FAIL) VSUB - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
        end
    endtask

    task execute_vmuleu;
        input [0:63] regA;
        input [0:63] regB;
        input [0:63] expected;
        input [1:0] width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b001000; // VMULEU
            width = width_setting;
            reg_a_data = regA;
            reg_b_data = regB;
            #10;
            if (alu_out === expected)
                $display("(PASS) VMULEU - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
            else
                $display("(FAIL) VMULEU - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
        end
    endtask
    
    task execute_vmulou;
        input [0:63] regA;
        input [0:63] regB;
        input [0:63] expected;
        input [1:0] width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b001001; // VMULOU
            width = width_setting;
            reg_a_data = regA;
            reg_b_data = regB;
            #10;
            if (alu_out === expected)
                $display("(PASS) VMULOU - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
            else
                $display("(FAIL) VMULOU - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
        end
    endtask
    
    task execute_vsrl;
        input [0:63] regA;
        input [0:63] regB;
        input [0:63] expected;
        input [1:0] width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b001011; // VSRL b001011
            width = width_setting;
            reg_a_data = regA;
            reg_b_data = regB;
            #10;
            if (alu_out === expected)
                $display("(PASS) VSRL - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
            else
                $display("(FAIL) VSRL - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
        end
    endtask
   
    task execute_vdiv;
	input [0:63] regA;
	input [0:63] regB;
	input [0:63] expected;
	input [1:0]  width_setting;
	begin
	    alu = 1; sfu = 0;
	    alu_op = 6'b001110; // VDIV operation (unsigned division)
	    width  = width_setting;
	    reg_a_data = regA;
	    reg_b_data = regB;
	    #10;
	    if (alu_out === expected)
		$display("(PASS) VDIV - Width %b: regA = %h, regB = %h, compute = %h (expected %h)",
			  width, regA, regB, alu_out, expected);
	    else
		$display("(FAIL - suspected due to DW truncation) VDIV - Width %b: regA = %h, regB = %h, compute = %h (expected %h)",
			  width, regA, regB, alu_out, expected);
	end
    endtask

    task execute_vmod;
	input [0:63] regA;
	input [0:63] regB;
	input [0:63] expected;
	input [1:0]  width_setting;
	begin
	    alu = 1; sfu = 0;
	    alu_op = 6'b001111; // VMOD op-code (modulo, remainder)
	    width  = width_setting;
	    reg_a_data = regA;
	    reg_b_data = regB;
	    #10;
	    if (alu_out === expected)
		$display("(PASS) VMOD - Width %b: regA = %h, regB = %h, compute = %h (expected %h)",
			 width, regA, regB, alu_out, expected);
	    else
		$display("(FAIL) VMOD - Width %b: regA = %h, regB = %h, compute = %h (expected %h)",
			 width, regA, regB, alu_out, expected);
	end
    endtask
 
    task execute_vsll;
        input [0:63] regA;
        input [0:63] regB;
        input [0:63] expected;
        input [1:0] width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b001010; // VSLL b001010
            width = width_setting;
            reg_a_data = regA;
            reg_b_data = regB;
            #10;
            
            
            if (alu_out === expected)
                $display("(PASS) VSLL - Width %b: regA = %h, regB = %h,  compute = %h (expected %h)", width, regA, regB, alu_out, expected);
            else
                $display("(FAIL) VSLL - Width %b: regA = %h, regB = %h,  compute = %h (expected %h)", width, regA, regB, alu_out, expected);
        end
    endtask

    task execute_vrtth;
        input [0:63] regA;
        input [0:63] regB;

        input [0:63] expected;
        input [1:0] width_setting;
    
        begin
            alu = 0; sfu = 1; // VRTTH is SFU op
            alu_op = 6'b001101; // VRTTH
            width = width_setting;
            reg_a_data = regA;
            //reg_a_data = 64'hDEADBEEFCAFEBABE; // not used
            #10;
            if (alu_out === expected)
                $display("(PASS) VRTTH - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
            else
                $display("(FAIL) VRTTH - Width %b: regA = %h, regB = %h, compute = %h (expected %h)", width, regA, regB, alu_out, expected);
        end
    endtask

    task execute_vsqeu;
        input [0:63] regA;
        input [0:63] expected;
        input [1:0] width_setting; // 00 = 8b, 01 = 16b, 10 = 32b
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b010000; // VSQEU opcode 
            width = width_setting;
            reg_a_data = regA;
            #10;
    
            if (alu_out === expected)
                $display("(PASS) VSQEU - Width %b: regA = %h, compute = %h (expected %h)",
                         width, regA, alu_out, expected);
            else
                $display("(FAIL) VSQEU - Width %b: regA = %h, compute = %h (expected %h)",
                         width, regA, alu_out, expected);
        end
    endtask

    task execute_vsqou;
        input [0:63] regA;
        input [0:63] expected;
        input [1:0] width_setting; // 00 = 8b, 01 = 16b, 10 = 32b
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b010001; // VSQOU opcode
            width = width_setting;
            reg_a_data = regA;
            #10;
    
            if (alu_out === expected)
                $display("(PASS) VSQOU - Width %b: regA = %h, compute = %h (expected %h)",
                         width, regA, alu_out, expected);
            else
                $display("(FAIL) VSQOU - Width %b: regA = %h, compute = %h (expected %h)",
                         width, regA, alu_out, expected);
        end
    endtask

    task execute_vsra;
        input [0:63] regA;
        input [0:63] regB;
        input [0:63] expected;
        input [1:0]  width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b001100; // hypothetical opcode for VSRA
            width = width_setting;
            reg_a_data = regA;
            reg_b_data = regB;
            #10;
    
            if (alu_out === expected)
                $display("(PASS) VSRA - Width %b: regA = %h, regB = %h, compute = %h (expected %h)",
                         width, regA, regB, alu_out, expected);
            else
                $display("(FAIL) VSRA - Width %b: regA = %h, regB = %h, compute = %h (expected %h)",
                         width, regA, regB, alu_out, expected);
        end
    endtask

    task execute_vsqrt;
        input [0:63] regA;
        input [0:63] expected;
        input [1:0]  width_setting;
    
        begin
            alu = 1; sfu = 0;
            alu_op = 6'b010010; // hypothetical opcode for VSQR
            width = width_setting;
            reg_a_data = regA;
            #10;
    
            if (alu_out === expected)
                $display("(PASS) VSQRT - Width %b: regA = %h,compute = %h (expected %h)",
                         width, regA, alu_out, expected);
            else
                $display("(FAIL) VSQRT - Width %b: regA = %h, compute = %h (expected %h)",
                         width, regA, alu_out, expected);
        end
    endtask

    initial begin
        $display("Starting ALU test...");
        //$monitor("Time=%0t | alu_op=%b | width=%b | reg_a_data=%h | reg_b_data=%h | alu_out=%h",
        //         $time, alu_op, width, reg_a_data, reg_b_data, alu_out);

        // Initialize inputs
        alu_op = 6'b000000;
        width = 2'b00;
        immediate_address = 16'h0000;
        reg_a_data = 64'h0000_0000_0000_0000;
        reg_b_data = 64'h0000_0000_0000_0000;

        #10;

        // ===================================================================
        //  VAND OP Test Cases
        //  - Bitwise AND between reg_a_data and reg_b_data
        //  - Result should be unaffected by the `width` field
        //  - Expected output: 64'h1234_0000_0000_0000
        // ===================================================================

        // --- Byte mode (width = 2'b00) ---
        execute_vand(
            64'hFFFF0000FFFF0000,
            64'h1234FFFF0000FFFF,
            64'h1234000000000000,
            2'b00
        );

        // --- Halfword mode (width = 2'b01) ---
        execute_vand(
            64'hA5A55A5AF0F00F0F,
            64'hFFFF0000F0F0FFFF,
            64'hA5A50000F0F00F0F,
            2'b01
        );

        // --- Word mode (width = 2'b10) ---
        execute_vand(
            64'hAAAA5555FFFF0000,
            64'hFFFF000012345678,
            64'hAAAA000012340000,
            2'b10
        );

        // --- Dword mode (width = 2'b11) ---
        execute_vand(
            64'h1111222233334444,
            64'hFFFF0000F0F0F0F0,
            64'h1111000030304040,
            2'b11
        );

        
        // ===================================================================
        //  VOR Instruction Test Cases
        //  - Bitwise OR: reg_a_data | reg_b_data
        //  - Operates lane-by-lane, but unaffected by width
        // ===================================================================

        // --- Byte mode (width = 2'b00) ---
        execute_vor(
            64'h00000000000000F0,
            64'h000000000000000F,
            64'h00000000000000FF,
            2'b00
        );

        // --- Halfword mode (width = 2'b01) ---
        execute_vor(
            64'hAAAA0000F0F00000,
            64'h00000F0F00001234,
            64'hAAAA0F0FF0F01234,
            2'b01
        );

        // --- Word mode (width = 2'b10) ---
        execute_vor(
            64'h0000000012340000,
            64'hFFFF000000005678,
            64'hFFFF000012345678,
            2'b10
        );

        // --- Dword mode (width = 2'b11) ---
        execute_vor(
            64'hAAAA000000000000,
            64'h00005555FFFFFFFF,
            64'hAAAA5555FFFFFFFF,
            2'b11
        );



        // ===================================================================
        //  VXOR Instruction Test Cases
        //  - Bitwise XOR: reg_a_data ^ reg_b_data
        //  - Affected by inputs, not width - but width varied for coverage
        // ===================================================================

        // --- Byte mode (width = 2'b00) ---
        execute_vxor(
            64'hFFFF0000FFFF0000,  // reg A
            64'h1234FFFF0000FFFF,  // reg B
            64'hEDCBFFFFFFFFFFFF,  // expected full 64-bit XOR
            2'b00
        );
        
        execute_vxor(
            64'hA5A55A5A0F0FF0F0,  // reg A
            64'hFFFF0000F0F00F0F,  // reg B
            64'h5A5A5A5AFFFFFFFF,  // expected: A5A5^FFFF = 5A5A, 5A5A^0000 = 5A5A, 0F0F^F0F0 = FFFF, F0F0^0F0F = FFFF
            2'b01
        );
        
        execute_vxor(
            64'h123456789ABCDEF0,  // reg A
            64'hFFFF000000000000,  // reg B
            64'hEDCB56789ABCDEF0,  // expected: 1234^FFFF = EDCB, rest unchanged
            2'b10
        );
        
        // ===================================================================
        //  VNOT Instruction Test Cases
        //  - Bitwise NOT of reg_a_data: ~reg_a_data
        //  - reg_b_data is ignored
        //  - Varies width for completeness
        // ===================================================================

        // --- Byte mode (width = 2'b00) ---
        execute_vnot(
            64'h00000000FFFFFFFF,
            64'hFFFFFFFF00000000,
            2'b00
        );

        // --- Halfword mode (width = 2'b01) ---
        execute_vnot(
            64'hA5A55A5A0000FFFF,
            64'h5A5AA5A5FFFF0000,
            2'b01
        );

        // --- Word mode (width = 2'b10) ---
        execute_vnot(
            64'h123456789ABCDEF0,
            64'hEDCBA9876543210F,
            2'b10
        );

        // --- Dword mode (width = 2'b11) ---
        execute_vnot(
            64'hFFFF00000000FFFF,
            64'h0000FFFFFFFF0000,
            2'b11
        );

        
        /// ===================================================================
        //  VADD Instruction Test Cases
        //  - Lane-based unsigned addition of reg_a_data + reg_b_data
        //  - Width determines lane size
        // ===================================================================
        
        // --- Byte mode (width = 2'b00) ---
        execute_vadd(
            64'h0102030405060708,
            64'h1020304050607080,
            64'h1122334455667788,
            2'b00
        );
    
        // --- Halfword mode (width = 2'b01) ---
        execute_vadd(
            64'h0001001001001000,
            64'h0001000200030004,
            64'h0002001201031004,
            2'b01
        );
    
        // --- Word mode (width = 2'b10) ---
        execute_vadd(
            64'h0000000112345678,
            64'h0000000100000001,
            64'h0000000212345679,
            2'b10
        );
    
        // --- Dword mode (width = 2'b11) ---
        execute_vadd(
            64'h0000000000000001,
            64'hFFFFFFFFFFFFFFFF,
            64'h0000000000000000,
            2'b11
        ); 
        
        // ===================================================================
        //  VSUB Instruction Test Cases
        //  - Per-lane unsigned subtraction: reg_a_data - reg_b_data
        //  - Lane width determined by `width`
        // ===================================================================

        // --- Byte mode (width = 2'b00) ---
        execute_vsub(
            64'h1102030405060708,
            64'h0102030304060505,
            64'h1000000101000203,
            2'b00
        );

        // --- Halfword mode (width = 2'b01) ---
        execute_vsub(
            64'h000A_0020_0100_1000,
            64'h0001_0002_0003_0004,
            64'h0009_001E_00FD_0FFC,
            2'b01
        );

        // --- Word mode (width = 2'b10) ---
        execute_vsub(
            64'h0000000212345679,
            64'h0000000112345678,
            64'h0000000100000001,
            2'b10
        );

        // --- Dword mode (width = 2'b11) ---
        execute_vsub(
            64'h0000000000000000,
            64'h0000000000000001,
            64'hFFFFFFFFFFFFFFFF, // wraparound
            2'b11
        );

        
        // ===================================================================
        //  VMULEU Instruction Test Cases
        //  - Unsigned Multiply Even lanes only (odd lanes = 0)
        //  - Width determines lane size (byte, halfword, word, dword)
        // ===================================================================

        // --- Byte mode (width = 2'b00) ---
        // Only bytes [0], [2], [4], [6] are multiplied
        // VMULEU - Byte Mode (WW = 2'b00)
        // All Verilog Task Calls:
        // WW = 00 ? 8b chunks (even indices only), result = 16b chunks
        execute_vmuleu(
            64'haa0f0f0301aa0f03,
            64'haa550f0103aa01aa,
            64'h70e400e10003000f,
            2'b00
        );


        // --- Halfword mode (width = 2'b01) ---
        // Even halfwords: [0:15], [32:47]
        // VMULEU - Half-Word Mode (WW = 2'b01)
        // WW = 01 ? 16b chunks (even indices only), result = 32b chunks
        execute_vmuleu(
            64'h005500aa000f0055,
            64'h0003005500010055,
            64'h000000ff0000000f,
            2'b01
        );


        // --- Word mode (width = 2'b10) ---
        // Even word: [0:31]
        // VMULEU - Word Mode (WW = 2'b10)
        // WW = 10 ? 32b chunks (even index only), result = 64b chunk
        execute_vmuleu(
            64'h000000aa00000055,
            64'h0000000f0000000f,
            64'h00000000000009f6,
            2'b10
        );

        #10;
        
        // ===================================================================
        //  VMULOU Instruction Test Cases
        //  - Unsigned Multiply Odd lanes only (even lanes = 0)
        //  - Width determines lane size (byte, halfword, word, dword)
        // ===================================================================

        // --- Byte mode (width = 2'b00) ---
        // Only bytes [1], [3], [5], [7] are multiplied
       // WW = 00 â†’ 8b chunks (odd indices only), result = 16b chunks
        // WW = 00 â†’ 8b chunks (odd indices only), result = 16b chunks
        execute_vmulou(
            64'h771e75677c50afdb,
            64'hf52036a015550881,
            64'h03c040601a906e5b,
            2'b00
        );
        
        // WW = 01 â†’ 16b chunks (odd indices only), result = 32b chunks
        execute_vmulou(
            64'h07aee4abdacfa1a3,
            64'h21c3c968628eb93c,
            64'hb3e7287874f4ad34,
            2'b01
        );
        
        // WW = 10 â†’ 32b chunks (odd index only), result = 64b chunk
        execute_vmulou(
            64'hf7c60e2d6f8d1c01,
            64'h62f48db034736c2d,
            64'h16daf536ec11582d,
            2'b10
        );

        
        // ===================================================================
        //  VSLL Instruction Test Cases
        //  - Logical left shift per lane
        //  - Shift amount comes from reg_b_data
        // ===================================================================

        // WW = 00, 3 bit source shift
        
        execute_vsll(
            64'haa00000f5503070f, // regA
            64'haa55070f55000701, // regB
            64'ha8000080a003801e, // expected
            2'b00
        );
        
        // WW = 01, 4 bit source shift
        
        execute_vsll(
            64'h00030007000700aa, // regA
            64'h0003000000010000, // regB
            64'h00180007000e00aa, // expected
            2'b01
        );
        
        // WW = 10, 5 bit source shift
        
        execute_vsll(
            64'h0000005500000007, // regA
            64'h000000550000000f, // regB
            64'h0aa0000000038000, // expected
            2'b10
        );
        
        // WW = 11, 6 bit source shift
        
        execute_vsll(
            64'h0000000000000001, // regA
            64'h0000000000000055, // regB
            64'h0000000000200000, // expected
            2'b11
        );

        // ===================================================================
        //  VSRL Instruction Test Cases
        //  - Please use the generate_vsrl_test_case.py script 
        //  - Logical right shift per lane
        //  - Shift amount comes from bits of reg_b_data
        // ===================================================================

        // --- Byte mode (width = 2'b00), 3-bit shifts ---
        execute_vsrl(
            64'h010703070f0f07aa, // regA
            64'h00550faa0355030f, // regB
            64'h0100000101000001, // expected
            2'b00
        );

        // --- Halfword mode (width = 2'b01), 4-bit shifts ---
        execute_vsrl(
            64'h000f005500550003, // regA
            64'h000f000300030001, // regB
            64'h0000000a000a0001, // expected
            2'b01
        );

        // --- Word mode (width = 2'b10), 5-bit shifts ---
        execute_vsrl(
            64'h0000000000000003, // regA
            64'h000000aa0000000f, // regB
            64'h0000000000000000, // expected
            2'b10
        );


        // --- Dword mode (width = 2'b11), 6-bit shift ---
        // WW = 11, 6 bit source shift
        
        execute_vsrl(
            64'h0000000000000001, // regA
            64'h0000000000000003, // regB
            64'h0000000000000000, // expected
            2'b11
        );

	// ===================================================================
        //  VDIV Instruction Test Cases
        //  - regA divided by regB per width
        //  - test cases will fail but its due to DW truncation
        // ===================================================================

	execute_vdiv(
	    64'hD4_D5_5D_11_E4_01_AE_48,
	    64'h44_82_15_DB_0B_14_17_50,
	    64'h03_01_04_00_14_00_07_00,
	    2'b00
	);

	execute_vdiv(
	    64'hB1_B8_C7_F8_D5_74_F8_DE,
	    64'hBD_8D_AB_F5_19_A8_9B_F9,
	    64'h00_00_00_01_00_08_00_01,
	    2'b01
	);

	execute_vdiv(
	    64'h21_55_37_59_03_D8_AA_EA,
	    64'h3B_71_45_74_CB_51_BD_E2,
	    64'h00_00_00_00_00_00_00_00,
	    2'b10
	);

	execute_vdiv(
	    64'h1F_08_0B_F4_83_79_93_2D,
	    64'h09_08_24_58_78_81_1A_0C,
	    64'h00_00_00_00_00_00_00_03,
	    2'b11
	);
	// ===================================================================
        //  VMOD Instruction Test Cases
        //  - regA mod regB per width
        //  - test cases will fail but its due to DW truncation
        // ===================================================================
	execute_vmod(
	    64'hD4_D5_5D_11_E4_01_AE_48,
	    64'h44_82_15_DB_0B_14_17_50,
	    64'h08_53_09_11_08_01_0D_48,
	    2'b00
	);

	execute_vmod(
	    64'hB1_B8_C7_F8_D5_74_F8_DE,
	    64'hBD_8D_AB_F5_19_A8_9B_F9,
	    64'hB1_B8_1C_03_08_34_5C_E5,
	    2'b01
	);

	execute_vmod(
	    64'h21_55_37_59_03_D8_AA_EA,
	    64'h3B_71_45_74_CB_51_BD_E2,
	    64'h21_55_37_59_03_D8_AA_EA,
	    2'b10
	);

	execute_vmod(
	    64'h1F_08_0B_F4_83_79_93_2D,
	    64'h09_08_24_58_78_81_1A_0C,
	    64'h03_EF_9E_EB_19_F6_45_09,
	    2'b11
	);	
        
        // ===================================================================
        //  VRTTH Instruction Test Cases
        //  - Rotates each field in regA by half its width
        //  - regB is not used, but passed in for display
        // ===================================================================

        // --- Byte mode (width = 2'b00): rotate each byte by 4 bits ---
        // Example: 0x12 ? 0x21, 0x34 ? 0x43, etc.
        execute_vrtth(
            64'h12_34_56_78_9A_BC_DE_F0,
            64'h0000000000000000,
            64'h21_43_65_87_A9_CB_ED_0F,
            2'b00
        );

        // --- Halfword mode (width = 2'b01): rotate each 16-bit value by 8 bits ---
        // 0x1234 ? 0x3412, 0x5678 ? 0x7856, etc.
        execute_vrtth(
            64'h1234_5678_9ABC_DEF0,
            64'h0000000000000000,
            64'h3412_7856_BC9A_F0DE,
            2'b01
        );

        // --- Word mode (width = 2'b10): rotate 32-bit values by 16 bits ---
        // 0x12345678 ? 0x56781234, 0x89ABCDEF ? 0xCDEF89AB
        execute_vrtth(
            64'h12345678_89ABCDEF,
            64'h0000000000000000,
            64'h56781234_CDEF89AB,
            2'b10
        );

        // --- Doubleword mode (width = 2'b11): rotate 64 bits by 32 ---
        // 0x11223344_AABBCCDD ? 0xAABBCCDD_11223344
        execute_vrtth(
            64'h11223344_AABBCCDD,
            64'h0000000000000000,
            64'hAABBCCDD_11223344,
            2'b11
        );

        // ===================================================================
        //  VSQEU Instruction Test Cases
        //  - Squares only the even-indexed fields of regA
        //  - Each field's bit-width is based on `width` (WW) setting:
        //      00 â†’ 8-bit fields (4 results Ã— 16-bit)
        //      01 â†’ 16-bit fields (2 results Ã— 32-bit)
        //      10 â†’ 32-bit field  (1 result Ã— 64-bit)
        //  - Results are zero-padded into 64-bit result
        //  - regB is unused (set to 0)
        // ===================================================================

        // WW = 00 â†’ 8b chunks (even indices only), result = 16b chunks
        execute_vsqeu(
            64'haa0f0103aa03aa0f,
            64'h70e4000170e470e4,
            2'b00
        );
        
        // WW = 01 â†’ 16b chunks (even indices only), result = 32b chunks
        execute_vsqeu(
            64'h00aa000f0001000f,
            64'h000070e400000001,
            2'b01
        );
        
        // WW = 10 â†’ 32b chunks (even index only), result = 64b chunk
        execute_vsqeu(
            64'h0000000f0000000f,
            64'h00000000000000e1,
            2'b10
        );
        
        // ===================================================================
        //  VSQOU Instruction Test Cases
        //  - Squares only the odd-indexed fields of regA
        //  - Each field's bit-width is based on `width` (WW) setting:
        //      00 â†’ 8-bit fields (4 results Ã— 16-bit)
        //      01 â†’ 16-bit fields (2 results Ã— 32-bit)
        //      10 â†’ 32-bit field  (1 result Ã— 64-bit)
        //  - Results are zero-padded into 64-bit result
        //  - regB is unused (set to 0)
        // ===================================================================

        // WW = 00 â†’ 8b chunks (odd indices only), result = 16b chunks
        execute_vsqou(
            64'hdc568eac28cba0ff,
            64'h1ce47390a0f9fe01,
            2'b00
        );
        
        // WW = 01 â†’ 16b chunks (odd indices only), result = 32b chunks
        execute_vsqou(
            64'h4f392493b2ed5518,
            64'h0539ac691c48f240,
            2'b01
        );
        
        // WW = 10 â†’ 32b chunks (odd index only), result = 64b chunk
        execute_vsqou(
            64'h130d325bc2aa466d,
            64'h940683fed023ca69,
            2'b10
        );
            
        // ===================================================================
        //  VSRA Instruction Test Cases
        //  - Performs arithmetic right shift on each data field in regA
        //  - Each field's bit-width is based on `width` (WW) setting:
        // 00 8-bit fields   (8 results — 8-bit)
        // 01 16-bit fields  (4 results — 16-bit)
        // 10 32-bit fields  (2 results — 32-bit)
        // 11 64-bit field   (1 result  — 64-bit)
        // - regB contains the per-field shift amounts
        // For WW = 00 3-bit shift fields per 8-bit lane
        // For WW = 01 4-bit shift fields per 16-bit lane
        // For WW = 10 5-bit shift fields per 32-bit lane
        // For WW = 11 6-bit shift value for full 64-bit word
        //  - Sign bit (MSB of each field) is extended during shift
        //  - Results are packed into a single 64-bit value in field order
        // ===================================================================

// WW = 00 ? Byte Mode (8b chunks)
execute_vsra(
    64'h7e05b3ad4f9c5d97,
    64'h1c2be3db083a8948,
    64'h0001b3fe13fe17e5,
    2'b00
);

// WW = 01 ? Halfword Mode (16b chunks)
execute_vsra(
    64'hdcd624ee026f47aa,
    64'h74cc8afa4fcc199b,
    64'hee6b024e0002008f,
    2'b01
);

// WW = 10 ? Word Mode (32b chunks)
execute_vsra(
    64'hdcd624ee026f47aa,
    64'h74cc8afa4fcc199b,
    64'hffee6b12000009bd,
    2'b10
);


// WW = 11 ? Doubleword Mode (64b)
execute_vsra(
    64'ha2b7d28ea6a7136c,
    64'h03ed2b94f6cb6d63,
    64'ha2b7d28ea6a7136c,
    2'b11
);
        
        // ===================================================================
        //  VSQR Instruction Test Cases
        // - does a square root based on the width and chunk
        // ===================================================================
        
        // WW = 00  8-bit fields
        // hex --- decimal
        // 40  --- 64
        // 10  --- 16
        // 64  --- 100
        execute_vsqrt(
            64'h40_10_64_00_04_00_90_00,
            64'h08_04_0a_00_02_00_0C_00,
            2'b00
        );
        
        // WW = 01 16-bit fields
        // hex --- decimal - result
        // 31 --- 49          (7)
        // 09 ---  9          (3)
        // 121 -  289         (17)
        // 3931 -- 14,641     (121)
         execute_vsqrt (
            64'h0031_0009_0121_3931,
            64'h0007_0003_0011_0079,
            2'b01
        );
        
        //// WW = 10  32-bit field
        // hex -------- decimal -------- result
        // 0259 A9E1 
        // 075B C371 
        execute_vsqrt(
            64'h00CB4904_075BC371,
            64'h00000E42_00002B67,
            2'b10
        );
        
        // WW = 11 64-bit field
        // 123456789 * 123456789 == h003626229738A3B9
        // result should be 75BCD15
        execute_vsqrt(
            64'h003626229738A3B9,
            64'h00000000075BCD15,
            2'b11
        );
        
        // Stop simulation
        $display("Test complete.");
        $finish;
    end

endmodule
