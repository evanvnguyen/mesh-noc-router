module program_counter (
  input clk,
  input reset,
  input stall,
  input branch,
  input [0:31] branch_address,
  output reg [0:31] pc_out
);

  always @(posedge clk) begin
    if (reset)
      pc_out <= 64'b0;
    else 
      if (!stall) begin
        if (branch)
          pc_out <= branch_address;
        else
          pc_out <= pc_out + 1;

      end
  end

endmodule