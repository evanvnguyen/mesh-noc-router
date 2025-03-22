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
        .cwro(cwro),
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
        .net_si(cwso), // for input channel of nic
        .net_ri(cwro), // for input channel of nic
        .net_di(cwdo), // 64-bit input data --> get from router
        .net_so(pesi),
        .net_ro(peri),
        .net_do(pedi), // 64-bit output data
        .net_polarity(polarity_out));

    always #5 clk = ~clk;
    
    // **** NIC functions **** 
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
    
    task read_data_from_nic_to_cpu;
        output reg [1:0] addr;
        output reg nicEn;
        output reg nicEnWR;
        
        begin
            addr    = 2'b00; // also allows d_in to go into input buffer
            nicEn   = 1'b1; // read data from input buffer and latch to d_out
            nicEnWR = 1'b0;
            #10;
        end
    
    endtask
        
    // Case 0: Task for loading from the Network Input Channel Buffer (read-only, addr 2'b00)
    task load_nic_input_channel_buffer;
        output reg [1:0] addr;
        output reg       nicEn;
        output reg       nicEnWR;
        begin
            addr    = 2'b00;
            nicEn   = 1'b1;
            nicEnWR = 1'b0;  // Load (read) operation
            #10;
        end
    endtask
    
    // Case 1: Task for loading from the Network Input Channel Status Register (read-only, addr 2'b01)
    task load_nic_input_channel_status;
        output reg [1:0] addr;
        output reg       nicEn;
        output reg       nicEnWR;
        begin
            addr    = 2'b01;
            nicEn   = 1'b1;
            nicEnWR = 1'b0;  // Load (read) operation
            #10;
        end
    endtask
    
    // Case 2: Task for storing to the Network Output Channel Buffer (write-only, addr 2'b10)
    task store_nic_output_channel_buffer;
        output reg [63:0] d_in;
        output reg [1:0] addr;
        output reg       nicEn;
        output reg       nicEnWR;
        begin
            d_in    = 64'h40100000ffffffff; // SN -> SN 1 hop
            addr    = 2'b10;
            nicEn   = 1'b1;
            nicEnWR = 1'b1;  // Store (write) operation
            #10;
        end
    endtask
    
    // Case 3: Task for loading from the Network Output Channel Status Register (read-only, addr 2'b11)
    task load_nic_output_channel_status;
        output reg [1:0] addr;
        output reg       nicEn;
        output reg       nicEnWR;
        begin
            addr    = 2'b11;
            nicEn   = 1'b1;
            nicEnWR = 1'b0;  // Load (read) operation
            #10;
        end
    endtask


    // **** End NIC functions **** 
    
    // Test stimulus
    initial begin
        clk=0;
        reset=1; 
        
        // de-assert system reset but reset CPU->NIC
        #10; reset = 0; reset_NIC_CPU_input(addr, d_in, nicEn, nicEnWR); 
        
        // send a packet CPU->NIC->ROUTER 
        #10; send_packet_from_cpu_to_router(addr, d_in, nicEn, nicEnWR); 
        #10; disable_write_to_nic(addr, nicEn, nicEnWR);
        #10; read_data_from_nic_to_cpu(addr, nicEn, nicEnWR);
        #10; load_nic_input_channel_buffer(addr, nicEn, nicEnWR);
        #10; load_nic_input_channel_status(addr, nicEn, nicEnWR);
        #10; store_nic_output_channel_buffer(d_in, addr, nicEn, nicEnWR); // < store new data
        //#10; disable_write_to_nic(addr, nicEn, nicEnWR);
        #10; load_nic_output_channel_status(addr, nicEn, nicEnWR);
        #10; read_data_from_nic_to_cpu(addr, nicEn, nicEnWR);
        
        #100;
        
        $finish;
    end
endmodule
