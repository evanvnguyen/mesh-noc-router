
/* Mesh connection
              GND           GND         GND          GND
          ===================================================
    GND  | router_0_0 | router_0_1 | router_0_2 | router_0_3 | GND
          ===================================================
    GND  | router_1_0 | router_1_1 | router_1_2 | router_1_3 | GND
          ===================================================
    GND  | router_2_0 | router_2_1 | router_2_2 | router_2_3 | GND
          ===================================================
    GND  | router_3_0 | router_3_1 | router_3_2 | router_3_3 | GND
          ===================================================
              GND           GND         GND          GND
*/

// not entirely sure how to wrap this properly.
// synthesis will optimize out nets not being driven by input or driven by output
module mesh_top #(
        parameter PACKET_WIDTH = 64,
        parameter SIZE_X = 4,
        parameter SIZE_Y = 4,
        parameter NUM_ROUTERS = SIZE_X * SIZE_Y
    ) (
        input clk,
        input reset,
    
        output [NUM_ROUTERS-1:0] polarity_out
    );
        // Declare all required routers signals
// CW (Clockwise) Signals
wire cwsi_0, cwsi_1, cwsi_2, cwsi_3, cwsi_4, cwsi_5, cwsi_6, cwsi_7, 
     cwsi_8, cwsi_9, cwsi_10, cwsi_11, cwsi_12, cwsi_13, cwsi_14, cwsi_15;

wire cwdi_0, cwdi_1, cwdi_2, cwdi_3, cwdi_4, cwdi_5, cwdi_6, cwdi_7, 
     cwdi_8, cwdi_9, cwdi_10, cwdi_11, cwdi_12, cwdi_13, cwdi_14, cwdi_15;

wire cwri_0, cwri_1, cwri_2, cwri_3, cwri_4, cwri_5, cwri_6, cwri_7, 
     cwri_8, cwri_9, cwri_10, cwri_11, cwri_12, cwri_13, cwri_14, cwri_15;

wire cwro_0, cwro_1, cwro_2, cwro_3, cwro_4, cwro_5, cwro_6, cwro_7, 
     cwro_8, cwro_9, cwro_10, cwro_11, cwro_12, cwro_13, cwro_14, cwro_15;

wire cwso_0, cwso_1, cwso_2, cwso_3, cwso_4, cwso_5, cwso_6, cwso_7, 
     cwso_8, cwso_9, cwso_10, cwso_11, cwso_12, cwso_13, cwso_14, cwso_15;

wire cwdo_0, cwdo_1, cwdo_2, cwdo_3, cwdo_4, cwdo_5, cwdo_6, cwdo_7, 
     cwdo_8, cwdo_9, cwdo_10, cwdo_11, cwdo_12, cwdo_13, cwdo_14, cwdo_15;

// CCW (Counter-Clockwise) Signals
wire ccwsi_0, ccwsi_1, ccwsi_2, ccwsi_3, ccwsi_4, ccwsi_5, ccwsi_6, ccwsi_7, 
     ccwsi_8, ccwsi_9, ccwsi_10, ccwsi_11, ccwsi_12, ccwsi_13, ccwsi_14, ccwsi_15;

wire ccwdi_0, ccwdi_1, ccwdi_2, ccwdi_3, ccwdi_4, ccwdi_5, ccwdi_6, ccwdi_7, 
     ccwdi_8, ccwdi_9, ccwdi_10, ccwdi_11, ccwdi_12, ccwdi_13, ccwdi_14, ccwdi_15;

wire ccwri_0, ccwri_1, ccwri_2, ccwri_3, ccwri_4, ccwri_5, ccwri_6, ccwri_7, 
     ccwri_8, ccwri_9, ccwri_10, ccwri_11, ccwri_12, ccwri_13, ccwri_14, ccwri_15;

wire ccwro_0, ccwro_1, ccwro_2, ccwro_3, ccwro_4, ccwro_5, ccwro_6, ccwro_7, 
     ccwro_8, ccwro_9, ccwro_10, ccwro_11, ccwro_12, ccwro_13, ccwro_14, ccwro_15;

wire ccwso_0, ccwso_1, ccwso_2, ccwso_3, ccwso_4, ccwso_5, ccwso_6, ccwso_7, 
     ccwso_8, ccwso_9, ccwso_10, ccwso_11, ccwso_12, ccwso_13, ccwso_14, ccwso_15;

wire ccwdo_0, ccwdo_1, ccwdo_2, ccwdo_3, ccwdo_4, ccwdo_5, ccwdo_6, ccwdo_7, 
     ccwdo_8, ccwdo_9, ccwdo_10, ccwdo_11, ccwdo_12, ccwdo_13, ccwdo_14, ccwdo_15;

// NS (North-South) Signals
wire nssi_0, nssi_1, nssi_2, nssi_3, nssi_4, nssi_5, nssi_6, nssi_7, 
     nssi_8, nssi_9, nssi_10, nssi_11, nssi_12, nssi_13, nssi_14, nssi_15;

wire nsdi_0, nsdi_1, nsdi_2, nsdi_3, nsdi_4, nsdi_5, nsdi_6, nsdi_7, 
     nsdi_8, nsdi_9, nsdi_10, nsdi_11, nsdi_12, nsdi_13, nsdi_14, nsdi_15;

wire nsri_0, nsri_1, nsri_2, nsri_3, nsri_4, nsri_5, nsri_6, nsri_7, 
     nsri_8, nsri_9, nsri_10, nsri_11, nsri_12, nsri_13, nsri_14, nsri_15;

wire nsro_0, nsro_1, nsro_2, nsro_3, nsro_4, nsro_5, nsro_6, nsro_7, 
     nsro_8, nsro_9, nsro_10, nsro_11, nsro_12, nsro_13, nsro_14, nsro_15;

wire nsso_0, nsso_1, nsso_2, nsso_3, nsso_4, nsso_5, nsso_6, nsso_7, 
     nsso_8, nsso_9, nsso_10, nsso_11, nsso_12, nsso_13, nsso_14, nsso_15;

wire nsdo_0, nsdo_1, nsdo_2, nsdo_3, nsdo_4, nsdo_5, nsdo_6, nsdo_7, 
     nsdo_8, nsdo_9, nsdo_10, nsdo_11, nsdo_12, nsdo_13, nsdo_14, nsdo_15;

// SN (South-North) Signals
wire snsi_0, snsi_1, snsi_2, snsi_3, snsi_4, snsi_5, snsi_6, snsi_7, 
     snsi_8, snsi_9, snsi_10, snsi_11, snsi_12, snsi_13, snsi_14, snsi_15;
     
wire snso_0, snso_1, snso_2, snso_3, snso_4, snso_5, snso_6, snso_7, 
     snso_8, snso_9, snso_10, snso_11, snso_12, snso_13, snso_14, snso_15;
         
wire sndo_0, sndo_1, sndo_2, sndo_3, sndo_4, sndo_5, sndo_6, sndo_7, 
     sndo_8, sndo_9, sndo_10, sndo_11, sndo_12, sndo_13, sndo_14, sndo_15;
      
wire sndi_0, sndi_1, sndi_2, sndi_3, sndi_4, sndi_5, sndi_6, sndi_7, 
     sndi_8, sndi_9, sndi_10, sndi_11, sndi_12, sndi_13, sndi_14, sndi_15;

wire snri_0, snri_1, snri_2, snri_3, snri_4, snri_5, snri_6, snri_7, 
     snri_8, snri_9, snri_10, snri_11, snri_12, snri_13, snri_14, snri_15;

wire snro_0, snro_1, snro_2, snro_3, snro_4, snro_5, snro_6, snro_7, 
     snro_8, snro_9, snro_10, snro_11, snro_12, snro_13, snro_14, snro_15;

// PE (Processing Element) Signals
wire pesi_0, pesi_1, pesi_2, pesi_3, pesi_4, pesi_5, pesi_6, pesi_7, 
     pesi_8, pesi_9, pesi_10, pesi_11, pesi_12, pesi_13, pesi_14, pesi_15;

wire pedi_0, pedi_1, pedi_2, pedi_3, pedi_4, pedi_5, pedi_6, pedi_7, 
     pedi_8, pedi_9, pedi_10, pedi_11, pedi_12, pedi_13, pedi_14, pedi_15;

wire peri_0, peri_1, peri_2, peri_3, peri_4, peri_5, peri_6, peri_7, 
     peri_8, peri_9, peri_10, peri_11, peri_12, peri_13, peri_14, peri_15;

wire pero_0, pero_1, pero_2, pero_3, pero_4, pero_5, pero_6, pero_7, 
     pero_8, pero_9, pero_10, pero_11, pero_12, pero_13, pero_14, pero_15;

wire peso_0, peso_1, peso_2, peso_3, peso_4, peso_5, peso_6, peso_7, 
     peso_8, peso_9, peso_10, peso_11, peso_12, peso_13, peso_14, peso_15;

wire pedo_0, pedo_1, pedo_2, pedo_3, pedo_4, pedo_5, pedo_6, pedo_7, 
     pedo_8, pedo_9, pedo_10, pedo_11, pedo_12, pedo_13, pedo_14, pedo_15;
     
            // top left corner
            router router_0_0 (
                    .clk(clk),
                    .reset(reset),
                    .router_position(),
                    .polarity_out(),
                    
                    // CW input/output or grounded for right edge
                    .cwsi(cwso_1),
                    .cwdi(cwdo_1),
                    .cwri(cwro_1),
                    .cwro(), // gnd
                    .cwso(), // gnd
                    .cwdo(), // gnd

                    // CCW input/output or grounded for left edge
                    .ccwsi(), // gnd
                    .ccwdi(), // gnd
                    .ccwri(), // gnd 
                    .ccwro(ccwri_1),
                    .ccwso(ccwsi_1),
                    .ccwdo(ccwdi_1),

                    // NS input/output or grounded for top row
                    .nssi(), // gnd
                    .nsdi(), // gnd
                    .nsri(), // gnd
                    .nsro(nsri_4), 
                    .nsso(nssi_4), 
                    .nsdo(nsdi_4),

                    // SN input/output or grounded for bottom row
                    .snsi(snso_4),
                    .sndi(sndo_4),
                    .snri(snro_4),
                    .snro(), // gnd
                    .snso(), // gnd
                    .sndo(), // gnd

                    // PE input/output to NIC
                    .pesi(pesi_0),
                    .pedi(pedi_0),
                    .peri(peri_0),
                    .pero(pero_0),
                    .peso(peso_0),
                    .pedo(pedo_0)
                );
                
                router router_1_0 (
                        .clk(clk),
                        .reset(reset),
                        .router_position(),
                        .polarity_out(),
                    
                        // CW input/output or grounded for right edge
                        .cwsi(cwsi_2),
                        .cwdi(cwdo_2),
                        .cwri(cwri_2),
                        .cwro(cwro_1),
                        .cwso(cwso_1),
                        .cwdo(cwdo_1),
                    
                        // CCW input/output or grounded for left edge
                        .ccwsi(ccwsi_1),
                        .ccwdi(ccwdi_1),
                        .ccwri(ccwri_1),
                        .ccwro(ccwro_2),
                        .ccwso(ccwso_2),
                        .ccwdo(ccwdo_2),
                    
                        // NS input/output or grounded for top row
                        .nssi(), // gnd
                        .nsdi(), // gnd
                        .nsri(), // gnd
                        .nsro(nsri_7),
                        .nsso(nssi_7),
                        .nsdo(nsdi_7),
                    
                        // SN input/output or grounded for bottom row
                        .snsi(snso_7), // to router_1_1
                        .sndi(sndo_7),
                        .snri(snro_7),
                        .snro(), // gnd
                        .snso(), // gnd
                        .sndo(), // gnd
                    
                        // PE input/output
                        .pesi(pesi_1),
                        .pedi(pedi_1),
                        .peri(peri_1),
                        .pero(pero_1),
                        .peso(peso_1),
                        .pedo(pedo_1)
                    );

                router router_2_0 (
                    .clk(clk),
                    .reset(reset),
                    .router_position(),
                    .polarity_out(),
                
                    // CW input/output or grounded for right edge
                    .cwsi(cwsi_3),
                    .cwdi(cwdi_3),
                    .cwri(cwri_3),
                    .cwro(cwri_2),
                    .cwso(cwsi_2),
                    .cwdo(cwdo_2),
                
                    // CCW input/output or grounded for left edge
                    .ccwsi(ccwso_2),
                    .ccwdi(ccwdo_2),
                    .ccwri(ccwro_2),
                    .ccwro(ccwri_3),
                    .ccwso(ccwsi_3),
                    .ccwdo(ccwdi_3),
                
                    // NS input/output or grounded for top row
                    .nssi(), // gnd
                    .nsdi(), // gnd
                    .nsri(), // gnd
                    .nsro(nsri_10),
                    .nsso(nssi_10),
                    .nsdo(nsdi_10),
                
                    // SN input/output or grounded for bottom row
                    .snsi(snso_10),
                    .sndi(sndo_10),
                    .snri(snro_10),
                    .snro(), // gnd
                    .snso(), // gnd 
                    .sndo(), // gnd
                
                    // PE input/output
                    .pesi(pesi_2),
                    .pedi(pedi_2),
                    .peri(peri_2),
                    .pero(pero_2),
                    .peso(peso_2),
                    .pedo(pedo_2)
                );

                // top right corner
                router router_3_0 (
                    .clk(clk),
                    .reset(reset),
                    .router_position(),
                    .polarity_out(),
                
                    // CW input/output or grounded for right edge
                    .cwsi(), // gnd
                    .cwdi(), // gnd
                    .cwri(), // gnd
                    .cwro(cwri_3),
                    .cwso(cwsi_3),
                    .cwdo(cwdi_3),
                
                    // CCW input/output or grounded for left edge
                    .ccwsi(ccwsi_3),
                    .ccwdi(ccwdi_3),
                    .ccwri(ccwri_3),
                    .ccwro(ccwro_3), // gnd
                    .ccwso(ccwso_3), // gnd
                    .ccwdo(ccwdo_3), // gnd
                
                    // NS input/output or grounded for top row
                    .nssi(nssi_3), // gnd
                    .nsdi(nsdi_3), // gnd
                    .nsri(nsri_3), // gnd
                    .nsro(nsro_3),
                    .nsso(nsso_3),
                    .nsdo(nsdo_3),
                
                    // SN input/output or grounded for bottom row
                    .snsi(snsi_3),
                    .sndi(sndi_3),
                    .snri(snri_3),
                    .snro(snro_3), // gnd
                    .snso(snso_3), // gnd
                    .sndo(sndo_3), // gnd
                
                    // PE input/output
                    .pesi(pesi_3),
                    .pedi(pedi_3),
                    .peri(peri_3),
                    .pero(pero_3),
                    .peso(peso_3),
                    .pedo(pedo_3)
                );

                router router_0_1 (
                    .clk(clk),
                    .reset(reset),
                    .router_position(),
                    .polarity_out(),
                
                    // CW input/output or grounded for right edge
                    .cwsi(cwso_7),
                    .cwdi(cwdo_7),
                    .cwri(cwro_7),
                    .cwro(), // gnd
                    .cwso(), // gnd
                    .cwdo(), // gnd
                
                    // CCW input/output or grounded for left edge
                    .ccwsi(), // gnd
                    .ccwdi(), // gnd
                    .ccwri(), // gnd
                    .ccwro(ccwri_7),
                    .ccwso(ccwsi_7),
                    .ccwdo(ccwdi_7),
                
                    // NS input/output or grounded for top row
                    .nssi(nssi_4),
                    .nsdi(nsdi_4),
                    .nsri(nsri_4),
                    .nsro(nsri_5),
                    .nsso(nssi_5),
                    .nsdo(nsdi_5),
                
                    // SN input/output or grounded for bottom row
                    .snsi(snso_5),
                    .sndi(sndo_5),
                    .snri(snro_5),
                    .snro(snro_4),
                    .snso(snso_4),
                    .sndo(sndo_4),
                
                    // PE input/output
                    .pesi(pesi_4),
                    .pedi(pedi_4),
                    .peri(peri_4),
                    .pero(pero_4),
                    .peso(peso_4),
                    .pedo(pedo_4)
                );

                router router_0_2 (
                    .clk(clk),
                    .reset(reset),
                    .router_position(),
                    .polarity_out(),
                
                    // CW input/output or grounded for right edge
                    .cwsi(cwso_8),
                    .cwdi(cwdo_8),
                    .cwri(cwro_8),
                    .cwro(),
                    .cwso(),
                    .cwdo(),
                
                    // CCW input/output or grounded for left edge
                    .ccwsi(),
                    .ccwdi(),
                    .ccwri(),
                    .ccwro(ccwri_8),
                    .ccwso(ccwsi_8),
                    .ccwdo(ccwdi_8),
                
                    // NS input/output or grounded for top row
                    .nssi(nssi_5),
                    .nsdi(nsdi_5),
                    .nsri(nsri_5),
                    .nsro(nsri_6),
                    .nsso(nssi_6),
                    .nsdo(nsdi_6),
                
                    // SN input/output or grounded for bottom row
                    .snsi(snso_6),
                    .sndi(sndo_6),
                    .snri(snro_6),
                    .snro(snro_5),
                    .snso(snso_5),
                    .sndo(sndo_5),
                
                    // PE input/output
                    .pesi(pesi_5),
                    .pedi(pedi_5),
                    .peri(peri_5),
                    .pero(pero_5),
                    .peso(peso_5),
                    .pedo(pedo_5)
                );

                router router_0_3 (
                    .clk(clk),
                    .reset(reset),
                    .router_position(),
                    .polarity_out(),
                
                    // CW input/output or grounded for right edge
                    .cwsi(cwso_9),
                    .cwdi(cwdo_9),
                    .cwri(cwro_9),
                    .cwro(),
                    .cwso(),
                    .cwdo(),
                
                    // CCW input/output or grounded for left edge
                    .ccwsi(),
                    .ccwdi(),
                    .ccwri(),
                    .ccwro(ccwri_9),
                    .ccwso(ccwsi_9),
                    .ccwdo(ccwdi_9),
                
                    // NS input/output or grounded for top row
                    .nssi(nssi_6),
                    .nsdi(nsdi_6),
                    .nsri(nsri_6),
                    .nsro(),
                    .nsso(),
                    .nsdo(),
                
                    // SN input/output or grounded for bottom row
                    .snsi(),
                    .sndi(),
                    .snri(),
                    .snro(snro_6),
                    .snso(snso_6),
                    .sndo(sndo_6),
                
                    // PE input/output
                    .pesi(pesi_6),
                    .pedi(pedi_6),
                    .peri(peri_6),
                    .pero(pero_6),
                    .peso(peso_6),
                    .pedo(pedo_6)
                );

                router router_1_1 (
                   .clk(clk),
                    .reset(reset),
                    .router_position(),
                    .polarity_out(),
                
                    // CW input/output or grounded for right edge
                    .cwsi(cwso_8),
                    .cwdi(cwdo_8),
                    .cwri(cwro_8),
                    .cwro(cwro_7),
                    .cwso(cwso_7),
                    .cwdo(cwdo_7),
                
                    // CCW input/output or grounded for left edge
                    .ccwsi(ccwsi_7),
                    .ccwdi(ccwdi_7),
                    .ccwri(ccwri_7),
                    .ccwro(ccwri_8),
                    .ccwso(ccwsi_8),
                    .ccwdo(ccwdi_8),
                
                    // NS input/output or grounded for top row
                    .nssi(nssi_7),
                    .nsdi(nsdi_7),
                    .nsri(nsri_7),
                    .nsro(nsro_7),
                    .nsso(nsso_7),
                    .nsdo(nsdo_7),
                
                    // SN input/output or grounded for bottom row
                    .snsi(snsi_7),
                    .sndi(sndi_7),
                    .snri(snri_7),
                    .snro(snro_7),
                    .snso(snso_7),
                    .sndo(sndo_7),
                
                    // PE input/output
                    .pesi(pesi_7),
                    .pedi(pedi_7),
                    .peri(peri_7),
                    .pero(pero_7),
                    .peso(peso_7),
                    .pedo(pedo_7)
                );

                router router_1_2 (
                    .clk(clk),
    .reset(reset),
    .router_position(),
    .polarity_out(),

    // CW input/output or grounded for right edge
    .cwsi(cwsi_8),
    .cwdi(cwdi_8),
    .cwri(cwri_8),
    .cwro(cwro_8),
    .cwso(cwso_8),
    .cwdo(cwdo_8),

    // CCW input/output or grounded for left edge
    .ccwsi(ccwsi_8),
    .ccwdi(ccwdi_8),
    .ccwri(ccwri_8),
    .ccwro(ccwro_8),
    .ccwso(ccwso_8),
    .ccwdo(ccwdo_8),

    // NS input/output or grounded for top row
    .nssi(nssi_8),
    .nsdi(nsdi_8),
    .nsri(nsri_8),
    .nsro(nsro_8),
    .nsso(nsso_8),
    .nsdo(nsdo_8),

    // SN input/output or grounded for bottom row
    .snsi(snsi_8),
    .sndi(sndi_8),
    .snri(snri_8),
    .snro(snro_8),
    .snso(snso_8),
    .sndo(sndo_8),

    // PE input/output
    .pesi(pesi_8),
    .pedi(pedi_8),
    .peri(peri_8),
    .pero(pero_8),
    .peso(peso_8),
    .pedo(pedo_8)
);

                router router_1_3 (
                    .clk(clk),
    .reset(reset),
    .router_position(),
    .polarity_out(),

    // CW input/output or grounded for right edge
    .cwsi(cwsi_9),
    .cwdi(cwdi_9),
    .cwri(cwri_9),
    .cwro(cwro_9),
    .cwso(cwso_9),
    .cwdo(cwdo_9),

    // CCW input/output or grounded for left edge
    .ccwsi(ccwsi_9),
    .ccwdi(ccwdi_9),
    .ccwri(ccwri_9),
    .ccwro(ccwro_9),
    .ccwso(ccwso_9),
    .ccwdo(ccwdo_9),

    // NS input/output or grounded for top row
    .nssi(nssi_9),
    .nsdi(nsdi_9),
    .nsri(nsri_9),
    .nsro(nsro_9),
    .nsso(nsso_9),
    .nsdo(nsdo_9),

    // SN input/output or grounded for bottom row
    .snsi(snsi_9),
    .sndi(sndi_9),
    .snri(snri_9),
    .snro(snro_9),
    .snso(snso_9),
    .sndo(sndo_9),

    // PE input/output
    .pesi(pesi_9),
    .pedi(pedi_9),
    .peri(peri_9),
    .pero(pero_9),
    .peso(peso_9),
    .pedo(pedo_9)
);

                router router_2_1 (
                    .clk(clk),
    .reset(reset),
    .router_position(),
    .polarity_out(),

    // CW input/output or grounded for right edge
    .cwsi(cwsi_10),
    .cwdi(cwdi_10),
    .cwri(cwri_10),
    .cwro(cwro_10),
    .cwso(cwso_10),
    .cwdo(cwdo_10),

    // CCW input/output or grounded for left edge
    .ccwsi(ccwsi_10),
    .ccwdi(ccwdi_10),
    .ccwri(ccwri_10),
    .ccwro(ccwro_10),
    .ccwso(ccwso_10),
    .ccwdo(ccwdo_10),

    // NS input/output or grounded for top row
    .nssi(nssi_10),
    .nsdi(nsdi_10),
    .nsri(nsri_10),
    .nsro(nsro_10),
    .nsso(nsso_10),
    .nsdo(nsdo_10),

    // SN input/output or grounded for bottom row
    .snsi(snsi_10),
    .sndi(sndi_10),
    .snri(snri_10),
    .snro(snro_10),
    .snso(snso_10),
    .sndo(sndo_10),

    // PE input/output
    .pesi(pesi_10),
    .pedi(pedi_10),
    .peri(peri_10),
    .pero(pero_10),
    .peso(peso_10),
    .pedo(pedo_10)
);

                router router_2_2 (
                    .clk(clk),
    .reset(reset),
    .router_position(),
    .polarity_out(),

    // CW input/output or grounded for right edge
    .cwsi(cwsi_11),
    .cwdi(cwdi_11),
    .cwri(cwri_11),
    .cwro(cwro_11),
    .cwso(cwso_11),
    .cwdo(cwdo_11),

    // CCW input/output or grounded for left edge
    .ccwsi(ccwsi_11),
    .ccwdi(ccwdi_11),
    .ccwri(ccwri_11),
    .ccwro(ccwro_11),
    .ccwso(ccwso_11),
    .ccwdo(ccwdo_11),

    // NS input/output or grounded for top row
    .nssi(nssi_11),
    .nsdi(nsdi_11),
    .nsri(nsri_11),
    .nsro(nsro_11),
    .nsso(nsso_11),
    .nsdo(nsdo_11),

    // SN input/output or grounded for bottom row
    .snsi(snsi_11),
    .sndi(sndi_11),
    .snri(snri_11),
    .snro(snro_11),
    .snso(snso_11),
    .sndo(sndo_11),

    // PE input/output
    .pesi(pesi_11),
    .pedi(pedi_11),
    .peri(peri_11),
    .pero(pero_11),
    .peso(peso_11),
    .pedo(pedo_11)
);

                router router_2_3 (
                    .clk(clk),
    .reset(reset),
    .router_position(),
    .polarity_out(),

    // CW input/output or grounded for right edge
    .cwsi(cwsi_12),
    .cwdi(cwdi_12),
    .cwri(cwri_12),
    .cwro(cwro_12),
    .cwso(cwso_12),
    .cwdo(cwdo_12),

    // CCW input/output or grounded for left edge
    .ccwsi(ccwsi_12),
    .ccwdi(ccwdi_12),
    .ccwri(ccwri_12),
    .ccwro(ccwro_12),
    .ccwso(ccwso_12),
    .ccwdo(ccwdo_12),

    // NS input/output or grounded for top row
    .nssi(nssi_12),
    .nsdi(nsdi_12),
    .nsri(nsri_12),
    .nsro(nsro_12),
    .nsso(nsso_12),
    .nsdo(nsdo_12),

    // SN input/output or grounded for bottom row
    .snsi(snsi_12),
    .sndi(sndi_12),
    .snri(snri_12),
    .snro(snro_12),
    .snso(snso_12),
    .sndo(sndo_12),

    // PE input/output
    .pesi(pesi_12),
    .pedi(pedi_12),
    .peri(peri_12),
    .pero(pero_12),
    .peso(peso_12),
    .pedo(pedo_12)
);
                router router_3_1 (
                    .clk(clk),
    .reset(reset),
    .router_position(),
    .polarity_out(),

    // CW input/output or grounded for right edge
    .cwsi(cwsi_13),
    .cwdi(cwdi_13),
    .cwri(cwri_13),
    .cwro(cwro_13),
    .cwso(cwso_13),
    .cwdo(cwdo_13),

    // CCW input/output or grounded for left edge
    .ccwsi(ccwsi_13),
    .ccwdi(ccwdi_13),
    .ccwri(ccwri_13),
    .ccwro(ccwro_13),
    .ccwso(ccwso_13),
    .ccwdo(ccwdo_13),

    // NS input/output or grounded for top row
    .nssi(nssi_13),
    .nsdi(nsdi_13),
    .nsri(nsri_13),
    .nsro(nsro_13),
    .nsso(nsso_13),
    .nsdo(nsdo_13),

    // SN input/output or grounded for bottom row
    .snsi(snsi_13),
    .sndi(sndi_13),
    .snri(snri_13),
    .snro(snro_13),
    .snso(snso_13),
    .sndo(sndo_13),

    // PE input/output
    .pesi(pesi_13),
    .pedi(pedi_13),
    .peri(peri_13),
    .pero(pero_13),
    .peso(peso_13),
    .pedo(pedo_13)
);

                router router_3_2 (
                    .clk(clk),
    .reset(reset),
    .router_position(),
    .polarity_out(),

    // CW input/output or grounded for right edge
    .cwsi(cwsi_14),
    .cwdi(cwdi_14),
    .cwri(cwri_14),
    .cwro(cwro_14),
    .cwso(cwso_14),
    .cwdo(cwdo_14),

    // CCW input/output or grounded for left edge
    .ccwsi(ccwsi_14),
    .ccwdi(ccwdi_14),
    .ccwri(ccwri_14),
    .ccwro(ccwro_14),
    .ccwso(ccwso_14),
    .ccwdo(ccwdo_14),

    // NS input/output or grounded for top row
    .nssi(nssi_14),
    .nsdi(nsdi_14),
    .nsri(nsri_14),
    .nsro(nsro_14),
    .nsso(nsso_14),
    .nsdo(nsdo_14),

    // SN input/output or grounded for bottom row
    .snsi(snsi_14),
    .sndi(sndi_14),
    .snri(snri_14),
    .snro(snro_14),
    .snso(snso_14),
    .sndo(sndo_14),

    // PE input/output
    .pesi(pesi_14),
    .pedi(pedi_14),
    .peri(peri_14),
    .pero(pero_14),
    .peso(peso_14),
    .pedo(pedo_14)
);

                router router_3_3 (
                    .clk(clk),
    .reset(reset),
    .router_position(),
    .polarity_out(),

    // CW input/output or grounded for right edge
    .cwsi(cwsi_15),
    .cwdi(cwdi_15),
    .cwri(cwri_15),
    .cwro(cwro_15),
    .cwso(cwso_15),
    .cwdo(cwdo_15),

    // CCW input/output or grounded for left edge
    .ccwsi(ccwsi_15),
    .ccwdi(ccwdi_15),
    .ccwri(ccwri_15),
    .ccwro(ccwro_15),
    .ccwso(ccwso_15),
    .ccwdo(ccwdo_15),

    // NS input/output or grounded for top row
    .nssi(nssi_15),
    .nsdi(nsdi_15),
    .nsri(nsri_15),
    .nsro(nsro_15),
    .nsso(nsso_15),
    .nsdo(nsdo_15),

    // SN input/output or grounded for bottom row
    .snsi(snsi_15),
    .sndi(sndi_15),
    .snri(snri_15),
    .snro(snro_15),
    .snso(snso_15),
    .sndo(sndo_15),

    // PE input/output
    .pesi(pesi_15),
    .pedi(pedi_15),
    .peri(peri_15),
    .pero(pero_15),
    .peso(peso_15),
    .pedo(pedo_15)
);
endmodule