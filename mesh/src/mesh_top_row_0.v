
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
    
    // CPU <--> External interface
    input [0:31] inst_in_0_0, inst_in_1_0, inst_in_2_0, inst_in_3_0,                // from imem
    input [0:63] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0,                            // data input from dmem
    output [0:31] pc_out_0_0, pc_out_1_0, pc_out_2_0, pc_out_3_0,                    // program counter out
    output  [0:63] d_out_0_0, d_out_1_0, d_out_2_0, d_out_3_0,                   // data output to data memory
    output  [0:31] addr_out_0_0, addr_out_1_0, addr_out_2_0, addr_out_3_0,        // data memory address
    output  memWrEn_0_0, memWrEn_1_0, memWrEn_2_0, memWrEn_3_0,                  // data memory write enable
    output  memEn_0_0, memEn_1_0, memEn_2_0, memEn_3_0                  // data memory write enable

); 

    // naming scheme is first signal - left. second signal - right
    wire cwsi_cwso_0, cwri_cwro_0, ccwso_ccwsi_0, ccwro_ccwri_0;
    wire [63:0] cwdi_cwdo_0, ccwdo_ccwdi_0; 
    wire cwsi_cwso_1, cwri_cwro_1, ccwso_ccwsi_1, ccwro_ccwri_1;
    wire [63:0] cwdi_cwdo_1, ccwdo_ccwdi_1; 
    
    wire wasd0, wasd1, wasd2, wasd3;
    wire [63:0] wasd5, wasd6; 
    
    wire cwsi_cwso_2, cwri_cwro_2, ccwso_ccwsi_2, ccwro_ccwri_2;
    wire [63:0] cwdi_cwdo_2, ccwdo_ccwdi_2; 


    
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
    
    // Add CPU for part 3
    wire [PACKET_WIDTH-1:0] d_in_0_0_between_nic, d_out_0_0_between_nic;
    wire [PACKET_WIDTH-1:0] d_in_1_0_between_nic, d_out_1_0_between_nic;
    wire [PACKET_WIDTH-1:0] d_in_2_0_between_nic, d_out_2_0_between_nic;
    wire [PACKET_WIDTH-1:0] d_in_3_0_between_nic, d_out_3_0_between_nic;
    
    // CPU <--> NIC
    wire nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;                              // NIC enable 
    wire nicWrEn_0_0, nicWrEn_1_0, nicWrEn_2_0, nicWrEn_3_0;                      // NIC write enable
    wire [0:1] addr_nic_0_0, addr_nic_1_0, addr_nic_2_0, addr_nic_3_0;         // NIC address
    wire [0:63] d_out_nic_0_0, d_out_nic_1_0, d_out_nic_2_0, d_out_nic_3_0;     // NIC data output
    wire [0:63] d_in_nic_0_0, d_in_nic_1_0, d_in_nic_2_0, d_in_nic_3_0;              // NIC data input

    // Left Ports Wire Declarations
    wire ccwsi_0_0 = 0;
    wire ccwso_0_0;
    wire ccwro_0_0 = 0;
    
    wire cwsi_0_0 = 0;
    wire cwri_0_0;
    wire cwso_0_0;
    wire cwro_0_0 = 0;
    
    // Bottom Ports Wire Declarations
    wire snsi_0_0 = 0;
    wire snri_0_0;
    wire nsso_0_0;
    wire nsro_0_0 = 0;


    // These signals should always be 1, as they are corresponding to the empty edge router buffers
    wire signal_to_icg_high_0_0, signal_to_icg_low_0_0;
    // Clock Gate Enable based on the conditions:
    // 1) SI signals are LOW (no data sending into input buffer)
    // 2) RO signals are HIGH (neighbor can accept a packet) OR RO signals are LOW (neighbor can't accept a packet)
    // 3) SO signal is LOW (no packet to be sent to a neighbor)
    // Clock Gate Enable for router_0_0
    wire router_0_0_icg_enable = !( 
        (cwsi_0_0 == 1'b0) &&            // SI signal LOW for left (no data in input buffer)
        (wasd1 == 1'b1 || wasd1 == 1'b0) && // RO signal HIGH or LOW for left (neighbor can/can't accept packet)
        (ccwso_0_0 == 1'b0) &&           // SO signal LOW for right (no packet to send to neighbor)
        (ccwro_0_0 == 1'b1 || ccwro_0_0 == 1'b0) && // RO signal HIGH or LOW for right (neighbor can/can't accept packet)
        (snsi_0_0 == 1'b0) &&            // SI signal LOW for bottom (no data in input buffer)
        (nsso_0_0 == 1'b0) &&            // SO signal LOW for bottom (no packet to send to neighbor)
        (nsro_0_0 == 1'b1 || nsro_0_0 == 1'b0)); // RO signal HIGH or LOW for bottom (neighbor can/can't accept packet)

        // 1 && 1 && 1 && 1 && 1 && 1 1
    wire router_0_0_gclk;
    clk_gate_latch router_0_0_icg (.CLK(clk), .EN(router_0_0_icg_enable), .GCLK(router_0_0_gclk));
    
    // bottom left corner 
    router router_0_0 (
        .clk(router_0_0_gclk), .reset(reset), .router_position(), .polarity_out(net_polarity_0_0),
        
        //left -- grounded
        .cwsi(cwsi_0_0), .cwri(cwri_0_0), .cwdi(), .ccwso(ccwso_0_0), .ccwro(ccwro_0_0), .ccwdo(),

        //right 
        //.cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        .cwso(wasd0), .cwro(wasd1), .cwdo(wasd5), .ccwsi(wasd2), .ccwri(wasd3), .ccwdi(wasd6),

        // top
        .snso(snso_0_0), .snro(snro_0_0), .sndo(sndo_0_0), .nssi(nssi_0_0), .nsri(nsri_0_0), .nsdi(nsdi_0_0),  
    
        // bottom - gnd
        .snsi(snsi_0_0), .snri(snri_0_0), .sndi(), .nsso(nsso_0_0), .nsro(nsro_0_0), .nsdo(),
 
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
        .addr(addr_nic_0_0),
        .d_in(d_in_nic_0_0),
        .d_out(d_out_nic_0_0),
        .nicEn(nicEn_0_0),
        .nicEnWR(nicWrEn_0_0),
    
        // Router-NIC Interface
        .net_si(net_si_0_0),
        .net_so(net_so_0_0),
        .net_ri(net_ri_0_0),
        .net_ro(net_ro_0_0),
    
        .net_di(net_di_0_0),
        .net_do(net_do_0_0),
        .net_polarity(net_polarity_0_0)
    );
    
    four_stage_processor cpu_0_0 (
        .clk(clk),
        .reset(reset),
    
        // CPU - CPU interface
        .inst_in(inst_in_0_0),
        .d_in(d_in_0_0),
        .pc_out(pc_out_0_0),
        .d_out(d_out_0_0),
        .addr_out(addr_out_0_0),
        .memWrEn(memWrEn_0_0),
        .memEn(memEn_0_0),
    
        // CPU - NIC interface
        .nicEn(nicEn_0_0),
        .nicWrEn(nicWrEn_0_0),
        .addr_nic(addr_nic_0_0),
        .d_out_nic(d_out_nic_0_0),
        .d_in_nic(d_in_nic_0_0)
    );
    
    router router_1_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_1_0),
        
        //right -> left of next router
        .cwsi(wasd0), .cwri(wasd1), .cwdi(wasd5), .ccwso(wasd2), .ccwro(wasd3), .ccwdo(wasd6),

        //left 
        .cwso(cwsi_cwso_2), .cwro(cwri_cwro_2), .cwdo(cwdi_cwdo_2), .ccwsi(ccwso_ccwsi_2), .ccwri(ccwro_ccwri_2), .ccwdi(ccwdo_ccwdi_2),

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
        .addr(addr_nic_1_0),
        .d_in(d_in_nic_1_0),
        .d_out(d_out_nic_1_0),
        .nicEn(nicEn_1_0),
        .nicEnWR(nicWrEn_1_0),
    
        // Router-NIC Interface
        .net_si(net_si_1_0),
        .net_so(net_so_1_0),
        .net_ri(net_ri_1_0),
        .net_ro(net_ro_1_0),
    
        .net_di(net_di_1_0),
        .net_do(net_do_1_0),
        .net_polarity(net_polarity_1_0)
    );
    
    four_stage_processor cpu_1_0 (
        .clk(clk),
        .reset(reset),
    
        // CPU - CPU interface
        .inst_in(inst_in_1_0),
        .d_in(d_in_1_0),
        .pc_out(pc_out_1_0),
        .d_out(d_out_1_0),
        .addr_out(addr_out_1_0),
        .memWrEn(memWrEn_1_0),
        .memEn(memEn_1_0),
    
        // CPU - NIC interface
        .nicEn(nicEn_1_0),
        .nicWrEn(nicWrEn_1_0),
        .addr_nic(addr_nic_1_0),
        .d_out_nic(d_out_nic_1_0),
        .d_in_nic(d_in_nic_1_0)
    );
    
    router router_2_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_2_0),
        
        //right -> left of next router
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
        .addr(addr_nic_2_0),
        .d_in(d_in_nic_2_0),
        .d_out(d_out_nic_2_0),
        .nicEn(nicEn_2_0),
        .nicEnWR(nicWrEn_2_0),
    
        // Router-NIC Interface
        .net_si(net_si_2_0),
        .net_so(net_so_2_0),
        .net_ri(net_ri_2_0),
        .net_ro(net_ro_2_0),
    
        .net_di(net_di_2_0),
        .net_do(net_do_2_0),
        .net_polarity(net_polarity_2_0)
    );

    four_stage_processor cpu_2_0 (
        .clk(clk),
        .reset(reset),
    
        // CPU - CPU interface
        .inst_in(inst_in_2_0),
        .d_in(d_in_2_0),
        .pc_out(pc_out_2_0),
        .d_out(d_out_2_0),
        .addr_out(addr_out_2_0),
        .memWrEn(memWrEn_2_0),
        .memEn(memEn_2_0),
    
        // CPU - NIC interface
        .nicEn(nicEn_2_0),
        .nicWrEn(nicWrEn_2_0),
        .addr_nic(addr_nic_2_0),
        .d_out_nic(d_out_nic_2_0),
        .d_in_nic(d_in_nic_2_0)
    );

    router router_3_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_3_0),
        
        //left
        .cwsi(cwsi_cwso_1), .cwri(cwri_cwro_1), .cwdi(cwdi_cwdo_1), .ccwso(ccwso_ccwsi_1), .ccwro(ccwro_ccwri_1), .ccwdo(ccwdo_ccwdi_1),

        //right
        .cwso(), .cwro(), .cwdo(), .ccwsi(), .ccwri(), .ccwdi(),

        
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
        .addr(addr_nic_3_0),
        .d_in(d_in_nic_3_0),
        .d_out(d_out_nic_3_0),
        .nicEn(nicEn_3_0),
        .nicEnWR(nicWrEn_3_0),
    
        // Router-NIC Interface
        .net_si(net_si_3_0),
        .net_so(net_so_3_0),
        .net_ri(net_ri_3_0),
        .net_ro(net_ro_3_0),
    
        .net_di(net_di_3_0),
        .net_do(net_do_3_0),
        .net_polarity(net_polarity_3_0)
    );
    
    
    four_stage_processor cpu_3_0 (
        .clk(clk),
        .reset(reset),
    
        // CPU - CPU interface
        .inst_in(inst_in_3_0),
        .d_in(d_in_3_0),
        .pc_out(pc_out_3_0),
        .d_out(d_out_3_0),
        .addr_out(addr_out_3_0),
        .memWrEn(memWrEn_3_0),
        .memEn(memEn_3_0),
    
        // CPU - NIC interface
        .nicEn(nicEn_3_0),
        .nicWrEn(nicWrEn_3_0),
        .addr_nic(addr_nic_3_0),
        .d_out_nic(d_out_nic_3_0),
        .d_in_nic(d_in_nic_3_0)
    );

endmodule
