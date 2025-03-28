module program_counter (
  input clk,
  input reset,
  output reg [0:31] pc_out
);

  always @(posedge clk) begin
    if (reset)
      pc_out <= 64'b0;
    else 
      pc_out <= pc_out + 4;
  end

endmodule