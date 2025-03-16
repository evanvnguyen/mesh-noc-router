module nic #(parameter PACKET_WIDTH = 64)(
    input clk, reset, 
    
    // **** Between CPU ****
    
     // Addressing for status reg and channel buffer reg
    input [0:1] addr,
    
    // Packet from CPU --> (NIC) network OUTPUT buffer 
    input [0:PACKET_WIDTH-1] d_in, 
    
    // Packet from Router --> (NIC)  stored in network INPUT buffer 
    output reg [0:PACKET_WIDTH-1] d_out, 
    
    // Enable signal to NIC. if !nicEn, d_out port = 0
    input nicEn, 
    
    // Write enable signal to the NIC. if nicEnWR + nicEn , d_in data assigned to network OUTPUT buffer
    input nicEnWR, 

    // **** Between Router ****
    
    // NIC <-- Send handshake signal-in for network input channel
    input net_si, 
    
    // Ready shandhsake signal-in for network input channel --> Router
    output reg net_ri, 
    
    // Packet data from router --> (NIC) stored innetwork INPUT buffer
    input [0:PACKET_WIDTH-1] net_di, 

    // Send handshaking signal-out for the network output channel --> Router
    output reg net_so, 
    
    //Ready handshaking signal for the network output channel
    input net_ro, 
    
     //Packet data for the network output channel
    output reg [0:PACKET_WIDTH-1] net_do,
    
    //Polarity input from the router connected to the NIC
    input net_polarity 
);

// router handshake

    // GET DATA FROM ROUTER --> NIC
    //1. check to see if buffer is empty
    //1. set ready signal
    //  - assert net_ri = 1
    //  - if input buffer is empty
    //2. assert net_si = 1 once router asserts pe_so = 1
    //3. check to see if in buff is empty
    reg [PACKET_WIDTH-1:0] channel_input_buffer;
    reg [PACKET_WIDTH-1:0] channel_output_buffer;
    reg channel_input_buffer_status;   
    reg channel_output_buffer_status;
    
    always @(*) begin
        // assert buffer status if full or empty
        channel_input_buffer_status = (channel_input_buffer == 64'b0) ? 1'b0 : 1'b1;
        channel_output_buffer_status = (channel_output_buffer == 64'b0) ? 1'b0 : 1'b1;

        // if input buf status = 1(full), don't accept data
        if (channel_input_buffer_status) begin
            net_ri = 0;
        end else begin // if = 0(empty), so accept data
            net_ri = 1;        
        end
        
    end
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all buffers and statuses
            channel_input_buffer <= 0;
            channel_input_buffer_status <= 0;
            channel_output_buffer <= 0;
            channel_output_buffer_status <= 0;
            d_out <= 0;
        end else begin
            // Handle data reception from router to NIC input buffer
            // 
            // nic_ri = 1, input buffer empty
            // net_si = 1
            if (net_ri && net_si) begin
                channel_input_buffer <= net_di;
                channel_input_buffer_status <= 1;
            end
            
            // send data from router to processor
            // nicEn == 1
            // nicEnWR == 0
            // addr == 2'b00 for channel input reg
            if (nicEn && !nicEnWR && addr == 2'b00) begin
                d_out <= channel_input_buffer;
            end else if (addr == 2'b01) begin // read input channel status register
                d_out <= {62'b0, channel_input_buffer_status};
            end else if (addr == 2'b11) begin // read output channel status register
                d_out <= {62'b0, channel_output_buffer_status};
            end
        end
    end
    
    // Network Output Channel Logic
    
    // 1. if nicEnWR && nicEn, place data into output buffer
    // 2. check if buffer is full && net_ro && net_polarity , yes then send
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            net_so <= 0;
            net_do <= 0;
        end else begin
            if (nicEnWR && nicEn) begin
                channel_output_buffer <= d_in;
            end
            // Check if there is a packet in the output buffer and router is ready
            if (channel_output_buffer_status && net_ro && net_polarity) begin
                // Assert net_so to signal that data is ready to be sent
                net_do <= channel_output_buffer; // Place packet on output channel
                net_so <= 1;
            end else begin
                // If router is not ready, keep net_so low and retain data
                net_so <= 0;
            end
        end
    end

endmodule