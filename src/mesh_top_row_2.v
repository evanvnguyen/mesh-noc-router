
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
// Row 1
// Row 0 <--

// bottom row of mesh
// need integrate to NIC

module mesh_top_row_0 #(
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
    
    // CPU tb signal
    input [1:0]   addr_0_0,
    input [63:0]  d_in_0_0,
    output [63:0] d_out_0_0,
    input         nicEn_0_0,
    input         nicEnWR_0_0,
    
    input [1:0]   addr_1_0,
    input [63:0]  d_in_1_0,
    output [63:0] d_out_1_0,
    input         nicEn_1_0,
    input         nicEnWR_1_0,
    
    input [1:0]   addr_2_0,
    input [63:0]  d_in_2_0,
    output [63:0] d_out_2_0,
    input         nicEn_2_0,
    input         nicEnWR_2_0,
    
    input [1:0]   addr_3_0,
    input [63:0]  d_in_3_0,
    output [63:0] d_out_3_0,
    input         nicEn_3_0,
    input         nicEnWR_3_0
    

); 

    // naming scheme is first signal - left. second signal - right
    wire cwsi_cwso_0, cwri_cwro_0, ccwso_ccwsi_0, ccwro_ccwri_0;
    wire [63:0] cwdi_cwdo_0, ccwdo_ccwdi_0; 
    wire cwsi_cwso_1, cwri_cwro_1, ccwso_ccwsi_1, ccwro_ccwri_1;
    wire [63:0] cwdi_cwdo_1, ccwdo_ccwdi_1; 
    wire cwsi_cwso_2, cwri_cwro_2, ccwso_ccwsi_2, ccwro_ccwri_2;
    wire [63:0] cwdi_cwdo_2, ccwdo_ccwdi_2; 

    // Disconnected from CPU as of part 1
    //wire [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
    //wire [PACKET_WIDTH-1:0] d_in_0_0, d_out_0_0;
    //wire [PACKET_WIDTH-1:0] d_in_1_0, d_out_1_0;
    //wire [PACKET_WIDTH-1:0] d_in_2_0, d_out_2_0;
    //wire [PACKET_WIDTH-1:0] d_in_3_0, d_out_3_0;
    //wire nicEn_0_0, nicEnWR_0_0;
    //wire nicEn_1_0, nicEnWR_1_0;
    //wire nicEn_2_0, nicEnWR_2_0;
    //wire nicEn_3_0, nicEnWR_3_0;
    
    wire net_si_0_0, net_so_0_0;
    wire net_ri_0_0, net_ro_0_0;
    wire [PACKET_WIDTH-1:0] net_di_0_0, net_do_0_0;
    wire net_polarity_0_0;
    
    wire net_si_1_0, net_so_1_0;
    wire net_ri_1_0, net_ro_1_0;
    wire [PACKET_WIDTH-1:0] net_di_1_0, net_do_1_0;
    wire net_polarity_1_0;
    
    wire net_si_2_0, net_so_2_0;
    wire net_ri_2_0, net_ro_2_0;
    wire [PACKET_WIDTH-1:0] net_di_2_0, net_do_2_0;
    wire net_polarity_2_0;
    
    wire net_si_3_0, net_so_3_0;
    wire net_ri_3_0, net_ro_3_0;
    wire [PACKET_WIDTH-1:0] net_di_3_0, net_do_3_0;
    wire net_polarity_3_0;


    // bottom left corner 
    router router_0_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_0_0),
        
        //right 
        .cwsi(cwsi_cwso_0), .cwri(cwri_cwro_0), .cwdi(cwdi_cwdo_0), .ccwso(ccwso_ccwsi_0), .ccwro(ccwro_ccwri_0), .ccwdo(ccwdo_ccwdi_0),

        //left - gnd
        .cwso(), .cwro(), .cwdo(), .ccwsi(), .ccwri(), .ccwdi(),
        
        // top
        .snso(snso_0_0), .snro(snro_0_0), .sndo(sndo_0_0), .nssi(nssi_0_0), .nsri(nsri_0_0), .nsdi(nsdi_0_0),  
    
        // bottom - gnd
        .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),
 
        // PE input/output to NIC
        .pesi(net_so_0_0), .pedi(net_do_0_0), .peri(net_ro_0_0), 
        .pero(net_ri_0_0), .peso(net_si_0_0), .pedo(net_di_0_0)
    );
    
   // NIC module instantiation for 0_0
    nic #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) nic_0_0 (
        .clk(clk),
        .reset(reset),
    
        // CPU-NIC Interface
        .addr(addr_0_0),
        .d_in(d_in_0_0),
        .d_out(d_out_0_0),
        .nicEn(nicEn_0_0),
        .nicEnWR(nicEnWR_0_0),
    
        // Router-NIC Interface
        .net_si(net_si_0_0),
        .net_so(net_so_0_0),
        .net_ri(net_ri_0_0),
        .net_ro(net_ro_0_0),
    
        .net_di(net_di_0_0),
        .net_do(net_do_0_0),
        .net_polarity(net_polarity_0_0)
    );
    
    router router_1_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_1_0),
        
        //right 
        .cwsi(cwsi_cwso_1), .cwri(cwri_cwro_1), .cwdi(cwdi_cwdo_1), .ccwso(ccwso_ccwsi_1), .ccwro(ccwro_ccwri_1), .ccwdo(ccwdo_ccwdi_1),

        //left 
        .cwso(cwsi_cwso_0), .cwro(cwri_cwro_0), .cwdo(cwdi_cwdo_0), .ccwsi(ccwso_ccwsi_0), .ccwri(ccwro_ccwri_0), .ccwdi(ccwdo_ccwdi_0),
        
        // top
        .snso(snso_1_0), .snro(snro_1_0), .sndo(sndo_1_0), .nssi(nssi_1_0), .nsri(nsri_1_0), .nsdi(nsdi_1_0),  
    
        // bottom - gnd
        .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),
 
        // PE input/output to NIC
        .pesi(net_so_1_0), .pedi(net_do_1_0), .peri(net_ro_1_0), 
        .pero(net_ri_1_0), .peso(net_si_1_0), .pedo(net_di_1_0)
    );
    
    // NIC module instantiation for 1_0
    nic #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) nic_1_0 (
        .clk(clk),
        .reset(reset),
    
        // CPU-NIC Interface
        .addr(addr_1_0),
        .d_in(d_in_1_0),
        .d_out(d_out_1_0),
        .nicEn(nicEn_1_0),
        .nicEnWR(nicEnWR_1_0),
    
        // Router-NIC Interface
        .net_si(net_si_1_0),
        .net_so(net_so_1_0),
        .net_ri(net_ri_1_0),
        .net_ro(net_ro_1_0),
    
        .net_di(net_di_1_0),
        .net_do(net_do_1_0),
        .net_polarity(net_polarity_1_0)
    );
    
    router router_2_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_2_0),
        
        //right 
        .cwsi(cwsi_cwso_2), .cwri(cwri_cwro_2), .cwdi(cwdi_cwdo_2), .ccwso(ccwso_ccwsi_2), .ccwro(ccwro_ccwri_2), .ccwdo(ccwdo_ccwdi_2),

        //left
        .cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        
        // top
        .snso(snso_2_0), .snro(snro_2_0), .sndo(sndo_2_0), .nssi(nssi_2_0), .nsri(nsri_2_0), .nsdi(nsdi_2_0),  
    
        // bottom - gnd
        .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),
 
        // PE input/output to NIC
        .pesi(net_so_2_0), .pedi(net_do_2_0), .peri(net_ro_2_0), 
        .pero(net_ri_2_0), .peso(net_si_2_0), .pedo(net_di_2_0)
    );
    
    // NIC module instantiation for 2_0
    nic #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) nic_2_0 (
        .clk(clk),
        .reset(reset),
    
        // CPU-NIC Interface
        .addr(addr_2_0),
        .d_in(d_in_2_0),
        .d_out(d_out_2_0),
        .nicEn(nicEn_2_0),
        .nicEnWR(nicEnWR_2_0),
    
        // Router-NIC Interface
        .net_si(net_si_2_0),
        .net_so(net_so_2_0),
        .net_ri(net_ri_2_0),
        .net_ro(net_ro_2_0),
    
        .net_di(net_di_2_0),
        .net_do(net_do_2_0),
        .net_polarity(net_polarity_2_0)
    );

    router router_3_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_3_0),
        
        //right - gnd 
        .cwsi(), .cwri(), .cwdi(), .ccwso(), .ccwro(), .ccwdo(),

        //left
        .cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        
        // top
        .snso(snso_3_0), .snro(snro_3_0), .sndo(sndo_3_0), .nssi(nssi_3_0), .nsri(nsri_3_0), .nsdi(nsdi_3_0),  

        // bottom - gnd
        .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),
 
        // PE input/output to NIC
        .pesi(net_so_3_0), .pedi(net_do_3_0), .peri(net_ro_3_0), 
        .pero(net_ri_3_0), .peso(net_si_3_0), .pedo(net_di_3_0)
    );
    
    // NIC module instantiation for 3_0
    nic #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) nic_3_0 (
        .clk(clk),
        .reset(reset),
    
        // CPU-NIC Interface
        .addr(addr_3_0),
        .d_in(d_in_3_0),
        .d_out(d_out_3_0),
        .nicEn(nicEn_3_0),
        .nicEnWR(nicEnWR_3_0),
    
        // Router-NIC Interface
        .net_si(net_si_3_0),
        .net_so(net_so_3_0),
        .net_ri(net_ri_3_0),
        .net_ro(net_ro_3_0),
    
        .net_di(net_di_3_0),
        .net_do(net_do_3_0),
        .net_polarity(net_polarity_3_0)
    );

endmodule
