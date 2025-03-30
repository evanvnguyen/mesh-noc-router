module forwarding_unit(
  input [0:4] id_rA_address,
  input [0:4] id_rB_address,
  input [0:4] ex_rA_address,
  input [0:4] ex_rB_address,
  input [0:4] ex_rD_address,
  output forward_rA,
  output forward_rB
);

  assign forward_rA = (id_rA_address != 0 && id_rA_address == ex_rA_address | id_rA_address == ex_rD_address);
  assign forward_rB = (id_rB_address != 0 && id_rB_address == ex_rB_address | id_rB_address == ex_rD_address);

endmodule