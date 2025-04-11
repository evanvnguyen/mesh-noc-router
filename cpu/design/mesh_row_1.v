/* Mesh connection
              GND           GND         GND          GND
          ===================================================
    GND  | router_0_3 | router_1_3 | router_2_3 | router_3_3 | GND
          ===================================================
    GND  | router_0_2 | router_1_2 | router_2_2 | router_3_2 | GND
          ===================================================
    GND  | router_0_1 | router_1_1 | router_2_1 | router_3_1 | GND
          ===================================================
    GND  | router_0_0 | router_1_1 | router_2_1 | router_3_1 | GND
          ===================================================
              GND           GND         GND          GND
        (x,y) = (0,0) (x,y) = (1,0) (x,y) = (2,0) (x,y) = (3,0)
*/


module mesh_row_1 #(
    parameter PACKET_WIDTH = 64
) (
    input clk, reset,
    
    // **Top Signals**
    input snro_0_1, nssi_0_1,
    input snro_1_1, nssi_1_1,
    input snro_2_1, nssi_2_1,
    input snro_3_1, nssi_3_1,

    input [63:0] nsdi_0_1,
    input [63:0] nsdi_1_1,
    input [63:0] nsdi_2_1,
    input [63:0] nsdi_3_1,

    output snso_0_1, nsri_0_1,
    output snso_1_1, nsri_1_1,
    output snso_2_1, nsri_2_1,
    output snso_3_1, nsri_3_1,

    output [63:0] sndo_0_1,
    output [63:0] sndo_1_1,
    output [63:0] sndo_2_1,
    output [63:0] sndo_3_1,

    // **Bottom Signals**
    input snsi_0_1, nsro_0_1,
    input snsi_1_1, nsro_1_1,
    input snsi_2_1, nsro_2_1,
    input snsi_3_1, nsro_3_1,

    input [63:0] sndi_0_1,
    input [63:0] sndi_1_1,
    input [63:0] sndi_2_1,
    input [63:0] sndi_3_1,

    output snri_0_1, nsso_0_1,
    output snri_1_1, nsso_1_1,
    output snri_2_1, nsso_2_1,
    output snri_3_1, nsso_3_1,

    output [63:0] nsdo_0_1,
    output [63:0] nsdo_1_1,
    output [63:0] nsdo_2_1,
    output [63:0] nsdo_3_1,
    
    input [1:0]   addr_0_1,
    input [63:0]  d_in_0_1,
    output [63:0]  d_out_0_1,
    input         nicEn_0_1,
    input         nicEnWR_0_1,
    
    input [1:0]   addr_1_1,
    input [63:0]  d_in_1_1,
    output [63:0]  d_out_1_1,
    input         nicEn_1_1,
    input         nicEnWR_1_1,
    
    input [1:0]   addr_2_1,
    input [63:0]  d_in_2_1,
    output [63:0]  d_out_2_1,
    input         nicEn_2_1,
    input         nicEnWR_2_1,
    
    input [1:0]   addr_3_1,
    input [63:0]  d_in_3_1,
    output [63:0]  d_out_3_1,
    input         nicEn_3_1,
    input         nicEnWR_3_1

); 

  // Row 0
  // router 0_1 to 1_1
  wire ccw_si_01_so_11;
  wire ccw_ri_01_ro_11;
  wire [63:0] ccw_di_01_do_11;

  wire cw_so_01_si_11;
  wire cw_ro_01_ri_11;
  wire [63:0] cw_do_01_di_11;

  // router 1_1 to 2_1
  wire ccw_si_11_so_21;
  wire ccw_ri_11_ro_21;
  wire [63:0] ccw_di_11_do_21;

  wire cw_so_11_si_21;
  wire cw_ro_11_ri_21;
  wire [63:0] cw_do_11_di_21;

  // router 2_1 to 3_1
  wire ccw_si_21_so_31;
  wire ccw_ri_21_ro_31;
  wire [63:0] ccw_di_21_do_31;

  wire cw_so_21_si_31;
  wire cw_ro_21_ri_31;
  wire [63:0] cw_do_21_di_31;

  // Router to NIC
  // Router 0_1
  wire net_so_pesi_01;
  wire net_ro_peri_01;
  wire [63:0] net_do_pedi_01;
  wire net_polarity_01;
  wire net_si_peso_01;
  wire net_ri_pero_01;
  wire [63:0] net_di_pedo_01;

  // Router 1_1
  wire net_so_pesi_11;
  wire net_ro_peri_11;
  wire [63:0] net_do_pedi_11;
  wire net_polarity_11;
  wire net_si_peso_11;
  wire net_ri_pero_11;
  wire [63:0] net_di_pedo_11;

  // Router 2_1
  wire net_so_pesi_21;
  wire net_ro_peri_21;
  wire [63:0] net_do_pedi_21;
  wire net_polarity_21;
  wire net_si_peso_21;
  wire net_ri_pero_21;
  wire [63:0] net_di_pedo_21;

  // Router 3_1
  wire net_so_pesi_31;
  wire net_ro_peri_31;
  wire [63:0] net_do_pedi_31;
  wire net_polarity_31;
  wire net_si_peso_31;
  wire net_ri_pero_31;
  wire [63:0] net_di_pedo_31;

  router router_0_1 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_01),
    // Left side, no connections
    .cwsi(), .cwri(), .cwdi(), .ccwso(), .ccwro(), .ccwdo(),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_01_so_11), .ccwri(ccw_ri_01_ro_11), .ccwdi(ccw_di_01_do_11),
    .cwso(cw_so_01_si_11), .cwro(cw_ro_01_ri_11), .cwdo(cw_do_01_di_11),

    // Bottom, no connections
    .snsi(snsi_0_1), .snri(snri_0_1), .sndi(sndi_0_1), .nsso(nsso_0_1), .nsro(nsro_0_1), .nsdo(nsdo_0_1),

    // Top side
    .snso(snso_0_1), .snro(snro_0_1), .sndo(sndo_0_1), .nssi(nssi_0_1), .nsri(nsri_0_1), .nsdi(nsdi_0_1),

    // PE input/output to NIC
    .pesi(net_so_pesi_01), .pedi(net_do_pedi_01), .peri(net_ro_peri_01),
    .peso(net_si_peso_01), .pedo(net_di_pedo_01), .pero(net_ri_pero_01)
  );

  // NIC module instantiation for 0_1
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_0_1 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_0_1),
      .d_in(d_in_0_1),
      .d_out(d_out_0_1),
      .nicEn(nicEn_0_1),
      .nicEnWR(nicEnWR_0_1),
  
      // Router-NIC Interface
      .net_si(net_si_peso_01),
      .net_so(net_so_pesi_01),
      .net_ri(net_ri_pero_01),
      .net_ro(net_ro_peri_01),
  
      .net_di(net_di_pedo_01),
      .net_do(net_do_pedi_01),
      .net_polarity(net_polarity_01)
  );

  router router_1_1 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_11),
    // Left side
    .cwsi(cw_so_01_si_11), .cwri(cw_ro_01_ri_11), .cwdi(cw_do_01_di_11),
    .ccwso(ccw_si_01_so_11), .ccwro(ccw_ri_01_ro_11), .ccwdo(ccw_di_01_do_11),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_11_so_21), .ccwri(ccw_ri_11_ro_21), .ccwdi(ccw_di_11_do_21),
    .cwso(cw_so_11_si_21), .cwro(cw_ro_11_ri_21), .cwdo(cw_do_11_di_21),

    // Bottom, no connections
    .snsi(snsi_1_1), .snri(snri_1_1), .sndi(sndi_1_1), .nsso(nsso_1_1), .nsro(nsro_1_1), .nsdo(nsdo_1_1),

    // Top side
    .snso(snso_1_1), .snro(snro_1_1), .sndo(sndo_1_1), .nssi(nssi_1_1), .nsri(nsri_1_1), .nsdi(nsdi_1_1),

    // PE input/output to NIC
    .pesi(net_so_pesi_11), .pedi(net_do_pedi_11), .peri(net_ro_peri_11),
    .peso(net_si_peso_11), .pedo(net_di_pedo_11), .pero(net_ri_pero_11)
  );

  // NIC module instantiation for 0_1
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_1_1 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_1_1),
      .d_in(d_in_1_1),
      .d_out(d_out_1_1),
      .nicEn(nicEn_1_1),
      .nicEnWR(nicEnWR_1_1),
  
      // Router-NIC Interface
      .net_si(net_si_peso_11),
      .net_so(net_so_pesi_11),
      .net_ri(net_ri_pero_11),
      .net_ro(net_ro_peri_11),
  
      .net_di(net_di_pedo_11),
      .net_do(net_do_pedi_11),
      .net_polarity(net_polarity_11)
  );

    router router_2_1 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_21),
    // Left side
    .cwsi(cw_so_11_si_21), .cwri(cw_ro_11_ri_21), .cwdi(cw_do_11_di_21),
    .ccwso(ccw_si_11_so_21), .ccwro(ccw_ri_11_ro_21), .ccwdo(ccw_di_11_do_21),

    // Right side CW out and CCW in
    .ccwsi(ccw_si_21_so_31), .ccwri(ccw_ri_21_ro_31), .ccwdi(ccw_di_21_do_31),
    .cwso(cw_so_21_si_31), .cwro(cw_ro_21_ri_31), .cwdo(cw_do_21_di_31),

    // Bottom, no connections
    .snsi(snsi_2_1), .snri(snri_2_1), .sndi(sndi_2_1), .nsso(nsso_2_1), .nsro(nsro_2_1), .nsdo(nsdo_2_1),

    // Top side
    .snso(snso_2_1), .snro(snro_2_1), .sndo(sndo_2_1), .nssi(nssi_2_1), .nsri(nsri_2_1), .nsdi(nsdi_2_1),

    // PE input/output to NIC
    .pesi(net_so_pesi_21), .pedi(net_do_pedi_21), .peri(net_ro_peri_21),
    .peso(net_si_peso_21), .pedo(net_di_pedo_21), .pero(net_ri_pero_21)
  );

  // NIC module instantiation for 0_1
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_2_1 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_2_1),
      .d_in(d_in_2_1),
      .d_out(d_out_2_1),
      .nicEn(nicEn_2_1),
      .nicEnWR(nicEnWR_2_1),
  
      // Router-NIC Interface
      .net_si(net_si_peso_21),
      .net_so(net_so_pesi_21),
      .net_ri(net_ri_pero_21),
      .net_ro(net_ro_peri_21),
  
      .net_di(net_di_pedo_21),
      .net_do(net_do_pedi_21),
      .net_polarity(net_polarity_21)
  );

      router router_3_1 (
    .clk (clk),
    .reset(reset),
    .router_position(0), 
    .polarity_out(net_polarity_31),
    // Left side
    .cwsi(cw_so_21_si_31), .cwri(cw_ro_21_ri_31), .cwdi(cw_do_21_di_31),
    .ccwso(ccw_si_21_so_31), .ccwro(ccw_ri_21_ro_31), .ccwdo(ccw_di_21_do_31),

    // Right side, no connections
    .ccwsi(), .ccwri(), .ccwdi(), .cwso(), .cwro(), .cwdo(),

    // Bottom, no connections
    .snsi(snsi_3_1), .snri(snri_3_1), .sndi(sndi_3_1), .nsso(nsso_3_1), .nsro(nsro_3_1), .nsdo(nsdo_3_1),

    // Top side
    .snso(snso_3_1), .snro(snro_3_1), .sndo(sndo_3_1), .nssi(nssi_3_1), .nsri(nsri_3_1), .nsdi(nsdi_3_1),

    // PE input/output to NIC
    .pesi(net_so_pesi_31), .pedi(net_do_pedi_31), .peri(net_ro_peri_31),
    .peso(net_si_peso_31), .pedo(net_di_pedo_31), .pero(net_ri_pero_31)
  );

  // NIC module instantiation for 0_1
  nic #(
      .PACKET_WIDTH(PACKET_WIDTH)
  ) nic_3_1 (
      .clk(clk),
      .reset(reset),
  
      // CPU-NIC Interface
      .addr(addr_3_1),
      .d_in(d_in_3_1),
      .d_out(d_out_3_1),
      .nicEn(nicEn_3_1),
      .nicEnWR(nicEnWR_3_1),
  
      // Router-NIC Interface
      .net_si(net_si_peso_31),
      .net_so(net_so_pesi_31),
      .net_ri(net_ri_pero_31),
      .net_ro(net_ro_peri_31),
  
      .net_di(net_di_pedo_31),
      .net_do(net_do_pedi_31),
      .net_polarity(net_polarity_31)
  );

endmodule