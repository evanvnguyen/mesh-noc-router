module tb_mesh_top_with_cpu;

    // Parameters
    parameter PACKET_WIDTH = 64;

    // Testbench signals
    reg clk;
    reg reset;

    // CPU signals for x_3
    wire [0:31] cpu_inst_in_0_3, cpu_inst_in_1_3, cpu_inst_in_2_3, cpu_inst_in_3_3;          // from imem
    wire [0:63] cpu_d_in_0_3, cpu_d_in_1_3, cpu_d_in_2_3, cpu_d_in_3_3;                      // data input from dmem
    wire [0:31] cpu_pc_out_0_3, cpu_pc_out_1_3, cpu_pc_out_2_3, cpu_pc_out_3_3;               // program counter out
    wire [0:63] cpu_d_out_0_3, cpu_d_out_1_3, cpu_d_out_2_3, cpu_d_out_3_3;                   // data output to data memory
    wire [0:31] cpu_addr_out_0_3, cpu_addr_out_1_3, cpu_addr_out_2_3, cpu_addr_out_3_3;        // data memory address
    wire cpu_memWrEn_0_3, cpu_memWrEn_1_3, cpu_memWrEn_2_3, cpu_memWrEn_3_3;                  // data memory write enable
    wire cpu_memEn_0_3, cpu_memEn_1_3, cpu_memEn_2_3, cpu_memEn_3_3;                          // data memory enable

    // CPU signals for x_2
    wire [0:31] cpu_inst_in_0_2, cpu_inst_in_1_2, cpu_inst_in_2_2, cpu_inst_in_3_2;          // from imem
    wire [0:63] cpu_d_in_0_2, cpu_d_in_1_2, cpu_d_in_2_2, cpu_d_in_3_2;                      // data input from dmem
    wire [0:31] cpu_pc_out_0_2, cpu_pc_out_1_2, cpu_pc_out_2_2, cpu_pc_out_3_2;               // program counter out
    wire [0:63] cpu_d_out_0_2, cpu_d_out_1_2, cpu_d_out_2_2, cpu_d_out_3_2;                   // data output to data memory
    wire [0:31] cpu_addr_out_0_2, cpu_addr_out_1_2, cpu_addr_out_2_2, cpu_addr_out_3_2;        // data memory address
    wire cpu_memWrEn_0_2, cpu_memWrEn_1_2, cpu_memWrEn_2_2, cpu_memWrEn_3_2;                  // data memory write enable
    wire cpu_memEn_0_2, cpu_memEn_1_2, cpu_memEn_2_2, cpu_memEn_3_2;                          // data memory enable

    // CPU signals for x_1
    wire [0:31] cpu_inst_in_0_1, cpu_inst_in_1_1, cpu_inst_in_2_1, cpu_inst_in_3_1;          // from imem
    wire [0:63] cpu_d_in_0_1, cpu_d_in_1_1, cpu_d_in_2_1, cpu_d_in_3_1;                      // data input from dmem
    wire [0:31] cpu_pc_out_0_1, cpu_pc_out_1_1, cpu_pc_out_2_1, cpu_pc_out_3_1;               // program counter out
    wire [0:63] cpu_d_out_0_1, cpu_d_out_1_1, cpu_d_out_2_1, cpu_d_out_3_1;                   // data output to data memory
    wire [0:31] cpu_addr_out_0_1, cpu_addr_out_1_1, cpu_addr_out_2_1, cpu_addr_out_3_1;        // data memory address
    wire cpu_memWrEn_0_1, cpu_memWrEn_1_1, cpu_memWrEn_2_1, cpu_memWrEn_3_1;                  // data memory write enable
    wire cpu_memEn_0_1, cpu_memEn_1_1, cpu_memEn_2_1, cpu_memEn_3_1;                          // data memory enable

    // CPU signals for x_0
    wire [0:31] cpu_inst_in_0_0, cpu_inst_in_1_0, cpu_inst_in_2_0, cpu_inst_in_3_0;          // from imem
    wire [0:63] cpu_d_in_0_0, cpu_d_in_1_0, cpu_d_in_2_0, cpu_d_in_3_0;                      // data input from dmem
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
    // For 0_0
    imem instruc_mem_0_0(
        .memAddr(cpu_pc_out_0_0),
        .dataOut(cpu_inst_in_0_0)
    );
    
    dmem data_mem_0_0(
        .clk(clk),
        .memEn(cpu_memEn_0_0),
        .memWrEn(cpu_memWrEn_0_0),
        .memAddr(cpu_addr_out_0_0),
        .dataIn(cpu_d_out_0_0),
        .dataOut(cpu_d_in_0_0)
    );
    
    // For 1_0
    imem instruc_mem_1_0(
        .memAddr(cpu_pc_out_1_0),
        .dataOut(cpu_inst_in_1_0)
    );
    
    dmem data_mem_1_0(
        .clk(clk),
        .memEn(cpu_memEn_1_0),
        .memWrEn(cpu_memWrEn_1_0),
        .memAddr(cpu_addr_out_1_0),
        .dataIn(cpu_d_out_1_0),
        .dataOut(cpu_d_in_1_0)
    );
    
    // For 2_0
    imem instruc_mem_2_0(
        .memAddr(cpu_pc_out_2_0),
        .dataOut(cpu_inst_in_2_0)
    );
    
    dmem data_mem_2_0(
        .clk(clk),
        .memEn(cpu_memEn_2_0),
        .memWrEn(cpu_memWrEn_2_0),
        .memAddr(cpu_addr_out_2_0),
        .dataIn(cpu_d_out_2_0),
        .dataOut(cpu_d_in_2_0)
    );
    
    // For 3_0
    imem instruc_mem_3_0(
        .memAddr(cpu_pc_out_3_0),
        .dataOut(cpu_inst_in_3_0)
    );
    
    dmem data_mem_3_0(
        .clk(clk),
        .memEn(cpu_memEn_3_0),
        .memWrEn(cpu_memWrEn_3_0),
        .memAddr(cpu_addr_out_3_0),
        .dataIn(cpu_d_out_3_0),
        .dataOut(cpu_d_in_3_0)
    );

    
    // For 0_1
    imem instruc_mem_0_1(
        .memAddr(cpu_pc_out_0_1),
        .dataOut(cpu_inst_in_0_1)
    );
    
    dmem data_mem_0_1(
        .clk(clk),
        .memEn(cpu_memEn_0_1),
        .memWrEn(cpu_memWrEn_0_1),
        .memAddr(cpu_addr_out_0_1),
        .dataIn(cpu_d_out_0_1),
        .dataOut(cpu_d_in_0_1)
    );
    
    // For 1_1
    imem instruc_mem_1_1(
        .memAddr(cpu_pc_out_1_1),
        .dataOut(cpu_inst_in_1_1)
    );
    
    dmem data_mem_1_1(
        .clk(clk),
        .memEn(cpu_memEn_1_1),
        .memWrEn(cpu_memWrEn_1_1),
        .memAddr(cpu_addr_out_1_1),
        .dataIn(cpu_d_out_1_1),
        .dataOut(cpu_d_in_1_1)
    );
    
    // For 2_1
    imem instruc_mem_2_1(
        .memAddr(cpu_pc_out_2_1),
        .dataOut(cpu_inst_in_2_1)
    );
    
    dmem data_mem_2_1(
        .clk(clk),
        .memEn(cpu_memEn_2_1),
        .memWrEn(cpu_memWrEn_2_1),
        .memAddr(cpu_addr_out_2_1),
        .dataIn(cpu_d_out_2_1),
        .dataOut(cpu_d_in_2_1)
    );
    
    // For 3_1
    imem instruc_mem_3_1(
        .memAddr(cpu_pc_out_3_1),
        .dataOut(cpu_inst_in_3_1)
    );
    
    dmem data_mem_3_1(
        .clk(clk),
        .memEn(cpu_memEn_3_1),
        .memWrEn(cpu_memWrEn_3_1),
        .memAddr(cpu_addr_out_3_1),
        .dataIn(cpu_d_out_3_1),
        .dataOut(cpu_d_in_3_1)
    );

    // For 0_2
    imem instruc_mem_0_2(
        .memAddr(cpu_pc_out_0_2),
        .dataOut(cpu_inst_in_0_2)
    );
    
    dmem data_mem_0_2(
        .clk(clk),
        .memEn(cpu_memEn_0_2),
        .memWrEn(cpu_memWrEn_0_2),
        .memAddr(cpu_addr_out_0_2),
        .dataIn(cpu_d_out_0_2),
        .dataOut(cpu_d_in_0_2)
    );
    
    // For 1_2
    imem instruc_mem_1_2(
        .memAddr(cpu_pc_out_1_2),
        .dataOut(cpu_inst_in_1_2)
    );
    
    dmem data_mem_1_2(
        .clk(clk),
        .memEn(cpu_memEn_1_2),
        .memWrEn(cpu_memWrEn_1_2),
        .memAddr(cpu_addr_out_1_2),
        .dataIn(cpu_d_out_1_2),
        .dataOut(cpu_d_in_1_2)
    );
    
    // For 2_2
    imem instruc_mem_2_2(
        .memAddr(cpu_pc_out_2_2),
        .dataOut(cpu_inst_in_2_2)
    );
    
    dmem data_mem_2_2(
        .clk(clk),
        .memEn(cpu_memEn_2_2),
        .memWrEn(cpu_memWrEn_2_2),
        .memAddr(cpu_addr_out_2_2),
        .dataIn(cpu_d_out_2_2),
        .dataOut(cpu_d_in_2_2)
    );
    
    // For 3_2
    imem instruc_mem_3_2(
        .memAddr(cpu_pc_out_3_2),
        .dataOut(cpu_inst_in_3_2)
    );
    
    dmem data_mem_3_2(
        .clk(clk),
        .memEn(cpu_memEn_3_2),
        .memWrEn(cpu_memWrEn_3_2),
        .memAddr(cpu_addr_out_3_2),
        .dataIn(cpu_d_out_3_2),
        .dataOut(cpu_d_in_3_2)
    );

    // For 0_3
    imem instruc_mem_0_3(
        .memAddr(cpu_pc_out_0_3),
        .dataOut(cpu_inst_in_0_3)
    );
    
    dmem data_mem_0_3(
        .clk(clk),
        .memEn(cpu_memEn_0_3),
        .memWrEn(cpu_memWrEn_0_3),
        .memAddr(cpu_addr_out_0_3),
        .dataIn(cpu_d_out_0_3),
        .dataOut(cpu_d_in_0_3)
    );
    
    // For 1_3
    imem instruc_mem_1_3(
        .memAddr(cpu_pc_out_1_3),
        .dataOut(cpu_inst_in_1_3)
    );
    
    dmem data_mem_1_3(
        .clk(clk),
        .memEn(cpu_memEn_1_3),
        .memWrEn(cpu_memWrEn_1_3),
        .memAddr(cpu_addr_out_1_3),
        .dataIn(cpu_d_out_1_3),
        .dataOut(cpu_d_in_1_3)
    );
    
    // For 2_3
    imem instruc_mem_2_3(
        .memAddr(cpu_pc_out_2_3),
        .dataOut(cpu_inst_in_2_3)
    );
    
    dmem data_mem_2_3(
        .clk(clk),
        .memEn(cpu_memEn_2_3),
        .memWrEn(cpu_memWrEn_2_3),
        .memAddr(cpu_addr_out_2_3),
        .dataIn(cpu_d_out_2_3),
        .dataOut(cpu_d_in_2_3)
    );
    
    // For 3_3
    imem instruc_mem_3_3(
        .memAddr(cpu_pc_out_3_3),
        .dataOut(cpu_inst_in_3_3)
    );
    
    dmem data_mem_3_3(
        .clk(clk),
        .memEn(cpu_memEn_3_3),
        .memWrEn(cpu_memWrEn_3_3),
        .memAddr(cpu_addr_out_3_3),
        .dataIn(cpu_d_out_3_3),
        .dataOut(cpu_d_in_3_3)
    );

    integer clock_cycle, i, j;
    // For all x_y combinations
    integer dmem0_dump_file_0_0, dmem0_dump_file_1_0, dmem0_dump_file_2_0, dmem0_dump_file_3_0;
    integer dmem0_dump_file_0_1, dmem0_dump_file_1_1, dmem0_dump_file_2_1, dmem0_dump_file_3_1;
    integer dmem0_dump_file_0_2, dmem0_dump_file_1_2, dmem0_dump_file_2_2, dmem0_dump_file_3_2;
    integer dmem0_dump_file_0_3, dmem0_dump_file_1_3, dmem0_dump_file_2_3, dmem0_dump_file_3_3;

    // For all x_y combinations
    reg [127:0] imem_filename_0_0, dump_filename_0_0;
    reg [127:0] imem_filename_1_0, dump_filename_1_0;
    reg [127:0] imem_filename_2_0, dump_filename_2_0;
    reg [127:0] imem_filename_3_0, dump_filename_3_0;
    
    reg [127:0] imem_filename_0_1, dump_filename_0_1;
    reg [127:0] imem_filename_1_1, dump_filename_1_1;
    reg [127:0] imem_filename_2_1, dump_filename_2_1;
    reg [127:0] imem_filename_3_1, dump_filename_3_1;
    
    reg [127:0] imem_filename_0_2, dump_filename_0_2;
    reg [127:0] imem_filename_1_2, dump_filename_1_2;
    reg [127:0] imem_filename_2_2, dump_filename_2_2;
    reg [127:0] imem_filename_3_2, dump_filename_3_2;
    
    reg [127:0] imem_filename_0_3, dump_filename_0_3;
    reg [127:0] imem_filename_1_3, dump_filename_1_3;
    reg [127:0] imem_filename_2_3, dump_filename_2_3;
    reg [127:0] imem_filename_3_3, dump_filename_3_3;

    always begin
        #5 clk = ~clk; 
    end

    initial begin
        clk = 0;
        reset = 1;
        #10;
        reset = 0;
        #10;

    for (j=1; j < 10; j = j + 1) begin
        repeat(5) @(negedge clk); 
        reset = 1'b0;
        // Format the filename string: "imem_<j>.fill"
        // For all x_y combinations
        //$sformat(imem_filename_0_0, "imem_%0d.fill", j);
        //$sformat(imem_filename_1_0, "imem_%0d.fill", j);
        //$sformat(imem_filename_2_0, "imem_%0d.fill", j);
        //$sformat(imem_filename_3_0, "imem_%0d.fill", j);
        //
        //$sformat(imem_filename_0_1, "imem_%0d.fill", j);
        //$sformat(imem_filename_1_1, "imem_%0d.fill", j);
        //$sformat(imem_filename_2_1, "imem_%0d.fill", j);
        //$sformat(imem_filename_3_1, "imem_%0d.fill", j);
        //
        //$sformat(imem_filename_0_2, "imem_%0d.fill", j);
        //$sformat(imem_filename_1_2, "imem_%0d.fill", j);
        //$sformat(imem_filename_2_2, "imem_%0d.fill", j);
        //$sformat(imem_filename_3_2, "imem_%0d.fill", j);
        //
        //$sformat(imem_filename_0_3, "imem_%0d.fill", j);
        //$sformat(imem_filename_1_3, "imem_%0d.fill", j);
        //$sformat(imem_filename_2_3, "imem_%0d.fill", j);
        //$sformat(imem_filename_3_3, "imem_%0d.fill", j);
        
        $sformat(imem_filename_0_0, "imem_0.0.fill", j);
        $sformat(imem_filename_1_0, "imem_0.0.fill", j);
        $sformat(imem_filename_2_0, "imem_0.0.fill", j);
        $sformat(imem_filename_3_0, "imem_0.0.fill", j);
                                          
        $sformat(imem_filename_0_1, "imem_0.0.fill", j);
        $sformat(imem_filename_1_1, "imem_0.0.fill", j);
        $sformat(imem_filename_2_1, "imem_0.0.fill", j);
        $sformat(imem_filename_3_1, "imem_0.0.fill", j);
                                         
        $sformat(imem_filename_0_2, "imem_0.0.fill", j);
        $sformat(imem_filename_1_2, "imem_0.0.fill", j);
        $sformat(imem_filename_2_2, "imem_0.0.fill", j);
        $sformat(imem_filename_3_2, "imem_0.0.fill", j);
                                          
        $sformat(imem_filename_0_3, "imem_0.0.fill", j);
        $sformat(imem_filename_1_3, "imem_0.0.fill", j);
        $sformat(imem_filename_2_3, "imem_0.0.fill", j);
        $sformat(imem_filename_3_3, "imem_0.0.fill", j);
        
    
        // For all x_y combinations
        $readmemh(imem_filename_0_0, instruc_mem_0_0.MEM);
        $readmemh("dmem.fill", data_mem_0_0.MEM);
        $readmemh(imem_filename_1_0, instruc_mem_1_0.MEM);
        $readmemh("dmem.fill", data_mem_1_0.MEM);
        $readmemh(imem_filename_2_0, instruc_mem_2_0.MEM);
        $readmemh("dmem.fill", data_mem_2_0.MEM);
        $readmemh(imem_filename_3_0, instruc_mem_3_0.MEM);
        $readmemh("dmem.fill", data_mem_3_0.MEM);
        
        $readmemh(imem_filename_0_1, instruc_mem_0_1.MEM);
        $readmemh("dmem.fill", data_mem_0_1.MEM);
        $readmemh(imem_filename_1_1, instruc_mem_1_1.MEM);
        $readmemh("dmem.fill", data_mem_1_1.MEM);
        $readmemh(imem_filename_2_1, instruc_mem_2_1.MEM);
        $readmemh("dmem.fill", data_mem_2_1.MEM);
        $readmemh(imem_filename_3_1, instruc_mem_3_1.MEM);
        $readmemh("dmem.fill", data_mem_3_1.MEM);
        
        $readmemh(imem_filename_0_2, instruc_mem_0_2.MEM);
        $readmemh("dmem.fill", data_mem_0_2.MEM);
        $readmemh(imem_filename_1_2, instruc_mem_1_2.MEM);
        $readmemh("dmem.fill", data_mem_1_2.MEM);
        $readmemh(imem_filename_2_2, instruc_mem_2_2.MEM);
        $readmemh("dmem.fill", data_mem_2_2.MEM);
        $readmemh(imem_filename_3_2, instruc_mem_3_2.MEM);
        $readmemh("dmem.fill", data_mem_3_2.MEM);
        
        $readmemh(imem_filename_0_3, instruc_mem_0_3.MEM);
        $readmemh("dmem.fill", data_mem_0_3.MEM);
        $readmemh(imem_filename_1_3, instruc_mem_1_3.MEM);
        $readmemh("dmem.fill", data_mem_1_3.MEM);
        $readmemh(imem_filename_2_3, instruc_mem_2_3.MEM);
        $readmemh("dmem.fill", data_mem_2_3.MEM);
        $readmemh(imem_filename_3_3, instruc_mem_3_3.MEM);
        $readmemh("dmem.fill", data_mem_3_3.MEM);

        // For all x_y combinations
        wait (cpu_inst_in_0_0 == 32'h00000000);
        wait (cpu_inst_in_1_0 == 32'h00000000);
        wait (cpu_inst_in_2_0 == 32'h00000000);
        wait (cpu_inst_in_3_0 == 32'h00000000);
        
        wait (cpu_inst_in_0_1 == 32'h00000000);
        wait (cpu_inst_in_1_1 == 32'h00000000);
        wait (cpu_inst_in_2_1 == 32'h00000000);
        wait (cpu_inst_in_3_1 == 32'h00000000);
        
        wait (cpu_inst_in_0_2 == 32'h00000000);
        wait (cpu_inst_in_1_2 == 32'h00000000);
        wait (cpu_inst_in_2_2 == 32'h00000000);
        wait (cpu_inst_in_3_2 == 32'h00000000);
        
        wait (cpu_inst_in_0_3 == 32'h00000000);
        wait (cpu_inst_in_1_3 == 32'h00000000);
        wait (cpu_inst_in_2_3 == 32'h00000000);
        wait (cpu_inst_in_3_3 == 32'h00000000);

        $display("The program completed in %d cycles", clock_cycle);
        // Let us now flush the pipe line
        repeat(5) @(negedge clk); 
        
        // For all x_y combinations
        
        // For 0_0
        $sformat(dump_filename_0_0, "cmp_test.dmem0_0_0_%0d.dump", j);
        dmem0_dump_file_0_0 = $fopen(dump_filename_0_0); // Assigning the channel descriptor for output file
        // For 1_0
        $sformat(dump_filename_1_0, "cmp_test.dmem0_1_0_%0d.dump", j);
        dmem0_dump_file_1_0 = $fopen(dump_filename_1_0); // Assigning the channel descriptor for output file
        // For 2_0
        $sformat(dump_filename_2_0, "cmp_test.dmem0_2_0_%0d.dump", j);
        dmem0_dump_file_2_0 = $fopen(dump_filename_2_0); // Assigning the channel descriptor for output file
        // For 3_0
        $sformat(dump_filename_3_0, "cmp_test.dmem0_3_0_%0d.dump", j);
        dmem0_dump_file_3_0 = $fopen(dump_filename_3_0); // Assigning the channel descriptor for output file
        
        // For 0_1
        $sformat(dump_filename_0_1, "cmp_test.dmem0_0_1_%0d.dump", j);
        dmem0_dump_file_0_1 = $fopen(dump_filename_0_1); // Assigning the channel descriptor for output file
        // For 1_1
        $sformat(dump_filename_1_1, "cmp_test.dmem0_1_1_%0d.dump", j);
        dmem0_dump_file_1_1 = $fopen(dump_filename_1_1); // Assigning the channel descriptor for output file
        // For 2_1
        $sformat(dump_filename_2_1, "cmp_test.dmem0_2_1_%0d.dump", j);
        dmem0_dump_file_2_1 = $fopen(dump_filename_2_1); // Assigning the channel descriptor for output file
        // For 3_1
        $sformat(dump_filename_3_1, "cmp_test.dmem0_3_1_%0d.dump", j);
        dmem0_dump_file_3_1 = $fopen(dump_filename_3_1); // Assigning the channel descriptor for output file
        
        // For 0_2
        $sformat(dump_filename_0_2, "cmp_test.dmem0_0_2_%0d.dump", j);
        dmem0_dump_file_0_2 = $fopen(dump_filename_0_2); // Assigning the channel descriptor for output file
        // For 1_2
        $sformat(dump_filename_1_2, "cmp_test.dmem0_1_2_%0d.dump", j);
        dmem0_dump_file_1_2 = $fopen(dump_filename_1_2); // Assigning the channel descriptor for output file
        // For 2_2
        $sformat(dump_filename_2_2, "cmp_test.dmem0_2_2_%0d.dump", j);
        dmem0_dump_file_2_2 = $fopen(dump_filename_2_2); // Assigning the channel descriptor for output file
        // For 3_2
        $sformat(dump_filename_3_2, "cmp_test.dmem0_3_2_%0d.dump", j);
        dmem0_dump_file_3_2 = $fopen(dump_filename_3_2); // Assigning the channel descriptor for output file
        
        // For 0_3
        $sformat(dump_filename_0_3, "cmp_test.dmem0_0_3_%0d.dump", j);
        dmem0_dump_file_0_3 = $fopen(dump_filename_0_3); // Assigning the channel descriptor for output file
        // For 1_3
        $sformat(dump_filename_1_3, "cmp_test.dmem0_1_3_%0d.dump", j);
        dmem0_dump_file_1_3 = $fopen(dump_filename_1_3); // Assigning the channel descriptor for output file
        // For 2_3
        $sformat(dump_filename_2_3, "cmp_test.dmem0_2_3_%0d.dump", j);
        dmem0_dump_file_2_3 = $fopen(dump_filename_2_3); // Assigning the channel descriptor for output file
        // For 3_3
        $sformat(dump_filename_3_3, "cmp_test.dmem0_3_3_%0d.dump", j);
        dmem0_dump_file_3_3 = $fopen(dump_filename_3_3); // Assigning the channel descriptor for output file
    
        // For 0_0
        $sformat(dump_filename_0_0, "cmp_test.dmem0_0_0_%0d.dump", j);
        dmem0_dump_file_0_0 = $fopen(dump_filename_0_0); // Opening the file
        $readmemh("imem_0_0_%0d.fill", instruc_mem_0_0.MEM);
        $readmemh("dmem_0_0.fill", data_mem_0_0.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_0_0, "Memory location #%d : %h ", i, data_mem_0_0.MEM[i]);
        end
        $fclose(dmem0_dump_file_0_0);
    
        // For 1_0
        $sformat(dump_filename_1_0, "cmp_test.dmem0_1_0_%0d.dump", j);
        dmem0_dump_file_1_0 = $fopen(dump_filename_1_0); // Opening the file
        $readmemh("imem_1_0_%0d.fill", instruc_mem_1_0.MEM);
        $readmemh("dmem_1_0.fill", data_mem_1_0.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_1_0, "Memory location #%d : %h ", i, data_mem_1_0.MEM[i]);
        end
        $fclose(dmem0_dump_file_1_0);
    
        // For 2_0
        $sformat(dump_filename_2_0, "cmp_test.dmem0_2_0_%0d.dump", j);
        dmem0_dump_file_2_0 = $fopen(dump_filename_2_0); // Opening the file
        $readmemh("imem_2_0_%0d.fill", instruc_mem_2_0.MEM);
        $readmemh("dmem_2_0.fill", data_mem_2_0.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_2_0, "Memory location #%d : %h ", i, data_mem_2_0.MEM[i]);
        end
        $fclose(dmem0_dump_file_2_0);
    
        // For 3_0
        $sformat(dump_filename_3_0, "cmp_test.dmem0_3_0_%0d.dump", j);
        dmem0_dump_file_3_0 = $fopen(dump_filename_3_0); // Opening the file
        $readmemh("imem_3_0_%0d.fill", instruc_mem_3_0.MEM);
        $readmemh("dmem_3_0.fill", data_mem_3_0.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_3_0, "Memory location #%d : %h ", i, data_mem_3_0.MEM[i]);
        end
        $fclose(dmem0_dump_file_3_0);
    
        // For 0_1
        $sformat(dump_filename_0_1, "cmp_test.dmem0_0_1_%0d.dump", j);
        dmem0_dump_file_0_1 = $fopen(dump_filename_0_1); // Opening the file
        $readmemh("imem_0_1_%0d.fill", instruc_mem_0_1.MEM);
        $readmemh("dmem_0_1.fill", data_mem_0_1.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_0_1, "Memory location #%d : %h ", i, data_mem_0_1.MEM[i]);
        end
        $fclose(dmem0_dump_file_0_1);
    
        // For 1_1
        $sformat(dump_filename_1_1, "cmp_test.dmem0_1_1_%0d.dump", j);
        dmem0_dump_file_1_1 = $fopen(dump_filename_1_1); // Opening the file
        $readmemh("imem_1_1_%0d.fill", instruc_mem_1_1.MEM);
        $readmemh("dmem_1_1.fill", data_mem_1_1.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_1_1, "Memory location #%d : %h ", i, data_mem_1_1.MEM[i]);
        end
        $fclose(dmem0_dump_file_1_1);
    
        // For 2_1
        $sformat(dump_filename_2_1, "cmp_test.dmem0_2_1_%0d.dump", j);
        dmem0_dump_file_2_1 = $fopen(dump_filename_2_1); // Opening the file
        $readmemh("imem_2_1_%0d.fill", instruc_mem_2_1.MEM);
        $readmemh("dmem_2_1.fill", data_mem_2_1.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_2_1, "Memory location #%d : %h ", i, data_mem_2_1.MEM[i]);
        end
        $fclose(dmem0_dump_file_2_1);
    
        // For 3_1
        $sformat(dump_filename_3_1, "cmp_test.dmem0_3_1_%0d.dump", j);
        dmem0_dump_file_3_1 = $fopen(dump_filename_3_1); // Opening the file
        $readmemh("imem_3_1_%0d.fill", instruc_mem_3_1.MEM);
        $readmemh("dmem_3_1.fill", data_mem_3_1.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_3_1, "Memory location #%d : %h ", i, data_mem_3_1.MEM[i]);
        end
        $fclose(dmem0_dump_file_3_1);
    
        // For 0_2
        $sformat(dump_filename_0_2, "cmp_test.dmem0_0_2_%0d.dump", j);
        dmem0_dump_file_0_2 = $fopen(dump_filename_0_2); // Opening the file
        $readmemh("imem_0_2_%0d.fill", instruc_mem_0_2.MEM);
        $readmemh("dmem_0_2.fill", data_mem_0_2.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_0_2, "Memory location #%d : %h ", i, data_mem_0_2.MEM[i]);
        end
        $fclose(dmem0_dump_file_0_2);
    
        // For 1_2
        $sformat(dump_filename_1_2, "cmp_test.dmem0_1_2_%0d.dump", j);
        dmem0_dump_file_1_2 = $fopen(dump_filename_1_2); // Opening the file
        $readmemh("imem_1_2_%0d.fill", instruc_mem_1_2.MEM);
        $readmemh("dmem_1_2.fill", data_mem_1_2.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_1_2, "Memory location #%d : %h ", i, data_mem_1_2.MEM[i]);
        end
        $fclose(dmem0_dump_file_1_2);
    
        // For 2_2
        $sformat(dump_filename_2_2, "cmp_test.dmem0_2_2_%0d.dump", j);
        dmem0_dump_file_2_2 = $fopen(dump_filename_2_2); // Opening the file
        $readmemh("imem_2_2_%0d.fill", instruc_mem_2_2.MEM);
        $readmemh("dmem_2_2.fill", data_mem_2_2.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_2_2, "Memory location #%d : %h ", i, data_mem_2_2.MEM[i]);
        end
        $fclose(dmem0_dump_file_2_2);
    
        // For 3_2
        $sformat(dump_filename_3_2, "cmp_test.dmem0_3_2_%0d.dump", j);
        dmem0_dump_file_3_2 = $fopen(dump_filename_3_2); // Opening the file
        $readmemh("imem_3_2_%0d.fill", instruc_mem_3_2.MEM);
        $readmemh("dmem_3_2.fill", data_mem_3_2.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_3_2, "Memory location #%d : %h ", i, data_mem_3_2.MEM[i]);
        end
        $fclose(dmem0_dump_file_3_2);
    
        // For 0_3
        $sformat(dump_filename_0_3, "cmp_test.dmem0_0_3_%0d.dump", j);
        dmem0_dump_file_0_3 = $fopen(dump_filename_0_3); // Opening the file
        $readmemh("imem_0_3_%0d.fill", instruc_mem_0_3.MEM);
        $readmemh("dmem_0_3.fill", data_mem_0_3.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_0_3, "Memory location #%d : %h ", i, data_mem_0_3.MEM[i]);
        end
        $fclose(dmem0_dump_file_0_3);
        
        // For 1_3
        $sformat(dump_filename_1_3, "cmp_test.dmem0_1_3_%0d.dump", j);
        dmem0_dump_file_1_3 = $fopen(dump_filename_1_3); // Opening the file
        $readmemh("imem_1_3_%0d.fill", instruc_mem_1_3.MEM);
        $readmemh("dmem_1_3.fill", data_mem_1_3.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_1_3, "Memory location #%d : %h ", i, data_mem_1_3.MEM[i]);
        end
        $fclose(dmem0_dump_file_1_3);
        
        // For 2_3
        $sformat(dump_filename_2_3, "cmp_test.dmem0_2_3_%0d.dump", j);
        dmem0_dump_file_2_3 = $fopen(dump_filename_2_3); // Opening the file
        $readmemh("imem_2_3_%0d.fill", instruc_mem_2_3.MEM);
        $readmemh("dmem_2_3.fill", data_mem_2_3.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_2_3, "Memory location #%d : %h ", i, data_mem_2_3.MEM[i]);
        end
        $fclose(dmem0_dump_file_2_3);
        
        // For 3_3
        $sformat(dump_filename_3_3, "cmp_test.dmem0_3_3_%0d.dump", j);
        dmem0_dump_file_3_3 = $fopen(dump_filename_3_3); // Opening the file
        $readmemh("imem_3_3_%0d.fill", instruc_mem_3_3.MEM);
        $readmemh("dmem_3_3.fill", data_mem_3_3.MEM);
        
        for (i = 0; i < 128; i = i + 1) begin
            $fdisplay(dmem0_dump_file_3_3, "Memory location #%d : %h ", i, data_mem_3_3.MEM[i]);
        end
        $fclose(dmem0_dump_file_3_3);
        
        end
       

        $finish;
    end
    
    always @(posedge clk) begin
        if (reset)
           clock_cycle <= 0;
        else  
           clock_cycle <= clock_cycle + 1;
    end

endmodule
