
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

); 

    // naming scheme is first signal - left. second signal - right
    wire cwsi_cwso_0, cwri_cwro_0, ccwso_ccwsi_0, ccwro_ccwri_0;
    wire [63:0] cwdi_cwdo_0, ccwdo_ccwdi_0; 
    wire cwsi_cwso_1, cwri_cwro_1, ccwso_ccwsi_1, ccwro_ccwri_1;
    wire [63:0] cwdi_cwdo_1, ccwdo_ccwdi_1; 
    wire cwsi_cwso_2, cwri_cwro_2, ccwso_ccwsi_2, ccwro_ccwri_2;
    wire [63:0] cwdi_cwdo_2, ccwdo_ccwdi_2; 

    // bottom left corner 
    router router_0_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(cwsi_cwso_0), .cwri(cwri_cwro_0), .cwdi(cwdi_cwdo_0), .ccwso(ccwso_ccwsi_0), .ccwro(ccwro_ccwri_0), .ccwdo(ccwdo_ccwdi_0),

        //left - gnd
        .cwso(), .cwro(), .cwdo(), .ccwsi(), .ccwri(), .ccwdi(),
        
        // top
        .snso(snso_0_0), .snro(snro_0_0), .sndo(sndo_0_0), .nssi(nssi_0_0), .nsri(nsri_0_0), .nsdi(nsdi_0_0),  
    
        // bottom - gnd
        .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),
 
        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );
   
    
    router router_1_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(cwsi_cwso_1), .cwri(cwri_cwro_1), .cwdi(cwdi_cwdo_1), .ccwso(ccwso_ccwsi_1), .ccwro(ccwro_ccwri_1), .ccwdo(ccwdo_ccwdi_1),

        //left 
        .cwso(cwsi_cwso_0), .cwro(cwri_cwro_0), .cwdo(cwdi_cwdo_0), .ccwsi(ccwso_ccwsi_0), .ccwri(ccwro_ccwri_0), .ccwdi(ccwdo_ccwdi_0),
        
        // top
        .snso(snso_1_0), .snro(snro_1_0), .sndo(sndo_1_0), .nssi(nssi_1_0), .nsri(nsri_1_0), .nsdi(nsdi_1_0),  
    
        // bottom - gnd
        .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),
 
        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );
    
    
    router router_2_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right 
        .cwsi(cwsi_cwso_2), .cwri(cwri_cwro_2), .cwdi(cwdi_cwdo_2), .ccwso(ccwso_ccwsi_2), .ccwro(ccwro_ccwri_2), .ccwdo(ccwdo_ccwdi_2),

        //left
        .cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        
        // top
        .snso(snso_2_0), .snro(snro_2_0), .sndo(sndo_2_0), .nssi(nssi_2_0), .nsri(nsri_2_0), .nsdi(nsdi_2_0),  
    
        // bottom - gnd
        .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),
 
        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );
        router router_3_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(),
        
        //right - gnd 
        .cwsi(), .cwri(), .cwdi(), .ccwso(), .ccwro(), .ccwdo(),

        //left
        .cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        
        // top
        .snso(snso_3_0), .snro(snro_3_0), .sndo(sndo_3_0), .nssi(nssi_3_0), .nsri(nsri_3_0), .nsdi(nsdi_3_0),  

        // bottom - gnd
        .snsi(), .snri(), .sndi(), .nsso(), .nsro(), .nsdo(),
 
        // PE input/output to NIC
        .pesi(), .pedi(), .peri(), 
        .pero(), .peso(), .pedo()
    );

endmodule
