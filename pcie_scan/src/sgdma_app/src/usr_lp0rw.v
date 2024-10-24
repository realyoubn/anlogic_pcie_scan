`include "../../sgdma_ip/def/para_def.vh"
module usr_lp0rw(
	input   wire   usr_lp0rw_run_i,//synthesis keep	
	
	input   wire   m0_axis_h2ca_tready_i,
    input   wire   [`DATA_WIDTH-1:0]   m0_axis_h2c_tdata_i,
    input   wire   [`KEEP_WIDTH-1:0]   m0_axis_h2c_tkeep_i,
    input   wire   [`KEEP_WIDTH-1:0]   m0_axis_h2c_tuser_i,
    input   wire   m0_axis_h2c_tlast_i,
    input   wire   m0_axis_h2c_tvalid_i,
	
	input   wire   s0_axis_c2h_tready_i,
    input   wire   [`DATA_WIDTH-1:0]  s0_axis_c2ha_tdata_i,
    input   wire   [`KEEP_WIDTH-1:0]  s0_axis_c2ha_tkeep_i,
    input   wire   [`KEEP_WIDTH-1:0]  s0_axis_c2ha_tuser_i,
    input   wire   s0_axis_c2ha_tlast_i,
    input   wire   s0_axis_c2ha_tvalid_i,
	
	output  wire   m0_axis_h2c_tready_o,
	output  wire   [`DATA_WIDTH-1:0]  s0_axis_c2h_tdata_o,
    output  wire   [`KEEP_WIDTH-1:0]  s0_axis_c2h_tkeep_o,
    output  wire   [`KEEP_WIDTH-1:0]  s0_axis_c2h_tuser_o,
    output  wire   s0_axis_c2h_tlast_o,
    output  wire   s0_axis_c2h_tvalid_o
);

assign s0_axis_c2h_tdata_o = usr_lp0rw_run_i ? m0_axis_h2c_tdata_i : s0_axis_c2ha_tdata_i;
assign s0_axis_c2h_tkeep_o = usr_lp0rw_run_i ? m0_axis_h2c_tkeep_i : s0_axis_c2ha_tkeep_i;
assign s0_axis_c2h_tuser_o = usr_lp0rw_run_i ? m0_axis_h2c_tuser_i : s0_axis_c2ha_tuser_i;
assign s0_axis_c2h_tlast_o = usr_lp0rw_run_i ? m0_axis_h2c_tlast_i : s0_axis_c2ha_tlast_i;
assign s0_axis_c2h_tvalid_o= usr_lp0rw_run_i ? m0_axis_h2c_tvalid_i : s0_axis_c2ha_tvalid_i; 
assign m0_axis_h2c_tready_o = usr_lp0rw_run_i ? s0_axis_c2h_tready_i : m0_axis_h2ca_tready_i;


endmodule
