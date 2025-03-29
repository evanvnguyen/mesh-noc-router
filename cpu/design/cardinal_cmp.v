module cardinal_cmp (
	input clk,
	input reset,
	
	input [0:31]  node0_inst_in,
	input [0:63]  node0_d_in,
  output [0:31] node0_pc_out,
  output [0:31] node0_d_out,
  output [0:31] node0_addr_out,
	output        node0_memWrEn,
	output        node0_memEn,

  input [0:31]  node1_inst_in,
	input [0:63]  node1_d_in,
	output [0:31] node1_pc_out,
	output [0:31] node1_d_out,
	output [0:31] node1_addr_out,
	output        node1_memWrEn,
	output        node1_memEn,

	input [0:31]  node2_inst_in,
	input [0:63]  node2_d_in,
	output [0:31] node2_pc_out,
	output [0:31] node2_d_out,
	output [0:31] node2_addr_out,
	output        node2_memWrEn,
	output        node2_memEn,

  input [0:31]  node3_inst_in,
	input [0:63]  node3_d_in,
	output [0:31] node3_pc_out,
	output [0:31] node3_d_out,
	output [0:31] node3_addr_out,
	output        node3_memWrEn,
	output        node3_memEn
	);

  four_stage_processor p0 (
    .clk(clk),
    .reset(reset),
    .inst_in(node0_inst_in),
    .d_in(node0_d_in),
    .pc_out(node0_pc_out),
    .d_out(node0_d_out),
    .addr_out(node0_addr_out),
    .memWrEn(node0_memWrEn),
    .memEn(node0_memEn)
  );

  four_stage_processor p1 (
    .clk(clk),
    .reset(reset),
    .inst_in(node1_inst_in),
    .d_in(node1_d_in),
    .pc_out(node1_pc_out),
    .d_out(node1_d_out),
    .addr_out(node1_addr_out),
    .memWrEn(node1_memWrEn),
    .memEn(node1_memEn)
  );

  four_stage_processor p2 (
    .clk(clk),
    .reset(reset),
    .inst_in(node2_inst_in),
    .d_in(node2_d_in),
    .pc_out(node2_pc_out),
    .d_out(node2_d_out),
    .addr_out(node2_addr_out),
    .memWrEn(node2_memWrEn),
    .memEn(node2_memEn)
  );

  four_stage_processor p3 (
    .clk(clk),
    .reset(reset),
    .inst_in(node3_inst_in),
    .d_in(node3_d_in),
    .pc_out(node3_pc_out),
    .d_out(node3_d_out),
    .addr_out(node3_addr_out),
    .memWrEn(node3_memWrEn),
    .memEn(node3_memEn)
  );

endmodule