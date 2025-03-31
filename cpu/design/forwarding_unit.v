module forwarding_unit(
  input [0:4] id_out_rA_address,
  input [0:4] id_out_rB_address,
  input [0:4] id_stage_rA_address,
  input [0:4] id_stage_rB_address,
  input [0:4] ex_rD_address,
  input storing,
  output reg [0:1] forward_rA,
  output reg [0:1] forward_rB
);

  // 10 store using id_stage_address == ex_rD_address. Forward ex_r_mux_out
  // 01 forwarding id_out_address == ex_rD_address, id_stage_data <= ex_rA_mux_out
  // 11 forwardinf id_stage_address == ex_rD_address, alu = ra_mux_out

  always @(*) begin
    forward_rA = 2'b0;
    forward_rB = 2'b0;

    if (storing) begin
      if (id_stage_rA_address != 0 && id_stage_rA_address == ex_rD_address)
        forward_rA = 2'b10;
      
      if (id_stage_rB_address != 0 && id_stage_rB_address == ex_rD_address)
        forward_rA = 2'b10;
    end else begin
      if (id_out_rA_address != 0 && id_out_rA_address == ex_rD_address)
        forward_rA = 2'b01;
      else if (id_stage_rA_address != 0 && id_stage_rA_address == ex_rD_address)
        forward_rA = 2'b11;
      
      if (id_out_rB_address != 0 && id_out_rB_address == ex_rD_address)
        forward_rB = 2'b01;
      else if (id_stage_rB_address != 0 && id_stage_rB_address == ex_rD_address)
        forward_rB = 2'b11;

    end
  end
endmodule