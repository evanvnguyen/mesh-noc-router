module tb_router_output_channel;
  reg clk, reset, polarity, ready;
  reg [63:0] data_in;
  wire send, blocked;
  wire [63:0] data_out;
  
  router_output_channel uut(clk, reset, polarity, ready, data_in, blocked, send, data_out);
  
    reg [63:0] data_array [10:0];
    integer cycle_count, data_index;
  
    initial clk = 0;
    always #2 clk = ~clk; // 250 Mhz
    
    initial begin
			$dumpfile("iverilog-out/dump.vcd");
			$dumpvars(0, tb_router_output_channel);
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
      ready = 1;
			reset = 1;
			#8
			reset = 0;
			#100
	
			$finish;
    end
    
	always @(posedge clk) begin
		if (!reset) begin
      if (!blocked && data_index < 10 && ready) begin
        data_in <= data_array[data_index];
        data_index <= data_index + 1;
      end

      ready <= !(cycle_count == 2 || cycle_count == 3 || cycle_count == 4);

			polarity <= ~polarity;
			cycle_count <= cycle_count + 1;
		end
		
		$display("TB: Time=%0t, clk=%b, reset=%b, polarity=%b, send=%b, blocked=%b, data=%h, ready=%b, data_out=%h",
						$time, clk, reset, polarity, send, blocked, data_in, ready, data_out);
	end
endmodule