module clk_gate_latch (
    input  wire CLK,     // input clock
    input  wire EN,      // enable signal
    output wire GCLK     // gated clock output
);

    reg en_latched;

    // Level-sensitive latch: transparent when CLK is low
    always @ (CLK or EN) begin
        if (!CLK)
            en_latched <= EN;
    end

    // Gated clock output
    assign GCLK = CLK & en_latched;

endmodule