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
    
    // data recieved for 1 cycle
    #10; nicEn = 1; net_si = 0; #20; reset = 1; #10; reset = 0;
    
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
    addr=2'b10;
    nicEn = 1;
    nicEnWR = 1; // Enable writing to output buffer
    #10;
    nicEnWR = 0;
    nicEn = 0;
    
    // Step 2: Simulate router readiness (net_ro) and polarity (net_polarity)
    net_ro = 1;
    net_polarity = 1;
    #10;#10;


    // Finish the simulation
    $finish;
end

endmodule
