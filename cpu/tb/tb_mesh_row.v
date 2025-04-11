`timescale 1ns/10ps

module tb_mesh_row;

  reg clk, reset;
  reg snro_0_0, nssi_0_0;
  reg snro_1_0, nssi_1_0;
  reg snro_2_0, nssi_2_0;
  reg snro_3_0, nssi_3_0;

  reg [63:0] nsdi_0_0;
  reg [63:0] nsdi_1_0;
  reg [63:0] nsdi_2_0;
  reg [63:0] nsdi_3_0;

  wire snso_0_0, nsri_0_0;
  wire snso_1_0, nsri_1_0;
  wire snso_2_0, nsri_2_0;
  wire snso_3_0, nsri_3_0;

  wire [63:0] sndo_0_0;
  wire [63:0] sndo_1_0;
  wire [63:0] sndo_2_0;
  wire [63:0] sndo_3_0;
  
  // CPU tb signals
  wire [0:31]  node_0_0_inst_in;
  wire [0:63]  node_0_0_d_in;
  wire [0:31] node_0_0_pc_out;
  wire [0:63] node_0_0_d_out;
  wire [0:31] node_0_0_addr_out;
  wire        node_0_0_memWrEn;
  wire        node_0_0_memE;

  wire [0:31]  node_1_0_inst_in;
	wire [0:63]  node_1_0_d_in;
	wire [0:31] node_1_0_pc_out;
	wire [0:63] node_1_0_d_out;
	wire [0:31] node_1_0_addr_out;
	wire        node_1_0_memWrEn;
	wire        node_1_0_memE;

	wire [0:31]  node_2_0_inst_in;
	wire [0:63]  node_2_0_d_in;
	wire [0:31] node_2_0_pc_out;
	wire [0:63] node_2_0_d_out;
	wire [0:31] node_2_0_addr_out;
	wire        node_2_0_memWrEn;
	wire        node_2_0_memE;

  wire [0:31]  node_3_0_inst_in;
	wire [0:63]  node_3_0_d_in;
	wire [0:31] node_3_0_pc_out;
	wire [0:63] node_3_0_d_out;
	wire [0:31] node_3_0_addr_out;
	wire        node_3_0_memWrEn;
	wire        node_3_0_memE;
  
  integer clock_cycle, i, j, dmem0_dump_file;
  reg [127:0] imem_filename;
  reg [127:0] dump_filename;

  imem i_mem_0_0(
    .memAddr(node_0_0_pc_out),
    .dataOut(node_0_0_inst_in)
  );

  dmem d_mem_0_0(
    .clk(clk),
    .memEn(node_0_0_memEn),
    .memWrEn(node_0_0_memWrEn),
    .memAddr(node_0_0_addr_out),
    .dataIn(node_0_0_d_out),
    .dataOut(node_0_0_d_in)
  );

  imem i_mem_1_0(
    .memAddr(node_1_0_pc_out),
    .dataOut(node_1_0_inst_in)
  );

  dmem d_mem_1_0(
    .clk(clk),
    .memEn(node_1_0_memEn),
    .memWrEn(node_1_0_memWrEn),
    .memAddr(node_1_0_addr_out),
    .dataIn(node_1_0_d_out),
    .dataOut(node_1_0_d_in)
  );

  imem i_mem_2_0(
    .memAddr(node_2_0_pc_out),
    .dataOut(node_2_0_inst_in)
  );

  dmem d_mem_2_0(
    .clk(clk),
    .memEn(node_2_0_memEn),
    .memWrEn(node_2_0_memWrEn),
    .memAddr(node_2_0_addr_out),
    .dataIn(node_2_0_d_out),
    .dataOut(node_2_0_d_in)
  );

  imem i_mem_3_0(
    .memAddr(node_3_0_pc_out),
    .dataOut(node_3_0_inst_in)
  );

  dmem d_mem_3_0(
    .clk(clk),
    .memEn(node_3_0_memEn),
    .memWrEn(node_3_0_memWrEn),
    .memAddr(node_3_0_addr_out),
    .dataIn(node_3_0_d_out),
    .dataOut(node_3_0_d_in)
  );

  mesh_row_0 uut(
    .clk(clk),
    .reset(reset),
    .snro_0_0(snro_0_0),
    .nssi_0_0(nssi_0_0),
    .snro_1_0(snro_1_0),
    .nssi_1_0(nssi_1_0),
    .snro_2_0(snro_2_0),
    .nssi_2_0(nssi_2_0),
    .snro_3_0(snro_3_0),
    .nssi_3_0(nssi_3_0),

    .nsdi_0_0(nsdi_0_0),
    .nsdi_1_0(nsdi_1_0),
    .nsdi_2_0(nsdi_2_0),
    .nsdi_3_0(nsdi_3_0),

    .snso_0_0(snso_0_0),
    .nsri_0_0(nsri_0_0),
    .snso_1_0(snso_1_0),
    .nsri_1_0(nsri_1_0),
    .snso_2_0(snso_2_0),
    .nsri_2_0(nsri_2_0),
    .snso_3_0(snso_3_0),
    .nsri_3_0(nsri_3_0),

    .sndo_0_0(sndo_0_0),
    .sndo_1_0(sndo_1_0),
    .sndo_2_0(sndo_2_0),
    .sndo_3_0(sndo_3_0),

    .node_0_0_inst_in(node_0_0_inst_in),
    .node_0_0_d_in(node_0_0_d_in),
    .node_0_0_pc_out(node_0_0_pc_out),
    .node_0_0_d_out(node_0_0_d_out),
    .node_0_0_addr_out(node_0_0_addr_out),
    .node_0_0_memWrEn(node_0_0_memWrEn),
    .node_0_0_memEn(node_0_0_memEn),

    .node_1_0_inst_in(node_1_0_inst_in),
    .node_1_0_d_in(node_1_0_d_in),
    .node_1_0_pc_out(node_1_0_pc_out),
    .node_1_0_d_out(node_1_0_d_out),
    .node_1_0_addr_out(node_1_0_addr_out),
    .node_1_0_memWrEn(node_1_0_memWrEn),
    .node_1_0_memEn(node_1_0_memEn),

    .node_2_0_inst_in(node_2_0_inst_in),
    .node_2_0_d_in(node_2_0_d_in),
    .node_2_0_pc_out(node_2_0_pc_out),
    .node_2_0_d_out(node_2_0_d_out),
    .node_2_0_addr_out(node_2_0_addr_out),
    .node_2_0_memWrEn(node_2_0_memWrEn),
    .node_2_0_memEn(node_2_0_memEn),

    .node_3_0_inst_in(node_3_0_inst_in),
    .node_3_0_d_in(node_3_0_d_in),
    .node_3_0_pc_out(node_3_0_pc_out),
    .node_3_0_d_out(node_3_0_d_out),
    .node_3_0_addr_out(node_3_0_addr_out),
    .node_3_0_memWrEn(node_3_0_memWrEn),
    .node_3_0_memEn(node_3_0_memEn)
  );

  initial clk = 0;
  always #2 clk <= ~clk;

  initial begin
    clock_cycle = 0;
    snro_0_0 = 0;
    nssi_0_0 = 0;
    snro_1_0 = 0;
    nssi_1_0 = 0;
    snro_2_0 = 0;
    nssi_2_0 = 0;
    snro_3_0 = 0;
    nssi_3_0 = 0;

    nsdi_0_0 = 64'b0;
    nsdi_1_0 = 64'b0;
    nsdi_2_0 = 64'b0;
    nsdi_3_0 = 64'b0;

    for (j=0; j < 1; j = j + 1) begin
        reset = 1'b1;
        repeat(5) @(negedge clk); 
        reset = 1'b0;
    
        // Format the filename string: "imem_<j>.fill"
        //$sformat(imem_filename, "imem_%0d.fill", j);
    
        // Load instruction and data memory
        $readmemh("send_inst.txt", i_mem_0_0.MEM);
        //$readmemh("dmem.fill", d_mem_0_0.MEM);
        $readmemh("receive_inst.txt", i_mem_1_0.MEM);
        $readmemh("dmem2.fill", d_mem_1_0.MEM);
        //$readmemh("receive_inst.txt", i_mem_2_0.MEM);
        $readmemh("dmem2.fill", d_mem_2_0.MEM);
        //$readmemh("receive_inst.txt", i_mem_3_0.MEM);
        $readmemh("dmem2.fill", d_mem_3_0.MEM);
    
        wait (node_0_0_inst_in == 32'h00000000);
        $display("The program completed in %d cycles", clock_cycle);
        // Let us now flush the pipe line
        repeat(5) @(negedge clk); 
        // Open file for wire
        // Dump data memory to a file
        $sformat(dump_filename, "mesh_row_%0d.dump", j);
        dmem0_dump_file = $fopen(dump_filename);// assigning the channel descriptor for wire file
    
        // Let us now dump all the locations of the data memory now
        $fdisplay(dmem0_dump_file, "|\tMem\t|\tD0\t|\tD1\t|\tD2\t|\tD3\t|");
        $fdisplay(dmem0_dump_file, "---------------------------------");        
        for (i=0; i<128; i=i+1) 
        begin
          $fdisplay(dmem0_dump_file, "|\t#%0d\t|\t%h\t|\t%h\t|\t%h\t|\t%h\t|", i, d_mem_0_0.MEM[i], d_mem_1_0.MEM[i], d_mem_2_0.MEM[i], d_mem_3_0.MEM[i]);
        end
        $fclose(dmem0_dump_file);    
    end    
    
    $finish;
    //
    //$readmemh("rf_random_values.txt", uut.rf.registerFile);
    //$readmemh("cpu_test_instructions2.txt", instruc_mem.MEM);
    //$readmemh("dmem.fill", data_mem.MEM);
  end
  
  always @(posedge clk) begin
    if (reset)
       clock_cycle <= 0;
    else  
       clock_cycle <= clock_cycle + 1;
  end

endmodule
