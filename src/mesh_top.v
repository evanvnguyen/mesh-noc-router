
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
        parameter SIZE_X = 2,
        parameter SIZE_Y = 2,
        parameter NUM_ROUTERS = SIZE_X * SIZE_Y
    ) (
        input clk,
        input reset,
    
        output [NUM_ROUTERS-1:0] polarity_out
    );
    
    // Flatten the width of the router inputs/outputs and splice it for each router
    wire [NUM_ROUTERS-1:0] cwsi, cwri, cwro, cwso;
    wire [NUM_ROUTERS-1:0] ccwsi, ccwri, ccwro, ccwso;

    // Don't really need cwdi/ccwdi_flat since we just connect outputs to output
    wire [(NUM_ROUTERS * PACKET_WIDTH) - 1:0] cwdi_flat, cwdo_flat;
    wire [(NUM_ROUTERS * PACKET_WIDTH) - 1:0] ccwdi_flat, ccwdo_flat;

    wire [NUM_ROUTERS-1:0] pesi, peri, pero, peso;
    wire [(NUM_ROUTERS * PACKET_WIDTH) - 1:0] pedi_flat, pedo_flat;

    wire [NUM_ROUTERS-1:0] nssi, nsri, nsro, nsso;
    wire [NUM_ROUTERS-1:0] snsi, snri, snro, snso;

    // Don't really need nsdi/sndi_flat since we just connect outputs to output
    wire [(NUM_ROUTERS * PACKET_WIDTH) - 1:0] nsdi_flat, nsdo_flat;
    wire [(NUM_ROUTERS * PACKET_WIDTH) - 1:0] sndi_flat, sndo_flat;

    /* Edge grounding
    1. Top Row (i == 0):
       - Ground North-South (NS) inputs/outputs since there's no router above.
       - .nssi and .nsdi set to GND

    2. Bottom Row (i == 3):
       - Ground South-North (SN) inputs/outputs since there's no router below.
       - .snsi and .sndi set to GND

    3. Left Column (j == 0):
       - Ground Counter-Clockwise (CCW) inputs/outputs since there's no router to the left.
       - .ccwsi and .ccwdi are set to GND

    4. Right Column (j == 3):
       - Ground Clockwise (CW) inputs/outputs since there's no router to the right.
       - .cwsi and .cwdi are set to GND

    5. Corner Routers:
         - router_genblk(0,0) ? Ground NS and CCW
         - router_genblk(0,3) ? Ground NS and CW
         - router_genblk(3,0) ? Ground SN and CCW
         - router_genblk(3,3) ? Ground SN and CW
    */

    // Flattened NIC signals for each router
    wire [15:0] nic_net_si, nic_net_ri, nic_net_so, nic_net_ro;
    wire [(16 * PACKET_WIDTH) - 1:0] nic_net_di_flat, nic_net_do_flat;
    wire [(16 * 2) - 1:0] nic_addr_flat;
    wire [(16 * PACKET_WIDTH) - 1:0] nic_din_flat;
    wire [15:0] nic_en, nic_en_wr;

    // Generates a 4x4 router mesh, each router with 1 NIC. Each NIC has 1 dummy CPU to drive PE
    genvar i, j;
    generate
        for (i=0; i<SIZE_X; i=i+1) begin : ROW
            for (j=0; j<SIZE_Y; j=j+1) begin : COLUMN
                localparam index = i * SIZE_X + j;
                
                /*
                    1. Hooks up 1 dummy CPU to 1 NIC.
                    2. Hooks up 1 NIC to 1 router.
                    These signals need to connect to the  actual CPU in future:
                     - addr
                     - d_in/d_out
                     - nicEn
                     - nicEnWr
                     Currently driven by a dummy cpu that always rigths to the output buffer
                */

                /* Splice handling
                    -   if index = 3 and PACKET_WIDTH = 64,
                        (index + 1) × PACKET_WIDTH = 4 × 64 = 256.
                        So cwdi comes from cwdo_flat[256 +: 64], i.e. bits [256 : 319].
                    
                        Similarly, index × PACKET_WIDTH = 3 × 64 = 192.
                        So the local cwdo slice is cwdo_flat[192 +: 64], i.e. bits [192 : 255].
                */
                
                dummy_cpu #(PACKET_WIDTH) cpu_inst (
                    .clk(clk),
                    .reset(reset),
                    .addr(nic_addr_flat[(index * 2) +: 2]),
                    .d_out(nic_din_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]),
                    .d_in(nic_net_do_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]),
                    .nicEn(nic_en[index]),
                    .nicEnWR(nic_en_wr[index])
                );
                
                nic #(PACKET_WIDTH) nic_inst (
                    .clk(clk),
                    .reset(reset),
                    .addr(nic_addr_flat[(index * 2) +: 2]),
                    .d_in(nic_din_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]),
                    .d_out(nic_net_do_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]),
                    .nicEn(nic_en[index]),
                    .nicEnWR(nic_en_wr[index]),
                    .net_si(peso[index]),
                    .net_ri(pero[index]),
                    .net_di(pedo_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]),
                    .net_so(pesi[index]),
                    .net_ro(peri[index]),
                    .net_do(pedi_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]),
                    .net_polarity(polarity_out[index])
                );

                // x = 3 -- far right row                
                // y = 3 -- far bottom row
                // indexing fixed
                router router_genblk (
                    .clk(clk),
                    .reset(reset),
                    .router_position({i[SIZE_X-1:0], j[SIZE_Y-1:0]}),
                    .polarity_out(polarity_out[index]),
                
                    // **CW input/output (Right)**
                    // if on right edge and i < size_x , leave it disconnected for clock wise inupt
                    // **CW input/output (Right)**
                    // **CW input/output (Right)**
                    .cwsi(), // to right router's CW output
                    .cwdi(), // output
                    .cwri(cwri[index]), //  input
                    .cwro(cwro[index]), // output
                    .cwso(cwso[index]), //  output
                    .cwdo(), //  output


                
                    // **CCW input/output (Left)**
                    // if on left edge i == 0, leave it disconnected for counter clock wise input
                    .ccwsi(), // input
                    .ccwdi(ccwdi_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]), // input
                    .ccwri(ccwri[index]), // output
                    .ccwro(ccwro[index]), // input
                    .ccwso(), // output
                    .ccwdo(ccwdo_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]), // output
                
                    // **NS input/output (Up)**
                    // get above router only if its not the top row
                    .nssi((j == 0) ? 1'b0 : ((j < SIZE_Y) ? nsso[index-1] : 1'b0)), // input
                    .nsdi(nsdi_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]), // input
                    .nsri(nsri[index]), // output
                    .nsro((j == 0) ? 1'b0 : ((j < SIZE_Y) ? nsri[index-1] : 1'b0)), // input
                    .nsso(nsso[index]), // output
                    .nsdo(nsdo_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]), // output
                
                    // **SN input/output (Down)**
                    // get below router only if its not the bottom row
                    .snsi((j < SIZE_Y - 1) ? ((j + 1 < SIZE_Y) ? snso[index + 1] : 1'b0) : 1'b0), // input
                    .sndi(), // input
                    .snri(snri[index]), // output
                    .snro((j < SIZE_Y - 1) ? ((j + 1 < SIZE_Y) ? snri[index + 1] : 1'b0) : 1'b0), // input
                    .snso(snso[index]), // output
                    .sndo(), // output
                    

                    // **PE input/output**
                    .pesi(pesi[index]), // input
                    .pedi(pedi_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]), // input
                    .peri(peri[index]), // output
                    .pero(pero[index]), // input
                    .peso(peso[index]), // output
                    .pedo(pedo_flat[(index * PACKET_WIDTH) +: PACKET_WIDTH]) // output
                );
            end
        end
    endgenerate

endmodule
