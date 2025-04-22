/*
* This module receives input data, stores it in a virtual channel and outputs it when ready.
* The virtual channel is determined by the polarity input. If the polarity is high, the data is stored in virtual channel 2.
* If the polarity is low, the data is stored in virtual channel 1.
* The module has a blocked input that prevents the module from receiving or sending data on the next clock cycle. The module 
* will fill up both virtual channels before it fully blocks.
*/

module router_input_channel_test (
  input clk,                  // Clock signal
  input reset,                // Synchronous High Reset
  input polarity,             // Dictates with virtual channel we are using. 
  input send,                 // Goes high when receiving data
  input blocked,              // This prevents us from receiving or sending data on the next clock cycle
  input [63:0] data_in,       // The data being received
  output ready,           // Signals we are ready to receive data
  output reg [63:0] data_out  // The data being sent within the router
);

  reg [63:0] virtual_channel_1;
  reg [63:0] virtual_channel_2;

  reg [2:0] vc_1_state, vc_2_state;
  localparam IDLE = 3'b000;
  localparam NEW_PACKET = 3'b001;
  localparam SENDING = 3'b010;
  localparam SEND = 3'b011;
  localparam BLOCKED = 3'b100;

  reg vc_1_ready, vc_2_ready;
  reg vc_1_sent, vc_2_sent;

  // We are ready to receive data if we have space in the virtual channel and we are not blocked.
  // We also check our polarity depending on the virtual channel we are going to be using in the
  // next clock cycle.
  assign ready = (polarity ? vc_1_sent : vc_2_sent) && !blocked;

  always @(*) begin
    if (reset) begin
      virtual_channel_1 = 64'b0;
      virtual_channel_2 = 64'b0;
      vc_1_ready = 1'b0;
      vc_2_ready = 1'b0;
    end else begin
        vc_1_ready = 1'b0;
        vc_2_ready = 1'b0;

        // 0 (even) input goes to vc1. 1 (odd) input goes to vc2
        if (polarity) begin
          // If send is high and we have space in vc2, store data in vc2
          if (send && vc_2_sent && data_in != 64'b0 && data_in != virtual_channel_1) begin
            virtual_channel_2 = data_in;
            vc_2_ready = 1'b1;
          end
        end else begin
          // If send is high and we have space in vc1, store data in vc1
          if (send && vc_1_sent && data_in != 64'b0 && data_in != virtual_channel_2) begin
            virtual_channel_1 = data_in;
            vc_1_ready = 1'b1;
          end
        end

        if (blocked) begin
          if (!polarity && vc_1_sent) begin
            vc_1_ready = 1'b1;
          end else if (polarity && vc_2_sent) begin
            vc_2_ready = 1'b1;
          end
        end
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      vc_1_state = IDLE;
      vc_2_state = IDLE;
    end else begin
      case (vc_1_state)
        IDLE: begin
          if (send && data_in != 64'b0 && data_in != virtual_channel_2) begin
            vc_1_state = NEW_PACKET;
          end else begin
            vc_1_state = IDLE;
          end
        end
        NEW_PACKET: begin
          if (vc_1_ready) begin
            vc_1_state <= SENDING;
          end else begin
            vc_1_state <= IDLE;
          end
        end
        SENDING: begin
          if (send) begin
            vc_1_state <= SEND;
          end else begin
            vc_1_state <= BLOCKED;
          end
        end
        SEND: begin
          if (!send) begin
            vc_1_state <= IDLE;
          end else begin
            vc_1_state <= SENDING;
          end
        end
        BLOCKED: begin
          if (!blocked) begin
            vc_1_state <= IDLE;
          end else begin
            vc_1_state <= BLOCKED;
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      data_out <= 64'b0;
      vc_1_sent <= 1'b0;
      vc_2_sent <= 1'b0;
    end else begin
      data_out <= 64'b0;

      if (!polarity) begin
        // Check if we have data in vc1 and we are not blocked
        if (virtual_channel_1 != 0 && vc_1_ready && !blocked) begin
          data_out <= virtual_channel_1;
          vc_1_sent <= 1'b0;
        end
      end else begin      
        // Check if we have data in vc2 and we are not blocked
        if (virtual_channel_2 != 0 && vc_2_ready && !blocked) begin
          data_out <= virtual_channel_2;
          vc_2_sent <= 1'b0;
        end
      end

      if (!blocked) begin
        if (polarity && !vc_1_sent) begin
          vc_1_sent <= 1'b1;
        end else if (!polarity && !vc_2_sent) begin
          vc_2_sent <= 1'b1;
        end
      end
    end
    
  end

endmodule