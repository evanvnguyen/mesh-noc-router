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


module mesh_row_3 #(
    parameter PACKET_WIDTH = 64
) (
    input clk, reset,
    
    // **Bottom Signals**
    input snsi_0_3, nsro_0_3,
    input snsi_1_3, nsro_1_3,
    input snsi_2_3, nsro_2_3,
    input snsi_3_3, nsro_3_3,

    input [63:0] sndi_0_3,
    input [63:0] sndi_1_3,
    input [63:0] sndi_2_3,
    input [63:0] sndi_3_3,

    output snri_0_3, nsso_0_3,
    output snri_1_3, nsso_1_3,
    output snri_2_3, nsso_2_3,
    output snri_3_3, nsso_3_3,

    output [63:0] nsdo_0_3,
    output [63:0] nsdo_1_3,
    output [63:0] nsdo_2_3,
    output [63:0] nsdo_3_3,
    
    input [1:0]   addr_0_3,
    input [63:0]  d_in_0_3,
    output [63:0]  d_out_0_3,
    input         nicEn_0_3,
    input         nicEnWR_0_3,
    
    input [1:0]   addr_1_3,
    input [63:0]  d_in_1_3,
    output [63:0]  d_out_1_3,
    input         nicEn_1_3,
    input         nicEnWR_1_3,
    
    input [1:0]   addr_2_3,
    input [63:0]  d_in_2_3,
    output [63:0]  d_out_2_3,
    input         nicEn_2_3,
    input         nicEnWR_2_3,
    
    input [1:0]   addr_3_3,
    input [63:0]  d_in_3_3,
    output [63:0]  d_out_3_3,
    input         nicEn_3_3,
    input         nicEnWR_3_3

); 

  // Row 0
  // router 0_2 to 1_2
  wire ccw_si_03_so_13;
  wire ccw_ri_03_ro_13;
  wire [63:0] ccw_di_03_do_13;

  wire cw_so_03_si_13;
  wire cw_ro_03_ri_13;
  wire [63:0] cw_do_03_di_13;

  // router 1_2 to 2_2
  wire ccw_si_13_so_23;
  wire ccw_ri_13_ro_23;
  wire [63:0] ccw_di_13_do_23;

  wire cw_so_13_si_23;
  wire cw_ro_13_ri_23;
  wire [63:0] cw_do_13_di_23;

  // router 2_2 to 3_2
  wire ccw_si_23_so_33;
  wire ccw_ri_23_ro_33;
  wire [63:0] ccw_di_23_do_33;

  wire cw_so_23_si_33;
  wire cw_ro_23_ri_33;
  wire [63:0] cw_do_23_di_33;

  // Router to NIC
  // Router 0_2
  wire net_so_pesi_03;
  wire net_ro_peri_03;
  wire [63:0] net_do_pedi_03;
  wire net_polarity_03;
  wire net_si_peso_03;
  wire net_ri_pero_03;
  wire [63:0] net_di_pedo_03;

  // Router 1_2
  wire net_so_pesi_13;
  wire net_ro_peri_13;
  wire [63:0] net_do_pedi_13;
  wire net_polarity_13;
  wire net_si_peso_13;
  wire net_ri_pero_13;
  wire [63:0] net_di_pedo_13;

  // Router 2_2
  wire net_so_pesi_23;
  wire net_ro_peri_23;
  wire [63:0] net_do_pedi_23;
  wire net_polarity_23;
  wire net_si_peso_23;
  wire net_ri_pero_23;
  wire [63:0] net_di_pedo_23;

  // Router 3_2
  wire net_so_pesi_33;
  wire net_ro_peri_33;
  wire [63:0] net_do_pedi_33;
  wire net_polarity_33;
  wire net_si_peso_33;
  wire net_ri_pero_33;
  wire [63:0] net_di_pedo_33;

  router router_0_3 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_03),
    // Left side, no connections
    .cwsi(), .cwri(), .cwdi(), .ccwso(), .ccwro(), .ccwdo(),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_03_so_13), .ccwri(ccw_ri_03_ro_13), .ccwdi(ccw_di_03_do_13),
    .cwso(cw_so_03_si_13), .cwro(cw_ro_03_ri_13), .cwdo(cw_do_03_di_13),

    // Bottom, no connections
    .snsi(snsi_0_3), .snri(snri_0_3), .sndi(sndi_0_3), .nsso(nsso_0_3), .nsro(nsro_0_3), .nsdo(nsdo_0_3),

    // Top side
    .snso(), .snro(), .sndo(), .nssi(), .nsri(), .nsdi(),

    // PE input/output to NIC
    .pesi(net_so_pesi_03), .pedi(net_do_pedi_03), .peri(net_ro_peri_03),
    .peso(net_si_peso_03), .pedo(net_di_pedo_03), .pero(net_ri_pero_03)
  );

  // NIC module instantiation for 0_2
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_0_3 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_0_3),
      .d_in(d_in_0_3),
      .d_out(d_out_0_3),
      .nicEn(nicEn_0_3),
      .nicEnWR(nicEnWR_0_3),
  
      // Router-NIC Interface
      .net_si(net_si_peso_03),
      .net_so(net_so_pesi_03),
      .net_ri(net_ri_pero_03),
      .net_ro(net_ro_peri_03),
  
      .net_di(net_di_pedo_03),
      .net_do(net_do_pedi_03),
      .net_polarity(net_polarity_03)
  );

  router router_1_3 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_13),
    // Left side
    .cwsi(cw_so_03_si_13), .cwri(cw_ro_03_ri_13), .cwdi(cw_do_03_di_13),
    .ccwso(ccw_si_03_so_13), .ccwro(ccw_ri_03_ro_13), .ccwdo(ccw_di_03_do_13),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_13_so_23), .ccwri(ccw_ri_13_ro_23), .ccwdi(ccw_di_13_do_23),
    .cwso(cw_so_13_si_23), .cwro(cw_ro_13_ri_23), .cwdo(cw_do_13_di_23),

    // Bottom, no connections
    .snsi(snsi_1_3), .snri(snri_1_3), .sndi(sndi_1_3), .nsso(nsso_1_3), .nsro(nsro_1_3), .nsdo(nsdo_1_3),

    // Top side
    .snso(), .snro(), .sndo(), .nssi(), .nsri(), .nsdi(),

    // PE input/output to NIC
    .pesi(net_so_pesi_13), .pedi(net_do_pedi_13), .peri(net_ro_peri_13),
    .peso(net_si_peso_13), .pedo(net_di_pedo_13), .pero(net_ri_pero_13)
  );

  // NIC module instantiation for 0_2
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_1_3 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_1_3),
      .d_in(d_in_1_3),
      .d_out(d_out_1_3),
      .nicEn(nicEn_1_3),
      .nicEnWR(nicEnWR_1_3),
  
      // Router-NIC Interface
      .net_si(net_si_peso_13),
      .net_so(net_so_pesi_13),
      .net_ri(net_ri_pero_13),
      .net_ro(net_ro_peri_13),
  
      .net_di(net_di_pedo_13),
      .net_do(net_do_pedi_13),
      .net_polarity(net_polarity_13)
  );

    router router_2_3 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_23),
    // Left side
    .cwsi(cw_so_13_si_23), .cwri(cw_ro_13_ri_23), .cwdi(cw_do_13_di_23),
    .ccwso(ccw_si_13_so_23), .ccwro(ccw_ri_13_ro_23), .ccwdo(ccw_di_13_do_23),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_23_so_33), .ccwri(ccw_ri_23_ro_33), .ccwdi(ccw_di_23_do_33),
    .cwso(cw_so_23_si_33), .cwro(cw_ro_23_ri_33), .cwdo(cw_do_23_di_33),

    // Bottom, no connections
    .snsi(snsi_2_3), .snri(snri_2_3), .sndi(sndi_2_3), .nsso(nsso_2_3), .nsro(nsro_2_3), .nsdo(nsdo_2_3),

    // Top side
    .snso(), .snro(), .sndo(), .nssi(), .nsri(), .nsdi(),

    // PE input/output to NIC
    .pesi(net_so_pesi_23), .pedi(net_do_pedi_23), .peri(net_ro_peri_23),
    .peso(net_si_peso_23), .pedo(net_di_pedo_23), .pero(net_ri_pero_23)
  );

  // NIC module instantiation for 0_2
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_2_3 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_2_3),
      .d_in(d_in_2_3),
      .d_out(d_out_2_3),
      .nicEn(nicEn_2_3),
      .nicEnWR(nicEnWR_2_3),
  
      // Router-NIC Interface
      .net_si(net_si_peso_23),
      .net_so(net_so_pesi_23),
      .net_ri(net_ri_pero_23),
      .net_ro(net_ro_peri_23),
  
      .net_di(net_di_pedo_23),
      .net_do(net_do_pedi_23),
      .net_polarity(net_polarity_23)
  );

      router router_3_3 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_33),
    // Left side
    .cwsi(cw_so_23_si_33), .cwri(cw_ro_23_ri_33), .cwdi(cw_do_23_di_33),
    .ccwso(ccw_si_23_so_33), .ccwro(ccw_ri_23_ro_33), .ccwdo(ccw_di_23_do_33),

    // Right side, no connections
    .ccwsi(), .ccwri(), .ccwdi(), .cwso(), .cwro(), .cwdo(),

    // Bottom, no connections
    .snsi(snsi_3_3), .snri(snri_3_3), .sndi(sndi_3_3), .nsso(nsso_3_3), .nsro(nsro_3_3), .nsdo(nsdo_3_3),

    // Top side
    .snso(), .snro(), .sndo(), .nssi(), .nsri(), .nsdi(),

    // PE input/output to NIC
    .pesi(net_so_pesi_33), .pedi(net_do_pedi_33), .peri(net_ro_peri_33),
    .peso(net_si_peso_33), .pedo(net_di_pedo_33), .pero(net_ri_pero_33)
  );

  // NIC module instantiation for 0_2
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_3_3 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_3_3),
      .d_in(d_in_3_3),
      .d_out(d_out_3_3),
      .nicEn(nicEn_3_3),
      .nicEnWR(nicEnWR_3_3),
  
      // Router-NIC Interface
      .net_si(net_si_peso_33),
      .net_so(net_so_pesi_33),
      .net_ri(net_ri_pero_33),
      .net_ro(net_ro_peri_33),
  
      .net_di(net_di_pedo_33),
      .net_do(net_do_pedi_33),
      .net_polarity(net_polarity_33)
  );

endmodule