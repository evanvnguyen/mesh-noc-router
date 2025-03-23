/*
* This module is responsible for managing the output channel of the router.
* It receives data from the virtual channels and sends it to the output port if 
* the receiver is ready to accept it. It also keeps track of the blocked state
* of the virtual channels. If blocked is high, we do not have space in the 
* virtual channel to accept new data.
*/


module router_output_channel (
  input clk,                  // Clock signal
  input reset,                // Reset signal
  input polarity,             // Polarity of the output channel
  input ready,                // Is the receiver ready to accept data?
  input [63:0] data_in,       // Data from an input channel
  output reg blocked,         // Is the virtual channel blocked?
  output reg send,            // Are we sending data to the output port?
  output reg [63:0] data_out  // Data to be sent to the output port
);

  reg [63:0] virtual_channel_1;
  reg [63:0] virtual_channel_2;
  reg vc_1_sent, vc_2_sent;

  always @(*) begin
    if (reset) begin
      virtual_channel_1 = 64'b0;
      virtual_channel_2 = 64'b0;
    end else begin
      virtual_channel_1 = virtual_channel_1;
      virtual_channel_2 = virtual_channel_2;
    
      // High polarity means that the virtual channel 1 is the input channel
      // Low polarity means that the virtual channel 2 is the input channel
      if (polarity) begin
        // If the virtual channel is empty, we can accept new data
        if (vc_1_sent || virtual_channel_1 == 64'b0)
          virtual_channel_1 = data_in;
      end else begin
        if (vc_2_sent || virtual_channel_2 == 64'b0)
          virtual_channel_2 = data_in;
      end

            // If the virtual channel is not empty and the receiver is not ready, we are blocked
      // and we cannot accept new data.
      blocked = (virtual_channel_1 != 0 || virtual_channel_2 != 0) && !ready;
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      send = 1'b0;
      data_out = 64'b0;
      vc_1_sent = 1'b1;
      vc_2_sent = 1'b1;
    end else begin
      send = 1'b0;
      data_out = 64'b0;
      vc_1_sent = 1'b0;
      vc_2_sent = 1'b0;

      // High polarity means that the virtual channel 2 is the output channel
      // Low polarity means that the virtual channel 1 is the output channel
      if (!polarity) begin
        // Are we ready to receive data?
        if (ready && virtual_channel_2 != 0) begin
          data_out <= virtual_channel_2;
          send <= 1'b1;

          // Reset the virtual channel. We sent the data so we have space for new data.
          vc_2_sent <= 1'b1;
        end
      end else begin
        // Are we ready to receive data?
        if (ready && virtual_channel_1 != 0) begin
          data_out <= virtual_channel_1;
          send <= 1'b1;

          // Reset the virtual channel. We sent the data so we have space for new data.
          vc_1_sent <= 1'b1;
        end
      end
    end 
  end
  
endmodule