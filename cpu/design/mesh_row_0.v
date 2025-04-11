/* Mesh connection
              GND           GND         GND          GND
          ===================================================
    GND  | router_0_3 | router_1_3 | router_2_3 | router_3_3 | GND
          ===================================================
    GND  | router_0_2 | router_1_2 | router_2_2 | router_3_2 | GND
          ===================================================
    GND  | router_0_1 | router_1_1 | router_2_1 | router_3_1 | GND
          ===================================================
    GND  | router_0_0 | router_1_0 | router_2_0 | router_3_0 | GND
          ===================================================
              GND           GND         GND          GND
        (x,y) = (0,0) (x,y) = (1,0) (x,y) = (2,0) (x,y) = (3,0)
*/


module mesh_row_0 #(
    parameter PACKET_WIDTH = 64
) (
  input clk,
  input reset,
  
  // Top signals
  input snro_0_0, nssi_0_0,
  input snro_1_0, nssi_1_0,
  input snro_2_0, nssi_2_0,
  input snro_3_0, nssi_3_0,

  input [63:0] nsdi_0_0,
  input [63:0] nsdi_1_0,
  input [63:0] nsdi_2_0,
  input [63:0] nsdi_3_0,

  output snso_0_0, nsri_0_0,
  output snso_1_0, nsri_1_0,
  output snso_2_0, nsri_2_0,
  output snso_3_0, nsri_3_0,

  output [63:0] sndo_0_0,
  output [63:0] sndo_1_0,
  output [63:0] sndo_2_0,
  output [63:0] sndo_3_0,
  
  // CPU tb signals
  input [0:31]  node_0_0_inst_in,
  input [0:63]  node_0_0_d_in,
  output [0:31] node_0_0_pc_out,
  output [0:63] node_0_0_d_out,
  output [0:31] node_0_0_addr_out,
  output        node_0_0_memWrEn,
  output        node_0_0_memEn,

  input [0:31]  node_1_0_inst_in,
	input [0:63]  node_1_0_d_in,
	output [0:31] node_1_0_pc_out,
	output [0:63] node_1_0_d_out,
	output [0:31] node_1_0_addr_out,
	output        node_1_0_memWrEn,
	output        node_1_0_memEn,

	input [0:31]  node_2_0_inst_in,
	input [0:63]  node_2_0_d_in,
	output [0:31] node_2_0_pc_out,
	output [0:63] node_2_0_d_out,
	output [0:31] node_2_0_addr_out,
	output        node_2_0_memWrEn,
	output        node_2_0_memEn,

  input [0:31]  node_3_0_inst_in,
	input [0:63]  node_3_0_d_in,
	output [0:31] node_3_0_pc_out,
	output [0:63] node_3_0_d_out,
	output [0:31] node_3_0_addr_out,
	output        node_3_0_memWrEn,
	output        node_3_0_memEn
); 

  // Row 0
  // router 0_0 to 1_0
  wire ccw_si_00_so_10;
  wire ccw_ri_00_ro_10;
  wire [63:0] ccw_di_00_do_10;

  wire cw_so_00_si_10;
  wire cw_ro_00_ri_10;
  wire [63:0] cw_do_00_di_10;

  // router 1_0 to 2_0
  wire ccw_si_10_so_20;
  wire ccw_ri_10_ro_20;
  wire [63:0] ccw_di_10_do_20;

  wire cw_so_10_si_20;
  wire cw_ro_10_ri_20;
  wire [63:0] cw_do_10_di_20;

  // router 2_0 to 3_0
  wire ccw_si_20_so_30;
  wire ccw_ri_20_ro_30;
  wire [63:0] ccw_di_20_do_30;

  wire cw_so_20_si_30;
  wire cw_ro_20_ri_30;
  wire [63:0] cw_do_20_di_30;

  // Router to NIC
  // Router 0_0
  wire net_so_pesi_00;
  wire net_ro_peri_00;
  wire [63:0] net_do_pedi_00;
  wire net_polarity_00;
  wire net_si_peso_00;
  wire net_ri_pero_00;
  wire [63:0] net_di_pedo_00;

  // Router 1_0
  wire net_so_pesi_10;
  wire net_ro_peri_10;
  wire [63:0] net_do_pedi_10;
  wire net_polarity_10;
  wire net_si_peso_10;
  wire net_ri_pero_10;
  wire [63:0] net_di_pedo_10;

  // Router 2_0
  wire net_so_pesi_20;
  wire net_ro_peri_20;
  wire [63:0] net_do_pedi_20;
  wire net_polarity_20;
  wire net_si_peso_20;
  wire net_ri_pero_20;
  wire [63:0] net_di_pedo_20;

  // Router 3_0
  wire net_so_pesi_30;
  wire net_ro_peri_30;
  wire [63:0] net_do_pedi_30;
  wire net_polarity_30;
  wire net_si_peso_30;
  wire net_ri_pero_30;
  wire [63:0] net_di_pedo_30;

  // CPU-NIC Interface
  wire nicEn_0_0;
  wire nicEnWR_0_0;
  wire [1:0]  nic_addr_0_0;
  wire [63:0] nic_d_in_0_0;
  wire [63:0] nic_d_out_0_0;

  wire nicEn_1_0;
  wire nicEnWR_1_0;
  wire [1:0]  nic_addr_1_0;
  wire [63:0] nic_d_in_1_0;
  wire [63:0] nic_d_out_1_0;

  wire nicEn_2_0;
  wire nicEnWR_2_0;
  wire [1:0]  nic_addr_2_0;
  wire [63:0] nic_d_in_2_0;
  wire [63:0] nic_d_out_2_0;

  wire nicEn_3_0;
  wire nicEnWR_3_0;
  wire [1:0]  nic_addr_3_0;
  wire [63:0] nic_d_in_3_0;
  wire [63:0] nic_d_out_3_0;

  router router_0_0 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_00),
    // Left side, no connections
    .cwsi(), .cwri(), .cwdi(), .ccwso(), .ccwro(), .ccwdo(),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_00_so_10), .ccwri(ccw_ri_00_ro_10), .ccwdi(ccw_di_00_do_10),
    .cwso(cw_so_00_si_10), .cwro(cw_ro_00_ri_10), .cwdo(cw_do_00_di_10),

    // Bottom, no connections
    .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),

    // Top side
    .snso(snso_0_0), .snro(snro_0_0), .sndo(sndo_0_0), .nssi(nssi_0_0), .nsri(nsri_0_0), .nsdi(nsdi_0_0),

    // PE input/output to NIC
    .pesi(net_so_pesi_00), .pedi(net_do_pedi_00), .peri(net_ro_peri_00),
    .peso(net_si_peso_00), .pedo(net_di_pedo_00), .pero(net_ri_pero_00)
  );

  // NIC module instantiation for 0_0
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_0_0 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(nic_addr_0_0),
      .d_in(nic_d_in_0_0),
      .d_out(nic_d_out_0_0),
      .nicEn(nicEn_0_0),
      .nicEnWR(nicEnWR_0_0),
  
      // Router-NIC Interface
      .net_si(net_si_peso_00),
      .net_so(net_so_pesi_00),
      .net_ri(net_ri_pero_00),
      .net_ro(net_ro_peri_00),
  
      .net_di(net_di_pedo_00),
      .net_do(net_do_pedi_00),
      .net_polarity(net_polarity_00)
  );

  four_stage_processor cpu_0_0 (
    .clk(clk),
    .reset(reset),
    .inst_in(node_0_0_inst_in),
    .d_in(node_0_0_d_in),
    .pc_out(node_0_0_pc_out),
    .d_out(node_0_0_d_out),
    .addr_out(node_0_0_addr_out),
    .memWrEn(node_0_0_memWrEn),
    .memEn(node_0_0_memEn),
    .nicEn(nicEn_0_0),
    .nicWrEn(nicEnWR_0_0),
    .addr_nic(nic_addr_0_0),
    .d_in_nic(nic_d_in_0_0),
    .d_out_nic(nic_d_out_0_0)
  );

  router router_1_0 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_10),
    // Left side
    .cwsi(cw_so_00_si_10), .cwri(cw_ro_00_ri_10), .cwdi(cw_do_00_di_10),
    .ccwso(ccw_si_00_so_10), .ccwro(ccw_ri_00_ro_10), .ccwdo(ccw_di_00_do_10),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_10_so_20), .ccwri(ccw_ri_10_ro_20), .ccwdi(ccw_di_10_do_20),
    .cwso(cw_so_10_si_20), .cwro(cw_ro_10_ri_20), .cwdo(cw_do_10_di_20),

    // Bottom, no connections
    .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),

    // Top side
    .snso(snso_1_0), .snro(snro_1_0), .sndo(sndo_1_0), .nssi(nssi_1_0), .nsri(nsri_1_0), .nsdi(nsdi_1_0),

    // PE input/output to NIC
    .pesi(net_so_pesi_10), .pedi(net_do_pedi_10), .peri(net_ro_peri_10),
    .peso(net_si_peso_10), .pedo(net_di_pedo_10), .pero(net_ri_pero_10)
  );

  // NIC module instantiation for 0_0
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_1_0 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(nic_addr_1_0),
      .d_in(nic_d_in_1_0),
      .d_out(nic_d_out_1_0),
      .nicEn(nicEn_1_0),
      .nicEnWR(nicEnWR_1_0),
  
      // Router-NIC Interface
      .net_si(net_si_peso_10),
      .net_so(net_so_pesi_10),
      .net_ri(net_ri_pero_10),
      .net_ro(net_ro_peri_10),
  
      .net_di(net_di_pedo_10),
      .net_do(net_do_pedi_10),
      .net_polarity(net_polarity_10)
  );

    four_stage_processor cpu_1_0 (
    .clk(clk),
    .reset(reset),
    .inst_in(node_1_0_inst_in),
    .d_in(node_1_0_d_in),
    .pc_out(node_1_0_pc_out),
    .d_out(node_1_0_d_out),
    .addr_out(node_1_0_addr_out),
    .memWrEn(node_1_0_memWrEn),
    .memEn(node_1_0_memEn),
    .nicEn(nicEn_1_0),
    .nicWrEn(nicEnWR_1_0),
    .addr_nic(nic_addr_1_0),
    .d_in_nic(nic_d_in_1_0),
    .d_out_nic(nic_d_out_1_0)
  );

    router router_2_0 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_20),
    // Left side
    .cwsi(cw_so_10_si_20), .cwri(cw_ro_10_ri_20), .cwdi(cw_do_10_di_20),
    .ccwso(ccw_si_10_so_20), .ccwro(ccw_ri_10_ro_20), .ccwdo(ccw_di_10_do_20),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_20_so_30), .ccwri(ccw_ri_20_ro_30), .ccwdi(ccw_di_20_do_30),
    .cwso(cw_so_20_si_30), .cwro(cw_ro_20_ri_30), .cwdo(cw_do_20_di_30),

    // Bottom, no connections
    .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),

    // Top side
    .snso(snso_2_0), .snro(snro_2_0), .sndo(sndo_2_0), .nssi(nssi_2_0), .nsri(nsri_2_0), .nsdi(nsdi_2_0),

    // PE input/output to NIC
    .pesi(net_so_pesi_20), .pedi(net_do_pedi_20), .peri(net_ro_peri_20),
    .peso(net_si_peso_20), .pedo(net_di_pedo_20), .pero(net_ri_pero_20)
  );

  // NIC module instantiation for 0_0
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_2_0 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(nic_addr_2_0),
      .d_in(nic_d_in_2_0),
      .d_out(nic_d_out_2_0),
      .nicEn(nicEn_2_0),
      .nicEnWR(nicEnWR_2_0),
  
      // Router-NIC Interface
      .net_si(net_si_peso_20),
      .net_so(net_so_pesi_20),
      .net_ri(net_ri_pero_20),
      .net_ro(net_ro_peri_20),
  
      .net_di(net_di_pedo_20),
      .net_do(net_do_pedi_20),
      .net_polarity(net_polarity_20)
  );

    four_stage_processor cpu_2_0 (
    .clk(clk),
    .reset(reset),
    .inst_in(node_2_0_inst_in),
    .d_in(node_2_0_d_in),
    .pc_out(node_2_0_pc_out),
    .d_out(node_2_0_d_out),
    .addr_out(node_2_0_addr_out),
    .memWrEn(node_2_0_memWrEn),
    .memEn(node_2_0_memEn),
    .nicEn(nicEn_2_0),
    .nicWrEn(nicEnWR_2_0),
    .addr_nic(nic_addr_2_0),
    .d_in_nic(nic_d_in_2_0),
    .d_out_nic(nic_d_out_2_0)
  );

      router router_3_0 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_30),
    // Left side
    .cwsi(cw_so_20_si_30), .cwri(cw_ro_20_ri_30), .cwdi(cw_do_20_di_30),
    .ccwso(ccw_si_20_so_30), .ccwro(ccw_ri_20_ro_30), .ccwdo(ccw_di_20_do_30),

    // Right side, no connections
    .ccwsi(), .ccwri(), .ccwdi(), .cwso(), .cwro(), .cwdo(),

    // Bottom, no connections
    .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),

    // Top side
    .snso(snso_3_0), .snro(snro_3_0), .sndo(sndo_3_0), .nssi(nssi_3_0), .nsri(nsri_3_0), .nsdi(nsdi_3_0),

    // PE input/output to NIC
    .pesi(net_so_pesi_30), .pedi(net_do_pedi_30), .peri(net_ro_peri_30),
    .peso(net_si_peso_30), .pedo(net_di_pedo_30), .pero(net_ri_pero_30)
  );

  // NIC module instantiation for 0_0
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_3_0 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(nic_addr_3_0),
      .d_in(nic_d_in_3_0),
      .d_out(nic_d_out_3_0),
      .nicEn(nicEn_3_0),
      .nicEnWR(nicEnWR_3_0),
  
      // Router-NIC Interface
      .net_si(net_si_peso_30),
      .net_so(net_so_pesi_30),
      .net_ri(net_ri_pero_30),
      .net_ro(net_ro_peri_30),
  
      .net_di(net_di_pedo_30),
      .net_do(net_do_pedi_30),
      .net_polarity(net_polarity_30)
  );

    four_stage_processor cpu_3_0 (
    .clk(clk),
    .reset(reset),
    .inst_in(node_3_0_inst_in),
    .d_in(node_3_0_d_in),
    .pc_out(node_3_0_pc_out),
    .d_out(node_3_0_d_out),
    .addr_out(node_3_0_addr_out),
    .memWrEn(node_3_0_memWrEn),
    .memEn(node_3_0_memEn),
    .nicEn(nicEn_3_0),
    .nicWrEn(nicEnWR_3_0),
    .addr_nic(nic_addr_3_0),
    .d_in_nic(nic_d_in_3_0),
    .d_out_nic(nic_d_out_3_0)
  );

endmodule