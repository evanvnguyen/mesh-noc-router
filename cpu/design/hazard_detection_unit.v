module hazard_detection_unit (
  input is_loading,
  input is_move,
  input [0:4] rA_address,
  input [0:4] rB_address,
  input [0:4] id_rD_address,
  output is_hazard
);

assign is_hazard = ((is_loading | is_move) && (rA_address == id_rD_address | rB_address == id_rD_address)) ? 1'b1 : 1'b0;

endmodule