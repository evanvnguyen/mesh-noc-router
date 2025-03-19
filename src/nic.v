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

    // Internal Buffers and Status Registers
    reg [PACKET_WIDTH-1:0] channel_input_buffer;
    reg [PACKET_WIDTH-1:0] channel_output_buffer;
    reg channel_input_buffer_status;   
    reg channel_output_buffer_status;
    
    // debug
    always @(posedge clk) begin
        if (net_ro && net_polarity) $display("NIC: net_ro=1 & polarity OK. Router input buffer is empty & ready. Placing data onto network output channel.");
        if (net_ri) $display("NIC: net_ri=1, we have space for incoming data.");
    end

    
    // router handhsake
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            channel_input_buffer <= 0;
            channel_output_buffer <= 0;
            channel_input_buffer_status <= 0;
            channel_output_buffer_status <= 0;
            d_out <= 0;
            net_ri <= 1;    // Ready to accept data after reset
            net_so <= 0;
            net_do <= 0;
        end else begin
            // Write to Output Buffer (if nicEnWR, nicEn, addr to output buffer, output buffer is empty)
            if (nicEnWR && nicEn && addr == 2'b10 && !channel_output_buffer_status) begin
                channel_output_buffer <= d_in;
            end
    
            // Receive Data from Router into Input Buffer (only if ready and valid)
            if (net_ri && net_si) begin
                channel_input_buffer <= net_di;
            end
            
            // Update Status Registers (0-empty, 1-full)
            channel_input_buffer_status <= (channel_input_buffer == 0) ? 1'b0 : 1'b1;
            channel_output_buffer_status <= (channel_output_buffer == 0) ? 1'b0 : 1'b1;
            
            // Update net_ri based on input buffer status
            net_ri <= (channel_input_buffer_status == 0) ? 1'b1 : 1'b0;
    
            // Send data to router (if router ready, polarity ok, buffer is full)
            if (channel_output_buffer_status && net_ro && net_polarity) begin
                net_do <= channel_output_buffer;
                net_so <= 1;
            end else begin
                net_so <= 0;
            end
    
            // Processor Read Logic
            if (nicEn && !nicEnWR) begin
                case (addr)
                    2'b00: d_out <= channel_input_buffer;                             // Read input buffer
                    2'b01: d_out <= {62'b0, channel_input_buffer_status};             // Read input status
                    2'b10: d_out <= 64'b0;                                            // Invalid read from output buffer
                    2'b11: d_out <= {62'b0, channel_output_buffer_status};            // Read output status
                    default: d_out <= 64'b0;
                endcase
            end
        end
    end

endmodule
