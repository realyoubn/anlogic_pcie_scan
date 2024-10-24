module reg_config( 
   	input   wire   usr_clk,
	input   wire   usr_rst_n,
    input  wire    [31:0]   bram_di,
    input   wire    [19:0]   bram_wraddr,
    input   wire   bram_wren,
    output  reg    cl_test,
    output  reg    [15:0] st_sp,
    output  reg    en_adc_cfg,
    output  reg    [31:0]   adc_cfg_data,
    output  reg dpi_mode,
    output  reg [31 : 0] sp_time,
    output  reg rgb_en,
    (*keep*)output  reg [15 : 0] red_times1,
	(*keep*)output  reg [15 : 0] green_times1,
	(*keep*)output  reg [15 : 0] blue_times1,
    output  reg color_en
);
wire [8:0]addr;
reg led0;
assign addr = bram_wraddr[10:2];

always@(posedge usr_clk,negedge usr_rst_n)
begin 
	if(!usr_rst_n) begin
		adc_cfg_data <=  32'b0;
        en_adc_cfg <=  1'b0;
        st_sp <= 16'b0;
        cl_test <= 1'b0;
        led0<=1'b0;
        end
    else if(bram_wren)begin
	if(addr == 9'h3)begin
		adc_cfg_data <=  bram_di;
        en_adc_cfg <= 1'b1;
        led0<=1'b1;
        end
	else if(addr == 9'h1)begin
		st_sp <=  bram_di[15:0];
        en_adc_cfg <=  1'b0;
        led0<=1'b0;
        end
    else if(addr == 9'h2)begin
		cl_test <=  bram_di[0];
        en_adc_cfg <=  1'b0;
        led0<=1'b0;
        end
    else if(addr == 9'h4)begin
		dpi_mode <=  bram_di[0];
        en_adc_cfg <=  1'b0;
        led0<=1'b0;
        end
    else if(addr == 9'h5)begin
		sp_time <=  bram_di;
        en_adc_cfg <=  1'b0;
        led0<=1'b0;
        end
    else if(addr == 9'h6)begin
		rgb_en <=  bram_di[0];
        en_adc_cfg <=  1'b0;
        led0<=1'b0;
        end
    else if(addr == 9'h7)begin
		red_times1 <=  bram_di[15 : 0];
        en_adc_cfg <=  1'b0;
        led0<=1'b0;
        end
    else if(addr == 9'h8)begin
		green_times1 <=  bram_di[15 : 0];
        en_adc_cfg <=  1'b0;
        led0<=1'b0;
        end
    else if(addr == 9'h9)begin
		blue_times1 <=  bram_di[15 : 0];
        en_adc_cfg <=  1'b0;
        led0<=1'b0;
        end
    else if(addr == 9'ha)begin
		color_en <=  bram_di[0];
        en_adc_cfg <=  1'b0;
        led0<=1'b0;
        end
    end
	else begin

    end
end

endmodule
