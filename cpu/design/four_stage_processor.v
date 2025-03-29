module four_stage_processor (
  input clk,
  input reset,
  input [0:31] inst_in,       // Instruction in from instruction memory
  input [0:63] d_in,          // Data input from data memory
  output [0:31] pc_out,   // Program counter out
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
wire hdu_out_is_hazard;
wire [0:31] nop_mux_out;

// Register File wires
wire [0:63] rf_out_rA_data;
wire [0:63] rf_out_rB_data;
reg [0:63] wb_rD_data;
reg wb_write_enable;
reg [0:2] wb_ppp;

// EX/WB stage pipeline registers
reg ex_stage_ld;
reg ex_stage_sd;
reg [0:4] ex_stage_rD_address;
reg [0:4] ex_stage_rA_address;
reg [0:4] ex_stage_rB_address;
reg [0:63] ex_stage_alu_out;
reg ex_stage_alu_or_sfu;
reg ex_stage_ppp;

// EX/WB stage interconnects
// ALU, rA_mux, rB_mux, fdu wires
wire fdu_forward_rA;
wire fdu_forward_rB;
wire [0:63] ex_rA_mux_out;
wire [0:63] ex_rB_mux_out;
wire [0:63] ex_alu_output;

wire [0:63] wb_result_mux_out;


program_counter pc(
  .clk(clk),
  .reset(reset),
  .stall(hdu_out_is_hazard),
  .pc_out(pc_out_pc_out)
);

mux #(.WIDTH(32)) branch_mux (
  .value_if_low(pc_out_pc_out), 
  .value_if_high({16'b0, id_out_immediate_address}),
  .control_signal(id_out_bez | id_out_bnez),
  .selection(pc_out)
  );

register_file rf(
  .clk(clk),
  .reset(reset),
  .writeEnable(wb_write_enable),
  .rA_address(id_out_rA_address),
  .rB_address(id_out_rB_address),
  .rD_address(ex_stage_rD_address),
  .rD_data(wb_rD_data), // I might changed this
  .ppp(wb_ppp),
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
  .value_if_low(inst_in),
  .value_if_high({4'b1, 28'b0}),
  .control_signal(id_out_bez | id_out_bnez),
  .selection(nop_mux_out)
);

hazard_detection_unit hdu(
  .is_loading(id_stage_ld),
  .is_move(id_stage_alu & id_stage_alu_operation == 6'b000101), // Move op
  .rA_address(id_out_rA_address),
  .rB_address(id_out_rB_address),
  .id_rD_address(id_stage_rD_address),
  .is_hazard(hdu_out_is_hazard)
);

// EX Stage modules
alu alu(
  .ld(),
  .sd(),
  .alu_op(id_stage_alu_operation),
  .width(id_stage_ww),
  .immediate_address(id_stage_immediate_address),
  .reg_a_data(ex_rA_mux_out),
  .reg_b_data(ex_rB_mux_out),
  .instruction(),
  .alu_out(ex_alu_output)
);

forwarding_unit fdu(
  .id_rA_address(id_stage_rA_address),
  .id_rB_address(id_stage_rB_address),
  .ex_rA_address(ex_stage_rA_address),
  .ex_rB_address(ex_stage_rB_address),
  .forward_rA(fdu_forward_rA),
  .forward_rB(fdu_forward_rB)
);

mux ex_rA_mux(
  .value_if_low(id_stage_rA_data),
  .value_if_high(wb_result_mux_out),
  .control_signal(fdu_forward_rA),
  .selection(ex_rA_mux_out)
);

mux ex_rB_mux(
  .value_if_low(id_stage_rB_data),
  .value_if_high(wb_result_mux_out),
  .control_signal(fdu_forward_rB),
  .selection(ex_rB_mux_out)
);

mux wb_result_mux(
  .value_if_low(ex_stage_alu_out),
  .value_if_high(d_in),
  .control_signal(ex_stage_ld | ex_stage_alu_or_sfu),
  .selection(wb_result_mux_out)
);

// Check if we need to branch or not
always @(id_out_bez or id_out_bnez) begin
    if_branch = 1'b0;
    
  // We use rB_data to access rD data.
  if (id_out_bez) begin
    if (rf_out_rB_data == 64'b0) begin // if rf[rD] == 0
      if_branch = 1'b1;
    end
  end

  if (id_out_bnez) begin
    if (rf_out_rB_data != 64'b0) begin // if rf[rD] != 0
      if_branch = 1'b1;
    end
  end
end

always @(posedge clk) begin
  if (reset) begin
    reset_clocked_values;
  end else begin
    memEn <= 1'b0;
    memWrEn <= 1'b0;
    d_out <= 64'b0;
    addr_out <= 5'b0;
    // load the pipeline registers from the intermediate values
    // IF stage
    if (!hdu_out_is_hazard)
      if_stage_instruction_in <= nop_mux_out;

    // ID stage
    if (hdu_out_is_hazard) begin
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
      id_stage_nop <= 1'b1;
    end else begin
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
    end

    // We should be loading data from the data memory
    // Loading takes 2 cycles and needs to start in the ID stage.
    // This will allow us to write the loaded value into the 
    // RF in the WB stage.
    if (id_stage_ld) begin
      addr_out <= {16'b0, id_stage_immediate_address};
      memEn <= 1'b1;
    end

    // EX/MEM stage
    ex_stage_ld <= id_stage_ld;
    ex_stage_sd <= id_stage_sd;
    ex_stage_rD_address <= id_stage_rD_address;
    ex_stage_rA_address <= id_stage_rA_address;
    ex_stage_rB_address <= id_stage_rB_address;
    ex_stage_alu_out <= ex_alu_output;
    ex_stage_alu_or_sfu <= (id_stage_alu | id_stage_sfu);
    ex_stage_ppp <= id_stage_ppp;

    // WB stage

    if (ex_stage_ld | ex_stage_alu_or_sfu) begin
      wb_write_enable <= 1'b1;
      wb_rD_data <= wb_result_mux_out;
      wb_ppp <= ex_stage_ppp;
    end else begin
      wb_write_enable <= 1'b0;
      wb_rD_data <= 64'b0;
      wb_ppp <= 3'b0;
    end
    
    if (ex_stage_sd) begin
      memEn <= 1'b1;
      memWrEn <= 1'b1;
      d_out <= ex_stage_alu_out;
      addr_out <= ex_stage_rD_address;
    end

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

    ex_stage_ld <= 1'b0;
    ex_stage_sd <= 1'b0;
    ex_stage_rD_address <= 5'b0;
    ex_stage_rA_address <= 5'b0;
    ex_stage_rB_address <= 5'b0;
    ex_stage_alu_out <= 64'b0;
    ex_stage_alu_or_sfu <= 1'b0;
    ex_stage_ppp <= 3'b0;
  end
endtask

endmodule