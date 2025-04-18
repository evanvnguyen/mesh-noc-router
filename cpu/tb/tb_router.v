module tb_router();
  reg clk, reset;
  reg node_0_cwsi, node_0_ccwsi, node_0_pesi, node_0_cwro, node_0_ccwro, node_0_pero, node_0_nssi, node_0_snsi, node_0_nsro, node_0_snro;
  reg [63:0] node_0_cwdi, node_0_ccwdi, node_0_pedi, node_0_nsdi, node_0_sndi;
  reg [3:0] node_0_router_position;
  wire node_0_cwri, node_0_ccwri, node_0_peri, node_0_nsri, node_0_snri, node_0_cwso, node_0_ccwso, node_0_peso, node_0_nsso, node_0_snso, node_0_polarity_out;
  wire [63:0] node_0_cwdo, node_0_ccwdo, node_0_pedo, node_0_nsdo, node_0_sndo;
  
  reg node_1_cwsi, node_1_ccwsi, node_1_pesi, node_1_cwro, node_1_pero, node_1_nssi, node_1_snsi, node_1_snro;
  reg [63:0] node_1_cwdi, node_1_ccwdi, node_1_pedi, node_1_nsdi, node_1_sndi;
  reg [3:0] node_1_router_position;
  wire node_1_cwri, node_1_ccwri, node_1_peri, node_1_nsri, node_1_snri, node_1_cwso, node_1_ccwso, node_1_peso, node_1_nsso, node_1_snso, node_1_polarity_out, node_1_ccwro;
  wire [63:0] node_1_cwdo, node_1_ccwdo, node_1_pedo, node_1_nsdo, node_1_sndo, node_1_nsro;
  
  reg [63:0] data_array [11:0];
  reg [63:0] data_array_heavy [29:0];
  reg [63:0] node_1_data_array_heavy [29:0];
  reg [10:0] passedTests;
  reg [63:0] returnedData [10:0];
  integer cycle_count, data_index, i, data_out_count, node_0_ccw_count, node_0_ns_count, node_1_ccw_count, node_1_ns_count;

  initial clk = 0;
  always #2 clk = ~clk; // 250 Mhz

  router node_0(
    .clk(clk),
    .reset(reset),
    .router_position(node_0_router_position),
    .polarity_out(node_0_polarity_out),
    .cwsi(node_1_ccwo),
    .cwdi(node_1_ccwo),
    .cwri(node_1_ccwo),
    .ccwsi(node_0_ccwsi),
    .ccwdi(node_0_ccwdi),
    .ccwri(node_0_ccwri),
    .pesi(node_0_pesi),
    .pedi(node_0_pedi),
    .peri(node_0_peri),
    .cwro(node_0_cwro),
    .cwso(node_0_cwso),
    .cwdo(node_0_cwdo),
    .ccwro(node_0_ccwro),
    .ccwso(node_0_ccwso),
    .ccwdo(node_0_ccwdo),
    .pero(node_0_pero),
    .peso(node_0_peso),
    .pedo(node_0_pedo),
    .nssi(node_0_nssi),
    .nsdi(node_0_nsdi),
    .nsri(node_0_nsri),
    .snsi(node_1_snso),
    .sndi(node_1_sndo),
    .snri(node_1_snro),
    .nsro(node_0_nsro),
    .nsso(node_0_nsso),
    .nsdo(node_0_nsdo),
    .snro(node_0_snro),
    .snso(node_0_snso),
    .sndo(node_0_sndo)
  );

  router node_1 (
    .clk(clk),
    .reset(reset),
    .router_position(node_1_router_position),
    .polarity_out(node_1_polarity_out),
    .cwsi(node_1_cwsi),
    .cwdi(node_1_cwdi),
    .cwri(node_1_cwri),
    .ccwsi(node_1_ccwsi),
    .ccwdi(node_1_ccwdi),
    .ccwri(node_1_ccwri),
    .pesi(node_1_pesi),
    .pedi(node_1_pedi),
    .peri(node_1_peri),
    .cwro(node_1_cwro),
    .cwso(node_1_cwso),
    .cwdo(node_1_cwdo),
    .ccwro(node_1_ccwro),
    .ccwso(node_1_ccwso),
    .ccwdo(node_1_ccwdo),
    .pero(node_1_pero),
    .peso(node_1_peso),
    .pedo(node_1_pedo),
    .nssi(node_1_nssi),
    .nsdi(node_1_nsdi),
    .nsri(node_1_nsri),
    .snsi(node_1_snsi),
    .sndi(node_1_sndi),
    .snri(node_1_snri),
    .nsro(node_1_nsro),
    .nsso(node_1_nsso),
    .nsdo(node_1_nsdo),
    .snro(node_1_snro),
    .snso(node_1_snso),
    .sndo(node_1_sndo)
  );

  initial begin
    //$dumpfile("iverilog-out/dump.vcd");
    //$dumpvars(0, tb_router);
    data_array[0] = 64'h200200000000FA50; // CW -> cw 2 hops
    data_array[1] = 64'h0002000000006840; // CCW -> CCW 2 hops
    data_array[2] = 64'h401200000000ffff; // PE -> CCW 1 hop
    data_array[3] = 64'h001000000000c7d4; // NS -> NS 1 hop
    data_array[4] = 64'h40100000ffffffff; // SN -> SN 1 hop

    // This should test a 2 part contention
    data_array[5] = 64'h00120000000fba34; // PE -> CCW 2 hops
    data_array[6] = 64'h0002000000053fda; // CCW -> CCW 2 hops

    // Now Let's test a 4 way contention to NS
    data_array[7] = 64'h0010000000abcdef;
    data_array[8] = 64'h0010000012345678;
    data_array[9] = 64'h0010000000def123;
    data_array[10] = 64'h0010000000011a11;

    data_array[11] = 64'h00000000000dda42;

    data_array_heavy[0] = 64'hC0100100DFF812AA;
    data_array_heavy[1] = 64'h401001001EB066A8;
    data_array_heavy[2] = 64'hC010010066AC331A;
    data_array_heavy[3] = 64'h401001000A420F15;
    data_array_heavy[4] = 64'hC01001009BEE4FA7;
    data_array_heavy[5] = 64'h40100100C318552B;
    data_array_heavy[6] = 64'hC0100100125050B9;
    data_array_heavy[7] = 64'h401001001F34F62C;
    data_array_heavy[8] = 64'hC01001008D978A29;
    data_array_heavy[9] = 64'h40100100C5E92FA4;
    data_array_heavy[10] = 64'hE01001007B0B46A1;
    data_array_heavy[11] = 64'h601001008ADF56C8;
    data_array_heavy[12] = 64'hE0100100121ABC7C;
    data_array_heavy[13] = 64'h601001007F435666;
    data_array_heavy[14] = 64'hE0100100704E8F62;

    data_array_heavy[15] = 64'h00000001B95C7423;
    data_array_heavy[16] = 64'h80000001255A9CF6;
    data_array_heavy[17] = 64'h0000000115DD6567;
    data_array_heavy[18] = 64'h80000001E597ECD5;
    data_array_heavy[19] = 64'h00000001EC6DB183;
    data_array_heavy[20] = 64'h800000012D67BC6B;
    data_array_heavy[21] = 64'h00000001BBA1C816;
    data_array_heavy[22] = 64'h800000017DB48FD6;
    data_array_heavy[23] = 64'h00000001240E0216;
    data_array_heavy[24] = 64'h80000001A14839F2;
    data_array_heavy[25] = 64'h000000013333DDAE;
    data_array_heavy[26] = 64'h80000001F48EC614;
    data_array_heavy[27] = 64'h000000017684D401;
    data_array_heavy[28] = 64'h800000012F7B31F5;
    data_array_heavy[29] = 64'h00000001BF2AA8F2;

    node_1_data_array_heavy[0] = 64'hC0100100DFF812FF;
    node_1_data_array_heavy[1] = 64'h401001001EB066FF;
    node_1_data_array_heavy[2] = 64'hC010010066AC33FF;
    node_1_data_array_heavy[3] = 64'h401001000A420FFF;
    node_1_data_array_heavy[4] = 64'hC01001009BEE4FFF;
    node_1_data_array_heavy[5] = 64'h40100100C31855FF;
    node_1_data_array_heavy[6] = 64'hC0100100125050FF;
    node_1_data_array_heavy[7] = 64'h401001001F34F6FF;
    node_1_data_array_heavy[8] = 64'hC01001008D978AFF;
    node_1_data_array_heavy[9] = 64'h40100100C5E92FFF;
    node_1_data_array_heavy[10] = 64'hE01001007B0B46FF;
    node_1_data_array_heavy[11] = 64'h601001008ADF56FF;
    node_1_data_array_heavy[12] = 64'hE0100100121ABCFF;
    node_1_data_array_heavy[13] = 64'h601001007F4356FF;
    node_1_data_array_heavy[14] = 64'hE0100100704E8FFF;

    node_1_data_array_heavy[15] = 64'h00010001B95CFFFF;
    node_1_data_array_heavy[16] = 64'h80010001255AFFFF;
    node_1_data_array_heavy[17] = 64'h0001000115DDFFFF;
    node_1_data_array_heavy[18] = 64'h80010001E597FFFF;
    node_1_data_array_heavy[19] = 64'h00010001EC6DFFFF;
    node_1_data_array_heavy[20] = 64'h800100012D67FFFF;
    node_1_data_array_heavy[21] = 64'h00010001BBA1FFFF;
    node_1_data_array_heavy[22] = 64'h800100017DB4FFFF;
    node_1_data_array_heavy[23] = 64'h00010001240EFFFF;
    node_1_data_array_heavy[24] = 64'h80010001A148FFFF;
    node_1_data_array_heavy[25] = 64'h000100013333FFFF;
    node_1_data_array_heavy[26] = 64'h80010001F48EFFFF;
    node_1_data_array_heavy[27] = 64'h000100017684FFFF;
    node_1_data_array_heavy[28] = 64'h800100012F7BFFFF;
    node_1_data_array_heavy[29] = 64'h00010001BF2AFFFF;

    for (i = 0; i < 10; i = i + 1) begin
      returnedData[i] = 64'h0;
    end

    passedTests = 11'b0;

    node_0_cwsi = 0;
    node_0_ccwsi = 0;
    node_0_pesi = 0;
    node_0_cwro = 1;
    node_0_ccwro = 1;
    node_0_pero = 1;
    node_0_nssi = 0;
    node_0_snsi = 0;
    node_0_nsro = 1;
    node_0_snro = 1;
    node_0_cwdi = 64'b0;
    node_0_ccwdi = 64'b0;
    node_0_pedi = 64'b0;
    node_0_nsdi = 64'b0;
    node_0_sndi = 64'b0;
    node_0_router_position = 4'b0;

    node_1_cwsi = 0;
    node_1_ccwsi = 0;
    node_1_pesi = 0;
    node_1_cwro = 1;
    node_1_pero = 1;
    node_1_nssi = 0;
    node_1_snsi = 0;
    node_1_snro = 1;
    node_1_cwdi = 64'b0;
    node_1_ccwdi = 64'b0;
    node_1_pedi = 64'b0;
    node_1_nsdi = 64'b0;
    node_1_sndi = 64'b0;
    node_1_router_position = 4'b0;

    cycle_count = 0;
    data_index = 0;
    data_out_count = 0;
    node_0_ccw_count = 15;
    node_0_ns_count = 0;
    node_1_ccw_count = 15;
    node_1_ns_count = 0;

    reset = 1;
    #8
    reset = 0;
    #200

    //for (i = 0; i < 11; i = i + 1) begin
    //  $display("Test %d %s, sent value %h, returned value %h", i, 
    //          (passedTests[i] ? "Passed" : "Failed"), data_array[i], returnedData[i]);
    //end

    $finish;
  end

  // always @(negedge clk) begin
  //   if (cycle_count == 20) begin
  //     if (peri) begin
  //       pesi <= 1;
  //       pedi <= data_array[5];
  //     end
  //     if (ccwri) begin
  //       ccwsi <= 1;
  //       ccwdi <= data_array[6];
  //     end
  //   end
  // end
    
	always @(posedge clk) begin
        if (!reset) begin
          node_0_cwsi <= 0;
          node_0_ccwsi <= 0;
          node_0_pesi <= 0;
          node_0_nssi <= 0;
          node_0_snsi <= 0;
          node_0_cwdi <= 0;
          node_0_ccwdi <= 0;
          node_0_pedi <= 0;
          node_0_nsdi <= 0;
          node_0_sndi <= 0;

          node_1_cwsi <= 0;
          node_1_ccwsi <= 0;
          node_1_pesi <= 0;
          node_1_nssi <= 0;
          node_1_snsi <= 0;
          node_1_cwdi <= 0;
          node_1_ccwdi <= 0;
          node_1_pedi <= 0;
          node_1_nsdi <= 0;
          node_1_sndi <= 0;
    
          //run_tests();
          
          if (cycle_count >= 3) begin
            if (node_0_nsri && node_0_ns_count < 16) begin
              node_0_nssi <= 1;
              node_0_nsdi <= data_array_heavy[node_0_ns_count];
              node_0_ns_count <= node_0_ns_count + 1;
            end else if (!node_0_nsri && node_0.block_ns_input_channel)
              node_0_ns_count <= node_0_ns_count - 1;
            if (node_0_ccwri && node_0_ccw_count < 30) begin
              node_0_ccwsi <= 1;
              node_0_ccwdi <= data_array_heavy[node_0_ccw_count];
              node_0_ccw_count <= node_0_ccw_count + 1;
            end else if (!node_0_ccwri && node_0.block_ccw_input_channel)
              node_0_ccw_count <= node_0_ccw_count - 1;


            if (node_1_nsri && node_1_ns_count < 16) begin
              node_1_nssi <= 1;
              node_1_nsdi <= node_1_data_array_heavy[node_1_ns_count];
              node_1_ns_count <= node_1_ns_count + 1;
            end else if (!node_1_nsri && node_1.block_ns_input_channel)
              node_1_ns_count <= node_1_ns_count - 1;
            if (node_1_ccwri && node_1_ccw_count < 31) begin
              node_1_ccwsi <= 1;
              node_1_ccwdi <= node_1_data_array_heavy[node_1_ccw_count];
              node_1_ccw_count <= node_1_ccw_count + 1;
            end else if (!node_1_ccwri && node_1.block_ccw_input_channel)
              node_1_ccw_count <= node_1_ccw_count - 1;
          end else begin
            node_0_cwsi <= 0;
            node_0_ccwsi <= 0;
            node_0_pesi <= 0;
            node_0_nssi <= 0;
            node_0_snsi <= 0;
            node_0_nsdi <= 0;
            node_1_cwsi <= 0;
            node_1_ccwsi <= 0;
            node_1_pesi <= 0;
            node_1_nssi <= 0;
            node_1_snsi <= 0;
            node_1_nsdi <= 0;
          end
          
//          if (cycle_count >= 5 && cycle_count <= 15)
//            pero <= 0;
//          else
//            pero <= 1;
          
          if (cycle_count > 3) begin
            if (node_0_pedo != 0) begin 
                $display("Pedo: %h, Cycle: %d, Count: %d", node_0_pedo, cycle_count, data_out_count);
                data_out_count = data_out_count + 1;
            end          
          end
        end
	end
	
	always @(posedge clk) begin
	   if (!reset)
	       cycle_count <= cycle_count + 1;
    end

  // task run_tests();
  //   begin
  //     case (cycle_count)
  //       3: begin // test case 1 tests loading data into the cwsi virtual channel
  //         if (cwri) begin
  //           cwsi <= 1;
  //           cwdi <= data_array[0];
  //         end
  //       end
  //       4: begin // test case 2 tests loading data into the ccwsi virtual channel
  //         if (ccwri) begin
  //           ccwsi <= 1;
  //           ccwdi <= data_array[1];
  //         end
  //       end
  //       5: begin // test case 3 tests loading data into the pesi virtual channel
  //         if (peri) begin
  //           pesi <= 1;
  //           pedi <= data_array[2];
  //         end          
  //       end
  //       6: begin // test case 4 tests loading data into the nssi virtual channel
  //         if (nsri) begin
  //           nssi <= 1;
  //           nsdi <= data_array[3];
  //         end
          
  //         if (cwdo[31:0] == data_array[0][31:0]) begin
  //           passedTests[0] <= 1'b1;
  //           returnedData[0] <= cwdo;
  //         end
  //       end
  //       7: begin // test case 5 tests loading data into the snsi virtual channel
  //         if (snri) begin
  //           snsi <= 1;
  //           sndi <= data_array[4];
  //         end

  //         if (ccwdo[31:0] == data_array[1][31:0]) begin
  //           passedTests[1] <= 1'b1;
  //           returnedData[1] <= ccwdo;
  //         end
  //       end
  //       8: begin // Tests that data goes to the pe output when there are not more hops
  //         if (ccwri) begin
  //           ccwsi <= 1;
  //           ccwdi <= data_array[11];
  //         end

  //         if (ccwdo[31:0] == data_array[2][31:0]) begin
  //           passedTests[2] <= 1'b1;
  //           returnedData[2] <= ccwdo;
  //         end
  //       end
  //       9: begin // test case 6 tests loading data into both pe and ccw at the same time. We should get a staggered output with both test cases
  //         if (peri) begin
  //           pesi <= 1;
  //           pedi <= data_array[5];
  //         end
  //         if (ccwri) begin
  //           ccwsi <= 1;
  //           ccwdi <= data_array[6];
  //         end

  //         if (nsdo[31:0] == data_array[3][31:0]) begin
  //           passedTests[3] <= 1'b1;
  //           returnedData[3] <= nsdo;
  //         end
  //       end
  //       10: begin
  //         if (sndo[31:0] == data_array[4][31:0]) begin
  //           passedTests[4] <= 1'b1;
  //           returnedData[4] <= sndo;
  //         end
  //       end
  //       12: begin
  //         if (ccwdo[31:0] == data_array[5][31:0]) begin
  //           passedTests[5] <= 1'b1;
  //           returnedData[5] <= ccwdo;
  //         end else if (ccwdo[31:0] == data_array[6][31:0]) begin
  //           passedTests[6] <= 1'b1;
  //           returnedData[6] <= ccwdo;
  //         end
  //       end

  //       14: begin
  //         if (peri) begin
  //           pesi <= 1;
  //           pedi <= data_array[7];
  //         end
  //         if (ccwri) begin
  //           ccwsi <= 1;
  //           ccwdi <= data_array[8];
  //         end
  //         if (cwri) begin
  //           cwsi <= 1;
  //           cwdi <= data_array[9];
  //         end
  //         if (nsri) begin
  //           nssi <= 1;
  //           nsdi <= data_array[10];
  //         end

  //         if (ccwdo[31:0] == data_array[5][31:0]) begin
  //           passedTests[5] <= 1'b1;
  //           returnedData[5] <= ccwdo;
  //         end else if (ccwdo[31:0] == data_array[6][31:0]) begin
  //           passedTests[6] <= 1'b1;
  //           returnedData[6] <= ccwdo;
  //         end
  //       end

  //       17: begin
  //         if (nsdo[31:0] == data_array[7][31:0]) begin
  //           passedTests[7] <= 1'b1;
  //           returnedData[7] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[8][31:0]) begin
  //           passedTests[8] <= 1'b1;
  //           returnedData[8] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[9][31:0]) begin
  //           passedTests[9] <= 1'b1;
  //           returnedData[9] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[10][31:0]) begin
  //           passedTests[10] <= 1'b1;
  //           returnedData[10] <= nsdo;
  //         end
  //       end

  //      19: begin
  //         if (nsdo[31:0] == data_array[7][31:0]) begin
  //           passedTests[7] <= 1'b1;
  //           returnedData[7] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[8][31:0]) begin
  //           passedTests[8] <= 1'b1;
  //           returnedData[8] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[9][31:0]) begin
  //           passedTests[9] <= 1'b1;
  //           returnedData[9] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[10][31:0]) begin
  //           passedTests[10] <= 1'b1;
  //           returnedData[10] <= nsdo;
  //         end
  //       end

  //       21: begin
  //         if (nsdo[31:0] == data_array[7][31:0]) begin
  //           passedTests[7] <= 1'b1;
  //           returnedData[7] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[8][31:0]) begin
  //           passedTests[8] <= 1'b1;
  //           returnedData[8] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[9][31:0]) begin
  //           passedTests[9] <= 1'b1;
  //           returnedData[9] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[10][31:0]) begin
  //           passedTests[10] <= 1'b1;
  //           returnedData[10] <= nsdo;
  //         end
  //       end

  //       23: begin
  //         if (nsdo[31:0] == data_array[7][31:0]) begin
  //           passedTests[7] <= 1'b1;
  //           returnedData[7] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[8][31:0]) begin
  //           passedTests[8] <= 1'b1;
  //           returnedData[8] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[9][31:0]) begin
  //           passedTests[9] <= 1'b1;
  //           returnedData[9] <= nsdo;
  //         end else if (nsdo[31:0] == data_array[10][31:0]) begin
  //           passedTests[10] <= 1'b1;
  //           returnedData[10] <= nsdo;
  //         end
  //       end
  //     endcase
  //   end
  // endtask
endmodule
