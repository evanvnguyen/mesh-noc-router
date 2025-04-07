module tb_router();
  reg clk, reset;
  reg cwsi, ccwsi, pesi, cwro, ccwro, pero, nssi, snsi, nsro, snro;
  reg [63:0] cwdi, ccwdi, pedi, nsdi, sndi;
  reg [3:0] router_position;
  wire cwri, ccwri, peri, nsri, snri, cwso, ccwso, peso, nsso, snso, polarity_out;
  wire [63:0] cwdo, ccwdo, pedo, nsdo, sndo;
  
  reg [63:0] data_array [11:0];
  reg [10:0] passedTests;
  reg [63:0] returnedData [10:0];
  integer cycle_count, data_index, i;

  initial clk = 0;
  always #2 clk = ~clk; // 250 Mhz

  router uut(
    .clk(clk),
    .reset(reset),
    .router_position(router_position),
    .polarity_out(polarity_out),
    .cwsi(cwsi),
    .cwdi(cwdi),
    .cwri(cwri),
    .ccwsi(ccwsi),
    .ccwdi(ccwdi),
    .ccwri(ccwri),
    .pesi(pesi),
    .pedi(pedi),
    .peri(peri),
    .cwro(cwro),
    .cwso(cwso),
    .cwdo(cwdo),
    .ccwro(ccwro),
    .ccwso(ccwso),
    .ccwdo(ccwdo),
    .pero(pero),
    .peso(peso),
    .pedo(pedo),
    .nssi(nssi),
    .nsdi(nsdi),
    .nsri(nsri),
    .snsi(snsi),
    .sndi(sndi),
    .snri(snri),
    .nsro(nsro),
    .nsso(nsso),
    .nsdo(nsdo),
    .snro(snro),
    .snso(snso),
    .sndo(sndo)
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

    for (i = 0; i < 10; i = i + 1) begin
      returnedData[i] = 64'h0;
    end

    passedTests = 11'b0;

    cwsi = 0;
    ccwsi = 0;
    pesi = 0;
    cwro = 1;
    ccwro = 1;
    pero = 1;
    nssi = 0;
    snsi = 0;
    nsro = 1;
    snro = 1;
    cwdi = 64'b0;
    ccwdi = 64'b0;
    pedi = 64'b0;
    nsdi = 64'b0;
    sndi = 64'b0;
    router_position = 4'b0;
    cycle_count = 0;
    data_index = 0;

    reset = 1;
    #8
    reset = 0;
    #100

    for (i = 0; i < 11; i = i + 1) begin
      $display("Test %d %s, sent value %h, returned value %h", i, 
              (passedTests[i] ? "Passed" : "Failed"), data_array[i], returnedData[i]);
    end

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
      cwsi <= 0;
      ccwsi <= 0;
      pesi <= 0;
      nssi <= 0;
      snsi <= 0;
      cwdi <= 0;
      ccwdi <= 0;
      pedi <= 0;
      nsdi <= 0;
      sndi <= 0;

      run_tests();
/*       if (cycle_count == 3) begin
        // test case 2 tests loading data into the ccwsi virtual channel
        if (ccwri) begin
          ccwsi <= 1;
          ccwdi <= data_array[1];
        end  
      end

      if (cycle_count == 4) begin
        // test case 3 tests loading data into the pesi virtual channel
        if (peri) begin
          pesi <= 1;
          pedi <= data_array[2];
        end  
      end */

		end

    cycle_count <= cycle_count + 1;
	end

  task run_tests();
    begin
      case (cycle_count)
        3: begin // test case 1 tests loading data into the cwsi virtual channel
          if (cwri) begin
            cwsi <= 1;
            cwdi <= data_array[0];
          end
        end
        4: begin // test case 2 tests loading data into the ccwsi virtual channel
          if (ccwri) begin
            ccwsi <= 1;
            ccwdi <= data_array[1];
          end
        end
        5: begin // test case 3 tests loading data into the pesi virtual channel
          if (peri) begin
            pesi <= 1;
            pedi <= data_array[2];
          end          
        end
        6: begin // test case 4 tests loading data into the nssi virtual channel
          if (nsri) begin
            nssi <= 1;
            nsdi <= data_array[3];
          end
          
          if (cwdo[31:0] == data_array[0][31:0]) begin
            passedTests[0] <= 1'b1;
            returnedData[0] <= cwdo;
          end
        end
        7: begin // test case 5 tests loading data into the snsi virtual channel
          if (snri) begin
            snsi <= 1;
            sndi <= data_array[4];
          end

          if (ccwdo[31:0] == data_array[1][31:0]) begin
            passedTests[1] <= 1'b1;
            returnedData[1] <= ccwdo;
          end
        end
        8: begin // Tests that data goes to the pe output when there are not more hops
          if (ccwri) begin
            ccwsi <= 1;
            ccwdi <= data_array[11];
          end

          if (ccwdo[31:0] == data_array[2][31:0]) begin
            passedTests[2] <= 1'b1;
            returnedData[2] <= ccwdo;
          end
        end
        9: begin // test case 6 tests loading data into both pe and ccw at the same time. We should get a staggered output with both test cases
          if (peri) begin
            pesi <= 1;
            pedi <= data_array[5];
          end
          if (ccwri) begin
            ccwsi <= 1;
            ccwdi <= data_array[6];
          end

          if (nsdo[31:0] == data_array[3][31:0]) begin
            passedTests[3] <= 1'b1;
            returnedData[3] <= nsdo;
          end
        end
        10: begin
          if (sndo[31:0] == data_array[4][31:0]) begin
            passedTests[4] <= 1'b1;
            returnedData[4] <= sndo;
          end
        end
        12: begin
          if (ccwdo[31:0] == data_array[5][31:0]) begin
            passedTests[5] <= 1'b1;
            returnedData[5] <= ccwdo;
          end else if (ccwdo[31:0] == data_array[6][31:0]) begin
            passedTests[6] <= 1'b1;
            returnedData[6] <= ccwdo;
          end
        end

        14: begin
          if (peri) begin
            pesi <= 1;
            pedi <= data_array[7];
          end
          if (ccwri) begin
            ccwsi <= 1;
            ccwdi <= data_array[8];
          end
          if (cwri) begin
            cwsi <= 1;
            cwdi <= data_array[9];
          end
          if (nsri) begin
            nssi <= 1;
            nsdi <= data_array[10];
          end

          if (ccwdo[31:0] == data_array[5][31:0]) begin
            passedTests[5] <= 1'b1;
            returnedData[5] <= ccwdo;
          end else if (ccwdo[31:0] == data_array[6][31:0]) begin
            passedTests[6] <= 1'b1;
            returnedData[6] <= ccwdo;
          end
        end

        17: begin
          if (nsdo[31:0] == data_array[7][31:0]) begin
            passedTests[7] <= 1'b1;
            returnedData[7] <= nsdo;
          end else if (nsdo[31:0] == data_array[8][31:0]) begin
            passedTests[8] <= 1'b1;
            returnedData[8] <= nsdo;
          end else if (nsdo[31:0] == data_array[9][31:0]) begin
            passedTests[9] <= 1'b1;
            returnedData[9] <= nsdo;
          end else if (nsdo[31:0] == data_array[10][31:0]) begin
            passedTests[10] <= 1'b1;
            returnedData[10] <= nsdo;
          end
        end

       19: begin
          if (nsdo[31:0] == data_array[7][31:0]) begin
            passedTests[7] <= 1'b1;
            returnedData[7] <= nsdo;
          end else if (nsdo[31:0] == data_array[8][31:0]) begin
            passedTests[8] <= 1'b1;
            returnedData[8] <= nsdo;
          end else if (nsdo[31:0] == data_array[9][31:0]) begin
            passedTests[9] <= 1'b1;
            returnedData[9] <= nsdo;
          end else if (nsdo[31:0] == data_array[10][31:0]) begin
            passedTests[10] <= 1'b1;
            returnedData[10] <= nsdo;
          end
        end

        21: begin
          if (nsdo[31:0] == data_array[7][31:0]) begin
            passedTests[7] <= 1'b1;
            returnedData[7] <= nsdo;
          end else if (nsdo[31:0] == data_array[8][31:0]) begin
            passedTests[8] <= 1'b1;
            returnedData[8] <= nsdo;
          end else if (nsdo[31:0] == data_array[9][31:0]) begin
            passedTests[9] <= 1'b1;
            returnedData[9] <= nsdo;
          end else if (nsdo[31:0] == data_array[10][31:0]) begin
            passedTests[10] <= 1'b1;
            returnedData[10] <= nsdo;
          end
        end

        23: begin
          if (nsdo[31:0] == data_array[7][31:0]) begin
            passedTests[7] <= 1'b1;
            returnedData[7] <= nsdo;
          end else if (nsdo[31:0] == data_array[8][31:0]) begin
            passedTests[8] <= 1'b1;
            returnedData[8] <= nsdo;
          end else if (nsdo[31:0] == data_array[9][31:0]) begin
            passedTests[9] <= 1'b1;
            returnedData[9] <= nsdo;
          end else if (nsdo[31:0] == data_array[10][31:0]) begin
            passedTests[10] <= 1'b1;
            returnedData[10] <= nsdo;
          end
        end
      endcase
    end
  endtask
endmodule