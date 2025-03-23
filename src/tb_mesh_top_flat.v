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
        begin
            zero_val = 1'b0; // Set zero value to 0
    
            // Row 3
            {addr_0_3, addr_1_3, addr_2_3, addr_3_3}       = {4{2'b00}};
            {nicEn_0_3, nicEn_1_3, nicEn_2_3, nicEn_3_3}   = {4{zero_val}};
            {nicEnWR_0_3, nicEnWR_1_3, nicEnWR_2_3, nicEnWR_3_3} = {4{zero_val}};
    
            // Row 2
            {addr_0_2, addr_1_2, addr_2_2, addr_3_2}       = {4{2'b00}};
            {nicEn_0_2, nicEn_1_2, nicEn_2_2, nicEn_3_2}   = {4{zero_val}};
            {nicEnWR_0_2, nicEnWR_1_2, nicEnWR_2_2, nicEnWR_3_2} = {4{zero_val}};
    
            // Row 1
            {addr_0_1, addr_1_1, addr_2_1, addr_3_1}       = {4{2'b00}};
            {nicEn_0_1, nicEn_1_1, nicEn_2_1, nicEn_3_1}   = {4{zero_val}};
            {nicEnWR_0_1, nicEnWR_1_1, nicEnWR_2_1, nicEnWR_3_1} = {4{zero_val}};
    
            // Row 0
            {addr_0_0, addr_1_0, addr_2_0, addr_3_0}       = {4{2'b00}};
            {nicEn_0_0, nicEn_1_0, nicEn_2_0, nicEn_3_0}   = {4{zero_val}};
            {nicEnWR_0_0, nicEnWR_1_0, nicEnWR_2_0, nicEnWR_3_0} = {4{zero_val}};
    
            #10;
        end
    endtask
    
    task send_packet_from_cpu_0_0_to_router;
        output reg [0:1] addr_1_0;
        output reg [0:PACKET_WIDTH-1] d_in_1_0;
        output reg nicEn_1_0;
        output reg nicEnWR_1_0;
    
        // SN:   64'h2002000066637D91, (0, 0), (0, 1)
        begin
            // Step 1: Write a packet to the NIC output buffer
            d_in_1_0 = 64'h2002000066637D91; // Example packet data
            addr_1_0 = 2'b10;
            nicEn_1_0 = 1;
            nicEnWR_1_0 = 1; // Enable writing to output buffer
            #10;
        end
    endtask
    
    // Empty initial block for stimulus
    initial begin
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
        #10; send_packet_from_cpu_0_0_to_router(addr_1_0, d_in_1_0, nicEn_1_0, nicEnWR_1_0);
        #200;
        $finish;
    end

endmodule
