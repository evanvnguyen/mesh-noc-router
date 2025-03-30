module instruction_decoder (
  input clk,
  input reset,
  input [0:31] instruction,
  output reg [0:4] rA_address,
  output reg [0:4] rB_address,
  output reg [0:4] rD_address,
  output reg [0:5] alu_operation,
  output reg [0:15] immediate_address,
  output reg [0:2] ppp,
  output reg [0:1] ww,
  output reg alu,
  output reg sfu,
  output reg ld,
  output reg sd,
  output reg bez,
  output reg bnez,
  output reg nop
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

reg [0:5] opcode;

// Update when the instruction value changes
always @(instruction) begin
  rA_address = 5'b0;
  rB_address = 5'b0;
  rD_address = 5'b0;
  alu_operation = 6'b0;
  immediate_address = 16'b0;
  ppp = 3'b0;
  ww = 2'b0;
  alu = 1'b0;
  sfu = 1'b0;
  ld = 1'b0;
  sd = 1'b0;
  bez = 1'b0;
  bnez = 1'b0;
  nop = 1'b0;

  if (!reset) begin
    opcode = instruction[OPCODE_MSB:OPCODE_LSB];
    case (opcode)
      ALU_OPCODE: begin
        alu_operation = instruction[ALU_OP_MSB:ALU_OP_LSB];
        rA_address = instruction[RA_MSB:RA_LSB];
        rD_address = instruction[RD_MSB:RD_LSB];
        ppp = instruction[PPP_MSB:PPP_LSB];
        ww = instruction[WW_MSB:WW_LSB];

        // This checks if the instructions are either a not, mov, rtth, sqeu, sqou, or sqrt operation. 
        // If so set the rB address to 5'b0.
        if (alu_operation == 6'b000100 || 
            alu_operation == 6'b000101 || 
            alu_operation == 6'b001101 || 
            alu_operation[1] == 1'b1)

          rB_address = 5'b0;
        else
          rB_address = instruction[RB_MSB:RB_LSB];

        // Check if the operation is an SFU operation
        if (instruction[1] == 1'b1 || opcode[0:4] == 5'b00111)
          sfu = 1'b1;
        else
          alu = 1'b1;
      end

      LOAD_OP: begin
        ld = 1'b1;
        rD_address = instruction[RD_MSB:RD_LSB];
        rA_address = 5'b0;
        immediate_address = instruction[IM_MSB:IM_LSB];
      end

      STORE_OP: begin
        sd = 1'b1;
        rD_address = instruction[RD_MSB:RD_LSB];
        rA_address = 5'b0;
        immediate_address = instruction[IM_MSB:IM_LSB];
      end

      BEZ_OP: begin
        bez = 1'b1;
        rD_address = instruction[RD_MSB:RD_LSB];
        rA_address = 5'b0;
        // We set this to rB so we can get the data from the RF
        rB_address = instruction[RD_MSB:RD_LSB];
        immediate_address = instruction[IM_MSB:IM_LSB];
      end

      BNEZ_OP: begin
        bnez = 1'b1;
        rD_address = instruction[RD_MSB:RD_LSB];
        rA_address = 5'b0;
        // We set this to rB so we can get the data from the RF
        rB_address = instruction[RD_MSB:RD_LSB];
        immediate_address = instruction[IM_MSB:IM_LSB];
      end

      default: begin
        // Insert NOPs any illegal operations
        nop = 1'b1;
        rA_address = 1'b0;
        rB_address = 1'b0;
        rD_address = 1'b0;
        alu_operation = 1'b0;
        immediate_address = 1'b0;
        ppp = 3'b0;
        ww = 2'b0;
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
