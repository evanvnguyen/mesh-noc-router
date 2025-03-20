module tb_router();
  reg clk, reset;
  reg cwsi, ccwsi, pesi, cwro, ccwro, pero, nssi, snsi, nsro, snro;
  reg [63:0] cwdi, ccwdi, pedi, nsdi, sndi;
  reg [3:0] router_position;
  wire cwri, ccwri, peri, nsri, snri, cwso, ccwso, peso, nsso, snso, polarity_out;
  wire [63:0] cwdo, ccwdo, pedo, nsdo, sndo;
  
  reg [63:0] data_array [10:0];
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
    $dumpfile("iverilog-out/dump.vcd");
    $dumpvars(0, tb_router);
    data_array[0] = 64'h200200000000FA50;
    data_array[1] = 64'h0002000000006840;
    data_array[2] = 64'h401200000000ffff;
    data_array[3] = 64'h401000000000c7d4;
    data_array[4] = 64'h00100000ffffffff;
    data_array[5] = 64'h00120000000fba34;
    data_array[6] = 64'h2002000000053fda;
    data_array[7] = 64'h2002000000abcdef;
    data_array[8] = 64'h2002000012345678;
    data_array[9] = 64'h2002000000def123;
    data_array[10] = 64'h2002000000011a11;

    for (i = 0; i < 10; i = i + 1) begin
      returnedData[i] = 64'h0;
      passedTests[i] = 11'b0;
    end

    cwsi = 0;
    ccwsi = 0;
    pesi = 0;
    cwro = 0;
    ccwro = 0;
    pero = 0;
    nssi = 0;
    snsi = 0;
    nsro = 0;
    snro = 0;
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
    #80

    $finish;
  end
    
	always @(posedge clk) begin
		if (!reset && cycle_count > 2) begin
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

      case (data_index)
        0: begin // test case 1 tests loading data into the cwsi virtual channel
          if (cwri) begin
            cwsi <= 1;
            cwdi <= data_array[0];
          end
        end
        1: begin // test case 2 tests loading data into the ccwsi virtual channel
          if (ccwri) begin
            ccwsi <= 1;
            ccwdi <= data_array[1];
          end
        end
        2: begin // test case 3 tests loading data into the pesi virtual channel
          if (peri) begin
            pesi <= 1;
            pedi <= data_array[2];
          end
        end
        3: begin // test case 4 tests loading data into the nssi virtual channel
          if (nsri) begin
            nssi <= 1;
            nsdi <= data_array[3];
          end
        end
        4: begin // test case 5 tests loading data into the snsi virtual channel
          if (snri) begin
            snsi <= 1;
            sndi <= data_array[4];
          end
        end
        5: begin // test case 6 tests loading data into both pe and cw at the same time
          if (peri) begin
            pesi <= 1;
            pedi <= data_array[5];
          end
          if (cwri) begin
            cwsi <= 1;
            cwdi <= data_array[6];
          end
        end
        default: begin
          cwsi <= 0;
          ccwsi <= 0;
          pesi <= 0;
          nssi <= 0;
          snsi <= 0;
        end
      endcase

      // Check if our first test case passed
      if (cycle_count == 5) begin
        cwro <= 1;
      end else if (cycle_count == 6) begin
        cwro <= 0;
        if (cwdo == {data_array[0][63:52], data_array[0][51:48] >> 1, data_array[0][47:0]}) begin
          passedTests[0] <= 1;
          $display("cwdo: %h", cwdo);
        end
      end

      // Check if our second test case passed
      if (cycle_count == 6) begin
        ccwro <= 1;
      end else if (cycle_count == 7) begin
        ccwro <= 0;
        if (ccwdo == {data_array[1][63:52], data_array[1][51:48] >> 1, data_array[1][47:0]}) begin
          passedTests[1] <= 1;
          $display("ccwdo: %h", ccwdo);
        end
      end

      // Check if our third test case passed
      if (cycle_count == 7) begin
        pero <= 1;
      end else if (cycle_count == 8) begin
        pero <= 0;
        if (pedo == {data_array[2][63:56], data_array[2][55:52] >> 1, data_array[2][51:0]}) begin
          passedTests[2] <= 1;
          $display("pedo: %h", ccwdo);
        end
      end

      // Check if our fourth test case passed
      if (cycle_count == 8) begin
        nsro <= 1;
      end else if (cycle_count == 9) begin
        nsro <= 0;
        if (nsdo == {data_array[3][63:56], data_array[3][55:52] >> 1, data_array[3][51:0]}) begin
          passedTests[3] <= 1;
          $display("nsdo: %h", ccwdo);
        end
      end

      // Check if our fifth test case passed
      if (cycle_count == 9) begin
        snro <= 1;
      end else if (cycle_count == 10) begin
        snro <= 0;
        if (sndo == {data_array[4][63:56], data_array[4][55:52] >> 1, data_array[4][51:0]}) begin
          passedTests[4] <= 1;
          $display("sndo: %h", ccwdo);
        end
      end

      data_index <= data_index + 1;
		end

    cycle_count <= cycle_count + 1;
	end
endmodule