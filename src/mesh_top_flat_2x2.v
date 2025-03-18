
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
     
     
                 // Router 10
            wire [1:0] nic_addr_0_0;
            wire [PACKET_WIDTH-1:0] nic_din_0_0;
            wire [PACKET_WIDTH-1:0] nic_net_do_0_0;
            wire nic_en_0_0;
            wire nic_en_wr_0_0;
            wire [PACKET_WIDTH-1:0] pedo_0_0;
            wire [PACKET_WIDTH-1:0] pedi_0_0;
            wire [PACKET_WIDTH-1:0] peso_0_0;
            wire [PACKET_WIDTH-1:0] pesi_0_0;
            wire [PACKET_WIDTH-1:0] peri_0_0;
            wire [PACKET_WIDTH-1:0] pero_0_0;
            wire polarity_out_0_0;
            
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
                    .pesi(pesi_0_0),
                    .pedi(pedi_0_0),
                    .peri(peri_0_0),
                    .pero(pero_0_0),
                    .peso(peso_0_0),
                    .pedo(pedo_0_0)
                );
                
            nic #(PACKET_WIDTH) nic_inst_0_0 (
                .clk(clk),
                .reset(reset),
                .addr(nic_addr_0_0),
                .d_in(nic_din_0_0),
                .d_out(nic_net_do_0_0),
                .nicEn(nic_en_0_0),
                .nicEnWR(nic_en_wr_0_0),
                .net_si(peso_0_0),
                .net_ri(pero_0_0),
                .net_di(pedo_0_0),
                .net_so(pesi_0_0),
                .net_ro(peri_0_0),
                .net_do(pedi_0_0),
                .net_polarity(polarity_out_0_0)
            );
            
            // Router 10
            wire [1:0] nic_addr_1_0;
            wire [PACKET_WIDTH-1:0] nic_din_1_0;
            wire [PACKET_WIDTH-1:0] nic_net_do_1_0;
            wire nic_en_1_0;
            wire nic_en_wr_1_0;
            wire [PACKET_WIDTH-1:0] pedo_1_0;
            wire [PACKET_WIDTH-1:0] pedi_1_0;
            wire [PACKET_WIDTH-1:0] peso_1_0;
            wire [PACKET_WIDTH-1:0] pesi_1_0;
            wire [PACKET_WIDTH-1:0] peri_1_0;
            wire [PACKET_WIDTH-1:0] pero_1_0;
            wire polarity_out_1_0;
                        
            router router_1_0 (
                    .clk(clk),
                    .reset(reset),
                    .router_position(),
                    .polarity_out(),
                
                    // CW input/output or grounded for right edge
                    .cwsi(),  // gnd
                    .cwdi(),  // gnd
                    .cwri(),  // gnd
                    .cwro(cwro_1),
                    .cwso(cwso_1),
                    .cwdo(cwdo_1),
                
                    // CCW input/output or grounded for left edge
                    .ccwsi(ccwsi_1),
                    .ccwdi(ccwdi_1),
                    .ccwri(ccwri_1),
                    .ccwro(),  // gnd
                    .ccwso(),  // gnd
                    .ccwdo(),  // gnd
                
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
                    .pesi(pesi_1_0),
                    .pedi(pedi_1_0),
                    .peri(peri_1_0),
                    .pero(pero_1_0),
                    .peso(peso_1_0),
                    .pedo(pedo_1_0)
            );

            nic #(PACKET_WIDTH) nic_inst_1_0 (
                .clk(clk),
                .reset(reset),
                .addr(nic_addr_1_0),
                .d_in(nic_din_1_0),
                .d_out(nic_net_do_1_0),
                .nicEn(nic_en_1_0),
                .nicEnWR(nic_en_wr_1_0),
                .net_si(peso_1_0),
                .net_ri(pero_1_0),
                .net_di(pedo_1_0),
                .net_so(pesi_1_0),
                .net_ro(peri_1_0),
                .net_do(pedi_1_0),
                .net_polarity(polarity_out_1_0)
            );
            
            // Router 01
            wire [1:0] nic_addr_0_1;
            wire [PACKET_WIDTH-1:0] nic_din_0_1;
            wire [PACKET_WIDTH-1:0] nic_net_do_0_1;
            wire nic_en_0_1;
            wire nic_en_wr_0_1;
            wire [PACKET_WIDTH-1:0] pedo_0_1;
            wire [PACKET_WIDTH-1:0] pedi_0_1;
            wire [PACKET_WIDTH-1:0] peso_0_1;
            wire [PACKET_WIDTH-1:0] pesi_0_1;
            wire [PACKET_WIDTH-1:0] peri_0_1;
            wire [PACKET_WIDTH-1:0] pero_0_1;
            wire polarity_out_0_1;
            
            router router_0_1 (
                .clk(clk),
                .reset(reset),
                .router_position(),
                .polarity_out(),
            
                // CW input/output or grounded for right edge
                .cwsi(cwsi_7),
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
                .nsro(),  // gnd
                .nsso(),  // gnd
                .nsdo(),  // gnd
            
                // SN input/output or grounded for bottom row
                .snsi(),  // gnd
                .sndi(),  // gnd
                .snri(),  // gnd
                .snro(snro_4),
                .snso(snso_4),
                .sndo(sndo_4),
            
                // PE input/output
                .pesi(pesi_0_1),
                .pedi(pedi_0_1),
                .peri(peri_0_1),
                .pero(pero_0_1),
                .peso(peso_0_1),
                .pedo(pedo_0_1)
            );

        nic #(PACKET_WIDTH) nic_inst_0_1 (
            .clk(clk),
            .reset(reset),
            .addr(nic_addr_0_1),
            .d_in(nic_din_0_1),
            .d_out(nic_net_do_0_1),
            .nicEn(nic_en_0_1),
            .nicEnWR(nic_en_wr_0_1),
            .net_si(peso_0_1),
            .net_ri(pero_0_1),
            .net_di(pedo_0_1),
            .net_so(pesi_0_1),
            .net_ro(peri_0_1),
            .net_do(pedi_0_1),
            .net_polarity(polarity_out_0_1)
        );
        
        // Router 11
        wire [1:0] nic_addr_1_1;
        wire [PACKET_WIDTH-1:0] nic_din_1_1;
        wire [PACKET_WIDTH-1:0] nic_net_do_1_1;
        wire nic_en_1_1;
        wire nic_en_wr_1_1;
        wire [PACKET_WIDTH-1:0] pedo_1_1;
        wire [PACKET_WIDTH-1:0] pedi_1_1;
        wire [PACKET_WIDTH-1:0] peso_1_1;
        wire [PACKET_WIDTH-1:0] pesi_1_1;
        wire [PACKET_WIDTH-1:0] peri_1_1;
        wire [PACKET_WIDTH-1:0] pero_1_1;
        wire polarity_out_1_1;
        
        router router_1_1 (
           .clk(clk),
            .reset(reset),
            .router_position(),
            .polarity_out(),
        
            // CW input/output or grounded for right edge
            .cwsi(),  // gnd
            .cwdi(),  // gnd
            .cwri(),  // gnd
            .cwro(cwro_7),
            .cwso(cwso_7),
            .cwdo(cwdo_7),
        
            // CCW input/output or grounded for left edge
            .ccwsi(ccwsi_7),
            .ccwdi(ccwdi_7),
            .ccwri(ccwri_7),
            .ccwro(),  // gnd
            .ccwso(),  // gnd
            .ccwdo(),  // gnd
        
            // NS input/output or grounded for top row
            .nssi(nssi_7),
            .nsdi(nsdi_7),
            .nsri(nsri_7),
            .nsro(),  // gnd
            .nsso(),  // gnd
            .nsdo(), // gnd
        
            // SN input/output or grounded for bottom row
            .snsi(),  // gnd
            .sndi(),  // gnd
            .snri(),  // gnd
            .snro(snro_7),
            .snso(snso_7),
            .sndo(sndo_7),
        
            // PE input/output
            .pesi(pesi_1_1),
            .pedi(pedi_1_1),
            .peri(peri_1_1),
            .pero(pero_1_1),
            .peso(peso_1_1),
            .pedo(pedo_1_1)
        );


        nic #(PACKET_WIDTH) nic_inst_1_1 (
            .clk(clk),
            .reset(reset),
            .addr(nic_addr_1_1),
            .d_in(nic_din_1_1),
            .d_out(nic_net_do_1_1),
            .nicEn(nic_en_1_1),
            .nicEnWR(nic_en_wr_1_1),
            .net_si(peso_1_1),
            .net_ri(pero_1_1),
            .net_di(pedo_1_1),
            .net_so(pesi_1_1),
            .net_ro(peri_1_1),
            .net_do(pedi_1_1),
            .net_polarity(polarity_out_1_1)
        );


endmodule