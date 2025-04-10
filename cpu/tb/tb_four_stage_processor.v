module tb_four_stage_processor;

  reg clk, reset;
  wire [0:31] inst_in;
  wire [0:63] d_in;
  wire [0:31] pc_out;
  wire [0:63] d_out;
  wire [0:31] addr_out;
  wire memWrEn;
  wire memEn;
  
  integer clock_cycle, i, j, dmem0_dump_file;
  reg [127:0] imem_filename;
  reg [127:0] dump_filename;

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
    //$readmemh("cpu_test_instructions2.txt", instruc_mem.MEM);
    //$readmemh("dmem copy.fill", data_mem.MEM);

    //$readmemh("imem_0.0.fill", instruc_mem.MEM);
    //$readmemh("dmem_0.0.fill", data_mem.MEM);
    
    for (j=1; j < 10; j = j + 1) begin
        reset = 1'b1;
        repeat(5) @(negedge clk); 
        reset = 1'b0;
    
        // Format the filename string: "imem_<j>.fill"
        $sformat(imem_filename, "imem_%0d.fill", j);
    
        // Load instruction and data memory
        $readmemh(imem_filename, instruc_mem.MEM);
        $readmemh("dmem.fill", data_mem.MEM);
    
        wait (inst_in == 32'h00000000);
        $display("The program completed in %d cycles", clock_cycle);
        // Let us now flush the pipe line
        repeat(5) @(negedge clk); 
        // Open file for output
        // Dump data memory to a file
        $sformat(dump_filename, "cmp_test.dmem0_%0d.dump", j);
        dmem0_dump_file = $fopen(dump_filename);// assigning the channel descriptor for output file
    
        // Let us now dump all the locations of the data memory now
        for (i=0; i<128; i=i+1) 
        begin
          $fdisplay(dmem0_dump_file, "Memory location #%d : %h ", i, data_mem.MEM[i]);
        end
        $fclose(dmem0_dump_file);    
    end    
    
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
