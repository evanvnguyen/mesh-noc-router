`timescale 1ns/10ps

module tb_register_file;

  reg clk, reset, writeEnable;
  reg [0:4] rA, rB, rD;
  reg [0:63] rD_data;
  reg [0:2] ppp;
  wire [0:63] rA_data, rB_data;

  integer rf_file, rf_index;
  reg [0:63] line;

  register_file uut(
  .clk(clk),
  .reset(reset),
  .writeEnable(writeEnable),
  .rA_address(rA),
  .rB_address(rB),
  .rD_address(rD),
  .rD_data(rD_data),
  .ppp(ppp),
  .rA_data(rA_data),
  .rB_data(rB_data)
 );

  initial clk = 1;
  always #2 clk = ~clk;

  initial begin
    $monitor("Time=%0t, clk=%b, reset=%b, rA=%b, rB=%b, rD=%b, rD_data=%h, ppp=%b, rA_data=%h, rB_data=%h",
             $time, clk, reset, rA, rB, rD, rD_data, ppp, rA_data, rB_data);
    writeEnable = 0;
    rA = 5'b0;
    rB = 5'b0;
    rD = 5'b0;
    rD_data = 64'b0;
    ppp = 3'b0;

    reset = 1;
    #12
    reset = 0;
    
    rf_file = $fopen("rf_random_values.txt", "r");
    rf_index = 1;
    
    while (! $feof(rf_file)) begin
      writeEnable = 0;
      $fscanf(rf_file, "%h\n", line);
      $display("Read %h", line);
      if (line) begin
        writeEnable = 1;
        rD = rf_index[4:0];
        rD_data = line[0:63];
      end
      #4

      rf_index = rf_index + 1;
    end

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
    #4
    rA = 5'b00100;
    rB = 5'b00110;
    writeEnable = 1;
    rD = 5'b00011;
    rD_data = 64'h00020000000ABCDE;
    #4
    writeEnable = 0;
    #4
    rA = 5'b00100;
    rB = 5'b01010;
    writeEnable = 1;
    rD = 5'b01010;
    rD_data = 64'h00020000000FFFFF;
    #4
    writeEnable = 0;
    #10

    $fclose(rf_file);
    $finish;
   end

endmodule