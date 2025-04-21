module nic #(
    parameter PACKET_WIDTH = 64
)(
    input                        clk,
    input                        reset,

    // **** Between CPU and NIC ****
    input      [1:0]             addr,                // Address for status & buffers
    input      [PACKET_WIDTH-1:0] d_in,                // From CPU ? network OUTPUT buffer
    output reg [PACKET_WIDTH-1:0] d_out,               // From network INPUT buffer ? CPU
    input                        nicEn,               // NIC enable
    input                        nicEnWR,             // NIC write enable

    // **** Between Router and NIC ****
    input                        net_si,              // Router ? NIC, data valid
    output wire                  net_ri,              // NIC ? Router, ready to accept
    input      [PACKET_WIDTH-1:0] net_di,              // Router ? NIC, data
    output reg                   net_so,              // NIC ? Router, data valid
    input                        net_ro,              // Router ? NIC, ready to accept
    output reg [PACKET_WIDTH-1:0] net_do,              // NIC ? Router, data
    input                        net_polarity         // Used to match high-bit polarity
);

    // Internal data buffers
    reg [PACKET_WIDTH-1:0] channel_input_buffer;
    reg [PACKET_WIDTH-1:0] channel_output_buffer;

    // Status signals (single source of truth)
    wire channel_input_buffer_status  = |channel_input_buffer;   // 1 if non-zero/full
    wire channel_output_buffer_status = |channel_output_buffer;  // 1 if non-zero/full

    // Ready handshake: ready when input buffer is empty
    assign net_ri = ~channel_input_buffer_status;

    // Clock-gating
    wire nic_clk_gate_en      = (nicEn || nicEnWR) && (channel_input_buffer_status || channel_output_buffer_status);
    wire nic_gclk;
    clk_gate_latch nic_clk_gate (
        .CLK(clk),
        .EN (nic_clk_gate_en),
        .GCLK(nic_gclk)
    );
    wire internal_clk = nic_gclk;

    // Detect if output channel is blocked
    wire output_channel_blocked = net_ro && channel_output_buffer_status;
    wire nic_output_clk_gate    = ~output_channel_blocked;

    // -------------------------------------------------------------------------
    // Main sequential logic: reset, NIC RX/TX, CPU push into output buffer
    // -------------------------------------------------------------------------
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            channel_input_buffer  <= {PACKET_WIDTH{1'b0}};
            channel_output_buffer <= {PACKET_WIDTH{1'b0}};
            //d_out                 <= {PACKET_WIDTH{1'b0}};
            net_so                <= 1'b0;
            net_do                <= {PACKET_WIDTH{1'b0}};
        end else begin
            // --- Receive path: Router ? Input Buffer ---
            if (net_ri && net_si) begin
                channel_input_buffer <= net_di;
            end

            // --- Send path: Output Buffer ? Router ---
            if (channel_output_buffer_status &&
                net_ro &&
                (net_polarity == channel_output_buffer[PACKET_WIDTH-1]))
            begin
                net_do  <= channel_output_buffer;
                net_so  <= 1'b1;
                // If previously blocked and CPU writes, grab next
                if (nicEnWR && nicEn && addr == 2'b10) begin
                    channel_output_buffer <= d_in;
                end else begin
                    channel_output_buffer <= {PACKET_WIDTH{1'b0}};
                end
            end else begin
                net_so <= 1'b0;
                net_do <= {PACKET_WIDTH{1'b0}};
            end

            // --- CPU write into output buffer (if empty) ---
            if (nicEnWR && nicEn && addr == 2'b10 && !channel_output_buffer_status) begin
                channel_output_buffer <= d_in;
            end
        end
    end

    // -------------------------------------------------------------------------
    // CPU read logic (combinational): drives d_out
    // -------------------------------------------------------------------------
    always @(*) begin
        if (nicEn && !nicEnWR) begin
            case (addr)
                2'b00: d_out = channel_input_buffer;                                 // Read data
                2'b01: d_out = {{(PACKET_WIDTH-1){1'b0}}, channel_input_buffer_status}; // Input status
                2'b10: d_out = {PACKET_WIDTH{1'b0}};                                  // Invalid
                2'b11: d_out = {{(PACKET_WIDTH-1){1'b0}}, channel_output_buffer_status}; // Output status
                default: d_out = {PACKET_WIDTH{1'b0}};
            endcase
        end else begin
            d_out = {PACKET_WIDTH{1'b0}};
        end
    end

endmodule
