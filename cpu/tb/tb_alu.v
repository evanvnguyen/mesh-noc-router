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

    initial begin
        $display("Starting ALU test...");
        $monitor("Time=%0t | alu_op=%b | width=%b | reg_a_data=%h | reg_b_data=%h | alu_out=%h",
                 $time, alu_op, width, reg_a_data, reg_b_data, alu_out);

        // Initialize inputs
        alu_op = 6'b000000;
        width = 2'b00;
        immediate_address = 16'h0000;
        reg_a_data = 64'h0000_0000_0000_0000;
        reg_b_data = 64'h0000_0000_0000_0000;

        #10;

        // === Test 1: VAND ===
        alu = 1; sfu = 0;
        alu_op = 6'b000001; // VAND
        reg_a_data = 64'hFFFF_0000_FFFF_0000;
        reg_b_data = 64'h1234_FFFF_0000_FFFF;
        // Expected: 64'h1234_0000_0000_0000
        #10;
        
        // === Test 2: VOR ===
        alu_op = 6'b000010; // VOR
        reg_a_data = 64'h0000_0000_0000_1234;
        reg_b_data = 64'hFFFF_0000_FFFF_0000;
        // Expected: 64'hFFFF_0000_FFFF_1234
        #10;
        
        // === Test 3: VXOR ===
        alu_op = 6'b000011; // VXOR
        reg_a_data = 64'hAAAA_AAAA_AAAA_AAAA;
        reg_b_data = 64'h5555_5555_5555_5555;
        // Expected: 64'hFFFF_FFFF_FFFF_FFFF
        #10;
        
        // === Test 4: VNOT ===
        alu_op = 6'b000100; // VNOT
        reg_a_data = 64'h0000_0000_FFFF_FFFF;
        reg_b_data = 64'hXXXX_XXXX_XXXX_XXXX; // Not used
        // Expected: 64'hFFFF_FFFF_0000_0000
        #10;
        
        // === Test 5: VMOV ===
        alu_op = 6'b000101; // VMOV
        reg_a_data = 64'h1122_3344_5566_7788;
        reg_b_data = 64'hXXXX_XXXX_XXXX_XXXX; // Not used
        // Expected: compute = reg_a_data
        #10;
        
        // === Test 6: VADD ===
        alu_op = 6'b000110; // VADD
        reg_a_data = 64'h0000_0000_0000_0001;
        reg_b_data = 64'h0000_0000_0000_0002;
        // Expected: 64'h0000_0000_0000_0003
        #10;
        
        // === Test 7: VSUB ===
        alu_op = 6'b000111; // VSUB
        reg_a_data = 64'h0000_0000_0000_0005;
        reg_b_data = 64'h0000_0000_0000_0003;
        // Expected: 64'h0000_0000_0000_0002
        #10;
        
        // === Test 8: VMULEU ===
        alu_op = 6'b001000; // VMULEU
        width = 2'b00; // Byte mode
        reg_a_data = 64'h01_02_03_04_05_06_07_08;
        reg_b_data = 64'h01_01_01_01_01_01_01_01;
        // Expected: multiply even-indexed bytes
        #10;
        
        // === Test 9: VMULOU ===
        alu_op = 6'b001001; // VMULOU
        width = 2'b00; // Byte mode
        reg_a_data = 64'h01_02_03_04_05_06_07_08;
        reg_b_data = 64'h01_01_01_01_01_01_01_01;
        // Expected: multiply odd-indexed bytes
        #10;
        
        // === Test 10: VSLL ===
        alu_op = 6'b001010; // VSLL
        width = 2'b01; // Halfword mode
        reg_a_data = 64'h1234_5678_9ABC_DEF0;
        reg_b_data = 64'h0001_0002_0003_0004;
        // Expected: shifted halfwords
        #10;
        
        // === Test 11: VSRL ===
        alu_op = 6'b001011; // VSRL
        width = 2'b01; // Halfword mode
        reg_a_data = 64'hF000_0F00_00F0_000F;
        reg_b_data = 64'h0004_0003_0002_0001;
        // Expected: right-shifted halfwords
        #10;
        
        // === Test 12: VRTTH ===
        alu_op = 6'b001101; // VRTTH
        width = 2'b01; // Halfword mode
        reg_b_data = 64'h1234_5678_9ABC_DEF0;
        // Expected: each 16b rotated by 8 bits = 0x3412_7856_BC9A_F0DE
        #10;





        // Stop simulation
        $display("Test complete.");
        $finish;
    end

endmodule
