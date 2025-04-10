
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


    // bottom left corner 
    router router_0_0 (
        .clk(clk), .reset(reset), .router_position(), .polarity_out(net_polarity_0_0),
        
        //right -- THIS IS GROUNDED!!!! rework this
        .cwsi(), .cwri(), .cwdi(), .ccwso(), .ccwro(), .ccwdo(),

        //left - gnd - BUT NOT REALLY
        //.cwso(cwsi_cwso_1), .cwro(cwri_cwro_1), .cwdo(cwdi_cwdo_1), .ccwsi(ccwso_ccwsi_1), .ccwri(ccwro_ccwri_1), .ccwdi(ccwdo_ccwdi_1),
        .cwso(wasd0), .cwro(wasd1), .cwdo(wasd5), .ccwsi(wasd2), .ccwri(wasd3), .ccwdi(wasd6),

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
        .addr(addr_nic_0_0),
        .d_in(d_in_0_0_between_nic),
        .d_out(d_out_0_0_between_nic),
        .nicEn(memEn_0_0),
        .nicEnWR(memWrEn_0_0),
    
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
        .reset(clk),
    
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
        .d_in(d_out_1_0_between_nic),
        .d_out(d_in_1_0_between_nic),
        .nicEn(memEn_1_0),
        .nicEnWR(memWrEn_1_0),
    
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
        .reset(clk),
    
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
        .d_in(d_in_2_0_between_nic),
        .d_out(d_out_2_0_between_nic),
        .nicEn(memEn_2_0),
        .nicEnWR(memWrEn_2_0),
    
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
        .reset(clk),
    
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
        
        //right -- THIS IS GROUNDED!!!! rework this -- right -> left
        .cwsi(cwsi_cwso_1), .cwri(cwri_cwro_1), .cwdi(cwdi_cwdo_1), .ccwso(ccwso_ccwsi_1), .ccwro(ccwro_ccwri_1), .ccwdo(ccwdo_ccwdi_1),

        //left
        .cwso(), .cwro(), .cwdo(), .ccwsi(), .ccwri(), .ccwdi(),

        //left - gnd - BUT NOT REALLY
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
        .d_in(d_in_3_0_between_nic),
        .d_out(d_out_3_0_between_nic),
        .nicEn(memEn_3_0),
        .nicEnWR(memWrEn_3_0),
    
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
        .reset(clk),
    
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
