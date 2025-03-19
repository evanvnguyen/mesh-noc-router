
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
// Row 2 <--
// Row 1 
// Row 0

// bottom row of mesh

module mesh_top_row_2 #(
        parameter PACKET_WIDTH = 64
    ) (
        input clk,
        input reset,
        
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

    );
    
    // naming scheme is first signal - left. second signal - right
    wire cwsi_cwso_0, cwri_cwro_0, ccwso_ccwsi_0, ccwro_ccwri_0;
    wire [63:0] cwdi_cwdo_0, ccwdo_ccwdi_0; 
    wire cwsi_cwso_1, cwri_cwro_1, ccwso_ccwsi_1, ccwro_ccwri_1;
    wire [63:0] cwdi_cwdo_1, ccwdo_ccwdi_1; 
    wire cwsi_cwso_2, cwri_cwro_2, ccwso_ccwsi_2, ccwro_ccwri_2;
    wire [63:0] cwdi_cwdo_2, ccwdo_ccwdi_2;

    // bottom left corner 
    router router_0_2 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(cwsi_cwso_0), .cwri(cwri_cwro_0), .cwdi(cwdi_cwdo_0), .ccwso(ccwso_ccwsi_0), .ccwro(ccwro_ccwri_0), .ccwdo(ccwdo_ccwdi_0),

        //left - gnd
        .cwso(), .cwro(), .cwdo(), .ccwsi(), .ccwri(), .ccwdi(),
        
        // top
        .snso(snso_0_2), .snro(snro_0_2), .sndo(sndo_0_2), .nssi(nssi_0_2), .nsri(nsri_0_2), .nsdi(nsdi_0_2),  
    
        // bottom
        .snsi(snsi_0_2), .snri(snri_0_2), .sndi(sndi_0_2), .nsso(nsso_0_2), .nsro(nsro_0_2), .nsdo(nsdo_0_2),
 
        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );
   
    
    router router_1_2 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(cwsi_cwso_1), .cwri(cwri_cwro_1), .cwdi(cwdi_cwdo_1), .ccwso(ccwso_ccwsi_1), .ccwro(ccwro_ccwri_1), .ccwdo(ccwdo_ccwdi_1),

        //left 
        .cwso(cwsi_cwso_0), .cwro(cwri_cwro_0), .cwdo(cwdi_cwdo_0), .ccwsi(ccwso_ccwsi_0), .ccwri(ccwro_ccwri_0), .ccwdi(ccwdo_ccwdi_0),
        
        // top
        .snso(snso_1_2), .snro(snro_1_2), .sndo(sndo_1_2), .nssi(nssi_1_2), .nsri(nsri_1_2), .nsdi(nsdi_1_2),  
    
        // bottom
        .snsi(snsi_1_2), .snri(snri_1_2), .sndi(sndi_1_2), .nsso(nsso_1_2), .nsro(nsro_1_2), .nsdo(nsdo_1_2),

        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );
    
    
    router router_2_2 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(cwsi_cwso_2), .cwri(cwri_cwro_2), .cwdi(cwdi_cwdo_2), .ccwso(ccwso_ccwsi_2), .ccwro(ccwro_ccwri_2), .ccwdo(ccwdo_ccwdi_2),

        //left
        .cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        
        // top
        .snso(snso_2_2), .snro(snro_2_2), .sndo(sndo_2_2), .nssi(nssi_2_2), .nsri(nsri_2_2), .nsdi(nsdi_2_2),  
    
        // bottom
        .snsi(snsi_2_2), .snri(snri_2_2), .sndi(sndi_2_2), .nsso(nsso_2_2), .nsro(nsro_2_2), .nsdo(nsdo_2_2),

        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );

     
    router router_3_2 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right - gnd 
        .cwsi(), .cwri(), .cwdi(), .ccwso(), .ccwro(), .ccwdo(),

        //left
        .cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        
        // top
        .snso(snso_3_2), .snro(snro_3_2), .sndo(sndo_3_2), .nssi(nssi_3_2), .nsri(nsri_3_2), .nsdi(nsdi_3_2),  

        // bottom 
        .snsi(snsi_3_2), .snri(snri_3_2), .sndi(sndi_3_2), .nsso(nsso_3_2), .nsro(nsro_3_2), .nsdo(nsdo_3_2),

        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );

endmodule
