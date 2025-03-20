`timescale 1ps / 1ps


module tb_nic_router();

    localparam PACKET_WIDTH=64;
    
    // Router wires
    reg clk, reset;
    wire cwsi, ccwsi, nssi, snsi, nsro, snro;
    wire cwro, ccwro, nsri, snri;
    wire [3:0] router_position;
    wire cwri, ccwri, nsso, snso, polarity_out;
    wire [63:0] cwdi, ccwdi, nsdi, sndi;
    
    // PE signals as **wires**
    wire pesi, pero, peso, peri;
    wire [63:0] pedi, pedo;
    
    // Output signals
    wire cwso, ccwso;
    wire [63:0] cwdo, ccwdo;
    wire [63:0] nsdo, sndo;
  
  
    router router_0(.clk(clk),
        .reset(reset),
        .router_position(router_position),
        
        .cwsi(cwsi),
        .cwdi(cwdi),
        .cwri(cwri),
        .ccwsi(ccwsi),
        .ccwdi(ccwdi),
        .ccwri(ccwri),
        .cwro(1'b1),
        .cwso(cwso),
        .cwdo(cwdo),
        .ccwro(ccwro),
        .ccwso(ccwso),
        .ccwdo(ccwdo),
        .nssi(nssi),
        .nsdi(nsdi),
        .nsri(nsri),
        .snsi(snsi),
        .sndi(sndi),
        .snri(snri),
        .nsro(nsro),
        .nsso(nsso),
        .nsdo(nsdo),
        .snro(snro),
        .snso(snso),
        .sndo(sndo),
        
         // To NIC
        .polarity_out(polarity_out),
        .pero(pero),
        .peso(peso),
        .pedo(pedo), // 64-bit output data
        .pesi(pesi),
        .pedi(pedi), // 64-bit input data
        .peri(peri));

    // NIC wires
    reg [0:1] addr;
    reg [0:PACKET_WIDTH-1] d_in;
    reg nicEn;
    reg nicEnWR;
    reg [0:PACKET_WIDTH-1] net_di;
    
    wire [0:PACKET_WIDTH-1] d_out;
    //wire [0:PACKET_WIDTH-1] net_do;

    nic #(PACKET_WIDTH) nic_0 (
        .clk(clk),
        .reset(reset),
        
        // From CPU
        .addr(addr),
        .d_in(d_in),
        .d_out(d_out),
        .nicEn(nicEn),
        .nicEnWR(nicEnWR),
        
         // To Router
        .net_si(peso),
        .net_ri(pero),
        .net_di(pedo), // 64-bit input data
        .net_so(pesi),
        .net_ro(peri),
        .net_do(pedi), // 64-bit output data
        .net_polarity(polarity_out));

    always #5 clk = ~clk;
    
    task reset_NIC_CPU_input;
        output reg [0:1] addr;
        output reg [0:PACKET_WIDTH-1] d_in;
        output reg nicEn;
        output reg nicEnWR;
    
        begin
            addr = 2'b00;
            d_in = {PACKET_WIDTH{1'b0}};
            nicEn = 0;
            nicEnWR = 0;
        end
    endtask
    
    task disable_write_to_nic;
        output reg [0:1] addr;
        output reg nicEn;
        output reg nicEnWR;
    
        begin
            // Step 1: Write a packet to the NIC output buffer
            addr = 2'b00;
            nicEn = 0;
            nicEnWR = 0; // Enable writing to output buffer
            #10;
        end
    endtask
    
    task send_packet_from_cpu_to_router;
        output reg [0:1] addr;
        output reg [0:PACKET_WIDTH-1] d_in;
        output reg nicEn;
        output reg nicEnWR;
    
        begin
            // Step 1: Write a packet to the NIC output buffer
            d_in = 64'h200200000000FA50; // Example packet data
            addr = 2'b10;
            nicEn = 1;
            nicEnWR = 1; // Enable writing to output buffer
            #10;
        end
    endtask

    
    // Test stimulus
    initial begin
        clk=0;
        reset=1; 
        
        // de-assert system reset but reset CPU->NIC
        #10; reset = 0; reset_NIC_CPU_input(addr, d_in, nicEn, nicEnWR); 
        
        // send a packet CPU->NIC->ROUTER 
        #10; send_packet_from_cpu_to_router(addr, d_in, nicEn, nicEnWR); 
        #10; disable_write_to_nic(addr, nicEn, nicEnWR);
        
        #100;
        
        $finish;
    end
endmodule
