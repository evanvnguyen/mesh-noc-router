`timescale 1ps / 1ps

module alu_tb;

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
            64'hFFFF0000FFFF0000,
            64'h1234FFFF0000FFFF,
            64'hEDCBFFFF0000FFFF,
            2'b00
        );

        // --- Halfword mode (width = 2'b01) ---
        execute_vxor(
            64'hA5A55A5A0F0FF0F0,
            64'hFFFF0000F0F00F0F,
            64'h5A5A5A5AFFFFFFFF,
            2'b01
        );

        // --- Word mode (width = 2'b10) ---
        execute_vxor(
            64'h123456789ABCDEF0,
            64'hFFFF000000000000,
            64'hEDCB56789ABCDEF0,
            2'b10
        );

        // --- Dword mode (width = 2'b11) ---
        execute_vxor(
            64'h0000111122223333,
            64'hFFFFEEEE22223333,
            64'hFFFFFFFF00000000,
            2'b11
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
        execute_vmuleu(
            64'h01_02_03_04_05_06_07_08, // A
            64'h02_02_02_02_02_02_02_02, // B
            64'h02_00_06_00_0A_00_0E_00, // 01*02, 03*02, 05*02, 07*02
            2'b00
        );

        // --- Halfword mode (width = 2'b01) ---
        // Even halfwords: [0:15], [32:47]
        execute_vmuleu(
            64'h0010_0020_0030_0040,
            64'h0002_0002_0002_0002,
            64'h0020_0000_0060_0000,
            2'b01
        );

        // --- Word mode (width = 2'b10) ---
        // Even word: [0:31]
        execute_vmuleu(
            64'h00000004_00000008,
            64'h00000003_00000002,
            64'h0000000C_00000000,
            2'b10
        );

        // --- Dword mode (width = 2'b11) ---
        execute_vmuleu(
            64'h00000000_00000005,
            64'h00000000_00000003,
            64'h00000000_0000000F,
            2'b11
        );

        #10;
        
        // ===================================================================
        //  VMULOU Instruction Test Cases
        //  - Unsigned Multiply Odd lanes only (even lanes = 0)
        //  - Width determines lane size (byte, halfword, word, dword)
        // ===================================================================

        // --- Byte mode (width = 2'b00) ---
        // Only bytes [1], [3], [5], [7] are multiplied
        execute_vmulou(
            64'h01_02_03_04_05_06_07_08,
            64'h02_02_02_02_02_02_02_02,
            64'h00_04_00_08_00_0C_00_10, // 02*02, 04*02, 06*02, 08*02
            2'b00
        );

        // --- Halfword mode (width = 2'b01) ---
        // Odd halfwords: [16:31] and [48:63]
        execute_vmulou(
            64'h0010_0020_0030_0040,
            64'h0002_0002_0002_0002,
            64'h0000_0040_0000_0080,
            2'b01
        );

        // --- Word mode (width = 2'b10) ---
        // Odd word: [32:63]
        execute_vmulou(
            64'h00000004_00000008,
            64'h00000003_00000002,
            64'h00000000_00000010,
            2'b10
        );

        // --- Dword mode (width = 2'b11) ---
        execute_vmulou(
            64'h00000000_00000005,
            64'h00000000_00000003,
            64'h00000000_0000000F,
            2'b11
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
        //  VRTTH Instruction Test Cases
        //  - Rotates each field in regA by half its width
        //  - regB is not used, but passed in for display
        // ===================================================================

        // --- Byte mode (width = 2'b00): rotate each byte by 4 bits ---
        // Example: 0x12 → 0x21, 0x34 → 0x43, etc.
        execute_vrtth(
            64'h12_34_56_78_9A_BC_DE_F0,
            64'h0000000000000000,
            64'h21_43_65_87_A9_CB_ED_0F,
            2'b00
        );

        // --- Halfword mode (width = 2'b01): rotate each 16-bit value by 8 bits ---
        // 0x1234 → 0x3412, 0x5678 → 0x7856, etc.
        execute_vrtth(
            64'h1234_5678_9ABC_DEF0,
            64'h0000000000000000,
            64'h3412_7856_BC9A_F0DE,
            2'b01
        );

        // --- Word mode (width = 2'b10): rotate 32-bit values by 16 bits ---
        // 0x12345678 → 0x56781234, 0x89ABCDEF → 0xCDEF89AB
        execute_vrtth(
            64'h12345678_89ABCDEF,
            64'h0000000000000000,
            64'h56781234_CDEF89AB,
            2'b10
        );

        // --- Doubleword mode (width = 2'b11): rotate 64 bits by 32 ---
        // 0x11223344_AABBCCDD → 0xAABBCCDD_11223344
        execute_vrtth(
            64'h11223344_AABBCCDD,
            64'h0000000000000000,
            64'hAABBCCDD_11223344,
            2'b11
        );

        // Stop simulation
        $display("Test complete.");
        $finish;
    end

endmodule
