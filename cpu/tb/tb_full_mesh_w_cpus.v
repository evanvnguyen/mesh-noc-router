`timescale 1ns/10ps

module tb_full_mesh_w_cpus;

  reg clk, reset;

  wire [0:31] cpu_inst_in_0_3, cpu_inst_in_1_3, cpu_inst_in_2_3, cpu_inst_in_3_3;          // from imem
  wire [0:63] cpu_d_in_0_3, cpu_d_in_1_3, cpu_d_in_2_3, cpu_d_in_3_3;                      // data input from dmem
  wire [0:31] cpu_pc_out_0_3, cpu_pc_out_1_3, cpu_pc_out_2_3, cpu_pc_out_3_3;               // program counter out
  wire [0:63] cpu_d_out_0_3, cpu_d_out_1_3, cpu_d_out_2_3, cpu_d_out_3_3;               // data output to data memory
  wire [0:31] cpu_addr_out_0_3, cpu_addr_out_1_3, cpu_addr_out_2_3, cpu_addr_out_3_3;    // data memory address
  wire cpu_memWrEn_0_3, cpu_memWrEn_1_3, cpu_memWrEn_2_3, cpu_memWrEn_3_3;              // data memory write enable
  wire cpu_memEn_0_3, cpu_memEn_1_3, cpu_memEn_2_3, cpu_memEn_3_3;                      // data memory enable

  // CPU signals for x_2
  wire [0:31] cpu_inst_in_0_2, cpu_inst_in_1_2, cpu_inst_in_2_2, cpu_inst_in_3_2;          // from imem
  wire [0:63] cpu_d_in_0_2, cpu_d_in_1_2, cpu_d_in_2_2, cpu_d_in_3_2;                      // data input from dmem
  wire [0:31] cpu_pc_out_0_2, cpu_pc_out_1_2, cpu_pc_out_2_2, cpu_pc_out_3_2;               // program counter out
  wire [0:63] cpu_d_out_0_2, cpu_d_out_1_2, cpu_d_out_2_2, cpu_d_out_3_2;               // data output to data memory
  wire [0:31] cpu_addr_out_0_2, cpu_addr_out_1_2, cpu_addr_out_2_2, cpu_addr_out_3_2;    // data memory address
  wire cpu_memWrEn_0_2, cpu_memWrEn_1_2, cpu_memWrEn_2_2, cpu_memWrEn_3_2;              // data memory write enable
  wire cpu_memEn_0_2, cpu_memEn_1_2, cpu_memEn_2_2, cpu_memEn_3_2;                      // data memory enable
  
  // CPU signals for x_1
  wire [0:31] cpu_inst_in_0_1, cpu_inst_in_1_1, cpu_inst_in_2_1, cpu_inst_in_3_1;          // from imem
  wire [0:63] cpu_d_in_0_1, cpu_d_in_1_1, cpu_d_in_2_1, cpu_d_in_3_1;                      // data input from dmem
  wire [0:31] cpu_pc_out_0_1, cpu_pc_out_1_1, cpu_pc_out_2_1, cpu_pc_out_3_1;               // program counter out
  wire [0:63] cpu_d_out_0_1, cpu_d_out_1_1, cpu_d_out_2_1, cpu_d_out_3_1;               // data output to data memory
  wire [0:31] cpu_addr_out_0_1, cpu_addr_out_1_1, cpu_addr_out_2_1, cpu_addr_out_3_1;    // data memory address
  wire cpu_memWrEn_0_1, cpu_memWrEn_1_1, cpu_memWrEn_2_1, cpu_memWrEn_3_1;              // data memory write enable
  wire cpu_memEn_0_1, cpu_memEn_1_1, cpu_memEn_2_1, cpu_memEn_3_1;                      // data memory enable
  
  // CPU signals for x_0
  wire [0:31] cpu_inst_in_0_0, cpu_inst_in_1_0, cpu_inst_in_2_0, cpu_inst_in_3_0;          // from imem
  wire [0:63] cpu_d_in_0_0, cpu_d_in_1_0, cpu_d_in_2_0, cpu_d_in_3_0;                      // data input from dmem
  wire [0:31] cpu_pc_out_0_0, cpu_pc_out_1_0, cpu_pc_out_2_0, cpu_pc_out_3_0;               // program counter out
  wire [0:63] cpu_d_out_0_0, cpu_d_out_1_0, cpu_d_out_2_0, cpu_d_out_3_0;               // data output to data memory
  wire [0:31] cpu_addr_out_0_0, cpu_addr_out_1_0, cpu_addr_out_2_0, cpu_addr_out_3_0;    // data memory address
  wire cpu_memWrEn_0_0, cpu_memWrEn_1_0, cpu_memWrEn_2_0, cpu_memWrEn_3_0;              // data memory write enable
  wire cpu_memEn_0_0, cpu_memEn_1_0, cpu_memEn_2_0, cpu_memEn_3_0;                      // data memory enable
  
  integer clock_cycle, i, j, dmem0_dump_file, target;
  reg [127:0] imem_filename;
  reg [127:0] dump_filename;

  imem i_mem_0_0(
    .memAddr(cpu_pc_out_0_0),
    .dataOut(cpu_inst_in_0_0)
  );

  dmem d_mem_0_0(
    .clk(clk),
    .memEn(cpu_memEn_0_0),
    .memWrEn(cpu_memWrEn_0_0),
    .memAddr(cpu_addr_out_0_0),
    .dataIn(cpu_d_out_0_0),
    .dataOut(cpu_d_in_0_0)
  );

   imem i_mem_1_0(
    .memAddr(cpu_pc_out_1_0),
    .dataOut(cpu_inst_in_1_0)
  );

  dmem d_mem_1_0(
    .clk(clk),
    .memEn(cpu_memEn_1_0),
    .memWrEn(cpu_memWrEn_1_0),
    .memAddr(cpu_addr_out_1_0),
    .dataIn(cpu_d_out_1_0),
    .dataOut(cpu_d_in_1_0)
  );

  imem i_mem_2_0(
    .memAddr(cpu_pc_out_2_0),
    .dataOut(cpu_inst_in_2_0)
  );

  dmem d_mem_2_0(
    .clk(clk),
    .memEn(cpu_memEn_2_0),
    .memWrEn(cpu_memWrEn_2_0),
    .memAddr(cpu_addr_out_2_0),
    .dataIn(cpu_d_out_2_0),
    .dataOut(cpu_d_in_2_0)
  );

  imem i_mem_3_0(
    .memAddr(cpu_pc_out_3_0),
    .dataOut(cpu_inst_in_3_0)
  );

  dmem d_mem_3_0(
    .clk(clk),
    .memEn(cpu_memEn_3_0),
    .memWrEn(cpu_memWrEn_3_0),
    .memAddr(cpu_addr_out_3_0),
    .dataIn(cpu_d_out_3_0),
    .dataOut(cpu_d_in_3_0)
  );

  imem i_mem_0_1(
    .memAddr(cpu_pc_out_0_1),
    .dataOut(cpu_inst_in_0_1)
  );

  dmem d_mem_0_1(
    .clk(clk),
    .memEn(cpu_memEn_0_1),
    .memWrEn(cpu_memWrEn_0_1),
    .memAddr(cpu_addr_out_0_1),
    .dataIn(cpu_d_out_0_1),
    .dataOut(cpu_d_in_0_1)
  );

  imem i_mem_1_1(
    .memAddr(cpu_pc_out_1_1),
    .dataOut(cpu_inst_in_1_1)
  );

  dmem d_mem_1_1(
    .clk(clk),
    .memEn(cpu_memEn_1_1),
    .memWrEn(cpu_memWrEn_1_1),
    .memAddr(cpu_addr_out_1_1),
    .dataIn(cpu_d_out_1_1),
    .dataOut(cpu_d_in_1_1)
  );

  imem i_mem_2_1(
    .memAddr(cpu_pc_out_2_1),
    .dataOut(cpu_inst_in_2_1)
  );

  dmem d_mem_2_1(
    .clk(clk),
    .memEn(cpu_memEn_2_1),
    .memWrEn(cpu_memWrEn_2_1),
    .memAddr(cpu_addr_out_2_1),
    .dataIn(cpu_d_out_2_1),
    .dataOut(cpu_d_in_2_1)
  );

  imem i_mem_3_1(
    .memAddr(cpu_pc_out_3_1),
    .dataOut(cpu_inst_in_3_1)
  );

  dmem d_mem_3_1(
    .clk(clk),
    .memEn(cpu_memEn_3_1),
    .memWrEn(cpu_memWrEn_3_1),
    .memAddr(cpu_addr_out_3_1),
    .dataIn(cpu_d_out_3_1),
    .dataOut(cpu_d_in_3_1)
  );

  imem i_mem_0_2(
    .memAddr(cpu_pc_out_0_2),
    .dataOut(cpu_inst_in_0_2)
  );

  dmem d_mem_0_2(
    .clk(clk),
    .memEn(cpu_memEn_0_2),
    .memWrEn(cpu_memWrEn_0_2),
    .memAddr(cpu_addr_out_0_2),
    .dataIn(cpu_d_out_0_2),
    .dataOut(cpu_d_in_0_2)
  );

  imem i_mem_1_2(
    .memAddr(cpu_pc_out_1_2),
    .dataOut(cpu_inst_in_1_2)
  );

  dmem d_mem_1_2(
    .clk(clk),
    .memEn(cpu_memEn_1_2),
    .memWrEn(cpu_memWrEn_1_2),
    .memAddr(cpu_addr_out_1_2),
    .dataIn(cpu_d_out_1_2),
    .dataOut(cpu_d_in_1_2)
  );

  imem i_mem_2_2(
    .memAddr(cpu_pc_out_2_2),
    .dataOut(cpu_inst_in_2_2)
  );

  dmem d_mem_2_2(
    .clk(clk),
    .memEn(cpu_memEn_2_2),
    .memWrEn(cpu_memWrEn_2_2),
    .memAddr(cpu_addr_out_2_2),
    .dataIn(cpu_d_out_2_2),
    .dataOut(cpu_d_in_2_2)
  );

  imem i_mem_3_2(
    .memAddr(cpu_pc_out_3_2),
    .dataOut(cpu_inst_in_3_2)
  );

  dmem d_mem_3_2(
    .clk(clk),
    .memEn(cpu_memEn_3_2),
    .memWrEn(cpu_memWrEn_3_2),
    .memAddr(cpu_addr_out_3_2),
    .dataIn(cpu_d_out_3_2),
    .dataOut(cpu_d_in_3_2)
  );

  imem i_mem_0_3(
    .memAddr(cpu_pc_out_0_3),
    .dataOut(cpu_inst_in_0_3)
  );

  dmem d_mem_0_3(
    .clk(clk),
    .memEn(cpu_memEn_0_3),
    .memWrEn(cpu_memWrEn_0_3),
    .memAddr(cpu_addr_out_0_3),
    .dataIn(cpu_d_out_0_3),
    .dataOut(cpu_d_in_0_3)
  );

  imem i_mem_1_3(
    .memAddr(cpu_pc_out_1_3),
    .dataOut(cpu_inst_in_1_3)
  );

  dmem d_mem_1_3(
    .clk(clk),
    .memEn(cpu_memEn_1_3),
    .memWrEn(cpu_memWrEn_1_3),
    .memAddr(cpu_addr_out_1_3),
    .dataIn(cpu_d_out_1_3),
    .dataOut(cpu_d_in_1_3)
  );

  imem i_mem_2_3(
    .memAddr(cpu_pc_out_2_3),
    .dataOut(cpu_inst_in_2_3)
  );

  dmem d_mem_2_3(
    .clk(clk),
    .memEn(cpu_memEn_2_3),
    .memWrEn(cpu_memWrEn_2_3),
    .memAddr(cpu_addr_out_2_3),
    .dataIn(cpu_d_out_2_3),
    .dataOut(cpu_d_in_2_3)
  );

  imem i_mem_3_3(
    .memAddr(cpu_pc_out_3_3),
    .dataOut(cpu_inst_in_3_3)
  );

  dmem d_mem_3_3(
    .clk(clk),
    .memEn(cpu_memEn_3_3),
    .memWrEn(cpu_memWrEn_3_3),
    .memAddr(cpu_addr_out_3_3),
    .dataIn(cpu_d_out_3_3),
    .dataOut(cpu_d_in_3_3)
  );


  mesh_top_flat uut (
    .clk(clk),
    .reset(reset),

    // x_3
    .cpu_inst_in_0_3(cpu_inst_in_0_3), .cpu_inst_in_1_3(cpu_inst_in_1_3), .cpu_inst_in_2_3(cpu_inst_in_2_3), .cpu_inst_in_3_3(cpu_inst_in_3_3),
    .cpu_d_in_0_3(cpu_d_in_0_3), .cpu_d_in_1_3(cpu_d_in_1_3), .cpu_d_in_2_3(cpu_d_in_2_3), .cpu_d_in_3_3(cpu_d_in_3_3),
    .cpu_pc_out_0_3(cpu_pc_out_0_3), .cpu_pc_out_1_3(cpu_pc_out_1_3), .cpu_pc_out_2_3(cpu_pc_out_2_3), .cpu_pc_out_3_3(cpu_pc_out_3_3),
    .cpu_d_out_0_3(cpu_d_out_0_3), .cpu_d_out_1_3(cpu_d_out_1_3), .cpu_d_out_2_3(cpu_d_out_2_3), .cpu_d_out_3_3(cpu_d_out_3_3),
    .cpu_addr_out_0_3(cpu_addr_out_0_3), .cpu_addr_out_1_3(cpu_addr_out_1_3), .cpu_addr_out_2_3(cpu_addr_out_2_3), .cpu_addr_out_3_3(cpu_addr_out_3_3),
    .cpu_memWrEn_0_3(cpu_memWrEn_0_3), .cpu_memWrEn_1_3(cpu_memWrEn_1_3), .cpu_memWrEn_2_3(cpu_memWrEn_2_3), .cpu_memWrEn_3_3(cpu_memWrEn_3_3),
    .cpu_memEn_0_3(cpu_memEn_0_3), .cpu_memEn_1_3(cpu_memEn_1_3), .cpu_memEn_2_3(cpu_memEn_2_3), .cpu_memEn_3_3(cpu_memEn_3_3),

    // x_2
    .cpu_inst_in_0_2(cpu_inst_in_0_2), .cpu_inst_in_1_2(cpu_inst_in_1_2), .cpu_inst_in_2_2(cpu_inst_in_2_2), .cpu_inst_in_3_2(cpu_inst_in_3_2),
    .cpu_d_in_0_2(cpu_d_in_0_2), .cpu_d_in_1_2(cpu_d_in_1_2), .cpu_d_in_2_2(cpu_d_in_2_2), .cpu_d_in_3_2(cpu_d_in_3_2),
    .cpu_pc_out_0_2(cpu_pc_out_0_2), .cpu_pc_out_1_2(cpu_pc_out_1_2), .cpu_pc_out_2_2(cpu_pc_out_2_2), .cpu_pc_out_3_2(cpu_pc_out_3_2),
    .cpu_d_out_0_2(cpu_d_out_0_2), .cpu_d_out_1_2(cpu_d_out_1_2), .cpu_d_out_2_2(cpu_d_out_2_2), .cpu_d_out_3_2(cpu_d_out_3_2),
    .cpu_addr_out_0_2(cpu_addr_out_0_2), .cpu_addr_out_1_2(cpu_addr_out_1_2), .cpu_addr_out_2_2(cpu_addr_out_2_2), .cpu_addr_out_3_2(cpu_addr_out_3_2),
    .cpu_memWrEn_0_2(cpu_memWrEn_0_2), .cpu_memWrEn_1_2(cpu_memWrEn_1_2), .cpu_memWrEn_2_2(cpu_memWrEn_2_2), .cpu_memWrEn_3_2(cpu_memWrEn_3_2),
    .cpu_memEn_0_2(cpu_memEn_0_2), .cpu_memEn_1_2(cpu_memEn_1_2), .cpu_memEn_2_2(cpu_memEn_2_2), .cpu_memEn_3_2(cpu_memEn_3_2),

    // x_1
    .cpu_inst_in_0_1(cpu_inst_in_0_1), .cpu_inst_in_1_1(cpu_inst_in_1_1), .cpu_inst_in_2_1(cpu_inst_in_2_1), .cpu_inst_in_3_1(cpu_inst_in_3_1),
    .cpu_d_in_0_1(cpu_d_in_0_1), .cpu_d_in_1_1(cpu_d_in_1_1), .cpu_d_in_2_1(cpu_d_in_2_1), .cpu_d_in_3_1(cpu_d_in_3_1),
    .cpu_pc_out_0_1(cpu_pc_out_0_1), .cpu_pc_out_1_1(cpu_pc_out_1_1), .cpu_pc_out_2_1(cpu_pc_out_2_1), .cpu_pc_out_3_1(cpu_pc_out_3_1),
    .cpu_d_out_0_1(cpu_d_out_0_1), .cpu_d_out_1_1(cpu_d_out_1_1), .cpu_d_out_2_1(cpu_d_out_2_1), .cpu_d_out_3_1(cpu_d_out_3_1),
    .cpu_addr_out_0_1(cpu_addr_out_0_1), .cpu_addr_out_1_1(cpu_addr_out_1_1), .cpu_addr_out_2_1(cpu_addr_out_2_1), .cpu_addr_out_3_1(cpu_addr_out_3_1),
    .cpu_memWrEn_0_1(cpu_memWrEn_0_1), .cpu_memWrEn_1_1(cpu_memWrEn_1_1), .cpu_memWrEn_2_1(cpu_memWrEn_2_1), .cpu_memWrEn_3_1(cpu_memWrEn_3_1),
    .cpu_memEn_0_1(cpu_memEn_0_1), .cpu_memEn_1_1(cpu_memEn_1_1), .cpu_memEn_2_1(cpu_memEn_2_1), .cpu_memEn_3_1(cpu_memEn_3_1),

    // x_0
    .cpu_inst_in_0_0(cpu_inst_in_0_0), .cpu_inst_in_1_0(cpu_inst_in_1_0), .cpu_inst_in_2_0(cpu_inst_in_2_0), .cpu_inst_in_3_0(cpu_inst_in_3_0),
    .cpu_d_in_0_0(cpu_d_in_0_0), .cpu_d_in_1_0(cpu_d_in_1_0), .cpu_d_in_2_0(cpu_d_in_2_0), .cpu_d_in_3_0(cpu_d_in_3_0),
    .cpu_pc_out_0_0(cpu_pc_out_0_0), .cpu_pc_out_1_0(cpu_pc_out_1_0), .cpu_pc_out_2_0(cpu_pc_out_2_0), .cpu_pc_out_3_0(cpu_pc_out_3_0),
    .cpu_d_out_0_0(cpu_d_out_0_0), .cpu_d_out_1_0(cpu_d_out_1_0), .cpu_d_out_2_0(cpu_d_out_2_0), .cpu_d_out_3_0(cpu_d_out_3_0),
    .cpu_addr_out_0_0(cpu_addr_out_0_0), .cpu_addr_out_1_0(cpu_addr_out_1_0), .cpu_addr_out_2_0(cpu_addr_out_2_0), .cpu_addr_out_3_0(cpu_addr_out_3_0),
    .cpu_memWrEn_0_0(cpu_memWrEn_0_0), .cpu_memWrEn_1_0(cpu_memWrEn_1_0), .cpu_memWrEn_2_0(cpu_memWrEn_2_0), .cpu_memWrEn_3_0(cpu_memWrEn_3_0),
    .cpu_memEn_0_0(cpu_memEn_0_0), .cpu_memEn_1_0(cpu_memEn_1_0), .cpu_memEn_2_0(cpu_memEn_2_0), .cpu_memEn_3_0(cpu_memEn_3_0)
  );

// the source is x
    
    initial clk = 0;
    always #2 clk <= ~clk;

    integer cpu_inject_log, cpu_dmem_log, cpu_receive, node_receive;
    integer cpu_dmem_log_0_0, cpu_dmem_log_0_1, cpu_dmem_log_0_2, cpu_dmem_log_0_3;
    integer cpu_dmem_log_1_0, cpu_dmem_log_1_1, cpu_dmem_log_1_2, cpu_dmem_log_1_3;
    integer cpu_dmem_log_2_0, cpu_dmem_log_2_1, cpu_dmem_log_2_2, cpu_dmem_log_2_3;
    integer cpu_dmem_log_3_0, cpu_dmem_log_3_1, cpu_dmem_log_3_2, cpu_dmem_log_3_3;
    
    // Task to open the cpu_inject_log file and set up fmonitor(s)
    // Check to see what data is getting received to which CPU dmem
    task setup_cpu_receive_monitor;
      begin
        node_receive = $fopen("node_receive.log", "w");
        if (node_receive == 0) begin
          $display("Error opening node_receive.log!");
          $finish;
       end

    // Write the header to the log file with additional direction signals.
    $fdisplay(node_receive, "block,component,type,clock_cycle,data,x_source,y_source,cwdi,ccwdi,nsdi,sndi");

    // Row 0 (y = 0): routers from 3_0, 2_0, 1_0, 0_0
    $fmonitor(node_receive, "Router,3_0,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_0.router_3_0.pedo, 
      uut.row_0.router_3_0.pedo[39:32], 
      uut.row_0.router_3_0.pedo[47:40],
      uut.row_0.router_3_0.cwdi,
      uut.row_0.router_3_0.ccwdi,
      uut.row_0.router_3_0.nsdi,
      uut.row_0.router_3_0.sndi);
      
    $fmonitor(node_receive, "Router,2_0,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_0.router_2_0.pedo, 
      uut.row_0.router_2_0.pedo[39:32], 
      uut.row_0.router_2_0.pedo[47:40],
      uut.row_0.router_2_0.cwdi,
      uut.row_0.router_2_0.ccwdi,
      uut.row_0.router_2_0.nsdi,
      uut.row_0.router_2_0.sndi);
      
    $fmonitor(node_receive, "Router,1_0,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_0.router_1_0.pedo, 
      uut.row_0.router_1_0.pedo[39:32], 
      uut.row_0.router_1_0.pedo[47:40],
      uut.row_0.router_1_0.cwdi,
      uut.row_0.router_1_0.ccwdi,
      uut.row_0.router_1_0.nsdi,
      uut.row_0.router_1_0.sndi);
      
    $fmonitor(node_receive, "Router,0_0,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_0.router_0_0.pedo, 
      uut.row_0.router_0_0.pedo[39:32], 
      uut.row_0.router_0_0.pedo[47:40],
      uut.row_0.router_0_0.cwdi,
      uut.row_0.router_0_0.ccwdi,
      uut.row_0.router_0_0.nsdi,
      uut.row_0.router_0_0.sndi);

    // Row 1 (y = 1): routers from 3_1, 2_1, 1_1, 0_1
    $fmonitor(node_receive, "Router,3_1,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_1.router_3_1.pedo, 
      uut.row_1.router_3_1.pedo[39:32], 
      uut.row_1.router_3_1.pedo[47:40],
      uut.row_1.router_3_1.cwdi,
      uut.row_1.router_3_1.ccwdi,
      uut.row_1.router_3_1.nsdi,
      uut.row_1.router_3_1.sndi);
      
    $fmonitor(node_receive, "Router,2_1,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_1.router_2_1.pedo, 
      uut.row_1.router_2_1.pedo[39:32], 
      uut.row_1.router_2_1.pedo[47:40],
      uut.row_1.router_2_1.cwdi,
      uut.row_1.router_2_1.ccwdi,
      uut.row_1.router_2_1.nsdi,
      uut.row_1.router_2_1.sndi);
      
    $fmonitor(node_receive, "Router,1_1,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_1.router_1_1.pedo, 
      uut.row_1.router_1_1.pedo[39:32], 
      uut.row_1.router_1_1.pedo[47:40],
      uut.row_1.router_1_1.cwdi,
      uut.row_1.router_1_1.ccwdi,
      uut.row_1.router_1_1.nsdi,
      uut.row_1.router_1_1.sndi);
      
    $fmonitor(node_receive, "Router,0_1,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_1.router_0_1.pedo, 
      uut.row_1.router_0_1.pedo[39:32], 
      uut.row_1.router_0_1.pedo[47:40],
      uut.row_1.router_0_1.cwdi,
      uut.row_1.router_0_1.ccwdi,
      uut.row_1.router_0_1.nsdi,
      uut.row_1.router_0_1.sndi);

    // Row 2 (y = 2): routers from 3_2, 2_2, 1_2, 0_2
    $fmonitor(node_receive, "Router,3_2,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_2.router_3_2.pedo, 
      uut.row_2.router_3_2.pedo[39:32], 
      uut.row_2.router_3_2.pedo[47:40],
      uut.row_2.router_3_2.cwdi,
      uut.row_2.router_3_2.ccwdi,
      uut.row_2.router_3_2.nsdi,
      uut.row_2.router_3_2.sndi);
      
    $fmonitor(node_receive, "Router,2_2,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_2.router_2_2.pedo, 
      uut.row_2.router_2_2.pedo[39:32], 
      uut.row_2.router_2_2.pedo[47:40],
      uut.row_2.router_2_2.cwdi,
      uut.row_2.router_2_2.ccwdi,
      uut.row_2.router_2_2.nsdi,
      uut.row_2.router_2_2.sndi);
      
    $fmonitor(node_receive, "Router,1_2,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_2.router_1_2.pedo, 
      uut.row_2.router_1_2.pedo[39:32], 
      uut.row_2.router_1_2.pedo[47:40],
      uut.row_2.router_1_2.cwdi,
      uut.row_2.router_1_2.ccwdi,
      uut.row_2.router_1_2.nsdi,
      uut.row_2.router_1_2.sndi);
      
    $fmonitor(node_receive, "Router,0_2,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_2.router_0_2.pedo, 
      uut.row_2.router_0_2.pedo[39:32], 
      uut.row_2.router_0_2.pedo[47:40],
      uut.row_2.router_0_2.cwdi,
      uut.row_2.router_0_2.ccwdi,
      uut.row_2.router_0_2.nsdi,
      uut.row_2.router_0_2.sndi);

    // Row 3 (y = 3): routers from 3_3, 2_3, 1_3, 0_3
    $fmonitor(node_receive, "Router,3_3,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_3.router_3_3.pedo, 
      uut.row_3.router_3_3.pedo[39:32], 
      uut.row_3.router_3_3.pedo[47:40],
      uut.row_3.router_3_3.cwdi,
      uut.row_3.router_3_3.ccwdi,
      uut.row_3.router_3_3.nsdi,
      uut.row_3.router_3_3.sndi);
      
    $fmonitor(node_receive, "Router,2_3,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_3.router_2_3.pedo, 
      uut.row_3.router_2_3.pedo[39:32], 
      uut.row_3.router_2_3.pedo[47:40],
      uut.row_3.router_2_3.cwdi,
      uut.row_3.router_2_3.ccwdi,
      uut.row_3.router_2_3.nsdi,
      uut.row_3.router_2_3.sndi);
      
    $fmonitor(node_receive, "Router,1_3,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_3.router_1_3.pedo, 
      uut.row_3.router_1_3.pedo[39:32], 
      uut.row_3.router_1_3.pedo[47:40],
      uut.row_3.router_1_3.cwdi,
      uut.row_3.router_1_3.ccwdi,
      uut.row_3.router_1_3.nsdi,
      uut.row_3.router_1_3.sndi);
      
    $fmonitor(node_receive, "Router,0_3,router_direction_channels,%0d,%h,%0d,%0d,%h,%h,%h,%h", 
      clock_cycle, 
      uut.row_3.router_0_3.pedo, 
      uut.row_3.router_0_3.pedo[39:32], 
      uut.row_3.router_0_3.pedo[47:40],
      uut.row_3.router_0_3.cwdi,
      uut.row_3.router_0_3.ccwdi,
      uut.row_3.router_0_3.nsdi,
      uut.row_3.router_0_3.sndi);
  end
endtask





    // Task to open the cpu_inject_log file and set up fmonitor(s)
    task setup_cpu_inject_monitor;
      begin
        cpu_inject_log = $fopen("cpu_inject_log.log", "w");
        if (cpu_inject_log == 0) begin
          $display("Error opening cpu_inject_log.log!");
          $finish;
        end
    
        // Write the header to the log file.
        $fdisplay(cpu_inject_log, "block,component,type,clock_cycle,data,x_source,y_source");
    
        // Row 0 (y = 0): routers from 3_0, 2_0, 1_0, 0_0
        $fmonitor(cpu_inject_log, "Router,3_0,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_0.router_3_0.pedi, uut.row_0.router_3_0.pedi[39:32], uut.row_0.router_3_0.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,2_0,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_0.router_2_0.pedi, uut.row_0.router_2_0.pedi[39:32], uut.row_0.router_2_0.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,1_0,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_0.router_1_0.pedi, uut.row_0.router_1_0.pedi[39:32], uut.row_0.router_1_0.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,0_0,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_0.router_0_0.pedi, uut.row_0.router_0_0.pedi[39:32], uut.row_0.router_0_0.pedi[47:40]);
    
        // Row 1 (y = 1): routers from 3_1, 2_1, 1_1, 0_1
        $fmonitor(cpu_inject_log, "Router,3_1,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_1.router_3_1.pedi, uut.row_1.router_3_1.pedi[39:32], uut.row_1.router_3_1.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,2_1,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_1.router_2_1.pedi, uut.row_1.router_2_1.pedi[39:32], uut.row_1.router_2_1.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,1_1,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_1.router_1_1.pedi, uut.row_1.router_1_1.pedi[39:32], uut.row_1.router_1_1.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,0_1,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_1.router_0_1.pedi, uut.row_1.router_0_1.pedi[39:32], uut.row_1.router_0_1.pedi[47:40]);
    
        // Row 2 (y = 2): routers from 3_2, 2_2, 1_2, 0_2
        $fmonitor(cpu_inject_log, "Router,3_2,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_2.router_3_2.pedi, uut.row_2.router_3_2.pedi[39:32], uut.row_2.router_3_2.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,2_2,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_2.router_2_2.pedi, uut.row_2.router_2_2.pedi[39:32], uut.row_2.router_2_2.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,1_2,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_2.router_1_2.pedi, uut.row_2.router_1_2.pedi[39:32], uut.row_2.router_1_2.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,0_2,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_2.router_0_2.pedi, uut.row_2.router_0_2.pedi[39:32], uut.row_2.router_0_2.pedi[47:40]);
    
        // Row 3 (y = 3): routers from 3_3, 2_3, 1_3, 0_3
        $fmonitor(cpu_inject_log, "Router,3_3,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_3.router_3_3.pedi, uut.row_3.router_3_3.pedi[39:32], uut.row_3.router_3_3.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,2_3,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_3.router_2_3.pedi, uut.row_3.router_2_3.pedi[39:32], uut.row_3.router_2_3.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,1_3,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_3.router_1_3.pedi, uut.row_3.router_1_3.pedi[39:32], uut.row_3.router_1_3.pedi[47:40]);
        $fmonitor(cpu_inject_log, "Router,0_3,cpu_data_inject,%0d,%h,%0d,%0d", 
          clock_cycle, uut.row_3.router_0_3.pedi, uut.row_3.router_0_3.pedi[39:32], uut.row_3.router_0_3.pedi[47:40]);
      end
    endtask
        
    // Task to open the cpu_dmem_log file and set up fmonitor(s)
    //task setup_destination_dmem_monitor;
    //  begin
    //    cpu_dmem_log = $fopen("cpu_0_0_dmem.log", "w");
    //    if (cpu_dmem_log == 0) begin
    //      $display("Error opening cpu_dmem_log.log!");
    //      $finish;
    //    end
    //
    //    // Print header
    //    $fdisplay(cpu_dmem_log, "block,component,type,clock_cycle,data,x_source,y_source");
    //
    //    // Set up a monitor that prints:
    //    // - clock_cycle
    //    // - dataIn (the entire 64-bit value)
    //    // - if dataIn is not 0 then a marker "<--dmem_inject"
    //    // - the source extracted from dataIn: y_src is now bits [16:23], x_src is bits [24:31]
    //    $fmonitor(cpu_dmem_log,
    //      "CPU,dmem,data_in,%0d,%h,%0d,%0d",
    //      clock_cycle,
    //      d_mem_0_0.dataIn,
    //      d_mem_0_0.dataIn[24:31],
    //      d_mem_0_0.dataIn[16:23]
    //    );
    //  end
    //endtask
    
    task setup_destination_dmem_monitor;
      begin
        // ---------------- DMEM Instance: d_mem_0_0 ----------------
        cpu_dmem_log_0_0 = $fopen("cpu_0_0_dmem.log", "w");
        if (cpu_dmem_log_0_0 == 0) begin
          $display("Error opening cpu_0_0_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_0_0, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_0_0,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d%s",
          clock_cycle,
          d_mem_0_0.dataIn,
          d_mem_0_0.dataIn[24:31],
          d_mem_0_0.dataIn[16:23],
          ((d_mem_0_0.dataIn != 32'h0) && (d_mem_0_0.dataIn != 32'bX)) ? "<--inject" : ""
        );
        
        // ---------------- DMEM Instance: d_mem_0_1 ----------------
        cpu_dmem_log_0_1 = $fopen("cpu_0_1_dmem.log", "w");
        if (cpu_dmem_log_0_1 == 0) begin
          $display("Error opening cpu_0_1_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_0_1, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_0_1,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_0_1.dataIn,
          d_mem_0_1.dataIn[24:31],
          d_mem_0_1.dataIn[16:23]
        );
    
        // ---------------- DMEM Instance: d_mem_0_2 ----------------
        cpu_dmem_log_0_2 = $fopen("cpu_0_2_dmem.log", "w");
        if (cpu_dmem_log_0_2 == 0) begin
          $display("Error opening cpu_0_2_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_0_2, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_0_2,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_0_2.dataIn,
          d_mem_0_2.dataIn[24:31],
          d_mem_0_2.dataIn[16:23]
        );
    
        // ---------------- DMEM Instance: d_mem_0_3 ----------------
        cpu_dmem_log_0_3 = $fopen("cpu_0_3_dmem.log", "w");
        if (cpu_dmem_log_0_3 == 0) begin
          $display("Error opening cpu_0_3_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_0_3, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_0_3,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_0_3.dataIn,
          d_mem_0_3.dataIn[24:31],
          d_mem_0_3.dataIn[16:23]
        );
        
        // ---------------- DMEM Instance: d_mem_1_0 ----------------
        cpu_dmem_log_1_0 = $fopen("cpu_1_0_dmem.log", "w");
        if (cpu_dmem_log_1_0 == 0) begin
          $display("Error opening cpu_1_0_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_1_0, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_1_0,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_1_0.dataIn,
          d_mem_1_0.dataIn[24:31],
          d_mem_1_0.dataIn[16:23]
        );
        
        // ---------------- DMEM Instance: d_mem_1_1 ----------------
        cpu_dmem_log_1_1 = $fopen("cpu_1_1_dmem.log", "w");
        if (cpu_dmem_log_1_1 == 0) begin
          $display("Error opening cpu_1_1_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_1_1, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_1_1,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_1_1.dataIn,
          d_mem_1_1.dataIn[24:31],
          d_mem_1_1.dataIn[16:23]
        );
    
        // ---------------- DMEM Instance: d_mem_1_2 ----------------
        cpu_dmem_log_1_2 = $fopen("cpu_1_2_dmem.log", "w");
        if (cpu_dmem_log_1_2 == 0) begin
          $display("Error opening cpu_1_2_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_1_2, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_1_2,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_1_2.dataIn,
          d_mem_1_2.dataIn[24:31],
          d_mem_1_2.dataIn[16:23]
        );
    
        // ---------------- DMEM Instance: d_mem_1_3 ----------------
        cpu_dmem_log_1_3 = $fopen("cpu_1_3_dmem.log", "w");
        if (cpu_dmem_log_1_3 == 0) begin
          $display("Error opening cpu_1_3_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_1_3, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_1_3,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_1_3.dataIn,
          d_mem_1_3.dataIn[24:31],
          d_mem_1_3.dataIn[16:23]
        );
        
        // ---------------- DMEM Instance: d_mem_2_0 ----------------
        cpu_dmem_log_2_0 = $fopen("cpu_2_0_dmem.log", "w");
        if (cpu_dmem_log_2_0 == 0) begin
          $display("Error opening cpu_2_0_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_2_0, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_2_0,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_2_0.dataIn,
          d_mem_2_0.dataIn[24:31],
          d_mem_2_0.dataIn[16:23]
        );
    
        // ---------------- DMEM Instance: d_mem_2_1 ----------------
        cpu_dmem_log_2_1 = $fopen("cpu_2_1_dmem.log", "w");
        if (cpu_dmem_log_2_1 == 0) begin
          $display("Error opening cpu_2_1_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_2_1, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_2_1,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_2_1.dataIn,
          d_mem_2_1.dataIn[24:31],
          d_mem_2_1.dataIn[16:23]
        );
    
        // ---------------- DMEM Instance: d_mem_2_2 ----------------
        cpu_dmem_log_2_2 = $fopen("cpu_2_2_dmem.log", "w");
        if (cpu_dmem_log_2_2 == 0) begin
          $display("Error opening cpu_2_2_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_2_2, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_2_2,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_2_2.dataIn,
          d_mem_2_2.dataIn[24:31],
          d_mem_2_2.dataIn[16:23]
        );
    
        // ---------------- DMEM Instance: d_mem_2_3 ----------------
        cpu_dmem_log_2_3 = $fopen("cpu_2_3_dmem.log", "w");
        if (cpu_dmem_log_2_3 == 0) begin
          $display("Error opening cpu_2_3_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_2_3, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_2_3,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_2_3.dataIn,
          d_mem_2_3.dataIn[24:31],
          d_mem_2_3.dataIn[16:23]
        );
        
        // ---------------- DMEM Instance: d_mem_3_0 ----------------
        cpu_dmem_log_3_0 = $fopen("cpu_3_0_dmem.log", "w");
        if (cpu_dmem_log_3_0 == 0) begin
          $display("Error opening cpu_3_0_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_3_0, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_3_0,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_3_0.dataIn,
          d_mem_3_0.dataIn[24:31],
          d_mem_3_0.dataIn[16:23]
        );
    
        // ---------------- DMEM Instance: d_mem_3_1 ----------------
        cpu_dmem_log_3_1 = $fopen("cpu_3_1_dmem.log", "w");
        if (cpu_dmem_log_3_1 == 0) begin
          $display("Error opening cpu_3_1_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_3_1, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_3_1,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_3_1.dataIn,
          d_mem_3_1.dataIn[24:31],
          d_mem_3_1.dataIn[16:23]
        );
    
        // ---------------- DMEM Instance: d_mem_3_2 ----------------
        cpu_dmem_log_3_2 = $fopen("cpu_3_2_dmem.log", "w");
        if (cpu_dmem_log_3_2 == 0) begin
          $display("Error opening cpu_3_2_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_3_2, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_3_2,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_3_2.dataIn,
          d_mem_3_2.dataIn[24:31],
          d_mem_3_2.dataIn[16:23],
          ((d_mem_3_2.dataIn != 32'h0) && (d_mem_3_2.dataIn != 32'bX)) ? "<--inject" : ""
        );
    
        // ---------------- DMEM Instance: d_mem_3_3 ----------------
        cpu_dmem_log_3_3 = $fopen("cpu_3_3_dmem.log", "w");
        if (cpu_dmem_log_3_3 == 0) begin
          $display("Error opening cpu_3_3_dmem.log!");
          $finish;
        end
        $fdisplay(cpu_dmem_log_3_3, "block,component,type,clock_cycle,data,x_source,y_source");
        $fmonitor(cpu_dmem_log_3_3,
          "CPU,dmem,data_in,%0d,%h,%0d,%0d",
          clock_cycle,
          d_mem_3_3.dataIn,
          d_mem_3_3.dataIn[24:31],
          d_mem_3_3.dataIn[16:23]
        );
        
      end
    endtask
   
    
    // Task to load the instruction and data memory files
    task load_memories_gather_0_0;
      begin
        // Load instruction memory (for all instances)
       $readmemh("receive-inst.txt", i_mem_0_0.MEM);
       //$readmemh("send-inst.txt", i_mem_0_1.MEM);
       //$readmemh("send-inst.txt", i_mem_0_2.MEM);
       //$readmemh("send-inst.txt", i_mem_0_3.MEM);
       //$readmemh("send-inst.txt", i_mem_1_0.MEM);
       //$readmemh("send-inst.txt", i_mem_1_1.MEM);
       //$readmemh("send-inst.txt", i_mem_1_2.MEM);
       //$readmemh("send-inst.txt", i_mem_1_3.MEM);
       //$readmemh("send-inst.txt", i_mem_2_0.MEM);
       //$readmemh("send-inst.txt", i_mem_2_1.MEM);
       //$readmemh("send-inst.txt", i_mem_2_2.MEM);
       //$readmemh("send-inst.txt", i_mem_2_3.MEM);
       //$readmemh("send-inst.txt", i_mem_3_0.MEM);
       //$readmemh("send-inst.txt", i_mem_3_1.MEM);
       //$readmemh("send-inst.txt", i_mem_3_2.MEM);
       //$readmemh("send-inst.txt", i_mem_3_3.MEM);
        
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_1_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_1_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_2_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_2_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_3_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_3_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/math.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_0_0.txt", d_mem_0_0.MEM);
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_1_0.txt", d_mem_1_0.MEM);
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_2_0.txt", d_mem_2_0.MEM);
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_3_0.txt", d_mem_3_0.MEM);
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_0_1.txt", d_mem_0_1.MEM);
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_1_1.txt", d_mem_1_1.MEM);
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_2_1.txt", d_mem_2_1.MEM);  
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_3_1.txt", d_mem_3_1.MEM);  
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_0_2.txt", d_mem_0_2.MEM);
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_1_2.txt", d_mem_1_2.MEM);  
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_2_2.txt", d_mem_2_2.MEM);
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_3_2.txt", d_mem_3_2.MEM);  
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_0_3.txt", d_mem_0_3.MEM);
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_1_3.txt", d_mem_1_3.MEM);  
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_2_3.txt", d_mem_2_3.MEM);  
        //$readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_0/d_mem_3_3.txt", d_mem_3_3.MEM);
        
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/math/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_1_0;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("receive-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_0/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_2_0;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("receive-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_0/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_3_0;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("receive-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_0/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    // Task to load the instruction and data memory files
    task load_memories_gather_0_1;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("receive-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_1/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_1_1;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("receive-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_1/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_2_1;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("receive-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_1/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_3_1;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("receive-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_1/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    // Task to load the instruction and data memory files
    task load_memories_gather_0_2;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("receive-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_2/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_1_2;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("receive-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_2/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_2_2;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("receive-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_2/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_3_2;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("receive-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_2/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    
    // Task to load the instruction and data memory files
    task load_memories_gather_0_3;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("receive-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/0_3/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_1_3;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("receive-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/1_3/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_2_3;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("receive-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/2_3/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    
    task load_memories_gather_3_3;
      begin
        // Load instruction memory (for all instances)
        $readmemh("send-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("receive-inst.txt", i_mem_3_3.MEM);
    
        // Load selected data memories
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_1_0.txt", d_mem_1_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_2_0.txt", d_mem_2_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_3_0.txt", d_mem_3_0.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_0_1.txt", d_mem_0_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_2_1.txt", d_mem_2_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_3_1.txt", d_mem_3_1.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_0_2.txt", d_mem_0_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_1_2.txt", d_mem_1_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_3_2.txt", d_mem_3_2.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_0_3.txt", d_mem_0_3.MEM);
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_1_3.txt", d_mem_1_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_2_3.txt", d_mem_2_3.MEM);  
        $readmemh("D:/mesh-noc-router/mesh-noc-router/cpu/tb_test_files/full_mesh_files/dmem/3_3/d_mem_3_3.txt", d_mem_3_3.MEM);
      end
    endtask
    // Task to dump the memory contents to a file
    task dump_data_memory(input integer row);
      integer i, dmem0_dump_file;
      reg [1023:0] dump_filename;
      begin
        // Create a file name based on the row index
        $sformat(dump_filename, "mesh_row_%0d.dump", row);
        dmem0_dump_file = $fopen(dump_filename, "w");
        if(dmem0_dump_file == 0) begin
          $display("Error opening %s for writing!", dump_filename);
          $finish;
        end
    
        // Write header and dump memory addresses 0 to 127
        $fdisplay(dmem0_dump_file, "|\tMem\t|\tD0\t|\tD1\t|\tD2\t|\tD3\t|");
        $fdisplay(dmem0_dump_file, "---------------------------------");
        for (i = 0; i < 128; i = i + 1) begin
          $fdisplay(dmem0_dump_file, "|\t#%0d\t|\t%h\t|\t%h\t|\t%h\t|\t%h\t|", 
                    i, d_mem_0_0.MEM[i], d_mem_1_0.MEM[i], d_mem_2_0.MEM[i], d_mem_3_0.MEM[i]);
        end
        $fclose(dmem0_dump_file);
      end
    endtask
    
    // Main simulation initial block
  // Main simulation initial block
  initial begin
    clock_cycle = 0;
        
    setup_destination_dmem_monitor();
    setup_cpu_inject_monitor();
    setup_cpu_receive_monitor();
    
    // Assert reset and deassert after a few cycles
    reset = 1'b1;
    repeat(5) @(negedge clk);
    reset = 1'b0;
    
      load_memories_gather_0_0();
      //load_memories_gather_0_1();
      //load_memories_gather_0_2();
      //load_memories_gather_0_3();
      //load_memories_gather_1_0();
      //load_memories_gather_1_1();
      //load_memories_gather_1_2();
      //load_memories_gather_1_3();
      //load_memories_gather_2_0();
      //load_memories_gather_2_1();
      //load_memories_gather_2_2();
      //load_memories_gather_2_3();
      //load_memories_gather_3_0();
      //load_memories_gather_3_1();
      //load_memories_gather_3_2();
      //load_memories_gather_3_3();    
    // Wait for termination condition (for example, when instruction 0_0 becomes zero)
    wait (cpu_inst_in_0_0 == 32'h00000000);
    $display("The program completed in %d cycles", clock_cycle);
    
    // Flush the pipeline
    repeat(20) @(negedge clk);
    
    // Dump logs
    $fclose(cpu_dmem_log);
    $fclose(cpu_receive);
    $fclose(cpu_inject_log);
    
    $finish;
  end

  // Clock cycle counter
  always @(posedge clk) begin
    if (reset)
      clock_cycle <= 0;
    else  
      clock_cycle <= clock_cycle + 1;
  end

endmodule
