module tb_four_stage_processor;

  reg clk, reset;
  reg [0:31] inst_in;
  reg [0:63] d_in;
  wire [0:31] pc_out;
  wire [0:63] d_out;
  wire [0:31] addr_out;
  wire memWrEn;
  wire memEn;
  
  integer clock_cycle;

  reg [0:31] instuc_mem [0:6];
  reg [0:63] mem [0:5];

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

  initial clk = 1;
  always #2 clk = ~clk;

  initial begin
    inst_in = 32'b0;
    d_in = 64'b0;
    clock_cycle = 0;

    mem[0] = 64'b0;
    mem[1] = {61'b0, 3'b101};
    mem[2] = {61'b0, 3'b010};
    mem[3] = 64'b0;
    mem[4] = 64'b0;

    instuc_mem[0] = 32'h80200001;
    instuc_mem[1] = 32'h80400002;
    instuc_mem[2] = 32'hA8611001;
    instuc_mem[3] = 32'hF0000000;
    instuc_mem[4] = 32'hF0000000;
    instuc_mem[5] = 32'hF0000000;
    instuc_mem[6] = 32'hF0000000;

    reset = 1'b1;
    #8
    reset = 1'b0;
    $readmemh("rf_random_values.txt", uut.rf.registerFile);
  end
  
  always @(posedge clk) begin
    if (!reset) begin
        inst_in = instuc_mem[pc_out / 4];
        
        if (memEn) begin
            d_in = mem[addr_out];
        end
       
       clock_cycle <= clock_cycle + 1;
       
       if (clock_cycle == 10) 
        $finish;
    end
  end

endmodule
