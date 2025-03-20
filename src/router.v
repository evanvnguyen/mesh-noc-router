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

  wire cw_granted;
  wire ccw_granted;
  wire [1:0] pe_granted;
  wire [1:0] ns_granted;
  wire [1:0] sn_granted;

  wire cw_out_blocked;
  wire ccw_out_blocked;
  wire pe_out_blocked;
  wire ns_out_blocked;
  wire sn_out_blocked;

  reg cw_in_blocked;
  reg ccw_in_blocked;
  reg pe_in_blocked;
  reg ns_in_blocked;
  reg sn_in_blocked;

  // These will be used to connect the output of the input channels
  // to the input of the output channels. This connection will be determined
  // by the arbiter.
  wire [63:0] cw_data_out;
  wire [63:0] ccw_data_out;
  wire [63:0] pe_data_out;
  wire [63:0] ns_data_out;
  wire [63:0] sn_data_out;

  // These will be used to connect the output of the input channels
  // to the input of the output channels. This connection will be determined
  // by the arbiter.
  reg [63:0] cw_data_in;
  reg [63:0] ccw_data_in;
  reg [63:0] pe_data_in;
  reg [63:0] ns_data_in;
  reg [63:0] sn_data_in;

  // Instantiate the input and output channels of the router
  router_input_channel cw_input_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .send(cwsi),
    .blocked(cw_in_blocked),
    .data_in(cwdi),
    .ready(cwri),
    .data_out(cw_data_out)
  );

  router_input_channel ccw_input_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .send(ccwsi),
    .blocked(ccw_in_blocked),
    .data_in(ccwdi),
    .ready(ccwri),
    .data_out(ccw_data_out)
  );

  router_input_channel pe_input_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .send(pesi),
    .blocked(pe_in_blocked),
    .data_in(pedi),
    .ready(peri),
    .data_out(pe_data_out)
  );

  router_input_channel ns_input_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .send(nssi),
    .blocked(ns_in_blocked),
    .data_in(nsdi),
    .ready(nsri),
    .data_out(ns_data_out)
  );

  router_input_channel sn_input_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .send(snsi),
    .blocked(sn_in_blocked),
    .data_in(sndi),
    .ready(snri),
    .data_out(sn_data_out)
  );

  router_output_channel cw_output_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .ready(cwro),
    .data_in(cw_data_in),
    .blocked(cw_out_blocked),
    .send(cwso),
    .data_out(cwdo)
  );

  router_output_channel ccw_output_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .ready(ccwro),
    .data_in(ccw_data_in),
    .blocked(ccw_out_blocked),
    .send(ccwso),
    .data_out(ccwdo)
  );

  router_output_channel pe_output_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .ready(pero),
    .data_in(pe_data_in),
    .blocked(pe_out_blocked),
    .send(peso),
    .data_out(pedo)
  );

  router_output_channel ns_output_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .ready(nsro),
    .data_in(ns_data_in),
    .blocked(ns_out_blocked),
    .send(nsso),
    .data_out(nsdo)
  );

  router_output_channel sn_output_channel (
    .clk(clk),
    .reset(reset),
    .polarity(polarity),
    .ready(snro),
    .data_in(sn_data_in),
    .blocked(sn_out_blocked),
    .send(snso),
    .data_out(sndo)
  );

  // Arbiters
  two_way_arbiter cw_arbiter (
    .reset(reset),
    .requests(cw_requests),
    .blockedRequests({pe_in_blocked | pe_out_blocked,
                      cw_in_blocked | cw_out_blocked}),
    .granted(cw_granted)
  );

  two_way_arbiter ccw_arbiter (
    .reset(reset),
    .requests(ccw_requests),
    .blockedRequests({pe_in_blocked | pe_out_blocked,
                      cw_in_blocked | cw_out_blocked}),
    .granted(ccw_granted)
  );

  four_way_arbiter pe_arbiter (
    .reset(reset),
    .requests(pe_requests),
    .blockedRequests({sn_in_blocked | sn_out_blocked,
                      ns_in_blocked | ns_out_blocked,
                      ccw_in_blocked | ccw_out_blocked,
                      cw_in_blocked | cw_out_blocked}),
    .granted(pe_granted)
  );

  four_way_arbiter ns_arbiter (
    .reset(reset),
    .requests(ns_requests),
    .blockedRequests({ns_in_blocked | ns_out_blocked,
                      pe_in_blocked | pe_out_blocked,
                      ccw_in_blocked | ccw_out_blocked,
                      cw_in_blocked | cw_out_blocked}),
    .granted(ns_granted)
  );

  four_way_arbiter sn_arbiter (
    .reset(reset),
    .requests(sn_requests),
    .blockedRequests({sn_in_blocked | sn_out_blocked,
                      pe_in_blocked | pe_out_blocked,
                      ccw_in_blocked | ccw_out_blocked,
                      cw_in_blocked | cw_out_blocked}),
    .granted(sn_granted)
  );

  always @(posedge clk) begin
    if (reset) begin
      $display("Router: Resetting...");
      reset_clocked_values;
      polarity <= 1'b0;
    end else begin
      $display("Router: Looking at the granted requests");
      // more the data from the input channels to the output channels
      if (cw_requests > 0) begin
        $display("Router: CW requests are %b", cw_requests);
        if (cw_granted) begin
          $display("Router: CW granted PE data to go to CW output channel");
          cw_data_in <= pe_data_out;

          // If cw also requested to send data to cw out, we need to block it.
          cw_in_blocked <= cw_requests[0];
        end else begin
          $display("Router: CW granted CW data to go to CW output channel");
          cw_data_in <= cw_data_out;

          pe_in_blocked <= cw_requests[1];
        end
      end

      if (ccw_requests > 0) begin
        $display("Router: CCW requests are %b", ccw_requests);
        if (ccw_granted) begin
          $display("Router: CCW granted PE data to go to CCW output channel");
          ccw_data_in <= pe_data_out;

          ccw_in_blocked <= ccw_requests[0];
        end else begin
          $display("Router: CCW granted CW data to go to CCW output channel");
          ccw_data_in <= ccw_data_out;

          pe_in_blocked <= ccw_requests[1];
        end
      end

      // Index 0 is for cw, index 1 is for ccw, index 2 is for ns, and index 3 is for sn
      if (pe_requests > 0) begin
        case (pe_granted)
          2'b00: begin
            $display("Router: PE granted CW data to go to PE output channel");
            pe_data_in <= cw_data_out;
            ccw_in_blocked <= pe_requests[1];
            ns_in_blocked <= pe_requests[2];
            sn_in_blocked <= pe_requests[3];
          end
          2'b01: begin
            $display("Router: PE granted CCW data to go to PE output channel");
            pe_data_in <= ccw_data_out;
            cw_in_blocked <= pe_requests[0];
            ns_in_blocked <= pe_requests[2];
            sn_in_blocked <= pe_requests[3];
          end
          2'b10: begin 
            $display("Router: PE granted NS data to go to PE output channel");
            pe_data_in <= ns_data_out;
            cw_in_blocked <= pe_requests[0];
            ccw_in_blocked <= pe_requests[1];
            sn_in_blocked <= pe_requests[3];
          end
          2'b11: begin
            $display("Router: PE granted SN data to go to PE output channel");
            pe_data_in <= sn_data_out;
            cw_in_blocked <= pe_requests[0];
            ccw_in_blocked <= pe_requests[1];
            ns_in_blocked <= pe_requests[2];
          end
        endcase
      end

      // Index 0 is for cw, index 1 is for ccw, index 2 is for pe, and index 3 is for ns
      if (ns_requests > 0) begin
        case (ns_granted)
          2'b00: begin 
            $display("Router: NS granted CW data to go to NS output channel");
            ns_data_in <= cw_data_out; 
            ccw_in_blocked <= pe_requests[1];
            pe_in_blocked <= pe_requests[2];
            sn_in_blocked <= pe_requests[3];
          end
          2'b01: begin 
            $display("Router: NS granted CCW data to go to NS output channel");
            ns_data_in <= ccw_data_out; 
            cw_in_blocked <= pe_requests[0];
            pe_in_blocked <= pe_requests[2];
            sn_in_blocked <= pe_requests[3];
          end
          2'b10: begin 
            $display("Router: NS granted PE data to go to NS output channel");
            ns_data_in <= pe_data_out; 
            cw_in_blocked <= pe_requests[0];
            ccw_in_blocked <= pe_requests[1];
            sn_in_blocked <= pe_requests[3];
          end
          2'b11: begin 
            $display("Router: NS granted SN data to go to NS output channel");
            ns_data_in <= ns_data_out; 
            cw_in_blocked <= pe_requests[0];
            ccw_in_blocked <= pe_requests[1];
            pe_in_blocked <= pe_requests[2];
          end
        endcase
      end

      // Index 0 is for cw, index 1 is for ccw, index 2 is for pe, and index 3 is for sn
      if (sn_requests > 0) begin
        case (sn_granted)
          2'b00: begin 
            $display("Router: SN granted CW data to go to SN output channel");
            sn_data_in <= cw_data_out; 
            ccw_in_blocked <= pe_requests[1];
            pe_in_blocked <= pe_requests[2];
            sn_in_blocked <= pe_requests[3];
          end
          2'b01: begin
            $display("Router: SN granted CCW data to go to SN output channel");
            sn_data_in <= ccw_data_out; 
            cw_in_blocked <= pe_requests[0];
            pe_in_blocked <= pe_requests[2];
            sn_in_blocked <= pe_requests[3];
          end
          2'b10: begin
            $display("Router: SN granted PE data to go to SN output channel");
            sn_data_in <= pe_data_out; 
            cw_in_blocked <= pe_requests[0];
            ccw_in_blocked <= pe_requests[1];
            sn_in_blocked <= pe_requests[3];
          end
          2'b11: begin
            $display("Router: SN granted SN data to go to SN output channel");
            sn_data_in <= sn_data_out; 
            cw_in_blocked <= pe_requests[0];
            ccw_in_blocked <= pe_requests[1];
            pe_in_blocked <= pe_requests[2];
          end
        endcase
      end

      polarity <= ~polarity;
    end
  end

  always @(*) begin
    reset_values;
    if (!reset) begin
      $display("Router: Running router");
      $display("cw_data_in: %h, pe_data_out=%h", cw_data_in, pe_data_out);

      // We need to look at the direction of the data and figure out where to 
      // send it. We will use an arbiter to determine who has priority if
      // multiple channels are trying to send data to the same output channel.
      $display("Router: Checking CW data");
      check_cw_data;

      $display("Router: Checking CCW data");
      check_ccw_data;

      $display("Router: Checking NS data");
      check_ns_data;

      $display("Router: Checking SN data");
      check_sn_data;

      $display("Router: Checking PE data");
      check_pe_data;
    end            

    polarity_out = polarity;
  end

  task reset_clocked_values();
    begin
        cw_data_in <= 64'b0;
        ccw_data_in <= 64'b0;
        pe_data_in <= 64'b0;
        ns_data_in <= 64'b0;
        sn_data_in <= 64'b0;

        cw_in_blocked <= 1'b0;
        ccw_in_blocked <= 1'b0;
        pe_in_blocked <= 1'b0;
        ns_in_blocked <= 1'b0;
        sn_in_blocked <= 1'b0;
    end
  endtask

  task reset_values();
    begin
      cw_requests = 1'b0; 
      ccw_requests = 1'b0;
      pe_requests = 4'b0; 
      ns_requests = 4'b0; 
      sn_requests = 4'b0;
    end
  endtask

  task check_pe_data();
    begin
      if (pe_data_out != 64'b0) begin
        $display("Router: PE data is not 0");
        // Is the packet traveling from west to east and are there any hops left?
        if (pe_data_out[X_HOP_BIT: X_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
          if (pe_data_out[EAST_WEST_BIT] == WEST_TO_EAST) begin
            $display("Router: PE data is traveling west to east with %b hops left", pe_data_out[X_HOP_BIT: X_HOP_BIT-HOP_BIT_WIDTH]);
            cw_requests[1] = 1'b1;
          end else begin
            $display("Router: PE data is traveling east to west with %b hops left", pe_data_out[X_HOP_BIT: X_HOP_BIT-HOP_BIT_WIDTH]);
            ccw_requests[1] = 1'b1;
          end
        end else if (pe_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
          if (pe_data_out[NORTH_SOUTH_BIT] == NORTH_TO_SOUTH) begin
            $display("Router: PE data is traveling north to south with %b hops left", pe_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH]);
            ns_requests[2] = 1'b1;
          end else begin
            $display("Router: PE data is traveling south to north with %b hops left", pe_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH]);
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
      if (cw_data_out != 64'b0) begin
        $display("Router: CW data is not 0");
        // Is the packet traveling from west to east and are there any hops left?
        if (cw_data_out[EAST_WEST_BIT] == WEST_TO_EAST && 
            cw_data_out[X_HOP_BIT: X_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
          $display("Router: CW data is traveling west to east with %b hops left", cw_data_out[X_HOP_BIT: X_HOP_BIT-HOP_BIT_WIDTH]);
          cw_requests[0] = 1'b1;
        end else if (cw_data_out[NORTH_SOUTH_BIT] == NORTH_TO_SOUTH &&
                     cw_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
                    
          $display("Router: CW data is traveling north to south with %b hops left", cw_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH]);
          ns_requests[0] = 1'b1;
        end else begin
          if (cw_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
            $display("Router: CW data is traveling south to north with %b hops left", cw_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH]);
            sn_requests[0] = 1'b1;
          end else begin
            // There are no more hops left, so we've reached our destination.
            $display("Router: CW data is at its destination.");
            pe_requests[0] = 1'b1;
          end
        end
      end
    end
  endtask

  task check_ccw_data();
    begin
      // If traveling ccw, we use the same logic as traveling cw.
      if (ccw_data_out != 64'b0) begin
        $display("Router: CCW data is not 0");
        // Is the packet traveling from west to east and are there any hops left?
        if (ccw_data_out[EAST_WEST_BIT] == EAST_TO_WEST && 
            ccw_data_out[X_HOP_BIT: X_HOP_BIT-HOP_BIT_WIDTH] > 0) begin

          $display("Router: CCW data is traveling east to west with %b hops left", ccw_data_out[X_HOP_BIT: X_HOP_BIT-HOP_BIT_WIDTH]);
          ccw_requests[0] = 1'b1;
        end else if (ccw_data_out[NORTH_SOUTH_BIT] == NORTH_TO_SOUTH &&
                     ccw_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
        
          $display("Router: CCW data is traveling north to south with %b hops left", ccw_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH]);
          ns_requests[1] = 1'b1;
        end else begin
          if (ccw_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin
            $display("Router: CCW data is traveling south to north with %b hops left", ccw_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH]);
            sn_requests[1] = 1'b1;
          end else begin
            // There are no more hops left, so we've reached our destination.
            $display("Router: CCW data is at its destination.");
            pe_requests[1] = 1'b1;
          end
        end
      end
    end
  endtask

  task check_ns_data();
    begin
      // If traveling ns, we will conitnue to travel ns until it runs out of hops.
      if (ns_data_out != 64'b0) begin
        // Is the packet traveling from north to south and are there any hops left?
        if (ns_data_out[NORTH_SOUTH_BIT] == NORTH_TO_SOUTH && 
            ns_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin

          ns_requests[2] = 1'b1;
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
      if (sn_data_out != 64'b0) begin
        // Is the packet traveling from north to south and are there any hops left?
        if (sn_data_out[NORTH_SOUTH_BIT] == SOUTH_TO_NORTH && 
            sn_data_out[Y_HOP_BIT: Y_HOP_BIT-HOP_BIT_WIDTH] > 0) begin

          sn_requests[3] = 1'b1;
        end else begin
          // There are no more hops left, so we've reached our destination.
          pe_requests[3] = 1'b1;
        end
      end
    end
  endtask

endmodule