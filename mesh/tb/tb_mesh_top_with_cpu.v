module tb_mesh_top_with_cpu;

    // Parameters
    parameter PACKET_WIDTH = 64;

    // Testbench signals
    reg clk;
    reg reset;

    // CPU signals for x_3
    reg [0:31] cpu_inst_in_0_3, cpu_inst_in_1_3, cpu_inst_in_2_3, cpu_inst_in_3_3;          // from imem
    reg [0:63] cpu_d_in_0_3, cpu_d_in_1_3, cpu_d_in_2_3, cpu_d_in_3_3;                      // data input from dmem
    wire [0:31] cpu_pc_out_0_3, cpu_pc_out_1_3, cpu_pc_out_2_3, cpu_pc_out_3_3;               // program counter out
    wire [0:63] cpu_d_out_0_3, cpu_d_out_1_3, cpu_d_out_2_3, cpu_d_out_3_3;                   // data output to data memory
    wire [0:31] cpu_addr_out_0_3, cpu_addr_out_1_3, cpu_addr_out_2_3, cpu_addr_out_3_3;        // data memory address
    wire cpu_memWrEn_0_3, cpu_memWrEn_1_3, cpu_memWrEn_2_3, cpu_memWrEn_3_3;                  // data memory write enable
    wire cpu_memEn_0_3, cpu_memEn_1_3, cpu_memEn_2_3, cpu_memEn_3_3;                          // data memory enable

    // CPU signals for x_2
    reg [0:31] cpu_inst_in_0_2, cpu_inst_in_1_2, cpu_inst_in_2_2, cpu_inst_in_3_2;          // from imem
    reg [0:63] cpu_d_in_0_2, cpu_d_in_1_2, cpu_d_in_2_2, cpu_d_in_3_2;                      // data input from dmem
    wire [0:31] cpu_pc_out_0_2, cpu_pc_out_1_2, cpu_pc_out_2_2, cpu_pc_out_3_2;               // program counter out
    wire [0:63] cpu_d_out_0_2, cpu_d_out_1_2, cpu_d_out_2_2, cpu_d_out_3_2;                   // data output to data memory
    wire [0:31] cpu_addr_out_0_2, cpu_addr_out_1_2, cpu_addr_out_2_2, cpu_addr_out_3_2;        // data memory address
    wire cpu_memWrEn_0_2, cpu_memWrEn_1_2, cpu_memWrEn_2_2, cpu_memWrEn_3_2;                  // data memory write enable
    wire cpu_memEn_0_2, cpu_memEn_1_2, cpu_memEn_2_2, cpu_memEn_3_2;                          // data memory enable

    // CPU signals for x_1
    reg [0:31] cpu_inst_in_0_1, cpu_inst_in_1_1, cpu_inst_in_2_1, cpu_inst_in_3_1;          // from imem
    reg [0:63] cpu_d_in_0_1, cpu_d_in_1_1, cpu_d_in_2_1, cpu_d_in_3_1;                      // data input from dmem
    wire [0:31] cpu_pc_out_0_1, cpu_pc_out_1_1, cpu_pc_out_2_1, cpu_pc_out_3_1;               // program counter out
    wire [0:63] cpu_d_out_0_1, cpu_d_out_1_1, cpu_d_out_2_1, cpu_d_out_3_1;                   // data output to data memory
    wire [0:31] cpu_addr_out_0_1, cpu_addr_out_1_1, cpu_addr_out_2_1, cpu_addr_out_3_1;        // data memory address
    wire cpu_memWrEn_0_1, cpu_memWrEn_1_1, cpu_memWrEn_2_1, cpu_memWrEn_3_1;                  // data memory write enable
    wire cpu_memEn_0_1, cpu_memEn_1_1, cpu_memEn_2_1, cpu_memEn_3_1;                          // data memory enable

    // CPU signals for x_0
    reg [0:31] cpu_inst_in_0_0, cpu_inst_in_1_0, cpu_inst_in_2_0, cpu_inst_in_3_0;          // from imem
    reg [0:63] cpu_d_in_0_0, cpu_d_in_1_0, cpu_d_in_2_0, cpu_d_in_3_0;                      // data input from dmem
    wire [0:31] cpu_pc_out_0_0, cpu_pc_out_1_0, cpu_pc_out_2_0, cpu_pc_out_3_0;               // program counter out
    wire [0:63] cpu_d_out_0_0, cpu_d_out_1_0, cpu_d_out_2_0, cpu_d_out_3_0;                   // data output to data memory
    wire [0:31] cpu_addr_out_0_0, cpu_addr_out_1_0, cpu_addr_out_2_0, cpu_addr_out_3_0;        // data memory address
    wire cpu_memWrEn_0_0, cpu_memWrEn_1_0, cpu_memWrEn_2_0, cpu_memWrEn_3_0;                  // data memory write enable
    wire cpu_memEn_0_0, cpu_memEn_1_0, cpu_memEn_2_0, cpu_memEn_3_0;                          // data memory enable

    // Instantiate the mesh_top_flat module
    mesh_top_flat uut (
        .clk(clk),
        .reset(reset),

        // CPU signals for x_3
        .cpu_inst_in_0_3(cpu_inst_in_0_3), .cpu_inst_in_1_3(cpu_inst_in_1_3), .cpu_inst_in_2_3(cpu_inst_in_2_3), .cpu_inst_in_3_3(cpu_inst_in_3_3),
        .cpu_d_in_0_3(cpu_d_in_0_3), .cpu_d_in_1_3(cpu_d_in_1_3), .cpu_d_in_2_3(cpu_d_in_2_3), .cpu_d_in_3_3(cpu_d_in_3_3),
        .cpu_pc_out_0_3(cpu_pc_out_0_3), .cpu_pc_out_1_3(cpu_pc_out_1_3), .cpu_pc_out_2_3(cpu_pc_out_2_3), .cpu_pc_out_3_3(cpu_pc_out_3_3),
        .cpu_d_out_0_3(cpu_d_out_0_3), .cpu_d_out_1_3(cpu_d_out_1_3), .cpu_d_out_2_3(cpu_d_out_2_3), .cpu_d_out_3_3(cpu_d_out_3_3),
        .cpu_addr_out_0_3(cpu_addr_out_0_3), .cpu_addr_out_1_3(cpu_addr_out_1_3), .cpu_addr_out_2_3(cpu_addr_out_2_3), .cpu_addr_out_3_3(cpu_addr_out_3_3),
        .cpu_memWrEn_0_3(cpu_memWrEn_0_3), .cpu_memWrEn_1_3(cpu_memWrEn_1_3), .cpu_memWrEn_2_3(cpu_memWrEn_2_3), .cpu_memWrEn_3_3(cpu_memWrEn_3_3),
        .cpu_memEn_0_3(cpu_memEn_0_3), .cpu_memEn_1_3(cpu_memEn_1_3), .cpu_memEn_2_3(cpu_memEn_2_3), .cpu_memEn_3_3(cpu_memEn_3_3),

        // CPU signals for x_2
        .cpu_inst_in_0_2(cpu_inst_in_0_2), .cpu_inst_in_1_2(cpu_inst_in_1_2), .cpu_inst_in_2_2(cpu_inst_in_2_2), .cpu_inst_in_3_2(cpu_inst_in_3_2),
        .cpu_d_in_0_2(cpu_d_in_0_2), .cpu_d_in_1_2(cpu_d_in_1_2), .cpu_d_in_2_2(cpu_d_in_2_2), .cpu_d_in_3_2(cpu_d_in_3_2),
        .cpu_pc_out_0_2(cpu_pc_out_0_2), .cpu_pc_out_1_2(cpu_pc_out_1_2), .cpu_pc_out_2_2(cpu_pc_out_2_2), .cpu_pc_out_3_2(cpu_pc_out_3_2),
        .cpu_d_out_0_2(cpu_d_out_0_2), .cpu_d_out_1_2(cpu_d_out_1_2), .cpu_d_out_2_2(cpu_d_out_2_2), .cpu_d_out_3_2(cpu_d_out_3_2),
        .cpu_addr_out_0_2(cpu_addr_out_0_2), .cpu_addr_out_1_2(cpu_addr_out_1_2), .cpu_addr_out_2_2(cpu_addr_out_2_2), .cpu_addr_out_3_2(cpu_addr_out_3_2),
        .cpu_memWrEn_0_2(cpu_memWrEn_0_2), .cpu_memWrEn_1_2(cpu_memWrEn_1_2), .cpu_memWrEn_2_2(cpu_memWrEn_2_2), .cpu_memWrEn_3_2(cpu_memWrEn_3_2),
        .cpu_memEn_0_2(cpu_memEn_0_2), .cpu_memEn_1_2(cpu_memEn_1_2), .cpu_memEn_2_2(cpu_memEn_2_2), .cpu_memEn_3_2(cpu_memEn_3_2),

        // CPU signals for x_1
        .cpu_inst_in_0_1(cpu_inst_in_0_1), .cpu_inst_in_1_1(cpu_inst_in_1_1), .cpu_inst_in_2_1(cpu_inst_in_2_1), .cpu_inst_in_3_1(cpu_inst_in_3_1),
        .cpu_d_in_0_1(cpu_d_in_0_1), .cpu_d_in_1_1(cpu_d_in_1_1), .cpu_d_in_2_1(cpu_d_in_2_1), .cpu_d_in_3_1(cpu_d_in_3_1),
        .cpu_pc_out_0_1(cpu_pc_out_0_1), .cpu_pc_out_1_1(cpu_pc_out_1_1), .cpu_pc_out_2_1(cpu_pc_out_2_1), .cpu_pc_out_3_1(cpu_pc_out_3_1),
        .cpu_d_out_0_1(cpu_d_out_0_1), .cpu_d_out_1_1(cpu_d_out_1_1), .cpu_d_out_2_1(cpu_d_out_2_1), .cpu_d_out_3_1(cpu_d_out_3_1),
        .cpu_addr_out_0_1(cpu_addr_out_0_1), .cpu_addr_out_1_1(cpu_addr_out_1_1), .cpu_addr_out_2_1(cpu_addr_out_2_1), .cpu_addr_out_3_1(cpu_addr_out_3_1),
        .cpu_memWrEn_0_1(cpu_memWrEn_0_1), .cpu_memWrEn_1_1(cpu_memWrEn_1_1), .cpu_memWrEn_2_1(cpu_memWrEn_2_1), .cpu_memWrEn_3_1(cpu_memWrEn_3_1),
        .cpu_memEn_0_1(cpu_memEn_0_1), .cpu_memEn_1_1(cpu_memEn_1_1), .cpu_memEn_2_1(cpu_memEn_2_1), .cpu_memEn_3_1(cpu_memEn_3_1),

        // CPU signals for x_0
        .cpu_inst_in_0_0(cpu_inst_in_0_0), .cpu_inst_in_1_0(cpu_inst_in_1_0), .cpu_inst_in_2_0(cpu_inst_in_2_0), .cpu_inst_in_3_0(cpu_inst_in_3_0),
        .cpu_d_in_0_0(cpu_d_in_0_0), .cpu_d_in_1_0(cpu_d_in_1_0), .cpu_d_in_2_0(cpu_d_in_2_0), .cpu_d_in_3_0(cpu_d_in_3_0),
        .cpu_pc_out_0_0(cpu_pc_out_0_0), .cpu_pc_out_1_0(cpu_pc_out_1_0), .cpu_pc_out_2_0(cpu_pc_out_2_0), .cpu_pc_out_3_0(cpu_pc_out_3_0),
        .cpu_d_out_0_0(cpu_d_out_0_0), .cpu_d_out_1_0(cpu_d_out_1_0), .cpu_d_out_2_0(cpu_d_out_2_0), .cpu_d_out_3_0(cpu_d_out_3_0),
        .cpu_addr_out_0_0(cpu_addr_out_0_0), .cpu_addr_out_1_0(cpu_addr_out_1_0), .cpu_addr_out_2_0(cpu_addr_out_2_0), .cpu_addr_out_3_0(cpu_addr_out_3_0),
        .cpu_memWrEn_0_0(cpu_memWrEn_0_0), .cpu_memWrEn_1_0(cpu_memWrEn_1_0), .cpu_memWrEn_2_0(cpu_memWrEn_2_0), .cpu_memWrEn_3_0(cpu_memWrEn_3_0),
        .cpu_memEn_0_0(cpu_memEn_0_0), .cpu_memEn_1_0(cpu_memEn_1_0), .cpu_memEn_2_0(cpu_memEn_2_0), .cpu_memEn_3_0(cpu_memEn_3_0)
    );

    always begin
        #5 clk = ~clk; 
    end

    initial begin

        reset = 1;
        #10;
        reset = 0;
        #10;

        $finish;
    end

endmodule
