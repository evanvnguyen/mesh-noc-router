`timescale 1ns/10ps

module tb_full_mesh_w_cpus;

  reg clk, reset;

  wire [0:31] cpu_inst_in_0_3, cpu_inst_in_1_3, cpu_inst_in_2_3, cpu_inst_in_3_3;          // from imem
  wire [0:63] cpu_d_in_0_3, cpu_d_in_1_3, cpu_d_in_2_3, cpu_d_in_3_3;                      // data input from dmem
  wire [0:31] cpu_pc_out_0_3, cpu_pc_out_1_3, cpu_pc_out_2_3, cpu_pc_out_3_3;               // program counter out
  wire [0:63] cpu_d_out_0_3, cpu_d_out_1_3, cpu_d_out_2_3, cpu_d_out_3_3;               // data output to data memory
  wire [0:31] cpu_addr_out_0_3, cpu_addr_out_1_3, cpu_addr_out_2_3, cpu_addr_out_3_3;    // data memory address
  wire cpu_memWrEn_0_3, cpu_memWrEn_1_3, cpu_memWrEn_2_3, cpu_memWrEn_3_3;              // data memory write enable
  wire cpu_memEn_0_3, cpu_memEn_1_3, cpu_memEn_2_3, cpu_memEn_3_3;                      // data memory enable

  // CPU signals for x_2
  wire [0:31] cpu_inst_in_0_2, cpu_inst_in_1_2, cpu_inst_in_2_2, cpu_inst_in_3_2;          // from imem
  wire [0:63] cpu_d_in_0_2, cpu_d_in_1_2, cpu_d_in_2_2, cpu_d_in_3_2;                      // data input from dmem
  wire [0:31] cpu_pc_out_0_2, cpu_pc_out_1_2, cpu_pc_out_2_2, cpu_pc_out_3_2;               // program counter out
  wire [0:63] cpu_d_out_0_2, cpu_d_out_1_2, cpu_d_out_2_2, cpu_d_out_3_2;               // data output to data memory
  wire [0:31] cpu_addr_out_0_2, cpu_addr_out_1_2, cpu_addr_out_2_2, cpu_addr_out_3_2;    // data memory address
  wire cpu_memWrEn_0_2, cpu_memWrEn_1_2, cpu_memWrEn_2_2, cpu_memWrEn_3_2;              // data memory write enable
  wire cpu_memEn_0_2, cpu_memEn_1_2, cpu_memEn_2_2, cpu_memEn_3_2;                      // data memory enable
  
  // CPU signals for x_1
  wire [0:31] cpu_inst_in_0_1, cpu_inst_in_1_1, cpu_inst_in_2_1, cpu_inst_in_3_1;          // from imem
  wire [0:63] cpu_d_in_0_1, cpu_d_in_1_1, cpu_d_in_2_1, cpu_d_in_3_1;                      // data input from dmem
  wire [0:31] cpu_pc_out_0_1, cpu_pc_out_1_1, cpu_pc_out_2_1, cpu_pc_out_3_1;               // program counter out
  wire [0:63] cpu_d_out_0_1, cpu_d_out_1_1, cpu_d_out_2_1, cpu_d_out_3_1;               // data output to data memory
  wire [0:31] cpu_addr_out_0_1, cpu_addr_out_1_1, cpu_addr_out_2_1, cpu_addr_out_3_1;    // data memory address
  wire cpu_memWrEn_0_1, cpu_memWrEn_1_1, cpu_memWrEn_2_1, cpu_memWrEn_3_1;              // data memory write enable
  wire cpu_memEn_0_1, cpu_memEn_1_1, cpu_memEn_2_1, cpu_memEn_3_1;                      // data memory enable
  
  // CPU signals for x_0
  wire [0:31] cpu_inst_in_0_0, cpu_inst_in_1_0, cpu_inst_in_2_0, cpu_inst_in_3_0;          // from imem
  wire [0:63] cpu_d_in_0_0, cpu_d_in_1_0, cpu_d_in_2_0, cpu_d_in_3_0;                      // data input from dmem
  wire [0:31] cpu_pc_out_0_0, cpu_pc_out_1_0, cpu_pc_out_2_0, cpu_pc_out_3_0;               // program counter out
  wire [0:63] cpu_d_out_0_0, cpu_d_out_1_0, cpu_d_out_2_0, cpu_d_out_3_0;               // data output to data memory
  wire [0:31] cpu_addr_out_0_0, cpu_addr_out_1_0, cpu_addr_out_2_0, cpu_addr_out_3_0;    // data memory address
  wire cpu_memWrEn_0_0, cpu_memWrEn_1_0, cpu_memWrEn_2_0, cpu_memWrEn_3_0;              // data memory write enable
  wire cpu_memEn_0_0, cpu_memEn_1_0, cpu_memEn_2_0, cpu_memEn_3_0;                      // data memory enable
  
  integer clock_cycle, i, j, dmem0_dump_file, target;
  reg [127:0] imem_filename;
  reg [127:0] dump_filename;

  imem i_mem_0_0(
    .memAddr(cpu_pc_out_0_0),
    .dataOut(cpu_inst_in_0_0)
  );

  dmem d_mem_0_0(
    .clk(clk),
    .memEn(cpu_memEn_0_0),
    .memWrEn(cpu_memWrEn_0_0),
    .memAddr(cpu_addr_out_0_0),
    .dataIn(cpu_d_out_0_0),
    .dataOut(cpu_d_in_0_0)
  );

   imem i_mem_1_0(
    .memAddr(cpu_pc_out_1_0),
    .dataOut(cpu_inst_in_1_0)
  );

  dmem d_mem_1_0(
    .clk(clk),
    .memEn(cpu_memEn_1_0),
    .memWrEn(cpu_memWrEn_1_0),
    .memAddr(cpu_addr_out_1_0),
    .dataIn(cpu_d_out_1_0),
    .dataOut(cpu_d_in_1_0)
  );

  imem i_mem_2_0(
    .memAddr(cpu_pc_out_2_0),
    .dataOut(cpu_inst_in_2_0)
  );

  dmem d_mem_2_0(
    .clk(clk),
    .memEn(cpu_memEn_2_0),
    .memWrEn(cpu_memWrEn_2_0),
    .memAddr(cpu_addr_out_2_0),
    .dataIn(cpu_d_out_2_0),
    .dataOut(cpu_d_in_2_0)
  );

  imem i_mem_3_0(
    .memAddr(cpu_pc_out_3_0),
    .dataOut(cpu_inst_in_3_0)
  );

  dmem d_mem_3_0(
    .clk(clk),
    .memEn(cpu_memEn_3_0),
    .memWrEn(cpu_memWrEn_3_0),
    .memAddr(cpu_addr_out_3_0),
    .dataIn(cpu_d_out_3_0),
    .dataOut(cpu_d_in_3_0)
  );

  imem i_mem_0_1(
    .memAddr(cpu_pc_out_0_1),
    .dataOut(cpu_inst_in_0_1)
  );

  dmem d_mem_0_1(
    .clk(clk),
    .memEn(cpu_memEn_0_1),
    .memWrEn(cpu_memWrEn_0_1),
    .memAddr(cpu_addr_out_0_1),
    .dataIn(cpu_d_out_0_1),
    .dataOut(cpu_d_in_0_1)
  );

  imem i_mem_1_1(
    .memAddr(cpu_pc_out_1_1),
    .dataOut(cpu_inst_in_1_1)
  );

  dmem d_mem_1_1(
    .clk(clk),
    .memEn(cpu_memEn_1_1),
    .memWrEn(cpu_memWrEn_1_1),
    .memAddr(cpu_addr_out_1_1),
    .dataIn(cpu_d_out_1_1),
    .dataOut(cpu_d_in_1_1)
  );

  imem i_mem_2_1(
    .memAddr(cpu_pc_out_2_1),
    .dataOut(cpu_inst_in_2_1)
  );

  dmem d_mem_2_1(
    .clk(clk),
    .memEn(cpu_memEn_2_1),
    .memWrEn(cpu_memWrEn_2_1),
    .memAddr(cpu_addr_out_2_1),
    .dataIn(cpu_d_out_2_1),
    .dataOut(cpu_d_in_2_1)
  );

  imem i_mem_3_1(
    .memAddr(cpu_pc_out_3_1),
    .dataOut(cpu_inst_in_3_1)
  );

  dmem d_mem_3_1(
    .clk(clk),
    .memEn(cpu_memEn_3_1),
    .memWrEn(cpu_memWrEn_3_1),
    .memAddr(cpu_addr_out_3_1),
    .dataIn(cpu_d_out_3_1),
    .dataOut(cpu_d_in_3_1)
  );

  imem i_mem_0_2(
    .memAddr(cpu_pc_out_0_2),
    .dataOut(cpu_inst_in_0_2)
  );

  dmem d_mem_0_2(
    .clk(clk),
    .memEn(cpu_memEn_0_2),
    .memWrEn(cpu_memWrEn_0_2),
    .memAddr(cpu_addr_out_0_2),
    .dataIn(cpu_d_out_0_2),
    .dataOut(cpu_d_in_0_2)
  );

  imem i_mem_1_2(
    .memAddr(cpu_pc_out_1_2),
    .dataOut(cpu_inst_in_1_2)
  );

  dmem d_mem_1_2(
    .clk(clk),
    .memEn(cpu_memEn_1_2),
    .memWrEn(cpu_memWrEn_1_2),
    .memAddr(cpu_addr_out_1_2),
    .dataIn(cpu_d_out_1_2),
    .dataOut(cpu_d_in_1_2)
  );

  imem i_mem_2_2(
    .memAddr(cpu_pc_out_2_2),
    .dataOut(cpu_inst_in_2_2)
  );

  dmem d_mem_2_2(
    .clk(clk),
    .memEn(cpu_memEn_2_2),
    .memWrEn(cpu_memWrEn_2_2),
    .memAddr(cpu_addr_out_2_2),
    .dataIn(cpu_d_out_2_2),
    .dataOut(cpu_d_in_2_2)
  );

  imem i_mem_3_2(
    .memAddr(cpu_pc_out_3_2),
    .dataOut(cpu_inst_in_3_2)
  );

  dmem d_mem_3_2(
    .clk(clk),
    .memEn(cpu_memEn_3_2),
    .memWrEn(cpu_memWrEn_3_2),
    .memAddr(cpu_addr_out_3_2),
    .dataIn(cpu_d_out_3_2),
    .dataOut(cpu_d_in_3_2)
  );

  imem i_mem_0_3(
    .memAddr(cpu_pc_out_0_3),
    .dataOut(cpu_inst_in_0_3)
  );

  dmem d_mem_0_3(
    .clk(clk),
    .memEn(cpu_memEn_0_3),
    .memWrEn(cpu_memWrEn_0_3),
    .memAddr(cpu_addr_out_0_3),
    .dataIn(cpu_d_out_0_3),
    .dataOut(cpu_d_in_0_3)
  );

  imem i_mem_1_3(
    .memAddr(cpu_pc_out_1_3),
    .dataOut(cpu_inst_in_1_3)
  );

  dmem d_mem_1_3(
    .clk(clk),
    .memEn(cpu_memEn_1_3),
    .memWrEn(cpu_memWrEn_1_3),
    .memAddr(cpu_addr_out_1_3),
    .dataIn(cpu_d_out_1_3),
    .dataOut(cpu_d_in_1_3)
  );

  imem i_mem_2_3(
    .memAddr(cpu_pc_out_2_3),
    .dataOut(cpu_inst_in_2_3)
  );

  dmem d_mem_2_3(
    .clk(clk),
    .memEn(cpu_memEn_2_3),
    .memWrEn(cpu_memWrEn_2_3),
    .memAddr(cpu_addr_out_2_3),
    .dataIn(cpu_d_out_2_3),
    .dataOut(cpu_d_in_2_3)
  );

  imem i_mem_3_3(
    .memAddr(cpu_pc_out_3_3),
    .dataOut(cpu_inst_in_3_3)
  );

  dmem d_mem_3_3(
    .clk(clk),
    .memEn(cpu_memEn_3_3),
    .memWrEn(cpu_memWrEn_3_3),
    .memAddr(cpu_addr_out_3_3),
    .dataIn(cpu_d_out_3_3),
    .dataOut(cpu_d_in_3_3)
  );


  mesh_top_flat uut (
    .clk(clk),
    .reset(reset),

    // x_3
    .cpu_inst_in_0_3(cpu_inst_in_0_3), .cpu_inst_in_1_3(cpu_inst_in_1_3), .cpu_inst_in_2_3(cpu_inst_in_2_3), .cpu_inst_in_3_3(cpu_inst_in_3_3),
    .cpu_d_in_0_3(cpu_d_in_0_3), .cpu_d_in_1_3(cpu_d_in_1_3), .cpu_d_in_2_3(cpu_d_in_2_3), .cpu_d_in_3_3(cpu_d_in_3_3),
    .cpu_pc_out_0_3(cpu_pc_out_0_3), .cpu_pc_out_1_3(cpu_pc_out_1_3), .cpu_pc_out_2_3(cpu_pc_out_2_3), .cpu_pc_out_3_3(cpu_pc_out_3_3),
    .cpu_d_out_0_3(cpu_d_out_0_3), .cpu_d_out_1_3(cpu_d_out_1_3), .cpu_d_out_2_3(cpu_d_out_2_3), .cpu_d_out_3_3(cpu_d_out_3_3),
    .cpu_addr_out_0_3(cpu_addr_out_0_3), .cpu_addr_out_1_3(cpu_addr_out_1_3), .cpu_addr_out_2_3(cpu_addr_out_2_3), .cpu_addr_out_3_3(cpu_addr_out_3_3),
    .cpu_memWrEn_0_3(cpu_memWrEn_0_3), .cpu_memWrEn_1_3(cpu_memWrEn_1_3), .cpu_memWrEn_2_3(cpu_memWrEn_2_3), .cpu_memWrEn_3_3(cpu_memWrEn_3_3),
    .cpu_memEn_0_3(cpu_memEn_0_3), .cpu_memEn_1_3(cpu_memEn_1_3), .cpu_memEn_2_3(cpu_memEn_2_3), .cpu_memEn_3_3(cpu_memEn_3_3),

    // x_2
    .cpu_inst_in_0_2(cpu_inst_in_0_2), .cpu_inst_in_1_2(cpu_inst_in_1_2), .cpu_inst_in_2_2(cpu_inst_in_2_2), .cpu_inst_in_3_2(cpu_inst_in_3_2),
    .cpu_d_in_0_2(cpu_d_in_0_2), .cpu_d_in_1_2(cpu_d_in_1_2), .cpu_d_in_2_2(cpu_d_in_2_2), .cpu_d_in_3_2(cpu_d_in_3_2),
    .cpu_pc_out_0_2(cpu_pc_out_0_2), .cpu_pc_out_1_2(cpu_pc_out_1_2), .cpu_pc_out_2_2(cpu_pc_out_2_2), .cpu_pc_out_3_2(cpu_pc_out_3_2),
    .cpu_d_out_0_2(cpu_d_out_0_2), .cpu_d_out_1_2(cpu_d_out_1_2), .cpu_d_out_2_2(cpu_d_out_2_2), .cpu_d_out_3_2(cpu_d_out_3_2),
    .cpu_addr_out_0_2(cpu_addr_out_0_2), .cpu_addr_out_1_2(cpu_addr_out_1_2), .cpu_addr_out_2_2(cpu_addr_out_2_2), .cpu_addr_out_3_2(cpu_addr_out_3_2),
    .cpu_memWrEn_0_2(cpu_memWrEn_0_2), .cpu_memWrEn_1_2(cpu_memWrEn_1_2), .cpu_memWrEn_2_2(cpu_memWrEn_2_2), .cpu_memWrEn_3_2(cpu_memWrEn_3_2),
    .cpu_memEn_0_2(cpu_memEn_0_2), .cpu_memEn_1_2(cpu_memEn_1_2), .cpu_memEn_2_2(cpu_memEn_2_2), .cpu_memEn_3_2(cpu_memEn_3_2),

    // x_1
    .cpu_inst_in_0_1(cpu_inst_in_0_1), .cpu_inst_in_1_1(cpu_inst_in_1_1), .cpu_inst_in_2_1(cpu_inst_in_2_1), .cpu_inst_in_3_1(cpu_inst_in_3_1),
    .cpu_d_in_0_1(cpu_d_in_0_1), .cpu_d_in_1_1(cpu_d_in_1_1), .cpu_d_in_2_1(cpu_d_in_2_1), .cpu_d_in_3_1(cpu_d_in_3_1),
    .cpu_pc_out_0_1(cpu_pc_out_0_1), .cpu_pc_out_1_1(cpu_pc_out_1_1), .cpu_pc_out_2_1(cpu_pc_out_2_1), .cpu_pc_out_3_1(cpu_pc_out_3_1),
    .cpu_d_out_0_1(cpu_d_out_0_1), .cpu_d_out_1_1(cpu_d_out_1_1), .cpu_d_out_2_1(cpu_d_out_2_1), .cpu_d_out_3_1(cpu_d_out_3_1),
    .cpu_addr_out_0_1(cpu_addr_out_0_1), .cpu_addr_out_1_1(cpu_addr_out_1_1), .cpu_addr_out_2_1(cpu_addr_out_2_1), .cpu_addr_out_3_1(cpu_addr_out_3_1),
    .cpu_memWrEn_0_1(cpu_memWrEn_0_1), .cpu_memWrEn_1_1(cpu_memWrEn_1_1), .cpu_memWrEn_2_1(cpu_memWrEn_2_1), .cpu_memWrEn_3_1(cpu_memWrEn_3_1),
    .cpu_memEn_0_1(cpu_memEn_0_1), .cpu_memEn_1_1(cpu_memEn_1_1), .cpu_memEn_2_1(cpu_memEn_2_1), .cpu_memEn_3_1(cpu_memEn_3_1),

    // x_0
    .cpu_inst_in_0_0(cpu_inst_in_0_0), .cpu_inst_in_1_0(cpu_inst_in_1_0), .cpu_inst_in_2_0(cpu_inst_in_2_0), .cpu_inst_in_3_0(cpu_inst_in_3_0),
    .cpu_d_in_0_0(cpu_d_in_0_0), .cpu_d_in_1_0(cpu_d_in_1_0), .cpu_d_in_2_0(cpu_d_in_2_0), .cpu_d_in_3_0(cpu_d_in_3_0),
    .cpu_pc_out_0_0(cpu_pc_out_0_0), .cpu_pc_out_1_0(cpu_pc_out_1_0), .cpu_pc_out_2_0(cpu_pc_out_2_0), .cpu_pc_out_3_0(cpu_pc_out_3_0),
    .cpu_d_out_0_0(cpu_d_out_0_0), .cpu_d_out_1_0(cpu_d_out_1_0), .cpu_d_out_2_0(cpu_d_out_2_0), .cpu_d_out_3_0(cpu_d_out_3_0),
    .cpu_addr_out_0_0(cpu_addr_out_0_0), .cpu_addr_out_1_0(cpu_addr_out_1_0), .cpu_addr_out_2_0(cpu_addr_out_2_0), .cpu_addr_out_3_0(cpu_addr_out_3_0),
    .cpu_memWrEn_0_0(cpu_memWrEn_0_0), .cpu_memWrEn_1_0(cpu_memWrEn_1_0), .cpu_memWrEn_2_0(cpu_memWrEn_2_0), .cpu_memWrEn_3_0(cpu_memWrEn_3_0),
    .cpu_memEn_0_0(cpu_memEn_0_0), .cpu_memEn_1_0(cpu_memEn_1_0), .cpu_memEn_2_0(cpu_memEn_2_0), .cpu_memEn_3_0(cpu_memEn_3_0)
  );


  initial clk = 0;
  always #2 clk <= ~clk;

  initial begin
    clock_cycle = 0;

    for (j=0; j < 1; j = j + 1) begin
        reset = 1'b1;
        repeat(5) @(negedge clk); 
        reset = 1'b0;    
        // Format the filename string: "imem_<j>.fill"
        //$sformat(imem_filename, "imem_%0d.fill", j);
    
        // Load instruction memory
        $readmemh("receive-inst.txt", i_mem_0_0.MEM);
        $readmemh("send-inst.txt", i_mem_0_1.MEM);
        $readmemh("send-inst.txt", i_mem_0_2.MEM);
        $readmemh("send-inst.txt", i_mem_0_3.MEM);
        $readmemh("send-inst.txt", i_mem_1_0.MEM);
        $readmemh("send-inst.txt", i_mem_1_1.MEM);
        $readmemh("send-inst.txt", i_mem_1_2.MEM);
        $readmemh("send-inst.txt", i_mem_1_3.MEM);
        $readmemh("send-inst.txt", i_mem_2_0.MEM);
        $readmemh("send-inst.txt", i_mem_2_1.MEM);
        $readmemh("send-inst.txt", i_mem_2_2.MEM);
        $readmemh("send-inst.txt", i_mem_2_3.MEM);
        $readmemh("send-inst.txt", i_mem_3_0.MEM);
        $readmemh("send-inst.txt", i_mem_3_1.MEM);
        $readmemh("send-inst.txt", i_mem_3_2.MEM);
        $readmemh("send-inst.txt", i_mem_3_3.MEM);

        // Load the data memory
        $readmemh("d_mem_0_0.txt", d_mem_0_0.MEM);
        $readmemh("d_mem_0_1.txt", d_mem_1_0.MEM);
        $readmemh("d_mem_0_2.txt", d_mem_2_0.MEM);
        $readmemh("d_mem_0_3.txt", d_mem_3_0.MEM);
        $readmemh("d_mem_1_0.txt", d_mem_0_1.MEM);
        $readmemh("d_mem_1_1.txt", d_mem_1_1.MEM);
        $readmemh("d_mem_1_2.txt", d_mem_2_1.MEM);
        $readmemh("d_mem_1_3.txt", d_mem_3_1.MEM);
        $readmemh("d_mem_2_0.txt", d_mem_0_2.MEM);
        $readmemh("d_mem_2_1.txt", d_mem_1_2.MEM);
        $readmemh("d_mem_2_2.txt", d_mem_2_2.MEM);
        $readmemh("d_mem_2_3.txt", d_mem_3_2.MEM);
        $readmemh("d_mem_3_0.txt", d_mem_0_3.MEM);
        $readmemh("d_mem_3_1.txt", d_mem_1_3.MEM);
        $readmemh("d_mem_3_2.txt", d_mem_2_3.MEM);
        $readmemh("d_mem_3_3.txt", d_mem_3_3.MEM);

    
        wait (cpu_inst_in_0_0 == 32'h00000000);
        $display("The program completed in %d cycles", clock_cycle);
        // Let us now flush the pipe line
        repeat(20) @(negedge clk); 
        // Open file for wire
        // Dump data memory to a file
        $sformat(dump_filename, "mesh_row_%0d.dump", j);
        dmem0_dump_file = $fopen(dump_filename);// assigning the channel descriptor for wire file
    
        // Let us now dump all the locations of the data memory now
        $fdisplay(dmem0_dump_file, "|\tMem\t|\tD0\t|\tD1\t|\tD2\t|\tD3\t|");
        $fdisplay(dmem0_dump_file, "---------------------------------");        
        for (i=0; i<128; i=i+1) 
        begin
          $fdisplay(dmem0_dump_file, "|\t#%0d\t|\t%h\t|\t%h\t|\t%h\t|\t%h\t|", i, d_mem_0_0.MEM[i], d_mem_1_0.MEM[i], d_mem_2_0.MEM[i], d_mem_3_0.MEM[i]);
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
