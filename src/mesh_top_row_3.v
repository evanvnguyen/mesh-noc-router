
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

// Row 3 <--
// Row 2 
// Row 1 
// Row 0

// top row of mesh

module mesh_top_row_3 #(
        parameter PACKET_WIDTH = 64
    ) (
        input clk,
        input reset,

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
        output [63:0] nsdo_3_3
    );       
    
    // naming scheme is first signal - left. second signal - right
    wire cwsi_cwso_0, cwri_cwro_0, ccwso_ccwsi_0, ccwro_ccwri_0;
    wire [63:0] cwdi_cwdo_0, ccwdo_ccwdi_0; 
    wire cwsi_cwso_1, cwri_cwro_1, ccwso_ccwsi_1, ccwro_ccwri_1;
    wire [63:0] cwdi_cwdo_1, ccwdo_ccwdi_1; 
    wire cwsi_cwso_2, cwri_cwro_2, ccwso_ccwsi_2, ccwro_ccwri_2;
    wire [63:0] cwdi_cwdo_2, ccwdo_ccwdi_2;

    // Disconnected from CPU as of part 1
    wire [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
    wire [PACKET_WIDTH-1:0] d_in_0_3, d_out_0_3;
    wire [PACKET_WIDTH-1:0] d_in_1_3, d_out_1_3;
    wire [PACKET_WIDTH-1:0] d_in_2_3, d_out_2_3;
    wire [PACKET_WIDTH-1:0] d_in_3_3, d_out_3_3;
    wire nicEn_0_3, nicEnWR_0_3;
    wire nicEn_1_3, nicEnWR_1_3;
    wire nicEn_2_3, nicEnWR_2_3;
    wire nicEn_3_3, nicEnWR_3_3;
    
    wire net_si_0_3, net_so_0_3;
    wire net_ri_0_3, net_ro_0_3;
    wire [PACKET_WIDTH-1:0] net_di_0_3, net_do_0_3;
    wire net_polarity_0_3;
    
    wire net_si_1_3, net_so_1_3;
    wire net_ri_1_3, net_ro_1_3;
    wire [PACKET_WIDTH-1:0] net_di_1_3, net_do_1_3;
    wire net_polarity_1_3;
    
    wire net_si_2_3, net_so_2_3;
    wire net_ri_2_3, net_ro_2_3;
    wire [PACKET_WIDTH-1:0] net_di_2_3, net_do_2_3;
    wire net_polarity_2_3;
    
    wire net_si_3_3, net_so_3_3;
    wire net_ri_3_3, net_ro_3_3;
    wire [PACKET_WIDTH-1:0] net_di_3_3, net_do_3_3;
    wire net_polarity_3_3;

    // bottom left corner 
    router router_0_3 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_0_3),
        
        //right 
        .cwsi(cwsi_cwso_0), .cwri(cwri_cwro_0), .cwdi(cwdi_cwdo_0), .ccwso(ccwso_ccwsi_0), .ccwro(ccwro_ccwri_0), .ccwdo(ccwdo_ccwdi_0),

        //left - gnd
        .cwso(), .cwro(), .cwdo(), .ccwsi(), .ccwri(), .ccwdi(),
        
        // top
        .snso(), .snro(), .sndo(), .nssi(), .nsri(), .nsdi(),  
    
        // bottom
        .snsi(snsi_0_3), .snri(snri_0_3), .sndi(sndi_0_3), .nsso(nsso_0_3), .nsro(nsro_0_3), .nsdo(nsdo_0_3),
 
        // PE input/output to NIC
        .pesi(net_so_0_3), .pedi(net_do_0_3), .peri(net_ro_0_3), 
        .pero(net_ri_0_3), .peso(net_si_0_3), .pedo(net_di_0_3)
    );
   
    nic #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) nic_0_3 (
        .clk(clk),
        .reset(clk),
    
        // CPU-NIC Interface
        .addr(addr_0_3),
        .d_in(d_in_0_3),
        .d_out(d_out_0_3),
        .nicEn(nicEn_0_3),
        .nicEnWR(nicEnWR_0_3),
    
        // Router-NIC Interface
        .net_si(net_si_0_3),  // Send handshake signal-in
        .net_so(net_so_0_3),  // Send handshake signal-out
        .net_ri(net_ri_0_3),  // Ready handshake signal-in
        .net_ro(net_ro_0_3),  // Ready handshake signal-out
    
        .net_di(net_di_0_3),  // Data input from Router
        .net_do(net_do_0_3),  // Data output to Router
        .net_polarity(net_polarity_0_3) // Polarity signal from Router
    );
    
    router router_1_3 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(cwsi_cwso_1), .cwri(cwri_cwro_1), .cwdi(cwdi_cwdo_1), .ccwso(ccwso_ccwsi_1), .ccwro(ccwro_ccwri_1), .ccwdo(ccwdo_ccwdi_1),

        //left 
        .cwso(cwsi_cwso_0), .cwro(cwri_cwro_0), .cwdo(cwdi_cwdo_0), .ccwsi(ccwso_ccwsi_0), .ccwri(ccwro_ccwri_0), .ccwdi(ccwdo_ccwdi_0),
        
        // top
        .snso(), .snro(), .sndo(), .nssi(), .nsri(), .nsdi(),  
    
        // bottom
        .snsi(snsi_1_3), .snri(snri_1_3), .sndi(sndi_1_3), .nsso(nsso_1_3), .nsro(nsro_1_3), .nsdo(nsdo_1_3),

        // PE input/output to NIC
        .pesi(net_so_1_3), .pedi(net_do_1_3), .peri(net_ro_1_3), 
        .pero(net_ri_1_3), .peso(net_si_1_3), .pedo(net_di_1_3)
    );
    
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
        .net_si(net_si_1_3),
        .net_so(net_so_1_3),
        .net_ri(net_ri_1_3),
        .net_ro(net_ro_1_3),
    
        .net_di(net_di_1_3),
        .net_do(net_do_1_3),
        .net_polarity(net_polarity_1_3)
    );
    
    router router_2_3 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(cwsi_cwso_2), .cwri(cwri_cwro_2), .cwdi(cwdi_cwdo_2), .ccwso(ccwso_ccwsi_2), .ccwro(ccwro_ccwri_2), .ccwdo(ccwdo_ccwdi_2),

        //left
        .cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        
        // top
        .snso(), .snro(), .sndo(), .nssi(), .nsri(), .nsdi(),  
    
        // bottom
        .snsi(snsi_2_3), .snri(snri_2_3), .sndi(sndi_2_3), .nsso(nsso_2_3), .nsro(nsro_2_3), .nsdo(nsdo_2_3),

        // PE input/output to NIC
        .pesi(net_so_2_3), .pedi(net_do_2_3), .peri(net_ro_2_3), 
        .pero(net_ri_2_3), .peso(net_si_2_3), .pedo(net_di_2_3)
    );
    
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
        .net_si(net_si_2_3),
        .net_so(net_so_2_3),
        .net_ri(net_ri_2_3),
        .net_ro(net_ro_2_3),
    
        .net_di(net_di_2_3),
        .net_do(net_do_2_3),
        .net_polarity(net_polarity_2_3)
    );
     
    router router_3_3 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(), .cwri(), .cwdi(), .ccwso(), .ccwro(), .ccwdo(),

        //left
        .cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        
        // top
        .snso(), .snro(), .sndo(), .nssi(), .nsri(), .nsdi(),  

        // bottom 
        .snsi(snsi_3_3), .snri(snri_3_3), .sndi(sndi_3_3), .nsso(nsso_3_3), .nsro(nsro_3_3), .nsdo(nsdo_3_3),

        // PE input/output to NIC
        .pesi(net_so_3_3), .pedi(net_do_3_3), .peri(net_ro_3_3), 
        .pero(net_ri_3_3), .peso(net_si_3_3), .pedo(net_di_3_3)
    );

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
        .net_si(net_si_3_3),
        .net_so(net_so_3_3),
        .net_ri(net_ri_3_3),
        .net_ro(net_ro_3_3),
    
        .net_di(net_di_3_3),
        .net_do(net_do_3_3),
        .net_polarity(net_polarity_3_3)
    );

endmodule
