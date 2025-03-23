/*
* This module is the router that routes the input channels to the output channels.
* The router is responsible for abritrating the input channels to the output channels.
* The router has 4 input channels and 4 output channels, 
*  - cw: clockwise
*  - ccw: counter clockwise
*  - pe: processing element
*  - ns: north-south
*  - sn: south-north
*/

module router (
  input clk,
  input reset,
  input [3:0] router_position,
  output reg polarity_out,

  // cw input channel signals
  input cwsi,
  input [63:0] cwdi,
  output cwri,

  // ccw input channel signals
  input ccwsi,
  input [63:0] ccwdi,
  output ccwri,

  // pe input channel signals
  input pesi,
  input [63:0] pedi,
  output peri,

  // cw output channel signals
  input cwro,
  output cwso,
  output [63:0] cwdo,

  // ccw output channel signals
  input ccwro,
  output ccwso,
  output [63:0] ccwdo,

  // pe output channel signals
  input pero,
  output peso,
  output [63:0] pedo,

  // ns input channel signals
  input nssi,
  input [63:0] nsdi,
  output nsri,

  // sn input channel signals
  input snsi,
  input [63:0] sndi,
  output snri,

  // ns output channel signals
  input nsro,
  output nsso,
  output [63:0] nsdo,

  // sn output channel signals
  input snro,
  output snso,
  output [63:0] sndo
);

  // Top bit is [3], left bit[0], bottom bit[2], right bit[1]
  // T B R L
  // 0 0 0 0
  parameter TOP_LEFT      = 4'b1001;
  parameter TOP           = 4'b1000;
  parameter TOP_RIGHT     = 4'b1010;
  parameter RIGHT         = 4'b0010;
  parameter BOTTOM_RIGHT  = 4'b0110;
  parameter BOTTOM        = 4'b0100;
  parameter BOTTOM_LEFT   = 4'b0101;
  parameter LEFT          = 4'b0001;
  parameter CENTER        = 4'b0000;

  localparam NORTH_TO_SOUTH = 1'b0; 
  localparam SOUTH_TO_NORTH = 1'b1;
  localparam EAST_TO_WEST = 1'b0;
  localparam WEST_TO_EAST = 1'b1;

  // 1-bit for the VC
  localparam VC_BIT = 63;          // The bit that determines which virtual channel we are using
  // 2-bits for the direction
  localparam NORTH_SOUTH_BIT = 62; // The bit that determines if the data is going north to south or south to north
  localparam EAST_WEST_BIT = 61;   // The bit that determines if the data is going east to west or west to east
  // There are 5 reserved bits 60-56
  localparam Y_HOP_BIT = 55;       // The MSB that points to how many hops we have left in the Y direction
  localparam X_HOP_BIT = 51;       // The MSB that points to how many hops we have left in the X direction
  localparam HOP_BIT_WIDTH = 3;    // The width of the hop bits. 1-bit is excluded to make it simplier to use
  // 8 bits for the hop values
  localparam Y_SOURCE_BITS = 47;   // The bits that point to the source of the data in the Y direction
  localparam X_SOURCE_BITS = 39;   // The bits that point to the source of the data in the X direction
  localparam SOURCE_BIT_WIDTH = 7; // The width of the source bits. 1-bit is excluded to make it simplier to use
  // 16 bits for the source and the remain 32-bits are for the data

  reg polarity;

  // This will be used to see who has requested to send data to a given output channel.
  reg [1:0] cw_requests;  // Index 0 is for cw and index 1 is for pe
  reg [1:0] ccw_requests; // Index 0 is for ccw and index 1 is for pe
  reg [3:0] pe_requests;  // Index 0 is for cw, index 1 is for ccw, index 2 is for ns, and index 3 is for sn
  reg [3:0] ns_requests;  // Index 0 is for cw, index 1 is for ccw, index 2 is for pe, and index 3 is for ns
  reg [3:0] sn_requests;  // Index 0 is for cw, index 1 is for ccw, index 2 is for pe, and index 3 is for sn

  // These signals control which request was granted or allowed to pass to the given output channel
  wire cw_granted;
  wire ccw_granted;
  wire [1:0] pe_granted;
  wire [1:0] ns_granted;
  wire [1:0] sn_granted;

  wire cw_output_channel_blocked;
  wire ccw_output_channel_blocked;
  wire pe_output_channel_blocked;
  wire ns_output_channel_blocked;
  wire sn_output_channel_blocked;

  reg block_cw_input_channel;
  reg block_ccw_input_channel;
  reg block_pe_input_channel;
  reg block_ns_input_channel;
  reg block_sn_input_channel;

  // These will be used to connect the output of the input channels
  // to the input of the output channels. This connection will be determined
  // by the arbiter.
  wire [63:0] cw_input_channel_data_out;
  wire [63:0] ccw_input_channel_data_out;
  wire [63:0] pe_input_channel_data_out;
  wire [63:0] ns_input_channel_data_out;
  wire [63:0] sn_input_channel_data_out;

  // These will be used to connect the output of the input channels
  // to the input of the output channels. This connection will be determined
  // by the arbiter.
  reg [63:0] cw_output_channel_data_in;
  reg [63:0] ccw_output_channel_data_in;
  reg [63:0] pe_output_channel_data_in;
  reg [63:0] ns_output_channel_data_in;
  reg [63:0] sn_output_channel_data_in;

  // Instantiate the input and output channels of the router
  router_input_channel cw_input_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .send(cwsi),
    .blocked(block_cw_input_channel),
    .data_in(cwdi),
    .ready(cwri),
    .data_out(cw_input_channel_data_out)
  );

  router_input_channel ccw_input_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .send(ccwsi),
    .blocked(block_ccw_input_channel),
    .data_in(ccwdi),
    .ready(ccwri),
    .data_out(ccw_input_channel_data_out)
  );

  router_input_channel pe_input_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .send(pesi),
    .blocked(block_pe_input_channel),
    .data_in(pedi),
    .ready(peri),
    .data_out(pe_input_channel_data_out)
  );

  router_input_channel ns_input_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .send(nssi),
    .blocked(block_ns_input_channel),
    .data_in(nsdi),
    .ready(nsri),
    .data_out(ns_input_channel_data_out)
  );

  router_input_channel sn_input_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .send(snsi),
    .blocked(block_sn_input_channel),
    .data_in(sndi),
    .ready(snri),
    .data_out(sn_input_channel_data_out)
  );

  router_output_channel cw_output_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .ready(cwro),
    .data_in(cw_output_channel_data_in),
    .blocked(cw_output_channel_blocked),
    .send(cwso),
    .data_out(cwdo)
  );

  router_output_channel ccw_output_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .ready(ccwro),
    .data_in(ccw_output_channel_data_in),
    .blocked(ccw_output_channel_blocked),
    .send(ccwso),
    .data_out(ccwdo)
  );

  router_output_channel pe_output_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .ready(pero),
    .data_in(pe_output_channel_data_in),
    .blocked(pe_output_channel_blocked),
    .send(peso),
    .data_out(pedo)
  );

  router_output_channel ns_output_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .ready(nsro),
    .data_in(ns_output_channel_data_in),
    .blocked(ns_output_channel_blocked),
    .send(nsso),
    .data_out(nsdo)
  );

  router_output_channel sn_output_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .ready(snro),
    .data_in(sn_output_channel_data_in),
    .blocked(sn_output_channel_blocked),
    .send(snso),
    .data_out(sndo)
  );

  // Arbiters
  two_way_arbiter cw_arbiter (
    .reset(reset),
    .requests(cw_requests),
    .blockedRequests({block_pe_input_channel | pe_output_channel_blocked,
                      block_cw_input_channel | cw_output_channel_blocked}),
    .granted(cw_granted)
  );

  two_way_arbiter ccw_arbiter (
    .reset(reset),
    .requests(ccw_requests),
    .blockedRequests({block_pe_input_channel | pe_output_channel_blocked,
                      block_ccw_input_channel | ccw_output_channel_blocked}),
    .granted(ccw_granted)
  );

  four_way_arbiter pe_arbiter (
    .reset(reset),
    .requests(pe_requests),
    .blockedRequests({block_sn_input_channel | sn_output_channel_blocked,
                      block_ns_input_channel | ns_output_channel_blocked,
                      block_ccw_input_channel | ccw_output_channel_blocked,
                      block_cw_input_channel | cw_output_channel_blocked}),
    .granted(pe_granted)
  );

  four_way_arbiter ns_arbiter (
    .reset(reset),
    .requests(ns_requests),
    .blockedRequests({block_ns_input_channel | ns_output_channel_blocked,
                      block_pe_input_channel | pe_output_channel_blocked,
                      block_ccw_input_channel | ccw_output_channel_blocked,
                      block_cw_input_channel | cw_output_channel_blocked}),
    .granted(ns_granted)
  );

  four_way_arbiter sn_arbiter (
    .reset(reset),
    .requests(sn_requests),
    .blockedRequests({block_sn_input_channel | sn_output_channel_blocked,
                      block_pe_input_channel | pe_output_channel_blocked,
                      block_ccw_input_channel | ccw_output_channel_blocked,
                      block_cw_input_channel | cw_output_channel_blocked}),
    .granted(sn_granted)
  );

  always @(posedge clk) begin
    if (reset) begin
      reset_clocked_values;
      polarity <= 1'b0;
    end else begin
      reset_clocked_values;

      polarity <= ~polarity;
    end
  end

  always @(*) begin
    reset_values;
    if (!reset) begin
      // We need to look at the direction of the data and figure out where to 
      // send it. We will use an arbiter to determine who has priority if
      // multiple channels are trying to send data to the same output channel.
      check_cw_data;

      check_ccw_data;

      check_ns_data;

      check_sn_data;

      check_pe_data;

      execute_requests;

      block_channels;
    end            

    polarity_out = polarity;
  end

  task reset_clocked_values();
    begin
      if (reset) begin
        block_cw_input_channel = 1'b0;
        block_ccw_input_channel = 1'b0;
        block_pe_input_channel = 1'b0;
        block_ns_input_channel = 1'b0;
        block_sn_input_channel = 1'b0;
      end
    end
  endtask

  task reset_values();
    begin
      cw_requests = 1'b0; 
      ccw_requests = 1'b0;
      pe_requests = 4'b0; 
      ns_requests = 4'b0; 
      sn_requests = 4'b0;

      cw_output_channel_data_in = 64'b0;
      ccw_output_channel_data_in = 64'b0;
      pe_output_channel_data_in = 64'b0;
      ns_output_channel_data_in = 64'b0;
      sn_output_channel_data_in = 64'b0;

      if (reset) begin
        block_cw_input_channel = 1'b0;
        block_ccw_input_channel = 1'b0;
        block_pe_input_channel = 1'b0;
        block_ns_input_channel = 1'b0;
        block_sn_input_channel = 1'b0;
      end
    end
  endtask

  task check_pe_data();
    begin
      if (pe_input_channel_data_out != 64'b0) begin
        // Is the packet traveling from west to east and are there any hops left?
        if (pe_input_channel_data_out[X_HOP_BIT: X_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
          if (pe_input_channel_data_out[EAST_WEST_BIT] == WEST_TO_EAST) begin
            cw_requests[1] = 1'b1;
          end else begin
            ccw_requests[1] = 1'b1;
          end
        end else if (pe_input_channel_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
          if (pe_input_channel_data_out[NORTH_SOUTH_BIT] == NORTH_TO_SOUTH) begin
            ns_requests[2] = 1'b1;
          end else begin
            sn_requests[2] = 1'b1;
          end
        end
      end
    end
  endtask

  task check_cw_data();
    begin
      // If traveling cw, we will conitnue to travel cw until it runs out of hops.
      // After that, we will travel ns or sn until it runs out of hops.
      // Once we are out of y hops and x hops we have reached our destination and
      // we will send the data to the processing element.
      if (cw_input_channel_data_out != 64'b0) begin
        // Is the packet traveling from west to east and are there any hops left?
        if (cw_input_channel_data_out[EAST_WEST_BIT] == WEST_TO_EAST && 
            cw_input_channel_data_out[X_HOP_BIT: X_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
          cw_requests[0] = 1'b1;
        end else if (cw_input_channel_data_out[NORTH_SOUTH_BIT] == NORTH_TO_SOUTH &&
                     cw_input_channel_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
          ns_requests[0] = 1'b1;
        end else begin
          if (cw_input_channel_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
            sn_requests[0] = 1'b1;
          end else begin
            // There are no more hops left, so we've reached our destination.
            pe_requests[0] = 1'b1;
          end
        end
      end
    end
  endtask

  task check_ccw_data();
    begin
      // If traveling ccw, we use the same logic as traveling cw.
      if (ccw_input_channel_data_out != 64'b0) begin
        // Is the packet traveling from west to east and are there any hops left?
        if (ccw_input_channel_data_out[EAST_WEST_BIT] == EAST_TO_WEST && 
            ccw_input_channel_data_out[X_HOP_BIT: X_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
          ccw_requests[0] = 1'b1;
        end else if (ccw_input_channel_data_out[NORTH_SOUTH_BIT] == NORTH_TO_SOUTH &&
                     ccw_input_channel_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
          ns_requests[1] = 1'b1;
        end else begin
          if (ccw_input_channel_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
            sn_requests[1] = 1'b1;
          end else begin
            // There are no more hops left, so we've reached our destination.
            pe_requests[1] = 1'b1;
          end
        end
      end
    end
  endtask

  task check_ns_data();
    begin
      // If traveling ns, we will conitnue to travel ns until it runs out of hops.
      if (ns_input_channel_data_out != 64'b0) begin
        // Is the packet traveling from north to south and are there any hops left?
        if (ns_input_channel_data_out[NORTH_SOUTH_BIT] == NORTH_TO_SOUTH && 
            ns_input_channel_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
          ns_requests[3] = 1'b1;
        end else begin
          // There are no more hops left, so we've reached our destination.
          pe_requests[2] = 1'b1;
        end
      end
    end
  endtask

  task check_sn_data();
    begin
      // If traveling sn, we will conitnue to travel sn until it runs out of hops.
      if (sn_input_channel_data_out != 64'b0) begin
        // Is the packet traveling from north to south and are there any hops left?
        if (sn_input_channel_data_out[NORTH_SOUTH_BIT] == SOUTH_TO_NORTH && 
            sn_input_channel_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
          sn_requests[3] = 1'b1;
        end else begin
          // There are no more hops left, so we've reached our destination.
          pe_requests[3] = 1'b1;
        end
      end
    end
  endtask

  task execute_requests();
    begin
      // more the data from the input channels to the output channels
      if (cw_requests > 0) begin
        if (cw_granted) begin
          cw_output_channel_data_in = {pe_input_channel_data_out[63:52], pe_input_channel_data_out[51:48] >> 1, pe_input_channel_data_out[47:0]};
        end else begin
          cw_output_channel_data_in = {cw_input_channel_data_out[63:52], cw_input_channel_data_out[51:48] >> 1, cw_input_channel_data_out[47:0]};
        end
      end

      if (ccw_requests > 0) begin
        if (ccw_granted) begin
          ccw_output_channel_data_in = {pe_input_channel_data_out[63:52], pe_input_channel_data_out[51:48] >> 1, pe_input_channel_data_out[47:0]};
        end else begin
          ccw_output_channel_data_in = {ccw_input_channel_data_out[63:52], ccw_input_channel_data_out[51:48] >> 1, ccw_input_channel_data_out[47:0]};
        end
      end

      // Index 0 is for cw, index 1 is for ccw, index 2 is for ns, and index 3 is for sn
      if (pe_requests > 0) begin
        case (pe_granted)
          2'b00: begin
            pe_output_channel_data_in = {cw_input_channel_data_out[63:52], cw_input_channel_data_out[51:48] >> 1, cw_input_channel_data_out[47:0]};
          end
          2'b01: begin
            pe_output_channel_data_in = {ccw_input_channel_data_out[63:52], ccw_input_channel_data_out[51:48] >> 1, ccw_input_channel_data_out[47:0]};
          end
          2'b10: begin 
            pe_output_channel_data_in = {ns_input_channel_data_out[63:56], ns_input_channel_data_out[55:52] >> 1, ns_input_channel_data_out[51:0]};
          end
          2'b11: begin
            pe_output_channel_data_in = {sn_input_channel_data_out[63:56], sn_input_channel_data_out[55:52] >> 1, sn_input_channel_data_out[51:0]};
          end
        endcase
      end

      // Index 0 is for cw, index 1 is for ccw, index 2 is for pe, and index 3 is for ns
      if (ns_requests > 0) begin
        case (ns_granted)
          2'b00: begin 
            ns_output_channel_data_in = {cw_input_channel_data_out[63:56], cw_input_channel_data_out[55:52] >> 1, cw_input_channel_data_out[51:0]};
          end
          2'b01: begin 
            ns_output_channel_data_in = {ccw_input_channel_data_out[63:56], ccw_input_channel_data_out[55:52] >> 1, ccw_input_channel_data_out[51:0]}; 
          end
          2'b10: begin 
            ns_output_channel_data_in = {pe_input_channel_data_out[63:56], pe_input_channel_data_out[55:52] >> 1, pe_input_channel_data_out[51:0]};
          end
          2'b11: begin 
            ns_output_channel_data_in = {ns_input_channel_data_out[63:56], ns_input_channel_data_out[55:52] >> 1, ns_input_channel_data_out[51:0]};
          end
        endcase
      end

      // Index 0 is for cw, index 1 is for ccw, index 2 is for pe, and index 3 is for sn
      if (sn_requests > 0) begin
        case (sn_granted)
          2'b00: begin 
            sn_output_channel_data_in = {cw_input_channel_data_out[63:56], cw_input_channel_data_out[55:52] >> 1, cw_input_channel_data_out[51:0]};
          end
          2'b01: begin
            sn_output_channel_data_in = {ccw_input_channel_data_out[63:56], ccw_input_channel_data_out[55:52] >> 1, ccw_input_channel_data_out[51:0]}; 
          end
          2'b10: begin
            sn_output_channel_data_in = {pe_input_channel_data_out[63:56], pe_input_channel_data_out[55:52] >> 1, pe_input_channel_data_out[51:0]};
          end
          2'b11: begin
            sn_output_channel_data_in = {sn_input_channel_data_out[63:56], sn_input_channel_data_out[55:52] >> 1, sn_input_channel_data_out[51:0]};
          end
        endcase
      end
    end
  endtask

  task block_channels();
    begin
      block_cw_input_channel = 1'b0;
      block_ccw_input_channel = 1'b0;
      block_pe_input_channel = 1'b0;
      block_ns_input_channel = 1'b0;
      block_sn_input_channel = 1'b0;

      // more the data from the input channels to the output channels
      if (cw_requests > 0) begin
        if (cw_granted) begin
          // If cw also requested to send data to cw out, we need to block it.
          block_cw_input_channel = cw_requests[0];
        end else begin
          block_pe_input_channel = cw_requests[1];
        end
      end

      if (ccw_requests > 0) begin
        if (ccw_granted) begin
          block_ccw_input_channel = ccw_requests[0];
        end else begin
          block_pe_input_channel = ccw_requests[1];
        end
      end

      // Index 0 is for cw, index 1 is for ccw, index 2 is for ns, and index 3 is for sn
      if (pe_requests > 0) begin
        case (pe_granted)
          2'b00: begin
            block_ccw_input_channel = pe_requests[1];
            block_ns_input_channel = pe_requests[2];
            block_sn_input_channel = pe_requests[3];
          end
          2'b01: begin
            block_cw_input_channel = pe_requests[0];
            block_ns_input_channel = pe_requests[2];
            block_sn_input_channel = pe_requests[3];
          end
          2'b10: begin 
            block_cw_input_channel = pe_requests[0];
            block_ccw_input_channel = pe_requests[1];
            block_sn_input_channel = pe_requests[3];
          end
          2'b11: begin
            block_cw_input_channel = pe_requests[0];
            block_ccw_input_channel = pe_requests[1];
            block_ns_input_channel = pe_requests[2];
          end
        endcase
      end

      // Index 0 is for cw, index 1 is for ccw, index 2 is for pe, and index 3 is for ns
      if (ns_requests > 0) begin
        case (ns_granted)
          2'b00: begin 
            block_ccw_input_channel = ns_requests[1];
            block_pe_input_channel = ns_requests[2];
            block_ns_input_channel = ns_requests[3];
          end
          2'b01: begin 
            block_cw_input_channel = ns_requests[0];
            block_pe_input_channel = ns_requests[2];
            block_ns_input_channel = ns_requests[3];
          end
          2'b10: begin 
            block_cw_input_channel = ns_requests[0];
            block_ccw_input_channel = ns_requests[1];
            block_ns_input_channel = ns_requests[3];
          end
          2'b11: begin 
            block_cw_input_channel = ns_requests[0];
            block_ccw_input_channel = ns_requests[1];
            block_pe_input_channel = ns_requests[2];
          end
        endcase
      end

      // Index 0 is for cw, index 1 is for ccw, index 2 is for pe, and index 3 is for sn
      if (sn_requests > 0) begin
        case (sn_granted)
          2'b00: begin 
            block_ccw_input_channel = sn_requests[1];
            block_pe_input_channel = sn_requests[2];
            block_sn_input_channel = sn_requests[3];
          end
          2'b01: begin
            block_cw_input_channel = sn_requests[0];
            block_pe_input_channel = sn_requests[2];
            block_sn_input_channel = sn_requests[3];
          end
          2'b10: begin
            block_cw_input_channel = sn_requests[0];
            block_ccw_input_channel = sn_requests[1];
            block_sn_input_channel = sn_requests[3];
          end
          2'b11: begin
            block_cw_input_channel = sn_requests[0];
            block_ccw_input_channel = sn_requests[1];
            block_pe_input_channel = sn_requests[2];
          end
        endcase
      end
    end
  endtask

endmodule