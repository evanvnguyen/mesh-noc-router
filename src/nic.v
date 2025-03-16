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
            // nic_ri = 1, input buffer empty
            // net_si = 1
            if (net_ri && net_si) begin
                channel_input_buffer <= net_di;
                channel_input_buffer_status <= 1;
            end
            
            // - for load/store 
            // send data from router to processor
            if (nicEn && !nicEnWR) begin
                case (addr)
                    2'b00: d_out <= channel_input_buffer;                   // Read channel buffer data
                    2'b01: d_out <= {62'b0, channel_input_buffer_status};   // Read input channel status register
                    2'b10: d_out <= channel_output_buffer;                  // Read channel buffer data
                    2'b11: d_out <= {62'b0, channel_output_buffer_status};  // Read output channel status register
                    default: d_out <= 0;
                endcase
            end
        end
    end
    
    // Network Output Channel Logic
    // 1. If nicEn and nicWrEN are both high
    // and addr[0:1] specifies the network output channel buffer, the packet on the d_in port is written to the output
    // channel buffer
    // 2. check if buffer is full && net_ro && net_polarity , yes then send
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            net_so <= 0;
            net_do <= 0;
            net_ri <= 1;
        end else begin
            // Write to output buffer
            if (nicEnWR && nicEn && addr == 2'b10) begin
                channel_output_buffer <= d_in;
            end
    
            // Check if there is a packet in the output buffer and router is ready
            if (channel_output_buffer_status && net_ro && net_polarity) begin
                net_do <= channel_output_buffer; // Place packet on output channel
                net_so <= 1;                     // Signal that data is ready to be sent
            end else begin
                net_so <= 0;                     // Keep signal low if router isn't ready
            end
        end
    end
endmodule