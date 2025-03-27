

module instruction_decoder (
  input clk,
  input reset,
  input [0:31] instruction
  output [0:4] rA_address,
  output [0:4] rB_address,
  output [0:4] rD_address,
  output [0:5] alu_operation,
  output [0:15] immediate_address,
  output [0:2] ppp,
  output [0:1] ww,
  output alu,
  output sfu,
  output ld,
  output sd,
  output bez,
  output bnez,
  output nop
);

localparam RA_MSB = 11;
localparam RA_LSB = 15;
localparam RB_MSB = 16;
localparam RB_LSB = 20;
localparam RD_MSB = 6;
localparam RD_LSB = 10;
localparam OPCODE_MSB = 0;
localparam OPCODE_LSB = 5;
localparam PPP_MSB = 21;
localparam PPP_LSB = 23;
localparam WW_MSB = 24;
localparam WW_LSB = 25;
localparam ALU_OP_MSB = 26;
localparam ALU_OP_LSB = 31;
localparam IM_MSB = 16;
localparam IM_LSB = 31;

localparam ALU_OPCODE   = 6'b101010;
localparam LOAD_OP      = 6'b100000;
localparam STORE_OP     = 6'b100001;
localparam BEZ_OP       = 6'b100010;
localparam BNEZ_OP      = 6'b100011;
localparam NOP          = 6'b111100;

reg opcode;

always @(*) begin
  if (!reset) begin
    opcode = instruction[OPCODE_MSB:OPCODE_LSB];
    case (opcode)
      ALU_OPCODE: begin
        
      end

      LOAD_OP: begin

      end

      STORE_OP: begin

      end

      BEZ_OP: begin

      end

      BNEZ_OP: begin
      
      end
      default: begin
        // Insert NOPs any illegal operations
        nop = 1'b1;
        rA_address = 1'b0;
        rB_address = 1'b0;
        rD_address = 1'b0;
        alu_operation = 1'b0;
        immediate_address = 1'b0;
        alu = 1'b0;
        sfu = 1'b0;
        ld = 1'b0;
        sd = 1'b0;
        bez = 1'b0;
        bnez = 1'b0;
      end
    endcase
  end
end

always @(posedge clk) begin
  if (reset) begin
    rA_address <= 5'b0;
    rB_address <= 5'b0;
    rD_address <= 5'b0;
    alu_operation <= 6'b0;
    immediate_address <= 16'b0;
    ppp <= 3'b0;
    ww <= 2'b0;
    alu <= 1'b0;
    sfu <= 1'b0;
    ld <= 1'b0;
    sd <= 1'b0;
    bez <= 1'b0;
    bnez <= 1'b0;
    nop <= 1'b0;
  end
end

endmodule
