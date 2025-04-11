/*                                
 *                                Mesh connection
 *                              -------------------
 *
                      GND           GND         GND          GND
                  ===================================================
            GND  | router_0_3 | router_1_3 | router_2_3 | router_3_3 | GND  <-- row 3
                  ===================================================
            GND  | router_0_2 | router_1_2 | router_2_2 | router_3_2 | GND  <-- row 2
                  ===================================================
            GND  | router_0_1 | router_1_1 | router_2_1 | router_3_1 | GND  <-- row 1
                  ===================================================
            GND  | router_0_0 | router_1_0 | router_2_0 | router_3_0 | GND  <-- row 0
                  ===================================================
                      GND           GND         GND          GND
*/

module mesh_top_flat (
        input clk,
        input reset,
        // create CPU probe for each nic
       
        
        // row 3
        input [1:0]   addr_0_3,
        input [63:0]  d_in_0_3,
        output [63:0]  d_out_0_3,
        input         nicEn_0_3,
        input         nicEnWR_0_3,
        
        input [1:0]   addr_1_3,
        input [63:0]  d_in_1_3,
        output [63:0]  d_out_1_3,
        input         nicEn_1_3,
        input         nicEnWR_1_3,
        
        input [1:0]   addr_2_3,
        input [63:0]  d_in_2_3,
        output [63:0]  d_out_2_3,
        input         nicEn_2_3,
        input         nicEnWR_2_3,
        
        input [1:0]   addr_3_3,
        input [63:0]  d_in_3_3,
        output [63:0]  d_out_3_3,
        input         nicEn_3_3,
        input         nicEnWR_3_3,
        
        // row 2
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
        input         nicEnWR_3_2,
        
        // row 1
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
        input         nicEnWR_3_1,
        
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

    localparam PACKET_WIDTH = 64;
    wire [63:0] sndo_from_02_to_sndi_03;

    wire [63:0] sndo_from_12_to_sndi_13;
    wire [63:0] sndo_from_22_to_sndi_23;
    wire [63:0] sndo_from_32_to_sndi_33;

    wire [63:0] nsdi_from_02_to_nsdo_03;
    wire [63:0] nsdi_from_12_to_nsdo_13;
    wire [63:0] nsdi_from_22_to_nsdo_23;
    wire [63:0] nsdi_from_32_to_nsdo_33;

    wire snso_from_02_to_snsi_03;
    wire snro_from_02_to_snri_03;
    wire nssi_from_02_to_nsso_03;
    wire nsri_from_02_to_nsro_03;

    wire snso_from_12_to_snsi_13;
    wire snro_from_12_to_snri_13;
    wire nssi_from_12_to_nsso_13;
    wire nsri_from_12_to_nsro_13;

    wire snso_from_22_to_snsi_23;
    wire snro_from_22_to_snri_23;
    wire nssi_from_22_to_nsso_23;
    wire nsri_from_22_to_nsro_23;

    wire snso_from_32_to_snsi_33;
    wire snro_from_32_to_snri_33;
    wire nssi_from_32_to_nsso_33;
    wire nsri_from_32_to_nsro_33;

   
    mesh_row_3 #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) row_3 (
        .clk(clk), 
        .reset(reset),
       
        // bottom signal router 0,3 
        .snsi_0_3(snso_from_02_to_snsi_03), .snri_0_3(snro_from_02_to_snri_03), .sndi_0_3(sndo_from_02_to_sndi_03), .nsso_0_3(nssi_from_02_to_nsso_03), .nsro_0_3(nsri_from_02_to_nsro_03), .nsdo_0_3(nsdi_from_02_to_nsdo_03), 
        
        // bottom signal router 1,3 
        .snsi_1_3(snso_from_12_to_snsi_13), .snri_1_3(snro_from_12_to_snri_13), .sndi_1_3(sndo_from_12_to_sndi_13), .nsso_1_3(nssi_from_12_to_nsso_13), .nsro_1_3(nsri_from_12_to_nsro_13), .nsdo_1_3(nsdi_from_12_to_nsdo_13), 
        
        // bottom signal router 2,3 
        .snsi_2_3(snso_from_22_to_snsi_23), .snri_2_3(snro_from_22_to_snri_23), .sndi_2_3(sndo_from_22_to_sndi_23), .nsso_2_3(nssi_from_22_to_nsso_23), .nsro_2_3(nsri_from_22_to_nsro_23), .nsdo_2_3(nsdi_from_22_to_nsdo_23), 
        
        // bottom signal router 3,3 
        .snsi_3_3(snso_from_32_to_snsi_33), .snri_3_3(snso_from_32_to_snsi_33), .sndi_3_3(sndo_from_32_to_sndi_33), .nsso_3_3(nssi_from_32_to_nsso_33), .nsro_3_3(nsri_from_32_to_nsro_33), .nsdo_3_3(nsdi_from_32_to_nsdo_33),
        

        .addr_0_3(addr_0_3),
        .d_in_0_3(d_in_0_3),
        .d_out_0_3(d_out_0_3),
        .nicEn_0_3(nicEn_0_3),
        .nicEnWR_0_3(nicEnWR_0_3),
        
        .addr_1_3(addr_1_3),
        .d_in_1_3(d_in_1_3),
        .d_out_1_3(d_out_1_3),
        .nicEn_1_3(nicEn_1_3),
        .nicEnWR_1_3(nicEnWR_1_3),
        
        .addr_2_3(addr_2_3),
        .d_in_2_3(d_in_2_3),
        .d_out_2_3(d_out_2_3),
        .nicEn_2_3(nicEn_2_3),
        .nicEnWR_2_3(nicEnWR_2_3),
        
        .addr_3_3(addr_3_3),
        .d_in_3_3(d_in_3_3),
        .d_out_3_3(d_out_3_3),
        .nicEn_3_3(nicEn_3_3),
        .nicEnWR_3_3(nicEnWR_3_3)

         
    );

    wire [63:0] sndo_from_01_to_sndi_02;
    wire [63:0] sndo_from_11_to_sndi_12;
    wire [63:0] sndo_from_21_to_sndi_22;
    wire [63:0] sndo_from_31_to_sndi_32;

    wire [63:0] nsdi_from_01_to_nsdo_02;
    wire [63:0] nsdi_from_11_to_nsdo_12;
    wire [63:0] nsdi_from_21_to_nsdo_22;
    wire [63:0] nsdi_from_31_to_nsdo_32;

    wire snso_from_01_to_snsi_02;
    wire snro_from_01_to_snri_02;
    wire nssi_from_01_to_nsso_02;
    wire nsri_from_01_to_nsro_02;

    wire snso_from_11_to_snsi_12;
    wire snro_from_11_to_snri_12;
    wire nssi_from_11_to_nsso_12;
    wire nsri_from_11_to_nsro_12;

    wire snso_from_21_to_snsi_22;
    wire snro_from_21_to_snri_22;
    wire nssi_from_21_to_nsso_22;
    wire nsri_from_21_to_nsro_22;

    wire snso_from_31_to_snsi_32;
    wire snro_from_31_to_snri_32;
    wire nssi_from_31_to_nsso_32;
    wire nsri_from_31_to_nsro_32;

    mesh_row_2 #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) row_2 (
        .clk(clk), 
        .reset(reset),
       
        // top signal router 0,2 
        .snso_0_2(snso_from_02_to_snsi_03), .snro_0_2(snro_from_02_to_snri_03), .sndo_0_2(sndo_from_02_to_sndi_03), .nssi_0_2(nssi_from_02_to_nsso_03), .nsri_0_2(nsri_from_02_to_nsro_03), .nsdi_0_2(nsdi_from_02_to_nsdo_03),
        
        // bottom signal router 0,2
        .snsi_0_2(snso_from_01_to_snsi_02), .snri_0_2(snro_from_01_to_snri_02), .sndi_0_2(sndo_from_01_to_sndi_02), .nsso_0_2(nssi_from_01_to_nsso_02), .nsro_0_2(nsri_from_01_to_nsro_02), .nsdo_0_2(nsdi_from_01_to_nsdo_02), 

        // top signal router 1,2 
        .snso_1_2(snso_from_12_to_snsi_13), .snro_1_2(snro_from_12_to_snri_13), .sndo_1_2(sndo_from_12_to_sndi_13), .nssi_1_2(nssi_from_12_to_nsso_13), .nsri_1_2(nsri_from_12_to_nsro_13), .nsdi_1_2(nsdi_from_12_to_nsdo_13),
        
        // bottom signal router 1,2
        .snsi_1_2(snso_from_11_to_snsi_12), .snri_1_2(snro_from_11_to_snri_12), .sndi_1_2(sndo_from_11_to_sndi_12), .nsso_1_2(nssi_from_11_to_nsso_12), .nsro_1_2(nsri_from_11_to_nsro_12), .nsdo_1_2(nsdi_from_11_to_nsdo_12), 

        // top signal router 2,2 
        .snso_2_2(snso_from_22_to_snsi_23), .snro_2_2(snro_from_22_to_snri_23), .sndo_2_2(sndo_from_22_to_sndi_23), .nssi_2_2(nssi_from_22_to_nsso_23), .nsri_2_2(nsri_from_22_to_nsro_23), .nsdi_2_2(nsdi_from_22_to_nsdo_23),

        // bottom signal router 2,2
        .snsi_2_2(snso_from_21_to_snsi_22), .snri_2_2(snro_from_21_to_snri_22), .sndi_2_2(sndo_from_21_to_sndi_22), .nsso_2_2(nssi_from_21_to_nsso_22), .nsro_2_2(nsri_from_21_to_nsro_22), .nsdo_2_2(nsdi_from_21_to_nsdo_22), 

        // top signal router 3,2 
        .snso_3_2(snso_from_32_to_snsi_33), .snro_3_2(snso_from_32_to_snsi_33), .sndo_3_2(sndo_from_32_to_sndi_33), .nssi_3_2(nssi_from_32_to_nsso_33), .nsri_3_2(nsri_from_32_to_nsro_33), .nsdi_3_2(nsdi_from_32_to_nsdo_33),

        // bottom signal router 3,2
        .snsi_3_2(snso_from_31_to_snsi_32), .snri_3_2(snro_from_31_to_snri_32), .sndi_3_2(sndo_from_31_to_sndi_32), .nsso_3_2(nssi_from_31_to_nsso_32), .nsro_3_2(nsri_from_31_to_nsro_32), .nsdo_3_2(nsdi_from_31_to_nsdo_32),
        
        .addr_0_2(addr_0_2),
        .d_in_0_2(d_in_0_2),
        .d_out_0_2(d_out_0_2),
        .nicEn_0_2(nicEn_0_2),
        .nicEnWR_0_2(nicEnWR_0_2),
        
        .addr_1_2(addr_1_2),
        .d_in_1_2(d_in_1_2),
        .d_out_1_2(d_out_1_2),
        .nicEn_1_2(nicEn_1_2),
        .nicEnWR_1_2(nicEnWR_1_2),
        
        .addr_2_2(addr_2_2),
        .d_in_2_2(d_in_2_2),
        .d_out_2_2(d_out_2_2),
        .nicEn_2_2(nicEn_2_2),
        .nicEnWR_2_2(nicEnWR_2_2),
        
        .addr_3_2(addr_3_2),
        .d_in_3_2(d_in_3_2),
        .d_out_3_2(d_out_3_2),
        .nicEn_3_2(nicEn_3_2),
        .nicEnWR_3_2(nicEnWR_3_2)
        
    );

    wire [63:0] sndo_from_00_to_sndi_01;
    wire [63:0] sndo_from_10_to_sndi_11;
    wire [63:0] sndo_from_20_to_sndi_21;
    wire [63:0] sndo_from_30_to_sndi_31;

    wire [63:0] nsdi_from_00_to_nsdo_01;
    wire [63:0] nsdi_from_10_to_nsdo_11;
    wire [63:0] nsdi_from_20_to_nsdo_21;
    wire [63:0] nsdi_from_30_to_nsdo_31;

    wire snso_from_00_to_snsi_01;
    wire snro_from_00_to_snri_01;
    wire nssi_from_00_to_nsso_01;
    wire nsri_from_00_to_nsro_01;

    wire snso_from_10_to_snsi_11;
    wire snro_from_10_to_snri_11;
    wire nssi_from_10_to_nsso_11;
    wire nsri_from_10_to_nsro_11;

    wire snso_from_20_to_snsi_21;
    wire snro_from_20_to_snri_21;
    wire nssi_from_20_to_nsso_21;
    wire nsri_from_20_to_nsro_21;

    wire snso_from_30_to_snsi_31;
    wire snro_from_30_to_snri_31;
    wire nssi_from_30_to_nsso_31;
    wire nsri_from_30_to_nsro_31;

    mesh_row_1 #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) row_1 (
        .clk(clk), 
        .reset(reset),
       
        // top signal router 0,1 
        .snso_0_1(snso_from_01_to_snsi_02), .snro_0_1(snro_from_01_to_snri_02), .sndo_0_1(sndo_from_01_to_sndi_02), .nssi_0_1(nssi_from_01_to_nsso_02), .nsri_0_1(nsri_from_01_to_nsro_02), .nsdi_0_1(nsdi_from_01_to_nsdo_02),

        // botto2 signal router 0,1
        .snsi_0_1(snso_from_00_to_snsi_01), .snri_0_1(snro_from_00_to_snri_01), .sndi_0_1(sndo_from_00_to_sndi_01), .nsso_0_1(nssi_from_00_to_nsso_01), .nsro_0_1(nsri_from_00_to_nsro_01), .nsdo_0_1(nsdi_from_00_to_nsdo_01), 

        // top s2gnal router 1,1 
        .snso_1_1(snso_from_11_to_snsi_12), .snro_1_1(snro_from_11_to_snri_12), .sndo_1_1(sndo_from_11_to_sndi_12), .nssi_1_1(nssi_from_11_to_nsso_12), .nsri_1_1(nsri_from_11_to_nsro_12), .nsdi_1_1(nsdi_from_11_to_nsdo_12),

        // botto2 signal router 1,1
        .snsi_1_1(snso_from_10_to_snsi_11), .snri_1_1(snro_from_10_to_snri_11), .sndi_1_1(sndo_from_10_to_sndi_11), .nsso_1_1(nssi_from_10_to_nsso_11), .nsro_1_1(nsri_from_10_to_nsro_11), .nsdo_1_1(nsdi_from_10_to_nsdo_11), 

        // top s2gnal router 2,1 
        .snso_2_1(snso_from_21_to_snsi_22), .snro_2_1(snro_from_21_to_snri_22), .sndo_2_1(sndo_from_21_to_sndi_22), .nssi_2_1(nssi_from_21_to_nsso_22), .nsri_2_1(nsri_from_21_to_nsro_22), .nsdi_2_1(nsdi_from_21_to_nsdo_22),

        // botto2 signal router 2,1
        .snsi_2_1(snso_from_20_to_snsi_21), .snri_2_1(snro_from_20_to_snri_21), .sndi_2_1(sndo_from_20_to_sndi_21), .nsso_2_1(nssi_from_20_to_nsso_21), .nsro_2_1(nsri_from_20_to_nsro_21), .nsdo_2_1(nsdi_from_20_to_nsdo_21), 

        // top s2gnal router 3,1 
        .snso_3_1(snso_from_31_to_snsi_32), .snro_3_1(snro_from_31_to_snri_32), .sndo_3_1(sndo_from_31_to_sndi_32), .nssi_3_1(nssi_from_31_to_nsso_32), .nsri_3_1(nsri_from_31_to_nsro_32), .nsdi_3_1(nsdi_from_31_to_nsdo_32),

        // botto2 signal router 3,1
        .snsi_3_1(snso_from_30_to_snsi_31), .snri_3_1(snro_from_30_to_snri_31), .sndi_3_1(sndo_from_30_to_sndi_31), .nsso_3_1(nssi_from_30_to_nsso_31), .nsro_3_1(nsri_from_30_to_nsro_31), .nsdo_3_1(nsdi_from_30_to_nsdo_31),
        
        .addr_0_1(addr_0_1),
        .d_in_0_1(d_in_0_1),
        .d_out_0_1(d_out_0_1),
        .nicEn_0_1(nicEn_0_1),
        .nicEnWR_0_1(nicEnWR_0_1),
        
        .addr_1_1(addr_1_1),
        .d_in_1_1(d_in_1_1),
        .d_out_1_1(d_out_1_1),
        .nicEn_1_1(nicEn_1_1),
        .nicEnWR_1_1(nicEnWR_1_1),
        
        .addr_2_1(addr_2_1),
        .d_in_2_1(d_in_2_1),
        .d_out_2_1(d_out_2_1),
        .nicEn_2_1(nicEn_2_1),
        .nicEnWR_2_1(nicEnWR_2_1),
        
        .addr_3_1(addr_3_1),
        .d_in_3_1(d_in_3_1),
        .d_out_3_1(d_out_3_1),
        .nicEn_3_1(nicEn_3_1),
        .nicEnWR_3_1(nicEnWR_3_1)

    );


    mesh_row_0 #(
        .PACKET_WIDTH(PACKET_WIDTH)
    ) row_0 (
        .clk(clk), 
        .reset(reset),
       
        // top signal router 0,0 
        .snso_0_0(snso_from_00_to_snsi_01), .snro_0_0(snro_from_00_to_snri_01), .sndo_0_0(sndo_from_00_to_sndi_01), .nssi_0_0(nssi_from_00_to_nsso_01), .nsri_0_0(nsri_from_00_to_nsro_01), .nsdi_0_0(nsdi_from_00_to_nsdo_01),
        
        // top signal router 1,0 
        .snso_1_0(snso_from_10_to_snsi_11), .snro_1_0(snro_from_10_to_snri_11), .sndo_1_0(sndo_from_10_to_sndi_11), .nssi_1_0(nssi_from_10_to_nsso_11), .nsri_1_0(nsri_from_10_to_nsro_11), .nsdi_1_0(nsdi_from_10_to_nsdo_11),
        
        // top signal router 2,0 
        .snso_2_0(snso_from_20_to_snsi_21), .snro_2_0(snro_from_20_to_snri_21), .sndo_2_0(sndo_from_20_to_sndi_21), .nssi_2_0(nssi_from_20_to_nsso_21), .nsri_2_0(nsri_from_20_to_nsro_21), .nsdi_2_0(nsdi_from_20_to_nsdo_21),
        
        // top signal router 3,0 
        .snso_3_0(snso_from_30_to_snsi_31), .snro_3_0(snro_from_30_to_snri_31), .sndo_3_0(sndo_from_30_to_sndi_31), .nssi_3_0(nssi_from_30_to_nsso_31), .nsri_3_0(nsri_from_30_to_nsro_31), .nsdi_3_0(nsdi_from_30_to_nsdo_31),
        
        .addr_0_0(addr_0_0),
        .d_in_0_0(d_in_0_0),
        .d_out_0_0(d_out_0_0),
        .nicEn_0_0(nicEn_0_0),
        .nicEnWR_0_0(nicEnWR_0_0),
        
        .addr_1_0(addr_1_0),
        .d_in_1_0(d_in_1_0),
        .d_out_1_0(d_out_1_0),
        .nicEn_1_0(nicEn_1_0),
        .nicEnWR_1_0(nicEnWR_1_0),
        
        .addr_2_0(addr_2_0),
        .d_in_2_0(d_in_2_0),
        .d_out_2_0(d_out_2_0),
        .nicEn_2_0(nicEn_2_0),
        .nicEnWR_2_0(nicEnWR_2_0),
        
        .addr_3_0(addr_3_0),
        .d_in_3_0(d_in_3_0),
        .d_out_3_0(d_out_3_0),
        .nicEn_3_0(nicEn_3_0),
        .nicEnWR_3_0(nicEnWR_3_0)

    );


endmodule
