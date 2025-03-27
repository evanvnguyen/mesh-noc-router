`timescale 1ns/10ps

module tb_instruction_decoder;

  reg  clk, reset, writeEnable;
  // For rf
  reg [0:4] rA, rB, rD;
  reg [0:63] rD_data;
  wire [0:63] rA_data, rB_data;

  // For Id
  reg  [0:31] instruction;
  wire [0:4] rA_address;
  wire [0:4] rB_address;
  wire [0:4] rD_address;
  wire [0:5] alu_operation;
  wire [0:15] immediate_address;
  wire [0:2] ppp;
  wire [0:1] ww;
  wire alu;
  wire sfu;
  wire ld;
  wire sd;
  wire bez;
  wire bnez;
  wire nop;

  integer rf_file, id_file, rf_index, id_index;
  reg [0:63] line;
  reg [0:31] instruc;
  reg [0:64] instruction_register [0:31];
  reg doneLoading;

  register_file rf(clk, reset, writeEnable, rA, rB, rD, rD_data, rA_data, rB_data);
  instruction_decoder id (clk, reset, instruction, rA_address, rB_address, rD_address, alu_operation, immediate_address, ppp, ww, alu, sfu, ld, sd, bez, bnez, nop);

  initial clk = 1;
  always #2 clk = ~clk;

  initial begin
    id_file = $fopen("id_test_cases.txt", "r");
    rf_file = $fopen("rf_random_values.txt", "r");
    rf_index = 1;
    id_index = 0;
    doneLoading = 0;

    reset = 1;
    #8
    reset = 0;
    
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

    while (! $feof(id_file)) begin
      $fscanf(id_file, "%b\n", instruc);
      $display("Read %b", instruc);
      if (instruc) begin
        instruction_register[id_index] = instruc[0:31];
      end

      id_index = id_index + 1;
    end

    id_index = 0;
    
    $fclose(rf_file);
    $fclose(id_file);

    doneLoading = 1;
   end

   always @(posedge clk) begin
    if (!reset && doneLoading) begin
      instruction <= instruction_register[id_index];
      $display("instru=%b, rA=%b, rB=%b, rD=%b, alu_op=%b, imm_addr=%b, ppp=%b, ww=%b, alu=%b, sfu=%b, ld=%b, sd=%b, bez=%b, bnez=%b, nop=%b",
              instruction, rA_address, rB_address, rD_address, alu_operation, immediate_address, ppp, ww, alu, sfu, ld, sd, bez, bnez, nop);
      id_index <= id_index + 1;
    end

    if (id_index >= 25)
      $finish;
   end

endmodule