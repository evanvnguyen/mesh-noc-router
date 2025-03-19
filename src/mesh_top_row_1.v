
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

module mesh_top_row_1 #(
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

    );       

    // naming scheme is first signal - left. second signal - right
    wire cwsi_cwso_0, cwri_cwro_0, ccwso_ccwsi_0, ccwro_ccwri_0;
    wire [63:0] cwdi_cwdo_0, ccwdo_ccwdi_0; 
    wire cwsi_cwso_1, cwri_cwro_1, ccwso_ccwsi_1, ccwro_ccwri_1;
    wire [63:0] cwdi_cwdo_1, ccwdo_ccwdi_1; 
    wire cwsi_cwso_2, cwri_cwro_2, ccwso_ccwsi_2, ccwro_ccwri_2;
    wire [63:0] cwdi_cwdo_2, ccwdo_ccwdi_2;

    // bottom left corner 
    router router_0_1 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(cwsi_cwso_0), .cwri(cwri_cwro_0), .cwdi(cwdi_cwdo_0), .ccwso(ccwso_ccwsi_0), .ccwro(ccwro_ccwri_0), .ccwdo(ccwdo_ccwdi_0),

        //left - gnd
        .cwso(), .cwro(), .cwdo(), .ccwsi(), .ccwri(), .ccwdi(),
        
        // top
        .snso(snso_0_1), .snro(snro_0_1), .sndo(sndo_0_1), .nssi(nssi_0_1), .nsri(nsri_0_1), .nsdi(nsdi_0_1),  
    
        // bottom
        .snsi(snsi_0_1), .snri(snri_0_1), .sndi(sndi_0_1), .nsso(nsso_0_1), .nsro(nsro_0_1), .nsdo(nsdo_0_1),
 
        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );
   
    
    router router_1_1 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(cwsi_cwso_1), .cwri(cwri_cwro_1), .cwdi(cwdi_cwdo_1), .ccwso(ccwso_ccwsi_1), .ccwro(ccwro_ccwri_1), .ccwdo(ccwdo_ccwdi_1),

        //left 
        .cwso(cwsi_cwso_0), .cwro(cwri_cwro_0), .cwdo(cwdi_cwdo_0), .ccwsi(ccwso_ccwsi_0), .ccwri(ccwro_ccwri_0), .ccwdi(ccwdo_ccwdi_0),
        
        // top
        .snso(snso_1_1), .snro(snro_1_1), .sndo(sndo_1_1), .nssi(nssi_1_1), .nsri(nsri_1_1), .nsdi(nsdi_1_1),  
    
        // bottom
        .snsi(snsi_1_1), .snri(snri_1_1), .sndi(sndi_1_1), .nsso(nsso_1_1), .nsro(nsro_1_1), .nsdo(nsdo_1_1),

        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );
    
    
    router router_2_1 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(cwsi_cwso_2), .cwri(cwri_cwro_2), .cwdi(cwdi_cwdo_2), .ccwso(ccwso_ccwsi_2), .ccwro(ccwro_ccwri_2), .ccwdo(ccwdo_ccwdi_2),

        //left
        .cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        
        // top
        .snso(snso_2_1), .snro(snro_2_1), .sndo(sndo_2_1), .nssi(nssi_2_1), .nsri(nsri_2_1), .nsdi(nsdi_2_1),  
    
        // bottom
        .snsi(snsi_2_1), .snri(snri_2_1), .sndi(sndi_2_1), .nsso(nsso_2_1), .nsro(nsro_2_1), .nsdo(nsdo_2_1),

        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );

     
    router router_3_1 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right - gnd 
        .cwsi(), .cwri(), .cwdi(), .ccwso(), .ccwro(), .ccwdo(),

        //left
        .cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        
        // top
        .snso(snso_3_1), .snro(snro_3_1), .sndo(sndo_3_1), .nssi(nssi_3_1), .nsri(nsri_3_1), .nsdi(nsdi_3_1),  

        // bottom 
        .snsi(snsi_3_1), .snri(snri_3_1), .sndi(sndi_3_1), .nsso(nsso_3_1), .nsro(nsro_3_1), .nsdo(nsdo_3_1),

        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );

endmodule
