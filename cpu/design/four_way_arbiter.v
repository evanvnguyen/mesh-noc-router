/*
* This is a simple 4-way arbiter module that arbitrates between 4 request inputs.
* The arbiter grants requests in a round-robin fashion.
* The arbiter has a reset input that resets the granted output to 0.
*/

// 0000
// 0001
// 0010
// 0100
// 1000

module four_way_arbiter (
  input reset,
  input [3:0] requests,  // 4 request inputs
  input [3:0] blockedRequests,
  input output_channel_blocked,
  output reg [2:0] granted // 4-bit granted output 
);

  reg [2:0] last_granted;  // Tracks last granted request

  always @(*) begin
    if (reset) begin
      granted = 3'b000;
      last_granted = 3'b000;
    end else begin
      if (output_channel_blocked) begin
        granted = {1'b1, last_granted[1:0]};
        last_granted = {1'b1, last_granted[1:0]};
      end else begin
        granted[2] = 1'b0;
        last_granted[2] = 1'b0;
        case (last_granted[1:0])
              2'b00: begin
                if (requests[1] && !blockedRequests[1]) begin granted = 3'b001; last_granted = 3'b001; end
                else if (requests[2] && !blockedRequests[2]) begin granted = 3'b010; last_granted = 3'b010; end
                else if (requests[3] && !blockedRequests[3]) begin granted = 3'b011; last_granted = 3'b011; end
                else if (requests[0] && !blockedRequests[0]) begin granted = 3'b000; last_granted = 3'b000; end
              end
              2'b01: begin
                if (requests[2] && !blockedRequests[2]) begin granted = 3'b010; last_granted = 3'b010; end
                else if (requests[3] && !blockedRequests[3]) begin granted = 3'b011; last_granted = 3'b011; end
                else if (requests[0] && !blockedRequests[0]) begin granted = 3'b000; last_granted = 3'b000; end
                else if (requests[1] && !blockedRequests[1]) begin granted = 3'b001; last_granted = 3'b001; end
              end
              2'b10: begin
                if (requests[3] && !blockedRequests[3]) begin granted = 3'b011; last_granted = 3'b011; end
                else if (requests[0] && !blockedRequests[0]) begin granted = 3'b000; last_granted = 3'b000; end
                else if (requests[1] && !blockedRequests[1]) begin granted = 3'b001; last_granted = 3'b001; end
                else if (requests[2] && !blockedRequests[2]) begin granted = 3'b010; last_granted = 3'b010; end
              end
              2'b11: begin
                if (requests[0] && !blockedRequests[0]) begin granted = 3'b000; last_granted = 3'b000; end
                else if (requests[1] && !blockedRequests[1]) begin granted = 3'b001; last_granted = 3'b001; end
                else if (requests[2] && !blockedRequests[2]) begin granted = 3'b010; last_granted = 3'b010; end
                else if (requests[3] && !blockedRequests[3]) begin granted = 3'b011; last_granted = 3'b011; end
              end
            endcase
      end
     
    end
  end

endmodule
