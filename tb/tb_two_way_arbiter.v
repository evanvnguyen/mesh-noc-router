module tb_two_way_arbiter ();
  reg clk;
  reg reset;
  reg [1:0] requests;
  wire granted;

  two_way_arbiter uut (
    .reset(reset),
    .requests(requests),
    .granted(granted)
  );

  initial clk = 0;
  always #0.5 clk = ~clk;

  initial begin
    $dumpfile("iverilog-out/dump.vcd");
    $dumpvars(0, tb_two_way_arbiter);

    reset = 1;
    requests = 2'b00;
    #1 reset = 0;
    #1 requests = 2'b01;
    #1 requests = 2'b10;
    #1 requests = 2'b11;
    #3 requests = 2'b01;
    #1 requests = 2'b10;
    #1 requests = 2'b00;
    #1 //reset = 1;
    #1 $finish;
  end

endmodule