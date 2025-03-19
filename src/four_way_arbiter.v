/*
* This is a simple 4-way arbiter module that arbitrates between 4 request inputs.
* The arbiter grants requests in a round-robin fashion.
* The arbiter has a reset input that resets the granted output to 0.
*/

module four_way_arbiter (
  input reset,
  input [3:0] requests,  // 4 request inputs
  input [3:0] blockedRequests,
  output reg [1:0] granted // 4-bit granted output 
);

  reg [1:0] last_granted;  // Tracks last granted request

  always @(*) begin
    if (reset) begin
      granted = 2'b00;
      last_granted = 2'b00;
    end else begin
      case (last_granted)
        2'b00: begin
          if (requests[1] && !blockedRequests[1]) begin granted = 2'b01; last_granted = 2'b01; end
          else if (requests[2] && !blockedRequests[2]) begin granted = 2'b10; last_granted = 2'b10; end
          else if (requests[3] && !blockedRequests[3]) begin granted = 2'b11; last_granted = 2'b11; end
          else if (requests[0] && !blockedRequests[0]) begin granted = 2'b00; last_granted = 2'b00; end
        end
        2'b01: begin
          if (requests[2] && !blockedRequests[2]) begin granted = 2'b10; last_granted = 2'b10; end
          else if (requests[3] && !blockedRequests[3]) begin granted = 2'b11; last_granted = 2'b11; end
          else if (requests[0] && !blockedRequests[0]) begin granted = 2'b00; last_granted = 2'b00; end
          else if (requests[1] && !blockedRequests[1]) begin granted = 2'b01; last_granted = 2'b01; end
        end
        2'b10: begin
          if (requests[3] && !blockedRequests[3]) begin granted = 2'b11; last_granted = 2'b11; end
          else if (requests[0] && !blockedRequests[0]) begin granted = 2'b00; last_granted = 2'b00; end
          else if (requests[1] && !blockedRequests[1]) begin granted = 2'b01; last_granted = 2'b01; end
          else if (requests[2] && !blockedRequests[2]) begin granted = 2'b10; last_granted = 2'b10; end
        end
        2'b11: begin
          if (requests[0] && !blockedRequests[0]) begin granted = 2'b00; last_granted = 2'b00; end
          else if (requests[1] && !blockedRequests[1]) begin granted = 2'b01; last_granted = 2'b01; end
          else if (requests[2] && !blockedRequests[2]) begin granted = 2'b10; last_granted = 2'b10; end
          else if (requests[3] && !blockedRequests[3]) begin granted = 2'b11; last_granted = 2'b11; end
        end
      endcase
    end
  end

endmodule
