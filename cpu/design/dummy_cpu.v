`timescale 1ns / 1ps

// Dummy CPU Module to drive NIC inputs
module dummy_cpu #(parameter PACKET_WIDTH = 64) (
    input clk,
    input reset,
    output reg [1:0] addr,
    output reg [PACKET_WIDTH-1:0] d_in,
    output reg nicEn,
    output reg nicEnWR
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            addr <= 2'b00;
            d_in <= {PACKET_WIDTH{1'b0}};
            nicEn <= 1'b0;
            nicEnWR <= 1'b0;
        end else begin
            // write to output buffer
            addr <= 2'b10;
            d_in <= 64'hDEADBEEFDEADBEEF;
            nicEn <= 1'b1;
            nicEnWR <= 1'b1;
        end
    end
endmodule
