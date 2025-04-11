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


module mesh_row_2 #(
    parameter PACKET_WIDTH = 64
) (
    input clk, reset,
    
    // **Top Signals**
    input snro_0_2, nssi_0_2,
    input snro_1_2, nssi_1_2,
    input snro_2_2, nssi_2_2,
    input snro_3_2, nssi_3_2,

    input [63:0] nsdi_0_2,
    input [63:0] nsdi_1_2,
    input [63:0] nsdi_2_2,
    input [63:0] nsdi_3_2,

    output snso_0_2, nsri_0_2,
    output snso_1_2, nsri_1_2,
    output snso_2_2, nsri_2_2,
    output snso_3_2, nsri_3_2,

    output [63:0] sndo_0_2,
    output [63:0] sndo_1_2,
    output [63:0] sndo_2_2,
    output [63:0] sndo_3_2,

    // **Bottom Signals**
    input snsi_0_2, nsro_0_2,
    input snsi_1_2, nsro_1_2,
    input snsi_2_2, nsro_2_2,
    input snsi_3_2, nsro_3_2,

    input [63:0] sndi_0_2,
    input [63:0] sndi_1_2,
    input [63:0] sndi_2_2,
    input [63:0] sndi_3_2,

    output snri_0_2, nsso_0_2,
    output snri_1_2, nsso_1_2,
    output snri_2_2, nsso_2_2,
    output snri_3_2, nsso_3_2,

    output [63:0] nsdo_0_2,
    output [63:0] nsdo_1_2,
    output [63:0] nsdo_2_2,
    output [63:0] nsdo_3_2,
    
    input [1:0]   addr_0_2,
    input [63:0]  d_in_0_2,
    output [63:0]  d_out_0_2,
    input         nicEn_0_2,
    input         nicEnWR_0_2,
    
    input [1:0]   addr_1_2,
    input [63:0]  d_in_1_2,
    output [63:0]  d_out_1_2,
    input         nicEn_1_2,
    input         nicEnWR_1_2,
    
    input [1:0]   addr_2_2,
    input [63:0]  d_in_2_2,
    output [63:0]  d_out_2_2,
    input         nicEn_2_2,
    input         nicEnWR_2_2,
    
    input [1:0]   addr_3_2,
    input [63:0]  d_in_3_2,
    output [63:0]  d_out_3_2,
    input         nicEn_3_2,
    input         nicEnWR_3_2

); 

  // Row 0
  // router 0_2 to 1_2
  wire ccw_si_02_so_12;
  wire ccw_ri_02_ro_12;
  wire [63:0] ccw_di_02_do_12;

  wire cw_so_02_si_12;
  wire cw_ro_02_ri_12;
  wire [63:0] cw_do_02_di_12;

  // router 1_2 to 2_2
  wire ccw_si_12_so_22;
  wire ccw_ri_12_ro_22;
  wire [63:0] ccw_di_12_do_22;

  wire cw_so_12_si_22;
  wire cw_ro_12_ri_22;
  wire [63:0] cw_do_12_di_22;

  // router 2_2 to 3_2
  wire ccw_si_22_so_32;
  wire ccw_ri_22_ro_32;
  wire [63:0] ccw_di_22_do_32;

  wire cw_so_22_si_32;
  wire cw_ro_22_ri_32;
  wire [63:0] cw_do_22_di_32;

  // Router to NIC
  // Router 0_2
  wire net_so_pesi_02;
  wire net_ro_peri_02;
  wire [63:0] net_do_pedi_02;
  wire net_polarity_02;
  wire net_si_peso_02;
  wire net_ri_pero_02;
  wire [63:0] net_di_pedo_02;

  // Router 1_2
  wire net_so_pesi_12;
  wire net_ro_peri_12;
  wire [63:0] net_do_pedi_12;
  wire net_polarity_12;
  wire net_si_peso_12;
  wire net_ri_pero_12;
  wire [63:0] net_di_pedo_12;

  // Router 2_2
  wire net_so_pesi_22;
  wire net_ro_peri_22;
  wire [63:0] net_do_pedi_22;
  wire net_polarity_22;
  wire net_si_peso_22;
  wire net_ri_pero_22;
  wire [63:0] net_di_pedo_22;

  // Router 3_2
  wire net_so_pesi_32;
  wire net_ro_peri_32;
  wire [63:0] net_do_pedi_32;
  wire net_polarity_32;
  wire net_si_peso_32;
  wire net_ri_pero_32;
  wire [63:0] net_di_pedo_32;

  router router_0_2 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_02),
    // Left side, no connections
    .cwsi(), .cwri(), .cwdi(), .ccwso(), .ccwro(), .ccwdo(),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_02_so_12), .ccwri(ccw_ri_02_ro_12), .ccwdi(ccw_di_02_do_12),
    .cwso(cw_so_02_si_12), .cwro(cw_ro_02_ri_12), .cwdo(cw_do_02_di_12),

    // Bottom, no connections
    .snsi(snsi_0_2), .snri(snri_0_2), .sndi(sndi_0_2), .nsso(nsso_0_2), .nsro(nsro_0_2), .nsdo(nsdo_0_2),

    // Top side
    .snso(snso_0_2), .snro(snro_0_2), .sndo(sndo_0_2), .nssi(nssi_0_2), .nsri(nsri_0_2), .nsdi(nsdi_0_2),

    // PE input/output to NIC
    .pesi(net_so_pesi_02), .pedi(net_do_pedi_02), .peri(net_ro_peri_02),
    .peso(net_si_peso_02), .pedo(net_di_pedo_02), .pero(net_ri_pero_02)
  );

  // NIC module instantiation for 0_2
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_0_2 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_0_2),
      .d_in(d_in_0_2),
      .d_out(d_out_0_2),
      .nicEn(nicEn_0_2),
      .nicEnWR(nicEnWR_0_2),
  
      // Router-NIC Interface
      .net_si(net_si_peso_02),
      .net_so(net_so_pesi_02),
      .net_ri(net_ri_pero_02),
      .net_ro(net_ro_peri_02),
  
      .net_di(net_di_pedo_02),
      .net_do(net_do_pedi_02),
      .net_polarity(net_polarity_02)
  );

  router router_1_2 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_12),
    // Left side
    .cwsi(cw_so_02_si_12), .cwri(cw_ro_02_ri_12), .cwdi(cw_do_02_di_12),
    .ccwso(ccw_si_02_so_12), .ccwro(ccw_ri_02_ro_12), .ccwdo(ccw_di_02_do_12),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_12_so_22), .ccwri(ccw_ri_12_ro_22), .ccwdi(ccw_di_12_do_22),
    .cwso(cw_so_12_si_22), .cwro(cw_ro_12_ri_22), .cwdo(cw_do_12_di_22),

    // Bottom, no connections
    .snsi(snsi_1_2), .snri(snri_1_2), .sndi(sndi_1_2), .nsso(nsso_1_2), .nsro(nsro_1_2), .nsdo(nsdo_1_2),

    // Top side
    .snso(snso_1_2), .snro(snro_1_2), .sndo(sndo_1_2), .nssi(nssi_1_2), .nsri(nsri_1_2), .nsdi(nsdi_1_2),

    // PE input/output to NIC
    .pesi(net_so_pesi_12), .pedi(net_do_pedi_12), .peri(net_ro_peri_12),
    .peso(net_si_peso_12), .pedo(net_di_pedo_12), .pero(net_ri_pero_12)
  );

  // NIC module instantiation for 0_2
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_1_2 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_1_2),
      .d_in(d_in_1_2),
      .d_out(d_out_1_2),
      .nicEn(nicEn_1_2),
      .nicEnWR(nicEnWR_1_2),
  
      // Router-NIC Interface
      .net_si(net_si_peso_12),
      .net_so(net_so_pesi_12),
      .net_ri(net_ri_pero_12),
      .net_ro(net_ro_peri_12),
  
      .net_di(net_di_pedo_12),
      .net_do(net_do_pedi_12),
      .net_polarity(net_polarity_12)
  );

    router router_2_2 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_22),
    // Left side
    .cwsi(cw_so_12_si_22), .cwri(cw_ro_12_ri_22), .cwdi(cw_do_12_di_22),
    .ccwso(ccw_si_12_so_22), .ccwro(ccw_ri_12_ro_22), .ccwdo(ccw_di_12_do_22),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_22_so_32), .ccwri(ccw_ri_22_ro_32), .ccwdi(ccw_di_22_do_32),
    .cwso(cw_so_22_si_32), .cwro(cw_ro_22_ri_32), .cwdo(cw_do_22_di_32),

    // Bottom, no connections
    .snsi(snsi_2_2), .snri(snri_2_2), .sndi(sndi_2_2), .nsso(nsso_2_2), .nsro(nsro_2_2), .nsdo(nsdo_2_2),

    // Top side
    .snso(snso_2_2), .snro(snro_2_2), .sndo(sndo_2_2), .nssi(nssi_2_2), .nsri(nsri_2_2), .nsdi(nsdi_2_2),

    // PE input/output to NIC
    .pesi(net_so_pesi_22), .pedi(net_do_pedi_22), .peri(net_ro_peri_22),
    .peso(net_si_peso_22), .pedo(net_di_pedo_22), .pero(net_ri_pero_22)
  );

  // NIC module instantiation for 0_2
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_2_2 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_2_2),
      .d_in(d_in_2_2),
      .d_out(d_out_2_2),
      .nicEn(nicEn_2_2),
      .nicEnWR(nicEnWR_2_2),
  
      // Router-NIC Interface
      .net_si(net_si_peso_22),
      .net_so(net_so_pesi_22),
      .net_ri(net_ri_pero_22),
      .net_ro(net_ro_peri_22),
  
      .net_di(net_di_pedo_22),
      .net_do(net_do_pedi_22),
      .net_polarity(net_polarity_22)
  );

      router router_3_2 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_32),
    // Left side
    .cwsi(cw_so_22_si_32), .cwri(cw_ro_22_ri_32), .cwdi(cw_do_22_di_32),
    .ccwso(ccw_si_22_so_32), .ccwro(ccw_ri_22_ro_32), .ccwdo(ccw_di_22_do_32),

    // Right side, no connections
    .ccwsi(), .ccwri(), .ccwdi(), .cwso(), .cwro(), .cwdo(),

    // Bottom, no connections
    .snsi(snsi_3_2), .snri(snri_3_2), .sndi(sndi_3_2), .nsso(nsso_3_2), .nsro(nsro_3_2), .nsdo(nsdo_3_2),

    // Top side
    .snso(snso_3_2), .snro(snro_3_2), .sndo(sndo_3_2), .nssi(nssi_3_2), .nsri(nsri_3_2), .nsdi(nsdi_3_2),

    // PE input/output to NIC
    .pesi(net_so_pesi_32), .pedi(net_do_pedi_32), .peri(net_ro_peri_32),
    .peso(net_si_peso_32), .pedo(net_di_pedo_32), .pero(net_ri_pero_32)
  );

  // NIC module instantiation for 0_2
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_3_2 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_3_2),
      .d_in(d_in_3_2),
      .d_out(d_out_3_2),
      .nicEn(nicEn_3_2),
      .nicEnWR(nicEnWR_3_2),
  
      // Router-NIC Interface
      .net_si(net_si_peso_32),
      .net_so(net_so_pesi_32),
      .net_ri(net_ri_pero_32),
      .net_ro(net_ro_peri_32),
  
      .net_di(net_di_pedo_32),
      .net_do(net_do_pedi_32),
      .net_polarity(net_polarity_32)
  );

endmodule