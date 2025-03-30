module tb_four_stage_processor;

  reg clk, reset;
  wire [0:31] inst_in;
  wire [0:63] d_in;
  wire [0:31] pc_out;
  wire [0:63] d_out;
  wire [0:31] addr_out;
  wire memWrEn;
  wire memEn;
  
  integer clock_cycle, i, dmem0_dump_file;

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
    repeat(5) @(negedge clk); 
    reset = 1'b0;

    $readmemh("imem_1.fill", instruc_mem.MEM);
    $readmemh("dmem.fill", data_mem.MEM);

    wait (inst_in == 32'h00000000);
    $display("The program completed in %d cycles", clock_cycle);
    // Let us now flush the pipe line
    repeat(5) @(negedge clk); 
    // Open file for output
    dmem0_dump_file = $fopen("cmp_test.dmem0.dump"); // assigning the channel descriptor for output file

    // Let us now dump all the locations of the data memory now
    for (i=0; i<128; i=i+1) 
    begin
      $fdisplay(dmem0_dump_file, "Memory location #%d : %h ", i, data_mem.MEM[i]);
    end
    $fclose(dmem0_dump_file);
    $finish;
    //
    //$readmemh("rf_random_values.txt", uut.rf.registerFile);
    //$readmemh("cpu_test_instructions2.txt", instruc_mem.MEM);
    //$readmemh("dmem.fill", data_mem.MEM);
  end
  
  always @(posedge clk) begin
    if (reset)
       clock_cycle <= 0;
    else  
       clock_cycle <= clock_cycle + 1;
  end

endmodule
