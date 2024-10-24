task automatic delay;
    input [31:0] dc;//ori[3:0]
    begin
        repeat (dc) @ (posedge clk);
        # 1;
    end
endtask
// random data
task automatic rand_data_qw;
   output [64-1:0] rdata;

   reg    [64-1:0] tmp0;
   begin
      tmp0[15:0 ] = {$random} % 65536;
      tmp0[31:16] = {$random} % 65536;
      tmp0[47:32] = {$random} % 65536;
      tmp0[63:48] = {$random} % 65536;
      rdata = {tmp0};
   end
endtask
task automatic rand_data_dw;
   output [32-1:0] rdata;

   reg    [32-1:0] tmp0;
   begin
      tmp0[15:0 ] = {$random} % 65536;
      tmp0[31:16] = {$random} % 65536;
      rdata = {tmp0};
   end
endtask

task automatic mw_dw(
    input [63:0] address,
    input [31:0] data
);	
    begin
	@(posedge rc_core_clk);
	mw_en = 1;
	@(posedge rc_core_clk);
	mw_addr = address;
	mw_data = {32'd0, data};
	mw_data_en = 1;
	mw_len = 12'd4;
	mw_data_be = 8'h0F;
	@(posedge rc_core_clk);
	mw_data_en = 0;
	@(posedge rc_core_clk);
	op_start = 1;
	@(posedge rc_core_clk);
	op_start = 0;
	wait (mw_op_over);
	mw_en = 0;
	@(posedge rc_core_clk);
	end
endtask

// MEM RD
task automatic mr_dw(
    input  [63:0] address,
    output [31:0] data
);
    begin
	@(posedge rc_core_clk);
	mr_en = 1;
	@(posedge rc_core_clk);
	mr_addr = address;
	mr_len = 12'd4;
	mr_data_be = 8'h0F;
	@(posedge rc_core_clk);
	op_start = 1;
	@(posedge rc_core_clk);
	op_start = 0;
	wait (mr_data_vld);
	data = mr_data;
	wait (mr_op_over);
	@(posedge rc_core_clk);
	mr_en = 0;
	@(posedge rc_core_clk);
	end
endtask

// CFG0 WR
task cfg0w;
	input [31:0] address;
	input [31:0] data;
	
    begin
	@(posedge rc_core_clk);
	cfg0w_en = 1;
	@(posedge rc_core_clk);
	cfg0w_addr = address;
	cfg0w_data = data;
	@(posedge rc_core_clk);
	op_start = 1;
	@(posedge rc_core_clk);
	op_start = 0;
	wait (cfg0w_op_over);
	@(posedge rc_core_clk);
	cfg0w_en = 0;
	@(posedge rc_core_clk);
	end
endtask

// CFG0 RD
task cfg0r;
    input  [31:0] address;
    output [31:0] data;
	
    begin
	@(posedge rc_core_clk);
	cfg0r_en = 1;
	@(posedge rc_core_clk);
	cfg0r_addr = address;
	@(posedge rc_core_clk);
	op_start = 1;
	@(posedge rc_core_clk);
	op_start = 0;
	wait (cfg0r_op_over);
	@(posedge rc_core_clk);
	cfg0r_en = 0;
	@(posedge rc_core_clk);
	end
endtask

