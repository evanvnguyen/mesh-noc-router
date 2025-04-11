module tb_four_way_arbiter();
  reg reset;
  reg [3:0] requests;
  wire [1:0] granted;

  four_way_arbiter uut (
    .reset(reset),
    .requests(requests),
    .granted(granted)
  );

  initial begin
    $dumpfile("iverilog-out/dump.vcd");
    $dumpvars(0, tb_four_way_arbiter);

    reset = 1;
    requests = 4'b0000;
    #1 reset = 0;
    #1 requests = 4'b0001;
    #1 requests = 4'b0010;
    #1 requests = 4'b0011;
    #1 requests = 4'b0100;
    #1 requests = 4'b0101;
    #1 requests = 4'b0110;
    #1 requests = 4'b0111;
    #1 requests = 4'b1000;
    #1 requests = 4'b1001;
    #1 requests = 4'b1010;
    #1 requests = 4'b1011;
    #1 requests = 4'b1100;
    #1 requests = 4'b1101;
    #1 requests = 4'b1110;
    #1 requests = 4'b1111;
    #1 requests = 4'b0000;
    #1 //reset = 1;
    #1 $finish;
  end


endmodule