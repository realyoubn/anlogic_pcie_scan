`include "../../sgdma_ip/def/para_def.vh"
`include "../../../tb/def/tlp_fmt_type.vh"
`include "../../../tb/def/dt_para.vh"
module text_led(
   	input   wire   usr_clk,
	input   wire   usr_rst_n,
    input   wire   [31:0]   m_axil_wdata,
    output  reg    led0,
    output  reg    stop
 );
reg led_en;
reg   [23:0] 	led_cnt;

always@(posedge usr_clk,negedge usr_rst_n)
begin 
	if(!usr_rst_n) begin
		led_en <= `DLY 1'b0;
        stop <= `DLY 1'b0;
        end
	else if(m_axil_wdata == 32'h1234abcd)
		led_en <= `DLY 1'b1;
	else if(m_axil_wdata == 32'h0011aabb)
		led_en <= `DLY 1'b0;
	else if(m_axil_wdata == 32'h11223344)
		stop <= `DLY 1'b1;
end

always@(posedge usr_clk,negedge usr_rst_n)
begin 
	if(!usr_rst_n) begin
        led0 <= `DLY 1'b0;
        end
	else if(led_en)
		led0 <= `DLY 1'b1;
	else if(!led_en)
		led0 <= `DLY 1'b0;
end


endmodule
