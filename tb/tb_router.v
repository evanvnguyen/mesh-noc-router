module tb_router();
  reg clk, reset;
  reg cwsi, ccwsi, pesi, cwro, ccwro, pero, nssi, snsi, nsro, snro;
  reg [63:0] cwdi, ccwdi, pedi, nsdi, sndi;
  reg [3:0] router_position;
  wire cwri, ccwri, peri, nsri, snri, cwso, ccwso, peso, nsso, snso, polarity_out;
  wire [63:0] cwdo, ccwdo, pedo, nsdo, sndo;
  
  reg [63:0] data_array [10:0];
  integer cycle_count, data_index;

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
    data_array[0] = 'h200200000000FA50;
    data_array[1] = 'h2002000000006840;
    data_array[2] = 'h400200000000ffff;
    data_array[3] = 'h400200000000c7d4;
    data_array[4] = 'h60020000ffffffff;
    data_array[5] = 'h00020000000fba34;
    data_array[6] = 'h2002000000053fda;
    data_array[7] = 'h2002000000abcdef;
    data_array[8] = 'h2002000012345678;
    data_array[9] = 'h2002000000def123;
    data_array[10] = 'h2002000000011a11;

    cwsi = 0;
    ccwsi = 0;
    pesi = 0;
    cwro = 1;
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
    #40

    $finish;
  end
    
	always @(posedge clk) begin
		if (!reset) begin
      if (peri && cycle_count == 2) begin
        pedi <= data_array[0];
        pesi <= 1;
      end else if (peri && cycle_count == 4) begin
        pedi <= data_array[3];
        pesi <= 1;
      end else begin
        pedi <= 64'b0;
        pesi <= 0;
      end

      if (cwri && cycle_count == 2) begin
        cwsi <= 1;
        cwdi <= data_array[1];
      end else if (cwri && cycle_count == 3) begin
        cwsi <= 1;
        cwdi <= data_array[2];
      end else begin
        cwdi <= 64'b0;
        cwsi <= 0;
      end
		end

    cycle_count <= cycle_count + 1;
	end
endmodule