module ADconfig 
(
input            clk_sck,
input            rst_n,
input[31:0]      adc_cfg_data,
output reg[15:0] adc_cfg_data_o,
input            en_adc_cfg,
output           SCK,
output           SEN,
inout            SDI
);












parameter [8:0]reg00 =8'b01100101;
parameter [8:0]reg01 =8'b11110000;
parameter [8:0]reg02 =8'b00001111;
parameter [8:0]reg03 =8'b00001111;
parameter [8:0]reg04 =8'b00001111;
parameter [8:0]reg05 =8'b10001111;
parameter [8:0]reg06 =8'b10001111;
parameter [8:0]reg07 =8'b10001111;


reg reg_sdi,reg_sen,reg_scken;
reg [15:0]reg_data;
reg [7:0]reg_datain_15_0;
reg [7:0]reg_datain_31_16;
reg [7:0]cnt_sdi;
reg [4:0]cnt_reg;
wire reg_sck;

reg [23:0] delay_cnt;


wire    en_adc;
always @ (posedge clk_sck)
begin
    if (~rst_n)
        delay_cnt <= 24'b0;
    else if (en_adc)
        delay_cnt <= delay_cnt;
    else
        delay_cnt <= delay_cnt + 1'b1;
end

    assign  en_adc  = (delay_cnt == 24'h3f00) ? 1'b1 : 1'b0;


wire rd_op;

assign rd_op = adc_cfg_data[15] | adc_cfg_data[31];

always @ (posedge clk_sck)
begin
	if (!rst_n) begin
	reg_sdi<=0;
	reg_sen<=1;
	reg_scken<=0;
	cnt_sdi<=8'd0;
	cnt_reg<=5'h0;
	end
	else 
	begin
		if (en_adc_cfg & en_adc) begin
		//if (en_adc_cfg ) begin
        reg_sdi<=0;reg_sen<=1;reg_scken<=0;
        cnt_reg <= 5'h15;cnt_sdi <= 8'd0;
        end
		else if ((cnt_reg == 5'h14) | (cnt_reg == 5'h17) | (~en_adc)) begin
		//else if ((cnt_reg == 5'h14) | (cnt_reg == 5'h17) ) begin
		reg_sdi<=0;reg_sen<=1;reg_scken<=0;
		cnt_reg <= cnt_reg;cnt_sdi <= 8'd0;
		end
		else if (cnt_sdi == 8'd20) begin
		reg_sdi<=0;reg_sen<=1;reg_scken<=0;
		cnt_reg<=cnt_reg + 1'b1;cnt_sdi <= 8'd0;
		end
		else if (cnt_sdi == 8'd18) begin
		reg_sdi<=0;reg_sen<=1;reg_scken<=0;
		cnt_reg<=cnt_reg;cnt_sdi <= cnt_sdi + 1'b1;
		end
		else if (cnt_sdi == 8'd17) begin
		reg_sdi<=0;reg_sen<=1;reg_scken<=0;
		cnt_reg<=cnt_reg;cnt_sdi <= cnt_sdi + 1'b1;
		end
		else if (cnt_sdi == 8'd16) begin
		reg_sdi<=0;reg_sen<=1;reg_scken<=0;
		cnt_reg<=cnt_reg;cnt_sdi <= cnt_sdi + 1'b1;
		end
		else if ((cnt_sdi <= 8'd15) & ~rd_op)begin
		reg_sdi<=reg_data[15-cnt_sdi];reg_sen<=0;reg_scken<=1;
		cnt_reg<=cnt_reg;cnt_sdi <= cnt_sdi + 1'b1;
		end
		else if ((cnt_sdi <= 8'd7) & rd_op) begin
		reg_sdi<=reg_data[15-cnt_sdi];reg_sen<=0;reg_scken<=1;
		cnt_reg<=cnt_reg;cnt_sdi <= cnt_sdi + 1'b1;
		end
		else if ((cnt_sdi >= 8'd8) & (cnt_sdi <= 8'd15) & rd_op) begin
		reg_sen<=0;reg_scken<=1;
		cnt_reg<=cnt_reg;cnt_sdi <= cnt_sdi + 1'b1;
        end    
		else
		cnt_sdi<=cnt_sdi + 1'b1;
	end
end

wire gret9lit16;


reg[2:0] addr;

assign gret9lit16 =  (cnt_sdi >= 8'd9) & (cnt_sdi <= 8'd16) ? 1'b1 : 1'b0;

always @ (*) begin
	if (gret9lit16)
		addr= 16-cnt_sdi;
end



always @ (posedge clk_sck) begin
    if (~rst_n)
        reg_datain_15_0<=8'b0;
    else if (en_adc_cfg) 
        reg_datain_15_0<=8'b0;
	else if (gret9lit16 & (cnt_reg == 5'h15))
		reg_datain_15_0[addr]<=SDI;
end

always @ (posedge clk_sck) begin
    if (~rst_n)
        reg_datain_31_16<=8'b0;
    else if (en_adc_cfg) 
        reg_datain_31_16<=8'b0;
	else if (gret9lit16 & (cnt_reg == 5'h16))
		reg_datain_31_16[addr]<=SDI;
end


always @ (posedge clk_sck) begin
    if (~rst_n)
        adc_cfg_data_o<=16'b0;
    else 
		adc_cfg_data_o<= {reg_datain_31_16,reg_datain_15_0};
end





always @ (cnt_reg)
begin
  case (cnt_reg) 
	5'h00:reg_data<={1'b0,5'b00000,2'b00,reg00};
	5'h01:reg_data<={1'b0,5'b00001,2'b00,reg01};
	5'h02:reg_data<={1'b0,5'b00010,2'b00,reg02};
	5'h03:reg_data<={1'b0,5'b00011,2'b00,reg03};
	5'h04:reg_data<={1'b0,5'b00100,2'b00,reg04};
	5'h05:reg_data<={1'b0,5'b00101,2'b00,reg05};
	5'h06:reg_data<={1'b0,5'b00110,2'b00,reg06};
	5'h07:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h08:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h09:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h0A:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h0B:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h0C:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h0D:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h0E:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h0F:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h10:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h11:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h12:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h13:reg_data<={1'b0,5'b00111,2'b00,reg07};
	5'h15:reg_data<= adc_cfg_data[15:0];
	5'h16:reg_data<= adc_cfg_data[31:16];
 default:reg_data<={1'b0,5'b00000,2'b00,reg00};
  endcase
end

assign reg_sck = (~clk_sck) & reg_scken;

assign SCK = reg_sck;
assign SEN = reg_sen;

wire litte16;
assign litte16 = (cnt_sdi <= 8'd16) ? 1'b1 : 1'b0;
wire litte8;
assign litte8 = (cnt_sdi <= 8'd8) ? 1'b1 : 1'b0;

assign SDI =  (( litte16 & ~rd_op) |  ( litte8 & rd_op )) ?  reg_sdi : 1'bz;

endmodule
