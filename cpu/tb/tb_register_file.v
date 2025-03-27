`timescale 1ns/10ps

module tb_register_file;

  reg clk, reset, writeEnable;
  reg [4:0] rA, rB, rD;
  reg [63:0] rD_data;
  wire [63:0] rA_data, rB_data;

  register_file uut(clk, reset, writeEnable, rA, rB, rD, rD_data, rA_data, rB_data);

  initial clk = 1;
  always #2 clk = ~clk;

  initial begin
    $monitor("Time=%0t, clk=%b, reset=%b, rA=%b, rB=%b, rD=%b, rD_data=%h, rA_data=%h, rB_data=%h",
             $time, clk, reset, rA, rB, rD, rD_data, rA_data, rB_data);
    writeEnable = 0;
    rA = 5'b0;
    rB = 5'b0;
    rD = 5'b0;
    rD_data = 64'b0;

    reset = 1;
    #12
    reset = 0;

    writeEnable = 1;
    rD = 5'b00001;
    rD_data = 64'h200200000000FA50;
    #4
    writeEnable = 0;
    #4
    writeEnable = 1;
    rD = 5'b00010;
    rD_data = 64'h0002000000006840;
    #4
    writeEnable = 0;
    #10
    rA = 5'b00001;
    rB = 5'b00010;
    #4

    

    $finish;
   end

endmodule