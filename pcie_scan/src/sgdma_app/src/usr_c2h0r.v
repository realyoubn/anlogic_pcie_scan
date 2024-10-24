

module	usr_c2h0r(
   	input   wire   usr_clk,
	input   wire   usr_rst_n,
	// input   wire   stop,
	input   wire   usr_c2h0r_run_i,
	input   wire   s0_axis_c2h_rst_i,
	input   wire   s0_axis_c2h_tready_i,
    output  reg   [127:0]  s0_axis_c2h_tdata_o,
    output  wire   [15:0]  s0_axis_c2h_tkeep_o,
    output  wire   [15:0]  s0_axis_c2h_tuser_o,
    output  reg   s0_axis_c2h_tlast_o,
    output  reg   s0_axis_c2h_tvalid_o,
	
	output	wire   usr_c2h0irq_req_o,				
	input	wire   usr_c2h0irq_ack_i,
	output  wire   usr_c2h0err_o,
        output wire			c2h0r_run,
    	input   wire   [127:0]pcie_data,
        input   wire   pcie_valid,
        input   wire   pcie_start,
        input   wire   pcie_stop
);
 
reg				c2h0r_run_d1;
reg				c2h0r_run_d2;

reg  [7:0]data_cnt;
assign usr_c2h0irq_req_o = 1'b0;
assign s0_axis_c2h_tkeep_o= {16{1'b1}};
assign s0_axis_c2h_tuser_o  = {16{1'b0}};


always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)begin
		c2h0r_run_d1 <= 1'b0;
        c2h0r_run_d2 <= 1'b0;
        end 
	else begin
        c2h0r_run_d1 <= usr_c2h0r_run_i;
        c2h0r_run_d2 <= c2h0r_run_d1;
        end
end
assign c2h0r_run = c2h0r_run_d1 && (!c2h0r_run_d2);

always @(posedge usr_clk,negedge usr_rst_n)
	if(!usr_rst_n)begin
    	data_cnt <= 8'd0;
        s0_axis_c2h_tdata_o <= 128'b0;
        s0_axis_c2h_tvalid_o <= 1'b0;
        s0_axis_c2h_tlast_o <= 1'b0;     
    end
    else if(s0_axis_c2h_rst_i)begin
    	data_cnt <= 8'd0;
        s0_axis_c2h_tdata_o <= 128'b0;
        s0_axis_c2h_tvalid_o <= 1'b0;
        s0_axis_c2h_tlast_o <= 1'b0;     
    end
    else if(pcie_valid)begin
//    	if(pcie_stop)begin
//        s0_axis_c2h_tdata_o <= pcie_data;
//        s0_axis_c2h_tvalid_o <= 1'b1;
//        s0_axis_c2h_tlast_o <= 1'b1;
//        end
//        else begin
		if(data_cnt == 8'd255)begin
        s0_axis_c2h_tdata_o <= pcie_data;
        s0_axis_c2h_tvalid_o <= 1'b1;
        s0_axis_c2h_tlast_o <= 1'b1;
        data_cnt <= 8'd0;
        end
        else begin
        s0_axis_c2h_tdata_o <= pcie_data;
        s0_axis_c2h_tvalid_o <= 1'b1;
        s0_axis_c2h_tlast_o <= 1'b0;
        data_cnt <= data_cnt + 1'b1;
        end
//        end
    end
    
    else begin
        s0_axis_c2h_tdata_o <= 128'b0;
        s0_axis_c2h_tvalid_o <= 1'b0;
        s0_axis_c2h_tlast_o <= 1'b0;
    end

//ram_pingpang u_ram_pingpang
//(
//    .usr_clk(usr_clk)     ,   
//    .usr_rst_n(usr_rst_n)   ,    
//    .clk_50m(usr_clk)     , //写时钟，当与读时钟不同时，注意读使能需要控制信号，
//                            //当读地址到最大时要停止读取，否则会造成多次读取同一块ram
//    .stop(stop),             
//    .usr_c2h0r_run_i(usr_c2h0r_run_i),
//    .s0_axis_c2h_rst_i(s0_axis_c2h_rst_i),
//    .s0_axis_c2h_tready_i(s0_axis_c2h_tready_i),
//    .s0_axis_c2h_tdata_o(s0_axis_c2h_tdata_o),      
//    .s0_axis_c2h_tvalid_o(s0_axis_c2h_tvalid_o),
//    .s0_axis_c2h_tlast_o(s0_axis_c2h_tlast_o)
//);        

endmodule
