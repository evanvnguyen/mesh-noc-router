module tb_mesh_top_flat;
    localparam PACKET_WIDTH=64;
    
    // Clock and reset
    reg clk;
    reg reset;
    
    // row 3 signals
    reg  [1:0]  addr_0_3, addr_1_3, addr_2_3, addr_3_3;
    reg  [63:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
    wire [63:0] d_out_0_3, d_out_1_3, d_out_2_3, d_out_3_3;
    reg         nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
    reg         nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
    // row 2 signals
    reg  [1:0]  addr_0_2, addr_1_2, addr_2_2, addr_3_2;
    reg  [63:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
    wire [63:0] d_out_0_2, d_out_1_2, d_out_2_2, d_out_3_2;
    reg         nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
    reg         nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
    // row 1 signals
    reg  [1:0]  addr_0_1, addr_1_1, addr_2_1, addr_3_1;
    reg  [63:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
    wire [63:0] d_out_0_1, d_out_1_1, d_out_2_1, d_out_3_1;
    reg         nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
    reg         nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
    // row 0 signals
    reg  [1:0]  addr_0_0, addr_1_0, addr_2_0, addr_3_0;
    reg  [63:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
    wire [63:0] d_out_0_0, d_out_1_0, d_out_2_0, d_out_3_0;
    reg         nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
    reg         nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
    // Instantiate the design under test (DUT)
    mesh_top_flat uut (
        .clk(clk), .reset(reset),
        
        // row 3
        .addr_0_3(addr_0_3), .d_in_0_3(d_in_0_3), .d_out_0_3(d_out_0_3), .nicEn_0_3(nicEn_0_3), .nicEnWR_0_3(nicEnWR_0_3),
        .addr_1_3(addr_1_3), .d_in_1_3(d_in_1_3), .d_out_1_3(d_out_1_3), .nicEn_1_3(nicEn_1_3), .nicEnWR_1_3(nicEnWR_1_3),
        .addr_2_3(addr_2_3), .d_in_2_3(d_in_2_3), .d_out_2_3(d_out_2_3), .nicEn_2_3(nicEn_2_3), .nicEnWR_2_3(nicEnWR_2_3),
        .addr_3_3(addr_3_3), .d_in_3_3(d_in_3_3), .d_out_3_3(d_out_3_3), .nicEn_3_3(nicEn_3_3), .nicEnWR_3_3(nicEnWR_3_3),
        
        // row 2
        .addr_0_2(addr_0_2), .d_in_0_2(d_in_0_2), .d_out_0_2(d_out_0_2), .nicEn_0_2(nicEn_0_2), .nicEnWR_0_2(nicEnWR_0_2),
        .addr_1_2(addr_1_2), .d_in_1_2(d_in_1_2), .d_out_1_2(d_out_1_2), .nicEn_1_2(nicEn_1_2), .nicEnWR_1_2(nicEnWR_1_2),
        .addr_2_2(addr_2_2), .d_in_2_2(d_in_2_2), .d_out_2_2(d_out_2_2), .nicEn_2_2(nicEn_2_2), .nicEnWR_2_2(nicEnWR_2_2),
        .addr_3_2(addr_3_2), .d_in_3_2(d_in_3_2), .d_out_3_2(d_out_3_2), .nicEn_3_2(nicEn_3_2), .nicEnWR_3_2(nicEnWR_3_2),
        
        // row 1
        .addr_0_1(addr_0_1), .d_in_0_1(d_in_0_1), .d_out_0_1(d_out_0_1), .nicEn_0_1(nicEn_0_1), .nicEnWR_0_1(nicEnWR_0_1),
        .addr_1_1(addr_1_1), .d_in_1_1(d_in_1_1), .d_out_1_1(d_out_1_1), .nicEn_1_1(nicEn_1_1), .nicEnWR_1_1(nicEnWR_1_1),
        .addr_2_1(addr_2_1), .d_in_2_1(d_in_2_1), .d_out_2_1(d_out_2_1), .nicEn_2_1(nicEn_2_1), .nicEnWR_2_1(nicEnWR_2_1),
        .addr_3_1(addr_3_1), .d_in_3_1(d_in_3_1), .d_out_3_1(d_out_3_1), .nicEn_3_1(nicEn_3_1), .nicEnWR_3_1(nicEnWR_3_1),
        
        // row 0
        .addr_0_0(addr_0_0), .d_in_0_0(d_in_0_0), .d_out_0_0(d_out_0_0), .nicEn_0_0(nicEn_0_0), .nicEnWR_0_0(nicEnWR_0_0),
        .addr_1_0(addr_1_0), .d_in_1_0(d_in_1_0), .d_out_1_0(d_out_1_0), .nicEn_1_0(nicEn_1_0), .nicEnWR_1_0(nicEnWR_1_0),
        .addr_2_0(addr_2_0), .d_in_2_0(d_in_2_0), .d_out_2_0(d_out_2_0), .nicEn_2_0(nicEn_2_0), .nicEnWR_2_0(nicEnWR_2_0),
        .addr_3_0(addr_3_0), .d_in_3_0(d_in_3_0), .d_out_3_0(d_out_3_0), .nicEn_3_0(nicEn_3_0), .nicEnWR_3_0(nicEnWR_3_0)
    );
    
     always #5 clk = ~clk;
   

    // **** NIC functions **** 

    task reset_all_NIC_CPU_input;
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        reg zero_val;
        begin
            zero_val = 1'b0; // Set zero value to 0
    
            // Row 3
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3}       = {4{2'b00}};
            {d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3}       = {4{{PACKET_WIDTH{zero_val}}}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3}   = {4{zero_val}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{zero_val}};
    
            // Row 2
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2}       = {4{2'b00}};
            {d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2}       = {4{{PACKET_WIDTH{zero_val}}}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2}   = {4{zero_val}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{zero_val}};
    
            // Row 1
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1}       = {4{2'b00}};
            {d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1}       = {4{{PACKET_WIDTH{zero_val}}}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1}   = {4{zero_val}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{zero_val}};
    
            // Row 0
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0}       = {4{2'b00}};
            {d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0}       = {4{{PACKET_WIDTH{zero_val}}}};
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0}   = {4{zero_val}};
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{zero_val}};
    
            #10;
        end
    endtask

    // disable write, but enable reading the input buffer to the CPU
    task disable_write_to_all_nic;
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg       nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg       nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg       nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg       nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg       nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg       nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg       nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg       nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        reg zero_val;
        reg one_val;
        begin
            zero_val = 1'b0; // disable
            one_val = 1'b1; // enable
    
            // Row 3
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3}       = {4{2'b00}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3}   = {4{one_val}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{zero_val}};
    
            // Row 2
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2}       = {4{2'b00}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2}   = {4{one_val}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{zero_val}};
    
            // Row 1
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1}       = {4{2'b00}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1}   = {4{one_val}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{zero_val}};
    
            // Row 0
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0}       = {4{2'b00}};
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0}   = {4{one_val}};
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{zero_val}};
    
            #10;
        end
    endtask
    
    // **** Gather Phase tasks ****
    // - Unfortuantely since the wire locations are flattened, we have to do this manually
    
    // Probe each routers direction input buffer for changes 
    // - if we get new data in the buffer, then we know the data wasn't blocked
    // - and it can continue on its way
    always @(
        // Row 3
        mesh_top_flat.row_3.router_0_3.cw_input_channel.data_in or
        mesh_top_flat.row_3.router_0_3.ccw_input_channel.data_in or
        mesh_top_flat.row_3.router_0_3.ns_input_channel.data_in or
        mesh_top_flat.row_3.router_0_3.sn_input_channel.data_in or
                         
        mesh_top_flat.row_3.router_1_3.cw_input_channel.data_in or
        mesh_top_flat.row_3.router_1_3.ccw_input_channel.data_in or
        mesh_top_flat.row_3.router_1_3.ns_input_channel.data_in or
        mesh_top_flat.row_3.router_1_3.sn_input_channel.data_in or
                         
        mesh_top_flat.row_3.router_2_3.cw_input_channel.data_in or
        mesh_top_flat.row_3.router_2_3.ccw_input_channel.data_in or
        mesh_top_flat.row_3.router_2_3.ns_input_channel.data_in or
        mesh_top_flat.row_3.router_2_3.sn_input_channel.data_in or
                         
        mesh_top_flat.row_3.router_3_3.cw_input_channel.data_in or
        mesh_top_flat.row_3.router_3_3.ccw_input_channel.data_in or
        mesh_top_flat.row_3.router_3_3.ns_input_channel.data_in or
        mesh_top_flat.row_3.router_3_3.sn_input_channel.data_in or
                         
        // Row 2         
        mesh_top_flat.row_2.router_0_2.cw_input_channel.data_in or
        mesh_top_flat.row_2.router_0_2.ccw_input_channel.data_in or
        mesh_top_flat.row_2.router_0_2.ns_input_channel.data_in or
        mesh_top_flat.row_2.router_0_2.sn_input_channel.data_in or
                         
        mesh_top_flat.row_2.router_1_2.cw_input_channel.data_in or
        mesh_top_flat.row_2.router_1_2.ccw_input_channel.data_in or
        mesh_top_flat.row_2.router_1_2.ns_input_channel.data_in or
        mesh_top_flat.row_2.router_1_2.sn_input_channel.data_in or
                         
        mesh_top_flat.row_2.router_2_2.cw_input_channel.data_in or
        mesh_top_flat.row_2.router_2_2.ccw_input_channel.data_in or
        mesh_top_flat.row_2.router_2_2.ns_input_channel.data_in or
        mesh_top_flat.row_2.router_2_2.sn_input_channel.data_in or
                         
        mesh_top_flat.row_2.router_3_2.cw_input_channel.data_in or
        mesh_top_flat.row_2.router_3_2.ccw_input_channel.data_in or
        mesh_top_flat.row_2.router_3_2.ns_input_channel.data_in or
        mesh_top_flat.row_2.router_3_2.sn_input_channel.data_in or
                         
        // Row 1         
        mesh_top_flat.row_1.router_0_1.cw_input_channel.data_in or
        mesh_top_flat.row_1.router_0_1.ccw_input_channel.data_in or
        mesh_top_flat.row_1.router_0_1.ns_input_channel.data_in or
        mesh_top_flat.row_1.router_0_1.sn_input_channel.data_in or
                         
        mesh_top_flat.row_1.router_1_1.cw_input_channel.data_in or
        mesh_top_flat.row_1.router_1_1.ccw_input_channel.data_in or
        mesh_top_flat.row_1.router_1_1.ns_input_channel.data_in or
        mesh_top_flat.row_1.router_1_1.sn_input_channel.data_in or
                         
        mesh_top_flat.row_1.router_2_1.cw_input_channel.data_in or
        mesh_top_flat.row_1.router_2_1.ccw_input_channel.data_in or
        mesh_top_flat.row_1.router_2_1.ns_input_channel.data_in or
        mesh_top_flat.row_1.router_2_1.sn_input_channel.data_in or
                         
        mesh_top_flat.row_1.router_3_1.cw_input_channel.data_in or
        mesh_top_flat.row_1.router_3_1.ccw_input_channel.data_in or
        mesh_top_flat.row_1.router_3_1.ns_input_channel.data_in or
        mesh_top_flat.row_1.router_3_1.sn_input_channel.data_in or
                         
        // Row 0         
        mesh_top_flat.row_0.router_0_0.cw_input_channel.data_in or
        mesh_top_flat.row_0.router_0_0.ccw_input_channel.data_in or
        mesh_top_flat.row_0.router_0_0.ns_input_channel.data_in or
        mesh_top_flat.row_0.router_0_0.sn_input_channel.data_in or
                         
        mesh_top_flat.row_0.router_1_0.cw_input_channel.data_in or
        mesh_top_flat.row_0.router_1_0.ccw_input_channel.data_in or
        mesh_top_flat.row_0.router_1_0.ns_input_channel.data_in or
        mesh_top_flat.row_0.router_1_0.sn_input_channel.data_in or
                         
        mesh_top_flat.row_0.router_2_0.cw_input_channel.data_in or
        mesh_top_flat.row_0.router_2_0.ccw_input_channel.data_in or
        mesh_top_flat.row_0.router_2_0.ns_input_channel.data_in or
        mesh_top_flat.row_0.router_2_0.sn_input_channel.data_in or
                         
        mesh_top_flat.row_0.router_3_0.cw_input_channel.data_in or
        mesh_top_flat.row_0.router_3_0.ccw_input_channel.data_in or
        mesh_top_flat.row_0.router_3_0.ns_input_channel.data_in or
        mesh_top_flat.row_0.router_3_0.sn_input_channel.data_in
    ) begin
        $display("Time = %0t", $time);
        $display("Router signals:");
        
        $display("Row 3:");
        $display("ROUTER_0_3: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_3.router_0_3.cw_input_channel.data_in,
            mesh_top_flat.row_3.router_0_3.ccw_input_channel.data_in,
            mesh_top_flat.row_3.router_0_3.ns_input_channel.data_in,
            mesh_top_flat.row_3.router_0_3.sn_input_channel.data_in);
        $display("ROUTER_1_3: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_3.router_1_3.cw_input_channel.data_in,
            mesh_top_flat.row_3.router_1_3.ccw_input_channel.data_in,
            mesh_top_flat.row_3.router_1_3.ns_input_channel.data_in,
            mesh_top_flat.row_3.router_1_3.sn_input_channel.data_in);
        $display("ROUTER_2_3: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_3.router_2_3.cw_input_channel.data_in,
            mesh_top_flat.row_3.router_2_3.ccw_input_channel.data_in,
            mesh_top_flat.row_3.router_2_3.ns_input_channel.data_in,
            mesh_top_flat.row_3.router_2_3.sn_input_channel.data_in);
        $display("ROUTER_3_3: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_3.router_3_3.cw_input_channel.data_in,
            mesh_top_flat.row_3.router_3_3.ccw_input_channel.data_in,
            mesh_top_flat.row_3.router_3_3.ns_input_channel.data_in,
            mesh_top_flat.row_3.router_3_3.sn_input_channel.data_in);

        $display("Row 2:");
        $display("ROUTER_0_2: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_2.router_0_2.cw_input_channel.data_in,
            mesh_top_flat.row_2.router_0_2.ccw_input_channel.data_in,
            mesh_top_flat.row_2.router_0_2.ns_input_channel.data_in,
            mesh_top_flat.row_2.router_0_2.sn_input_channel.data_in);
        $display("ROUTER_1_2: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_2.router_1_2.cw_input_channel.data_in,
            mesh_top_flat.row_2.router_1_2.ccw_input_channel.data_in,
            mesh_top_flat.row_2.router_1_2.ns_input_channel.data_in,
            mesh_top_flat.row_2.router_1_2.sn_input_channel.data_in);
        $display("ROUTER_2_2: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_2.router_2_2.cw_input_channel.data_in,
            mesh_top_flat.row_2.router_2_2.ccw_input_channel.data_in,
            mesh_top_flat.row_2.router_2_2.ns_input_channel.data_in,
            mesh_top_flat.row_2.router_2_2.sn_input_channel.data_in);
        $display("ROUTER_3_2: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_2.router_3_2.cw_input_channel.data_in,
            mesh_top_flat.row_2.router_3_2.ccw_input_channel.data_in,
            mesh_top_flat.row_2.router_3_2.ns_input_channel.data_in,
            mesh_top_flat.row_2.router_3_2.sn_input_channel.data_in);

        $display("Row 1:");
        $display("ROUTER_0_1: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_1.router_0_1.cw_input_channel.data_in,
            mesh_top_flat.row_1.router_0_1.ccw_input_channel.data_in,
            mesh_top_flat.row_1.router_0_1.ns_input_channel.data_in,
            mesh_top_flat.row_1.router_0_1.sn_input_channel.data_in);
        $display("ROUTER_1_1: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_1.router_1_1.cw_input_channel.data_in,
            mesh_top_flat.row_1.router_1_1.ccw_input_channel.data_in,
            mesh_top_flat.row_1.router_1_1.ns_input_channel.data_in,
            mesh_top_flat.row_1.router_1_1.sn_input_channel.data_in);
        $display("ROUTER_2_1: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_1.router_2_1.cw_input_channel.data_in,
            mesh_top_flat.row_1.router_2_1.ccw_input_channel.data_in,
            mesh_top_flat.row_1.router_2_1.ns_input_channel.data_in,
            mesh_top_flat.row_1.router_2_1.sn_input_channel.data_in);
        $display("ROUTER_3_1: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_1.router_3_1.cw_input_channel.data_in,
            mesh_top_flat.row_1.router_3_1.ccw_input_channel.data_in,
            mesh_top_flat.row_1.router_3_1.ns_input_channel.data_in,
            mesh_top_flat.row_1.router_3_1.sn_input_channel.data_in);

        $display("Row 0:");
        $display("ROUTER_0_0: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_0.router_0_0.cw_input_channel.data_in,
            mesh_top_flat.row_0.router_0_0.ccw_input_channel.data_in,
            mesh_top_flat.row_0.router_0_0.ns_input_channel.data_in,
            mesh_top_flat.row_0.router_0_0.sn_input_channel.data_in);
        $display("ROUTER_1_0: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_0.router_1_0.cw_input_channel.data_in,
            mesh_top_flat.row_0.router_1_0.ccw_input_channel.data_in,
            mesh_top_flat.row_0.router_1_0.ns_input_channel.data_in,
            mesh_top_flat.row_0.router_1_0.sn_input_channel.data_in);
        $display("ROUTER_2_0: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_0.router_2_0.cw_input_channel.data_in,
            mesh_top_flat.row_0.router_2_0.ccw_input_channel.data_in,
            mesh_top_flat.row_0.router_2_0.ns_input_channel.data_in,
            mesh_top_flat.row_0.router_2_0.sn_input_channel.data_in);
        $display("ROUTER_3_0: cw=%h, ccw=%h, ns=%h, sn=%h",
            mesh_top_flat.row_0.router_3_0.cw_input_channel.data_in,
            mesh_top_flat.row_0.router_3_0.ccw_input_channel.data_in,
            mesh_top_flat.row_0.router_3_0.ns_input_channel.data_in,
            mesh_top_flat.row_0.router_3_0.sn_input_channel.data_in);
    end

    
    // Phase 0
    // All packets -> 0,0
    task start_phase0_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_1 = 64'h00100100856E23D6;
            d_in_0_2 = 64'h00200200EC85DB1B;
            d_in_0_3 = 64'h0040030023E2CB52;
        
            d_in_1_0 = 64'h000100017158D04A;
            d_in_1_1 = 64'h001101010A5165D7;
            d_in_1_2 = 64'h002102011FC6DE61;
            d_in_1_3 = 64'h00410301E9DCECB7;
        
            d_in_2_0 = 64'h0002000200D049B7;
            d_in_2_1 = 64'h0012010276B47144;
            d_in_2_2 = 64'h002202028F48E485;
            d_in_2_3 = 64'h004203028215DA8F;
        
            d_in_3_0 = 64'h0004000300E14881;
            d_in_3_1 = 64'h00140103C952B8B3;
            d_in_3_2 = 64'h0024020307EB546C;
            d_in_3_3 = 64'h004403032275EC92;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 1
    // All packets -> 0,1
    task start_phase1_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h40100000C68A1C74;
            d_in_0_2 = 64'h00100200748979FC;
            d_in_0_3 = 64'h0020030039ABC1BA;
        
            d_in_1_0 = 64'h40110001DB7525FE;
            d_in_1_1 = 64'h00010101028902C0;
            d_in_1_2 = 64'h00110201A5834B80;
            d_in_1_3 = 64'h00210301F43D214F;
        
            d_in_2_0 = 64'h401200024B95AF3C;
            d_in_2_1 = 64'h000201022A0CAA11;
            d_in_2_2 = 64'h00120202925ADD1F;
            d_in_2_3 = 64'h002203025DB15D77;
        
            d_in_3_0 = 64'h40140003780E5288;
            d_in_3_1 = 64'h000401036BD73BDF;
            d_in_3_2 = 64'h00140203E423E320;
            d_in_3_3 = 64'h00240303730572C6;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 2
    // All packets -> 0,2
    task start_phase2_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h4020000040CEF2B9;
            d_in_0_1 = 64'h40100100D7E69203;
            d_in_0_3 = 64'h00100300C2E31E15;
        
            d_in_1_0 = 64'h40210001AE16F7B0;
            d_in_1_1 = 64'h401101015918F2A3;
            d_in_1_2 = 64'h00010201C2896823;
            d_in_1_3 = 64'h001103010BEFD878;
        
            d_in_2_0 = 64'h40220002E2408155;
            d_in_2_1 = 64'h401201028A988FE2;
            d_in_2_2 = 64'h00020202F35C3EDD;
            d_in_2_3 = 64'h001203023A63943B;
        
            d_in_3_0 = 64'h402400038223BB60;
            d_in_3_1 = 64'h401401037738B56A;
            d_in_3_2 = 64'h000402030F1144D6;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 3
    // All packets -> 0,3
    task start_phase3_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h4040000065B454CE;
            d_in_0_1 = 64'h4020010071373F3F;
            d_in_0_2 = 64'h4010020037623F9E;
            d_in_0_3 = 64'h4010020037623F9E;
        
            d_in_1_0 = 64'h404100015389BAF7;
            d_in_1_1 = 64'h40210101665D65C0;
            d_in_1_2 = 64'h401102012004F323;
            d_in_1_3 = 64'h000103010098DAAC;
        
            d_in_2_0 = 64'h40420002980B0887;
            d_in_2_1 = 64'h40220102EF34EFCE;
            d_in_2_2 = 64'h401202024DE549FE;
            d_in_2_3 = 64'h00020302A21FC6E4;
        
            d_in_3_0 = 64'h40440003FBB7FF88;
            d_in_3_1 = 64'h402401035FBAC08D;
            d_in_3_2 = 64'h4014020357FD2BB0;
            d_in_3_3 = 64'h00040303237F78FD;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 4
    // All packets -> 1,0
    task start_phase4_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h200100008C7500E8;
            d_in_0_1 = 64'h2011010061A7267F;
            d_in_0_2 = 64'h20210200FC8F4C8D;
            d_in_0_3 = 64'h20410300FE8D2A74;
        
            d_in_1_1 = 64'h001001017E28314C;
            d_in_1_2 = 64'h002002010EE77988;
            d_in_1_3 = 64'h004003011D239F13;
        
            d_in_2_0 = 64'h000100027C403A87;
            d_in_2_1 = 64'h00110102A7ECD276;
            d_in_2_2 = 64'h0021020278C1D51F;
            d_in_2_3 = 64'h00410302F8F179A7;
        
            d_in_3_0 = 64'h000200033E67A4B6;
            d_in_3_1 = 64'h001201033C4E8030;
            d_in_3_2 = 64'h0022020333387617;
            d_in_3_3 = 64'h004203032B1B7475;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
     // Phase 5
    // All packets -> 1,1
    task start_phase5_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h6011000027BE619C;
            d_in_0_1 = 64'h20010100640690B9;
            d_in_0_2 = 64'h201102006438F755;
            d_in_0_3 = 64'h20210300CABA1A68;
        
            d_in_1_0 = 64'h40100001052242DD;
            d_in_1_2 = 64'h001002013628A245;
            d_in_1_3 = 64'h0020030142FE8625;
        
            d_in_2_0 = 64'h401100021DED47F4;
            d_in_2_1 = 64'h000101022F16E6F8;
            d_in_2_2 = 64'h001102023936341D;
            d_in_2_3 = 64'h002103024702CBC3;
        
            d_in_3_0 = 64'h4012000307781DDA;
            d_in_3_1 = 64'h000201030152423F;
            d_in_3_2 = 64'h00120203F2F29474;
            d_in_3_3 = 64'h00220303853F7A41;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
     // Phase 6
    // All packets -> 1,2
    task start_phase6_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h602100001F95C1C0;
            d_in_0_1 = 64'h60110100D4BC674E;
            d_in_0_2 = 64'h200102004CB5FB0A;
            d_in_0_3 = 64'h2011030062F76DA1;
        
            d_in_1_0 = 64'h40200001D2FE49B2;
            d_in_1_1 = 64'h401001019F8E39B1;
            d_in_1_3 = 64'h00100301BF39B343;
        
            d_in_2_0 = 64'h402100023223DF58;
            d_in_2_1 = 64'h4011010263369E6B;
            d_in_2_2 = 64'h0001020278C67509;
            d_in_2_3 = 64'h00110302D0E85C9C;
        
            d_in_3_0 = 64'h402200030E685203;
            d_in_3_1 = 64'h40120103ABD04DA3;
            d_in_3_2 = 64'h00020203F2615713;
            d_in_3_3 = 64'h00120303FB18B9D1;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 7
    // All packets -> 1,3
    task start_phase7_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h604100007DCB7CA2;
            d_in_0_1 = 64'h60210100713CF7F1;
            d_in_0_2 = 64'h601102004C13927C;
            d_in_0_3 = 64'h200103005F68C43A;
        
            d_in_1_0 = 64'h4040000196AE2473;
            d_in_1_1 = 64'h4020010126FA29AC;
            d_in_1_2 = 64'h40100201390F510A;
        
            d_in_2_0 = 64'h404100024A966FF6;
            d_in_2_1 = 64'h40210102E5131A16;
            d_in_2_2 = 64'h40110202AC2FE669;
            d_in_2_3 = 64'h00010302AF2CDF71;
        
            d_in_3_0 = 64'h40420003248FC8DF;
            d_in_3_1 = 64'h40220103DC7F2468;
            d_in_3_2 = 64'h40120203FA68C342;
            d_in_3_3 = 64'h00020303E1295899;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 8
    // All packets -> 2,0
    task start_phase8_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h20020000D95F1730;
            d_in_0_1 = 64'h201201003AA2B832;
            d_in_0_2 = 64'h20220200782A9DDA;
            d_in_0_3 = 64'h204203009FD9A8F3;
        
            d_in_1_0 = 64'h200100012D0B2891;
            d_in_1_1 = 64'h20110101986FC694;
            d_in_1_2 = 64'h20210201D67DF2F5;
            d_in_1_3 = 64'h2041030157A7D874;
        
            d_in_2_1 = 64'h00100102EF489814;
            d_in_2_2 = 64'h002002024E9DA45E;
            d_in_2_3 = 64'h00400302C6C7F6E3;
        
            d_in_3_0 = 64'h000100035B07486A;
            d_in_3_1 = 64'h0011010357ECEC89;
            d_in_3_2 = 64'h00210203546BEB92;
            d_in_3_3 = 64'h0041030316751C87;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 9
    // All packets -> 2,1
    task start_phase9_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h60120000CE97B4C9;
            d_in_0_1 = 64'h20020100437D7BB2;
            d_in_0_2 = 64'h20120200C012BAF4;
            d_in_0_3 = 64'h2022030015B79A28;
        
            d_in_1_0 = 64'h6011000142AE363A;
            d_in_1_1 = 64'h200101016D047B56;
            d_in_1_2 = 64'h201102012BBD4B84;
            d_in_1_3 = 64'h2021030117351F42;
        
            d_in_2_0 = 64'h401000021CDC6160;
            d_in_2_2 = 64'h001002020AA509E3;
            d_in_2_3 = 64'h0020030255C88405;
        
            d_in_3_0 = 64'h40110003EA0EE1B2;
            d_in_3_1 = 64'h00010103ABA7E94C;
            d_in_3_2 = 64'h00110203EFA5ACF8;
            d_in_3_3 = 64'h0021030358F112AD;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 10
    // All packets -> 2,2
    task start_phase10_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h60220000CF32AB58;
            d_in_0_1 = 64'h60120100E69DB69A;
            d_in_0_2 = 64'h20020200EBD6DA62;
            d_in_0_3 = 64'h20120300622CF2F6;
        
            d_in_1_0 = 64'h6021000157167B13;
            d_in_1_1 = 64'h60110101D495D846;
            d_in_1_2 = 64'h200102016F43837E;
            d_in_1_3 = 64'h2011030179C2D1F1;
        
            d_in_2_0 = 64'h40200002BC302DD8;
            d_in_2_1 = 64'h40100102FFF48830;
            d_in_2_3 = 64'h00100302A276FD2A;
        
            d_in_3_0 = 64'h40210003370E21E4;
            d_in_3_1 = 64'h40110103B6A0F308;
            d_in_3_2 = 64'h00010203DF6F95FE;
            d_in_3_3 = 64'h001103039155DA12;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 11
    // All packets -> 2,3
    task start_phase11_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h604200006F081545;
            d_in_0_1 = 64'h602201009185CFC6;
            d_in_0_2 = 64'h60120200B612772B;
            d_in_0_3 = 64'h20020300522FBD26;
        
            d_in_1_0 = 64'h6041000161D8D2CC;
            d_in_1_1 = 64'h602101013ED3613F;
            d_in_1_2 = 64'h6011020141FF1565;
            d_in_1_3 = 64'h20010301A872FE91;
        
            d_in_2_0 = 64'h404000022CAB028D;
            d_in_2_1 = 64'h4020010216901A67;
            d_in_2_2 = 64'h40100202C46EE72D;
        
            d_in_3_0 = 64'h404100033AA4AD0A;
            d_in_3_1 = 64'h40210103988185F8;
            d_in_3_2 = 64'h401102038149E546;
            d_in_3_3 = 64'h000103037C35E4C9;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 12
    // All packets -> 3,0
    task start_phase12_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h200400000D618DE5;
            d_in_0_1 = 64'h20140100B7D7D3F0;
            d_in_0_2 = 64'h20240200E182A8AF;
            d_in_0_3 = 64'h2044030040D3A7BB;
        
            d_in_1_0 = 64'h200200017F102905;
            d_in_1_1 = 64'h20120101BEFDA80E;
            d_in_1_2 = 64'h20220201346CAE19;
            d_in_1_3 = 64'h20420301177F3E2C;
        
            d_in_2_0 = 64'h200100024440DA44;
            d_in_2_1 = 64'h20110102F324DD0E;
            d_in_2_2 = 64'h20210202ECA8817F;
            d_in_2_3 = 64'h2041030251EE0F6E;
        
            d_in_3_1 = 64'h00100103738185B4;
            d_in_3_2 = 64'h002002038D5B5916;
            d_in_3_3 = 64'h0040030306406D30;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 13
    // All packets -> 3,1
    task start_phase13_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h60140000FED13989;
            d_in_0_1 = 64'h2004010033A1EAB4;
            d_in_0_2 = 64'h2014020061DCDAF7;
            d_in_0_3 = 64'h202403007B5208C3;
        
            d_in_1_0 = 64'h60120001F676F5BD;
            d_in_1_1 = 64'h2002010144D9A208;
            d_in_1_2 = 64'h201202011A32A51D;
            d_in_1_3 = 64'h202203019857DC1E;
        
            d_in_2_0 = 64'h601100021DF27893;
            d_in_2_1 = 64'h20010102EA09FFF8;
            d_in_2_2 = 64'h20110202D1131B24;
            d_in_2_3 = 64'h20210302C9177422;
        
            d_in_3_0 = 64'h40100003C06E0A30;
            d_in_3_2 = 64'h00100203B6565DD8;
            d_in_3_3 = 64'h0020030348A4A4C0;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 14
    // All packets -> 3,2
    task start_phase14_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h60140000FED13989;
            d_in_0_1 = 64'h2004010033A1EAB4;
            d_in_0_2 = 64'h2014020061DCDAF7;
            d_in_0_3 = 64'h202403007B5208C3;
        
            d_in_1_0 = 64'h60120001F676F5BD;
            d_in_1_1 = 64'h2002010144D9A208;
            d_in_1_2 = 64'h201202011A32A51D;
            d_in_1_3 = 64'h202203019857DC1E;
        
            d_in_2_0 = 64'h601100021DF27893;
            d_in_2_1 = 64'h20010102EA09FFF8;
            d_in_2_2 = 64'h20110202D1131B24;
            d_in_2_3 = 64'h20210302C9177422;
        
            d_in_3_0 = 64'h40100003C06E0A30;
            d_in_3_2 = 64'h00100203B6565DD8;
            d_in_3_3 = 64'h0020030348A4A4C0;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Phase 15
    // All packets -> 3,3
    task start_phase15_gather;
        output reg [1:0] addr_0_0, addr_1_0, addr_2_0, addr_3_0;
        output reg [PACKET_WIDTH-1:0] d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0;
        output reg nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0;
        output reg nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0;
    
        output reg [1:0] addr_0_1, addr_1_1, addr_2_1, addr_3_1;
        output reg [PACKET_WIDTH-1:0] d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1;
        output reg nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1;
        output reg nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1;
    
        output reg [1:0] addr_0_2, addr_1_2, addr_2_2, addr_3_2;
        output reg [PACKET_WIDTH-1:0] d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2;
        output reg nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2;
        output reg nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2;
    
        output reg [1:0] addr_0_3, addr_1_3, addr_2_3, addr_3_3;
        output reg [PACKET_WIDTH-1:0] d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3;
        output reg nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3;
        output reg nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3;
    
        begin
            // Assign unique values for d_in_x_y
            d_in_0_0 = 64'h604400002A2237F3;
            d_in_0_1 = 64'h60240100549B2473;
            d_in_0_2 = 64'h60140200C20CE928;
            d_in_0_3 = 64'h200403004743BBD7;
        
            d_in_1_0 = 64'h604200013AA667A2;
            d_in_1_1 = 64'h6022010114F2186A;
            d_in_1_2 = 64'h601202014365846C;
            d_in_1_3 = 64'h2002030149CDA026;
        
            d_in_2_0 = 64'h604100023CDC5698;
            d_in_2_1 = 64'h60210102B88BDBC6;
            d_in_2_2 = 64'h6011020288AF1C02;
            d_in_2_3 = 64'h20010302C27ACAE6;
        
            d_in_3_0 = 64'h404000038FD438B0;
            d_in_3_1 = 64'h4020010386567A9E;
            d_in_3_2 = 64'h401002039CAA875D;
        
            // Assign the same values to addr_x_y, nicEn_x_y, nicEnWR_x_y across all instances
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0} = {4{2'b10}};
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1} = {4{2'b10}};
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2} = {4{2'b10}};
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3} = {4{2'b10}};
        
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0} = {4{1'b1}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1} = {4{1'b1}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2} = {4{1'b1}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3} = {4{1'b1}};
        
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{1'b1}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{1'b1}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{1'b1}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{1'b1}};
            #10;
        end
    endtask
    
    // Empty initial block for stimulus
    initial begin
        $dumpfile("iverilog-out/dump.vcd");
		$dumpvars(0, tb_mesh_top_flat);
        // Add stimulus here
        clk=0;
        reset=1; 
        
        // de-assert system reset but reset CPU->NIC
        #10; reset = 0; 
        reset_all_NIC_CPU_input(
            addr_0_3, addr_1_3, addr_2_3, addr_3_3,
            d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3,
            nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3,
            nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3,
    
            addr_0_2, addr_1_2, addr_2_2, addr_3_2,
            d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2,
            nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2,
            nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2,
    
            addr_0_1, addr_1_1, addr_2_1, addr_3_1,
            d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1,
            nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1,
            nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1,
    
            addr_0_0, addr_1_0, addr_2_0, addr_3_0,
            d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0,
            nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0,
            nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0);
        
        // send 1 packet CPU->NIC->ROUTER 
        //#10; start_gather_0(addr_1_0, d_in_1_0, nicEn_1_0, nicEnWR_1_0);
        
        // Start gather 0 task
        #10; start_phase0_gather(
                addr_0_0, addr_1_0, addr_2_0, addr_3_0,
                d_in_0_0, d_in_1_0, d_in_2_0, d_in_3_0,
                nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0,
                nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0,
        
                addr_0_1, addr_1_1, addr_2_1, addr_3_1,
                d_in_0_1, d_in_1_1, d_in_2_1, d_in_3_1,
                nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1,
                nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1,
        
                addr_0_2, addr_1_2, addr_2_2, addr_3_2,
                d_in_0_2, d_in_1_2, d_in_2_2, d_in_3_2,
                nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2,
                nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2,
        
                addr_0_3, addr_1_3, addr_2_3, addr_3_3,
                d_in_0_3, d_in_1_3, d_in_2_3, d_in_3_3,
                nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3,
                nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3
            );
            #10; disable_write_to_all_nic(
                addr_0_3, addr_1_3, addr_2_3, addr_3_3,
                nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3,
                nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3,
        
                addr_0_2, addr_1_2, addr_2_2, addr_3_2,
                nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2,
                nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2,
        
                addr_0_1, addr_1_1, addr_2_1, addr_3_1,
                nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1,
                nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1,
        
                addr_0_0, addr_1_0, addr_2_0, addr_3_0,
                nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0,
                nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0
            );
        
        
        #300;
        $finish;
    end

endmodule
