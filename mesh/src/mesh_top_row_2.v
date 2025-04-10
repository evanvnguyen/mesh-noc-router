
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
*/

// Row 3
// Row 2
// Row 1 <--
// Row 0

// bottom row of mesh

module mesh_top_row_2 #(
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
    
    // CPU <--> External interface
    input [0:31] inst_in_0_2, inst_in_1_2, inst_in_2_2, inst_in_3_2,                // from imem
    input [0:63] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2,                            // data input from dmem
    output [0:31] pc_out_0_2, pc_out_1_2, pc_out_2_2, pc_out_3_2,                    // program counter out
    output  [0:63] d_out_0_2, d_out_1_2, d_out_2_2, d_out_3_2,                   // data output to data memory
    output  [0:31] addr_out_0_2, addr_out_1_2, addr_out_2_2, addr_out_3_2,        // data memory address
    output  memWrEn_0_2, memWrEn_1_2, memWrEn_2_2, memWrEn_3_2,                  // data memory write enable
    output  memEn_0_2, memEn_1_2, memEn_2_2, memEn_3_2                  // data memory write enable



    );       

    // naming scheme is first signal - left. second signal - right
    wire cwsi_cwso_0, cwri_cwro_0, ccwso_ccwsi_0, ccwro_ccwri_0;
    wire [63:0] cwdi_cwdo_0, ccwdo_ccwdi_0; 
    wire cwsi_cwso_1, cwri_cwro_1, ccwso_ccwsi_1, ccwro_ccwri_1;
    wire [63:0] cwdi_cwdo_1, ccwdo_ccwdi_1; 
    wire cwsi_cwso_2, cwri_cwro_2, ccwso_ccwsi_2, ccwro_ccwri_2;
    wire [63:0] cwdi_cwdo_2, ccwdo_ccwdi_2;
    
    // add CPU for part 3
    wire [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
    wire [PACKET_WIDTH-1:0] d_in_0_1, d_out_0_1;
    wire [PACKET_WIDTH-1:0] d_in_1_1, d_out_1_1;
    wire [PACKET_WIDTH-1:0] d_in_2_1, d_out_2_1;
    wire [PACKET_WIDTH-1:0] d_in_3_1, d_out_3_1;
    wire nicEn_0_1, nicEnWR_0_1;
    wire nicEn_1_1, nicEnWR_1_1;
    wire nicEn_2_1, nicEnWR_2_1;
    wire nicEn_3_1, nicEnWR_3_1;
    
    wire net_si_0_1, net_so_0_2;
    wire net_ri_0_1, net_ro_0_2;
    wire [PACKET_WIDTH-1:0] net_di_0_2, net_do_0_2;
    wire net_polarity_0_2;
    
    wire net_si_1_1, net_so_1_2;
    wire net_ri_1_1, net_ro_1_2;
    wire [PACKET_WIDTH-1:0] net_di_1_2, net_do_1_2;
    wire net_polarity_1_2;
    
    wire net_si_2_1, net_so_2_2;
    wire net_ri_2_1, net_ro_2_2;
    wire [PACKET_WIDTH-1:0] net_di_2_2, net_do_2_2;
    wire net_polarity_2_2;
    
    wire net_si_3_1, net_so_3_2;
    wire net_ri_3_1, net_ro_3_2;
    wire [PACKET_WIDTH-1:0] net_di_3_2, net_do_3_2;
    wire net_polarity_3_2;
    wire wasd0, wasd1, wasd2, wasd3;
    wire [63:0] wasd5, wasd6; 
    
    // CPU <--> NIC
    wire nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;                              // NIC enable 
    wire nicWrEn_0_2, nicWrEn_1_2, nicWrEn_2_2, nicWrEn_3_2;                      // NIC write enable
    wire [0:1] addr_nic_0_2, addr_nic_1_2, addr_nic_2_2, addr_nic_3_2;         // NIC address
    wire [0:63] d_out_nic_0_2, d_out_nic_1_2, d_out_nic_2_2, d_out_nic_3_2;     // NIC data output
    wire [0:63] d_in_nic_0_2, d_in_nic_1_2, d_in_nic_2_2, d_in_nic_3_2;              // NIC data input
    
    
    // bottom left corner 
    router router_0_2 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_0_2),
        
        //right 
        .cwsi(), .cwri(), .cwdi(), .ccwso(), .ccwro(), .ccwdo(),
        //.cwso(wasd0), .cwro(wasd1), .cwdo(wasd5), .ccwsi(wasd2), .ccwri(wasd3), .ccwdi(wasd6),

        //left - gnd
        //.cwso(), .cwro(), .cwdo(), .ccwsi(), .ccwri(), .ccwdi(),
        .cwso(wasd0), .cwro(wasd1), .cwdo(wasd5), .ccwsi(wasd2), .ccwri(wasd3), .ccwdi(wasd6),
        
        // top
        .snso(snso_0_2), .snro(snro_0_2), .sndo(sndo_0_2), .nssi(nssi_0_2), .nsri(nsri_0_2), .nsdi(nsdi_0_2),  
    
        // bottom
        .snsi(snsi_0_2), .snri(snri_0_2), .sndi(sndi_0_2), .nsso(nsso_0_2), .nsro(nsro_0_2), .nsdo(nsdo_0_2),
 
        // PE input/output to NIC
        .pesi(net_so_0_2), .pedi(net_do_0_2), .peri(net_ro_0_2), 
        .pero(net_ri_0_2), .peso(net_si_0_2), .pedo(net_di_0_2)
    );
   
    // NIC module instantiation for 0_1
    nic #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) nic_0_2 (
        .clk(clk),
        .reset(reset),
    
        // CPU-NIC Interface
        .addr(addr_nic_0_2),
        .d_in(d_in_0_2),
        .d_out(d_out_0_2),
        .nicEn(nicEn_0_2),
        .nicEnWR(nicWrEn_0_2),
    
        // Router-NIC Interface
        .net_si(net_si_0_2),
        .net_so(net_so_0_2),
        .net_ri(net_ri_0_2),
        .net_ro(net_ro_0_2),
    
        .net_di(net_di_0_2),
        .net_do(net_do_0_2),
        .net_polarity(net_polarity_0_2)
    );
    
    four_stage_processor cpu_0_2 (
        .clk(clk),
        .reset(clk),
    
        // CPU - CPU interface
        .inst_in(inst_in_0_2),
        .d_in(d_in_0_2),
        .pc_out(pc_out_0_2),
        .d_out(d_out_0_2),
        .addr_out(addr_out_0_2),
        .memWrEn(memWrEn_0_2),
        .memEn(memEn_0_2),
    
        // CPU - NIC interface
        .nicEn(nicEn_0_2),
        .nicWrEn(nicWrEn_0_2),
        .addr_nic(addr_nic_0_2),
        .d_out_nic(d_out_nic_0_2),
        .d_in_nic(d_in_nic_0_2)
    );

    router router_1_2 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_1_2),
        
        //right 
        //.cwsi(cwsi_cwso_1), .cwri(cwri_cwro_1), .cwdi(cwdi_cwdo_1), .ccwso(ccwso_ccwsi_1), .ccwro(ccwro_ccwri_1), .ccwdo(ccwdo_ccwdi_1),
        .cwsi(wasd0), .cwri(wasd1), .cwdi(wasd5), .ccwso(wasd2), .ccwro(wasd3), .ccwdo(wasd6),

        //left 
        .cwso(cwsi_cwso_2), .cwro(cwri_cwro_2), .cwdo(cwdi_cwdo_2), .ccwsi(ccwso_ccwsi_2), .ccwri(ccwro_ccwri_2), .ccwdi(ccwdo_ccwdi_2),
        
        // top
        .snso(snso_1_2), .snro(snro_1_2), .sndo(sndo_1_2), .nssi(nssi_1_2), .nsri(nsri_1_2), .nsdi(nsdi_1_2),  
    
        // bottom
        .snsi(snsi_1_2), .snri(snri_1_2), .sndi(sndi_1_2), .nsso(nsso_1_2), .nsro(nsro_1_2), .nsdo(nsdo_1_2),

        // PE input/output to NIC
        .pesi(net_so_1_2), .pedi(net_do_1_2), .peri(net_ro_1_2), 
        .pero(net_ri_1_2), .peso(net_si_1_2), .pedo(net_di_1_2)
    );
    
    // NIC module instantiation for 1_1
    nic #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) nic_1_2 (
        .clk(clk),
        .reset(reset),
    
        // CPU-NIC Interface
        .addr(addr_nic_1_2),
        .d_in(d_in_1_2),
        .d_out(d_out_1_2),
        .nicEn(nicEn_1_2),
        .nicEnWR(nicWrEn_1_2),
    
        // Router-NIC Interface
        .net_si(net_si_1_2),
        .net_so(net_so_1_2),
        .net_ri(net_ri_1_2),
        .net_ro(net_ro_1_2),
    
        .net_di(net_di_1_2),
        .net_do(net_do_1_2),
        .net_polarity(net_polarity_1_2)
    );
    
    
    four_stage_processor cpu_1_2 (
        .clk(clk),
        .reset(clk),
    
        // CPU - CPU interface
        .inst_in(inst_in_1_2),
        .d_in(d_in_1_2),
        .pc_out(pc_out_1_2),
        .d_out(d_out_1_2),
        .addr_out(addr_out_1_2),
        .memWrEn(memWrEn_1_2),
        .memEn(memEn_1_2),
    
        // CPU - NIC interface
        .nicEn(nicEn_1_2),
        .nicWrEn(nicWrEn_1_2),
        .addr_nic(addr_nic_1_2),
        .d_out_nic(d_out_nic_1_2),
        .d_in_nic(d_in_nic_1_2)
    );
    
    router router_2_2 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_2_2),
        
        //right 
        .cwsi(cwsi_cwso_2), .cwri(cwri_cwro_2), .cwdi(cwdi_cwdo_2), .ccwso(ccwso_ccwsi_2), .ccwro(ccwro_ccwri_2), .ccwdo(ccwdo_ccwdi_2),

        //left
        .cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        
        // top
        .snso(snso_2_2), .snro(snro_2_2), .sndo(sndo_2_2), .nssi(nssi_2_2), .nsri(nsri_2_2), .nsdi(nsdi_2_2),  
    
        // bottom
        .snsi(snsi_2_2), .snri(snri_2_2), .sndi(sndi_2_2), .nsso(nsso_2_2), .nsro(nsro_2_2), .nsdo(nsdo_2_2),

        // PE input/output to NIC
        .pesi(net_so_2_2), .pedi(net_do_2_2), .peri(net_ro_2_2), 
        .pero(net_ri_2_2), .peso(net_si_2_2), .pedo(net_di_2_2)
    );
    
    // NIC module instantiation for 2_1
    nic #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) nic_2_2 (
        .clk(clk),
        .reset(reset),
    
        // CPU-NIC Interface
        .addr(addr_nic_2_2),
        .d_in(d_in_2_2),
        .d_out(d_out_2_2),
        .nicEn(nicEn_2_2),
        .nicEnWR(nicWrEn_2_2),
    
        // Router-NIC Interface
        .net_si(net_si_2_2),
        .net_so(net_so_2_2),
        .net_ri(net_ri_2_2),
        .net_ro(net_ro_2_2),
    
        .net_di(net_di_2_2),
        .net_do(net_do_2_2),
        .net_polarity(net_polarity_2_2)
    );
    
    four_stage_processor cpu_2_2 (
        .clk(clk),
        .reset(clk),
    
        // CPU - CPU interface
        .inst_in(inst_in_2_2),
        .d_in(d_in_2_2),
        .pc_out(pc_out_2_2),
        .d_out(d_out_2_2),
        .addr_out(addr_out_2_2),
        .memWrEn(memWrEn_2_2),
        .memEn(memEn_2_2),
    
        // CPU - NIC interface
        .nicEn(nicEn_2_2),
        .nicWrEn(nicWrEn_2_2),
        .addr_nic(addr_nic_2_2),
        .d_out_nic(d_out_nic_2_2),
        .d_in_nic(d_in_nic_2_2)
    );
     
    router router_3_2 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_3_2),
        
        //right - gnd 
        .cwsi(cwsi_cwso_1), .cwri(cwri_cwro_1), .cwdi(cwdi_cwdo_1), .ccwso(ccwso_ccwsi_1), .ccwro(ccwro_ccwri_1), .ccwdo(ccwdo_ccwdi_1),

        //left
        .cwso(), .cwro(), .cwdo(), .ccwsi(), .ccwri(), .ccwdi(),
        
        // top
        .snso(snso_3_2), .snro(snro_3_2), .sndo(sndo_3_2), .nssi(nssi_3_2), .nsri(nsri_3_2), .nsdi(nsdi_3_2),  

        // bottom 
        .snsi(snsi_3_2), .snri(snri_3_2), .sndi(sndi_3_2), .nsso(nsso_3_2), .nsro(nsro_3_2), .nsdo(nsdo_3_2),

        // PE input/output to NIC
        .pesi(net_so_3_2), .pedi(net_do_3_2), .peri(net_ro_3_2), 
        .pero(net_ri_3_2), .peso(net_si_3_2), .pedo(net_di_3_2)
    );
    
    // NIC module instantiation for 3_1
    nic #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) nic_3_2 (
        .clk(clk),
        .reset(reset),
    
        // CPU-NIC Interface
        .addr(addr_nic_3_2),
        .d_in(d_in_3_2),
        .d_out(d_out_3_2),
        .nicEn(nicEn_3_2),
        .nicEnWR(nicWrEn_3_2),
    
        // Router-NIC Interface
        .net_si(net_si_3_2),
        .net_so(net_so_3_2),
        .net_ri(net_ri_3_2),
        .net_ro(net_ro_3_2),
    
        .net_di(net_di_3_2),
        .net_do(net_do_3_2),
        .net_polarity(net_polarity_3_2)
    );
    
    four_stage_processor cpu_3_2 (
        .clk(clk),
        .reset(clk),
    
        // CPU - CPU interface
        .inst_in(inst_in_3_2),
        .d_in(d_in_3_2),
        .pc_out(pc_out_3_2),
        .d_out(d_out_3_2),
        .addr_out(addr_out_3_2),
        .memWrEn(memWrEn_3_2),
        .memEn(memEn_3_2),
    
        // CPU - NIC interface
        .nicEn(nicEn_3_2),
        .nicWrEn(nicWrEn_3_2),
        .addr_nic(addr_nic_3_2),
        .d_out_nic(d_out_nic_3_2),
        .d_in_nic(d_in_nic_3_2)
    );

endmodule
