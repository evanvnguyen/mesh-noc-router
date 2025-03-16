/*
* This is a two way arbiter module that arbitrates between two requests. The arbiter will grant one of the requests based on the following priority:
* 1. If only one request is active, that request will be granted.
* 2. If both requests are active, the arbiter will grant the request that was not granted in the previous cycle. This is to ensure round-robin fairness.
* 3. If no requests are active, granted will be 0.
* The arbiter has a reset input that will reset the granted request to 0.
* Granted: will be 0 or 1 depending on which input is granted. This will correlate to the index of the requests array.
*/

module two_way_arbiter (
  input reset,
  input [1:0] requests,
  output reg granted
);
  
  reg last_granted;  // Tracks last granted request for round-robin fairness

  always @(*) begin
    if (reset) begin
      granted = 0;
      last_granted = 0;
    end else begin
      case (requests) 
        2'b10: begin
          granted = 1;
          last_granted = 1;
        end
        2'b01: begin
          granted = 0;
          last_granted = 0;
        end
        2'b11: begin  // Both requests active
          if (last_granted == 0) begin
            granted = 1;
            last_granted = 1;
          end else begin
            granted = 0;
            last_granted = 0;
          end
        end
        default: begin
          granted = 0;
        end
      endcase
    end
  end

endmodule
