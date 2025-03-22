/*
* This module receives input data, stores it in a virtual channel and outputs it when ready.
* The virtual channel is determined by the polarity input. If the polarity is high, the data is stored in virtual channel 2.
* If the polarity is low, the data is stored in virtual channel 1.
* The module has a blocked input that prevents the module from receiving or sending data on the next clock cycle. The module 
* will fill up both virtual channels before it fully blocks.
*/

module router_input_channel (
  input clk,                  // Clock signal
  input reset,                // Synchronous High Reset
  input polarity,             // Dictates with virtual channel we are using. 
  input send,                 // Goes high when receiving data
  input blocked,              // This prevents us from receiving or sending data on the next clock cycle
  input [63:0] data_in,       // The data being received
  output reg ready,           // Signals we are ready to receive data
  output reg [63:0] data_out  // The data being sent within the router
);

  reg [63:0] virtual_channel_1;
  reg [63:0] virtual_channel_2;
  reg vc_1_read, vc_2_read;

  always @(*) begin
    if (reset) begin
      virtual_channel_1 = 64'b0;
      virtual_channel_2 = 64'b0;
    end else begin
        // 0 (even) input goes to vc1. 1 (odd) input goes to vc2
        if (polarity) begin
          // If send is high and we have space in vc2, store data in vc2
          if (send && vc_2_read && !blocked) begin
            virtual_channel_2 = data_in;
            vc_2_read = 0;
          end
        end else begin
          // If send is high and we have space in vc1, store data in vc1
          if (send && vc_1_read && !blocked) begin
            virtual_channel_1 = data_in;
            vc_1_read = 0;
          end
        end

      if (blocked && vc_1_read)
        vc_1_read <= 1'b0;
      if (blocked && vc_2_read) 
        vc_2_read <= 1'b0;

        // We are ready to receive data if we have space in the virtual channel and we are not blocked.
        // We also check our polarity depending on the virtual channel we are going to be using in the
        // next clock cycle.
        ready = ((vc_1_read && polarity) || (vc_2_read && !polarity)) && !blocked;
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      ready <= 1'b1;
      data_out <= 64'b0;
      vc_1_read <= 1'b1;
      vc_2_read <= 1'b1;
    end else begin
      data_out <= 64'b0;

      if (!polarity) begin
        // Check if we have data in vc1 and we are not blocked
        if (virtual_channel_1 != 0 && !vc_1_read) begin
          data_out <= virtual_channel_1;
          vc_1_read <= 1'b1;
        end
      end else begin      
        // Check if we have data in vc2 and we are not blocked
        if (virtual_channel_2 != 0 && !vc_2_read) begin
          data_out <= virtual_channel_2;
          vc_2_read <= 1'b1;
        end
      end
    end
  end

endmodule