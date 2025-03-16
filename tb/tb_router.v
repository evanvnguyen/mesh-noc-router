module tb_router();
  reg clk, reset, polarity, send, in_blocked;
  reg [63:0] data_in;
  reg out_ready;
  
  wire ready;
  wire send_ou, out_blockedt;
  wire [63:0] input_channel_output;
  wire [63:0] data_out;
  
  router_input_channel in_channel(clk, reset, polarity, send, in_blocked, data_in, ready, input_channel_output);

  router_output_channel out_channel(clk, reset, polarity, out_ready, input_channel_output, out_blocked, send_out, data_out);
  
  reg [63:0] data_array [10:0];
  integer cycle_count, data_index;

  initial clk = 0;
  always #2 clk = ~clk; // 250 Mhz

  initial begin
    $dumpfile("iverilog-out/dump.vcd");
    $dumpvars(0, tb_router);
    data_array[0] = 'hfA50;
    data_array[1] = 'h6840;
    data_array[2] = 'hffff;
    data_array[3] = 'hc7d4;
    data_array[4] = 'hffffffff;
    data_array[5] = 'hfba34;
    data_array[6] = 'h53fda;
    data_array[7] = 'habcdef;
    data_array[8] = 'h12345678;
    data_array[9] = 'hdef123;
    data_array[10] = 'h11a11;
    
    data_in = 0;
    cycle_count = 0;
    data_index = 0;
    polarity = 0;
    in_blocked = 0;
    send = 0;
    out_ready = 1;

    reset = 1;
    #8
    reset = 0;
    #100

    $finish;
  end
    
	always @(posedge clk) begin
		if (!reset) begin
		    if (ready && data_index < 10 && !in_blocked) begin
				send <= 1;
				data_in <= data_array[data_index];
				
				data_index <= data_index + 1;
			end else begin
				send <= 0;
				data_in <= 0;
			end
			
			// blocked <= (cycle_count == 2 || cycle_count == 3);

			polarity <= ~polarity;
			cycle_count <= cycle_count + 1;
		end
		
		$display("TB: Time=%0t, clk=%b, reset=%b, polarity=%b, send=%b, blocked=%b, data=%h, ready=%b, data_out=%h",
						$time, clk, reset, polarity, send, in_blocked, data_in, ready, data_out);
	end
endmodule