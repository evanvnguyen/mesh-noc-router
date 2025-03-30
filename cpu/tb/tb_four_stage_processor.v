module tb_four_stage_processor;

  reg clk, reset;
  wire [0:31] inst_in;
  wire [0:63] d_in;
  wire [0:31] pc_out;
  wire [0:63] d_out;
  wire [0:31] addr_out;
  wire memWrEn;
  wire memEn;
  
  integer clock_cycle;

  imem instruc_mem(
    .memAddr(pc_out),
    .dataOut(inst_in)
  );

  dmem data_mem(
    .clk(clk),
    .memEn(memEn),
    .memWrEn(memWrEn),
    .memAddr(addr_out),
    .dataIn(d_out),
    .dataOut(d_in)
  );

  four_stage_processor uut(
    .clk(clk),
    .reset(reset),
    .inst_in(inst_in),
    .d_in(d_in),
    .pc_out(pc_out),
    .d_out(d_out),
    .addr_out(addr_out),
    .memWrEn(memWrEn),
    .memEn(memEn)
  );

  initial clk = 0;
  always #2 clk <= ~clk;

  initial begin
    clock_cycle = 0;

    reset = 1'b1;
    #8
    reset = 1'b0;
    $readmemh("rf_random_values.txt", uut.rf.registerFile);
    $readmemh("cpu_test_instructions2.txt", instruc_mem.MEM);
    $readmemh("dmem.fill", data_mem.MEM);
  end
  
  always @(posedge clk) begin
    if (!reset) begin        
       clock_cycle <= clock_cycle + 1;
       
       if (clock_cycle >= 30) 
        $finish;
    end
  end

endmodule
