`timescale 1ps / 1ps

module nic_tb;

// Parameters
parameter PACKET_WIDTH = 64;

// Inputs
reg clk;
reg reset;
reg [0:1] addr;
reg [0:PACKET_WIDTH-1] d_in;
reg nicEn;
reg nicEnWR;
reg net_si;
reg [0:PACKET_WIDTH-1] net_di;
reg net_ro;
reg net_polarity;

// Outputs
wire [0:PACKET_WIDTH-1] d_out;
wire net_ri;
wire net_so;
wire [0:PACKET_WIDTH-1] net_do;

// Instantiate the NIC module
nic #(PACKET_WIDTH) uut (
    .clk(clk),
    .reset(reset),
    .addr(addr),
    .d_in(d_in),
    .d_out(d_out),
    .nicEn(nicEn),
    .nicEnWR(nicEnWR),
    .net_si(net_si),
    .net_ri(net_ri),
    .net_di(net_di),
    .net_so(net_so),
    .net_ro(net_ro),
    .net_do(net_do),
    .net_polarity(net_polarity)
);

// Clock generation (10ns period => 100MHz)
always #5 clk = ~clk;

// Test stimulus
initial begin
    // Initialize inputs
    clk = 0;
    reset = 1;
    addr = 2'b00;
    d_in = 64'b0;
    nicEn = 0;
    nicEnWR = 0;
    net_si = 0;
    net_di = 64'b0;
    net_ro = 0;
    net_polarity = 0;

    // Wait for global reset
    #10;
    reset = 0;
    
    // Wait for the system to stabilize
    #10;
    
    // Simulate sending data from Router --> NIC
    net_di = 64'hA5A5A5A5A5A5A5A5; // Example test data
    net_si = 1;                    // Assert send-in signal
    
    #10;
    // Deassert net_si to simulate end of transmission
    net_si = 0;
    if (net_ri) begin
        $display("NIC is ready to receive data. Sending data: %h", net_di);
    end else begin
        $display("NIC is NOT ready to receive data. Test failed.");
    end

    #10;

    
    // Accept packet into CPU
    nicEnWR = 0;
    nicEn = 0;
    
    // Don't accept packet into d_out
    nicEn = 0;
    
    net_di = 64'h1515151; 
        
    #10; reset=1; // reset to clear input buffer status
    #10; reset=0; net_si = 1;
    #10; net_si = 0;
    
    // Accept packet into d_out 
    #10; nicEn = 1; #10; nicEn = 0;
    #10; addr=2'b10; #10; addr=2'b11;
    
    
    // write your code here
    // Test sending data from NIC to Router (network output channel)
    
    // Step 1: Write a packet to the NIC output buffer
    d_in = 64'hDEADBEEFDEADBEEF; // Example packet data
    nicEn = 1;
    nicEnWR = 1; // Enable writing to output buffer
    #10;
    nicEnWR = 0;
    nicEn = 0;
    
    // Step 2: Simulate router readiness (net_ro) and polarity (net_polarity)
    net_ro = 1;
    net_polarity = 1;
    #10;
    
    // Check if NIC asserts net_so and places data on net_do
    if (net_so && net_do == 64'hDEADBEEFDEADBEEF) begin
        $display("NIC correctly asserted net_so and placed packet on net_do: %h", net_do);
    end else begin
        $display("NIC failed to send data to router. Test failed.");
    end
    
    // Step 3: Simulate router not being ready and check if NIC holds the data
    net_ro = 0; // Router not ready
    net_polarity = 1;
    #10;
    
    if (!net_so) begin
        $display("NIC correctly held the packet as router is not ready (net_so deasserted).");
    end else begin
        $display("NIC incorrectly attempted to send data while router was not ready. Test failed.");
    end
    
    // Step 4: Router becomes ready again, NIC should attempt to send data
    net_ro = 1;
    #10; net_ro = 0;
    
    if (net_so && net_do == 64'hDEADBEEFDEADBEEF) begin
        $display("NIC correctly re-asserted net_so after router became ready. Packet on net_do: %h", net_do);
    end else begin
        $display("NIC failed to re-send data after router became ready. Test failed.");
    end
    
    #50;
    
    // Verify the data in the NIC input buffer (should match net_di)
    if (uut.channel_input_buffer == net_di) begin
        $display("Data correctly written to NIC input buffer: %h", uut.channel_input_buffer);
    end else begin
        $display("Data NOT written correctly. Test failed.");
    end

    // Check input buffer status
    if (uut.channel_input_buffer_status == 1'b1) begin
        $display("Input buffer status is FULL as expected.");
    end else begin
        $display("Input buffer status is NOT FULL. Test failed.");
    end

    // Finish the simulation
    $finish;
end

endmodule
