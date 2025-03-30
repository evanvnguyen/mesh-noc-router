module program_counter (
  input clk,
  input reset,
  input stall,
  output reg [0:31] pc_out
);

  always @(posedge clk) begin
    if (reset)
      pc_out <= 64'b0;
    else 
      if (!stall)
        pc_out <= pc_out + 1;
  end

endmodule