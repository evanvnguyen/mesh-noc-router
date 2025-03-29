module register_file (
  input clk,
  input reset,
  input writeEnable,
  input [0:4] rA_address,
  input [0:4] rB_address,
  input [0:4] rD_address,
  input [0:63] rD_data,
  input [0:2] ppp,
  output reg [0:63] rA_data,
  output reg [0:63] rB_data
);

reg [63:0] registerFile [31:0]; 
reg writeEn;

always @(*) begin
  if (reset) begin
    rA_data = 64'b0;
    rB_data = 64'b0;
  end else begin  
    if (!writeEn) begin
      rA_data = registerFile[rA_address];
      rB_data = registerFile[rB_address];
    end
  end
end

always @(posedge clk) begin
  if (reset) begin
    registerFile[0] = 64'b0;
    registerFile[1] = 64'b0;
    registerFile[2] = 64'b0;
    registerFile[3] = 64'b0;
    registerFile[4] = 64'b0;
    registerFile[5] = 64'b0;
    registerFile[6] = 64'b0;
    registerFile[7] = 64'b0;
    registerFile[8] = 64'b0;
    registerFile[9] = 64'b0;
    registerFile[11] = 64'b0;
    registerFile[10] = 64'b0;
    registerFile[12] = 64'b0;
    registerFile[13] = 64'b0;
    registerFile[14] = 64'b0;
    registerFile[15] = 64'b0;
    registerFile[16] = 64'b0;
    registerFile[17] = 64'b0;
    registerFile[18] = 64'b0;
    registerFile[19] = 64'b0;
    registerFile[20] = 64'b0;
    registerFile[21] = 64'b0;
    registerFile[22] = 64'b0;
    registerFile[23] = 64'b0;
    registerFile[24] = 64'b0;
    registerFile[25] = 64'b0;
    registerFile[26] = 64'b0;
    registerFile[27] = 64'b0;
    registerFile[28] = 64'b0;
    registerFile[29] = 64'b0;
    registerFile[30] = 64'b0;
    registerFile[31] = 64'b0;
    writeEn = 1'b0;
  end else begin
    writeEn = writeEnable;
    if (writeEn) begin
      if (rD_address != 5'b0) begin
        // |   0 : 7  |   8 : 15  |  16 : 23  |  24 : 31  |  32 : 39  |  40 : 47  |  48 : 55  |  56 : 63  | 
        //  0000 0000   0000 0000   0000 0000   0000 0000   0000 0000   0000 0000   0000 0000   0000 0000
        case (ppp)
          000: begin
            registerFile[rD_address] = rD_data;
          end

          001: begin
            register_file[rD_address][0:31] = rD_data[0:31];
          end

          010: begin
            register_file[rD_address][32:63] = rD_data[32:63];
          end

          011: begin
            register_file[rD_address][0:7] = rD_data[0:7];
            register_file[rD_address][16:23] = rD_data[16:23];
            register_file[rD_address][32:39] = rD_data[32:39];
            register_file[rD_address][48:55] = rD_data[48:55];
          end

          100: begin
            register_file[rD_address][8:15] = rD_data[8:15];
            register_file[rD_address][24:31] = rD_data[24:31];
            register_file[rD_address][40:47] = rD_data[40:47];
            register_file[rD_address][56:63] = rD_data[56:63];
          end
        endcase
      end

      writeEn = 1'b0;
    end
  end
end

endmodule