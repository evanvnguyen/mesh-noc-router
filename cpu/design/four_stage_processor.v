module four_stage_processor (
  input clk,
  input reset,
  input [0:31] inst_in,       // Instruction in from instruction memory
  input [0:63] d_in,          // Data input from data memory
  output reg [0:31] pc_out,   // Program counter out
  output reg [0:63] d_out,    // Data output to data memory
  output reg [0:31] addr_out, // Data memory address
  output reg memWrEn,         // Data memory write enable
  output reg memEn            // Data memory enable
);

// We have 4 stages so we will need 3 pipeline registers

// IF stage 
reg [0:31] if_stage_instruction_in;
reg if_branch;
wire [0:31] pc_out_pc_out;

// ID/EX stage pipeline registers
reg [0:4] id_stage_rA_address;
reg [0:4] id_stage_rB_address;
reg [0:4] id_stage_rD_address;
reg [0:5] id_stage_alu_operation;
reg [0:15] id_stage_immediate_address;
reg [0:2] id_stage_ppp;
reg [0:1] id_stage_ww;
reg [0:63] id_stage_rA_data;
reg [0:63] id_stage_rB_data;
reg id_stage_alu;
reg id_stage_sfu;
reg id_stage_ld;
reg id_stage_sd;
reg id_stage_bez;
reg id_stage_bnez;
reg id_stage_nop;

// ID stage interconnects
// Instruction Decoder wires
wire [0:4] id_out_rA_address;
wire [0:4] id_out_rB_address;
wire [0:4] id_out_rD_address;
wire [0:5] id_out_alu_operation;
wire [0:15] id_out_immediate_address;
wire [0:2] id_out_ppp;
wire [0:1] id_out_ww;
wire id_out_alu;
wire id_out_sfu;
wire id_out_ld;
wire id_out_sd;
wire id_out_bez;
wire id_out_bnez;
wire id_out_nop;

wire nop_mux_out;

// Register File wires
wire [0:63] rf_out_rA_data;
wire [0:63] rf_out_rB_data;
wire [0:63] wb_rD_data;
wire wb_write_enable;

program_counter pc(
  .clk(clk),
  .reset(reset),
  .pc_out(pc_out_pc_out)
);

mux #(.WIDTH(32)) branch_mux (
  .value_if_low(pc_out_pc_out), 
  .value_if_high(id_out_immediate_address),
  .control_signal(id_out_bez | id_out_bnez),
  .selection(pc_out)
  );

register_file rf(
  .clk(clk),
  .reset(reset),
  .writeEnable(wb_write_enable),
  .rA_address(id_out_rA_address),
  .rB_address(id_out_rB_address),
  .rD_address(id_out_rD_address),
  .rD_data(wb_rD_data), // I might changed this
  .rA_data(rf_out_rA_data),
  .rB_data(rf_out_rB_data)
);

instruction_decoder id(
  .clk(clk),
  .reset(reset),
  .instruction(if_stage_instruction_in),
  .rA_address(id_out_rA_address),
  .rB_address(id_out_rB_address),
  .rD_address(id_out_rD_address),
  .alu_operation(id_out_alu_operation),
  .immediate_address(id_out_immediate_address),
  .ppp(id_out_ppp),
  .ww(id_out_ww),
  .alu(id_out_alu),
  .sfu(id_out_sfu),
  .ld(id_out_ld),
  .sd(id_out_sd),
  .bez(id_out_bez),
  .bnez(id_out_bnez),
  .nop(id_out_nop)
);

mux #(.WIDTH(32)) nop_mux (
  .value_if_low(if_stage_instruction_in),
  .value_if_high({4'b1, 28'b0}),
  .control_signal(id_out_bez | id_out_bnez),
  .selection(nop_mux_out)
);

// Check if we need to branch or not
always @(id_out_bez or id_out_bnez) begin
  // We use rB_data to access rD data.
  if (id_out_bez) begin
    if (rf_out_rB_data == 64'b0) begin // if rf[rD] == 0
      if_branch = 1'b1;
      id_out_rB_address = 5'b0;
    end else begin
      id_out_rB_address = 5'b0;
      rf_out_rB_data = 1'b0;
    end
  end

  if (id_out_bnez) begin
    if (rf_out_rB_data != 64'b0) begin // if rf[rD] != 0
      if_branch = 1'b1;
      id_out_rB_address = 5'b0;
      rf_out_rB_data = 1'b0;
    end else begin
      id_out_rB_address = 5'b0;
    end
  end
end

always @(posedge clk) begin
  if (reset) begin
    reset_clocked_values;
  end else begin
    // load the pipeline registers from the intermediate values
    // IF stage
    if_stage_instruction_in <= inst_in;

    // ID stage
    id_stage_rA_address <= id_out_rA_address;
    id_stage_rB_address <= id_out_rB_address;
    id_stage_rD_address <= id_out_rD_address;
    id_stage_alu_operation <= id_out_alu_operation;
    id_stage_immediate_address <= id_out_immediate_address;
    id_stage_ppp <= id_out_ppp;
    id_stage_ww <= id_out_ww;
    id_stage_rA_data <= rf_out_rA_data;
    id_stage_rB_data <= rf_out_rB_data;
    id_stage_alu <= id_out_alu;
    id_stage_sfu <= id_out_sfu;
    id_stage_ld <= id_out_ld;
    id_stage_sd <= id_out_sd;
    id_stage_bez <= id_out_bez;
    id_stage_bnez <= id_out_bnez;
    id_stage_nop <= id_out_nop;

    // We should be loading data from the data memory
    // Loading takes 2 cycles and needs to start in the ID stage.
    // This will allow us to write the loaded value into the 
    // RF in the WB stage.
    if (id_out_ld) begin
      addr_out <= {16'b0, id_out_immediate_address};
      memEn <= 1'b1;
    end else begin
      addr_out <= 32'b0;
      memEn <= 1'b0;
    end

    // EX/MEM stage

    // WB stage

  end
end

// This resets all clocked values
task reset_clocked_values();
  begin
    id_stage_rA_address <= 5'b0;
    id_stage_rB_address <= 5'b0;
    id_stage_rD_address <= 5'b0;
    id_stage_alu_operation <= 6'b0;
    id_stage_immediate_address <= 16'b0;
    id_stage_ppp <= 3'b0;
    id_stage_ww <= 2'b0;
    id_stage_rA_data <= 64'b0;
    id_stage_rB_data <= 64'b0;
    id_stage_alu <= 1'b0;
    id_stage_sfu <= 1'b0;
    id_stage_ld <= 1'b0;
    id_stage_sd <= 1'b0;
    id_stage_bez <= 1'b0;
    id_stage_bnez <= 1'b0;
    id_stage_nop <= 1'b0;
  end
endtask

endmodule