module mux #(parameter WIDTH = 64) (
  input [0:WIDTH-1] value_if_low,
  input [0:WIDTH-1] value_if_high,
  input control_signal,
  output [0:WIDTH-1] selection
);

  assign selection = control_signal ? value_if_high : value_if_low;

endmodule