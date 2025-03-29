module forwarding_unit(
  input id_rA_address,
  input id_rB_address,
  input ex_rA_address,
  input ex_rB_address,
  output forward_rA,
  output forward_rB
);

  assign forward_rA = (id_rA_address == ex_rA_address);
  assign forward_rB = (id_rB_address == ex_rB_address);

endmodule