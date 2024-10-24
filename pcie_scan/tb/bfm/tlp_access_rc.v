// ===========================================================================
// Copyright (c) 2011-2021 Anlogic Inc., All Right Reserved.
// 
// TEL: 86-21-61633787
// WEB: http://www.anlogic.com/
// ===========================================================================
//
// Designer    :  
// Date        ：2021/09/15
// Discription ：The block demonstrates memory/IO request generation, and legacy interrupt process.
// Email       :  
// 
// ===========================================================================
`timescale 1ns/1ps
`include "tlp_fmt_type.vh"
module tlp_access_rc(
    core_rst_n,
    core_clk,
    rc_bdf,
    ep_bdf,
    // XALI0 tx
    client0_tlp_data,
    client0_tlp_addr,
    client0_remote_req_id,
    client0_tlp_byte_en,
    client0_cpl_byte_cnt,
    client0_addr_align_en,
    client0_tlp_tc,
    client0_tlp_attr,
    client0_cpl_status,
    client0_cpl_bcm,
    client0_tlp_dv,
    client0_tlp_eot,
    client0_tlp_bad_eot,
    client0_tlp_hv,
    client0_tlp_type,
    client0_tlp_fmt,
    client0_tlp_td,
    client0_tlp_byte_len,
    client0_tlp_tid,
    client0_tlp_ep,
    client0_tlp_func_num,
    client0_tlp_ats,
    client0_tlp_st,
    client0_tlp_nw,
    client0_tlp_th,
    client0_tlp_ph,
    client0_tlp_atu_bypass,
    client0_cpl_lookup_id,
    // XALI0 rx
    xadm_client0_halt,
    // BYPASS rx
    radm_bypass_data,
    radm_bypass_dwen,
    radm_bypass_dv,
    radm_bypass_hv,
    radm_bypass_eot,
    radm_bypass_dllp_abort,
    radm_bypass_tlp_abort,
    radm_bypass_ecrc_err,
    radm_bypass_addr,
    radm_bypass_fmt,
    radm_bypass_tc,
    radm_bypass_attr,
    radm_bypass_reqid,
    radm_bypass_type,
    radm_bypass_tag,
    radm_bypass_func_num,
    radm_bypass_td,
    radm_bypass_poisoned,
    radm_bypass_dw_len,   
    radm_bypass_rom_in_range,
    radm_bypass_first_be,
    radm_bypass_last_be,
    radm_bypass_io_req_in_range,
    radm_bypass_in_membar_range,
    radm_bypass_cpl_last,
    radm_bypass_cpl_status,
    radm_bypass_st,
    radm_bypass_cmpltr_id,
    radm_bypass_byte_cnt,
    radm_bypass_ats,
    radm_bypass_th,
    radm_bypass_ph,
    radm_bypass_bcm,
    
    // MEM & IO I/F
    mw_en,
    mr_en,
    iow_en,
    ior_en,
    cfg0w_en,
    cfg0r_en,
    op_start,
    mw_addr,
    mw_len,
    mw_data,
    mw_data_be,
    mw_data_en,
    mr_addr,
    mr_len,
    mr_data_be,
    mr_data,
    mr_data_vld,
    iow_addr,
    iow_data,
    ior_addr,
    ior_data,
    ior_data_vld,
    cfg0w_addr,
    cfg0w_data,
    cfg0r_addr,
    cfg0r_data,
    cfg0r_data_vld,
    mw_op_over,
    mr_op_over,
    iow_op_over,
    ior_op_over,
    cfg0w_op_over,
    cfg0r_op_over
    );
`include "bdf.vh"
	// Fmt
parameter FMT_3DW = 3'b000;
parameter FMT_4DW = 3'b001;
parameter FMT_3DW_DATA = 3'b010;
parameter FMT_4DW_DATA = 3'b011;  
parameter FMT_TLP_PRFX = 3'b100;

// --------------------------------------------------------------------
// Type
// --------------------------------------------------------------------
// Memory Read Request
parameter MRD_FMT = 3'b00x;
parameter MRD_TYPE = 5'b0_0000;

// Memory Read Request-Locked
parameter MRDLK_FMT = 3'b00x;
parameter MRDLK_TYPE = 5'b0_0001;

// Memory Write Request
parameter MWR_FMT = 3'b01x;
parameter MWR_TYPE = 5'b0_0000;

// I/O Read Request
parameter IORD_FMT = 3'b000;
parameter IORD_TYPE = 5'b0_0010;

// I/O Write Request
parameter IOWR_FMT = 3'b010;
parameter IOWR_TYPE = 5'b0_0010;

// Configuration Read Type 0
parameter CFGRD0_FMT = 3'b000;
parameter CFGRD0_TYPE = 5'b0_0100;

// Configuration Write Type 0
parameter CFGWR0_FMT = 3'b010;
parameter CFGWR0_TYPE = 5'b0_0100;

// Configuration Read Type 1
parameter CFGRD1_FMT = 3'b000;
parameter CFGRD1_TYPE = 5'b0_0101;

// Configuration Write Type 1
parameter CFGWR1_FMT = 3'b010;
parameter CFGWR1_TYPE = 5'b0_0101;

// Deprecated TLP Type4
parameter TCFGRD_FMT = 3'b000;
parameter TCFGRD_TYPE = 5'b1_1011;

// Deprecated TLP Type5
parameter TCFGWR_FMT = 3'b010;
parameter TCFGWR_TYPE = 5'b1_1011;

// Message Request
parameter MSG_FMT = 3'b001;
parameter MSG_TYPE = 5'b1_0xxx;

// Message Request with data payload
parameter MSGD_FMT = 3'b011;
parameter MSGD_TYPE = 5'b1_0xxx;

// Completion without Data
parameter CPL_FMT = 3'b000;
parameter CPL_TYPE = 5'b0_1010;

// Completion with Data
parameter CPLD_FMT = 3'b010;
parameter CPLD_TYPE = 5'b0_1010;

// Completion for Locked Memory Read without Data (Used only in error case.)
parameter CPLLK_FMT = 3'b000;
parameter CPLLK_TYPE = 5'b0_1011;

// Completion for Locked Memory Read (Otherwise like CplD.)
parameter CPLDLK_FMT = 3'b010;
parameter CPLDLK_TYPE = 5'b0_1011;

// Fetch and Add AtomicOp Request
parameter ATOMIC_FETCHADD_FMT_DATA = 3'b01x;
parameter ATOMIC_FETCHADD_TYPE = 5'b0_1100;

// Unconditional Swap AtomicOp Request
parameter ATOMIC_SWAP_FMT_DATA = 3'b01x;
parameter ATOMIC_SWAP_TYPE = 5'b0_1101;

// Compare and Swap AtomicOp Request
parameter ATOMIC_CAS_FMT_DATA = 3'b01x;
parameter ATOMIC_CAS_TYPE = 5'b0_1110;

// Local TLP Prefix
parameter LPRFX_FMT = 3'b100;
parameter LPRFX_TYPE = 5'b0_xxxx;

// End-End TLP Prefix
parameter EPRFX_FMT = 3'b100;
parameter EPRFX_TYPE = 5'b1_xxxx;

    input           core_rst_n;
    input           core_clk;
    input   [15:0]  rc_bdf;
    input   [15:0]  ep_bdf;
    
    // XALI0 tx
    output  [127:0]  client0_tlp_data;
    output  [63:0]  client0_tlp_addr;
    output  [15:0]  client0_remote_req_id;
    output  [7:0]   client0_tlp_byte_en;
    output  [11:0]  client0_cpl_byte_cnt;
    output          client0_addr_align_en;
    output  [2:0]   client0_tlp_tc;
    output  [2:0]   client0_tlp_attr;
    output  [2:0]   client0_cpl_status;
    output          client0_cpl_bcm;
    output          client0_tlp_dv;
    output          client0_tlp_eot;
    output          client0_tlp_bad_eot;
    output          client0_tlp_hv;
    output  [4:0]   client0_tlp_type;
    output  [1:0]   client0_tlp_fmt;
    output          client0_tlp_td;
    output  [12:0]  client0_tlp_byte_len;
    output  [9:0]   client0_tlp_tid;
    output          client0_tlp_ep;
    output          client0_tlp_func_num;
    output  [1:0]   client0_tlp_ats;
    output  [7:0]   client0_tlp_st;
    output          client0_tlp_nw;
    output          client0_tlp_th;
    output  [1:0]   client0_tlp_ph;
    output          client0_tlp_atu_bypass;
    output  [9:0]   client0_cpl_lookup_id;
    // XALI0 rx
    input           xadm_client0_halt;
    // BYPASS rx
    input   [127:0]  radm_bypass_data;
    input   [3:0]   radm_bypass_dwen;
    input           radm_bypass_dv;
    input           radm_bypass_hv;
    input           radm_bypass_eot;
    input           radm_bypass_dllp_abort;
    input           radm_bypass_tlp_abort;
    input           radm_bypass_ecrc_err;
    input   [63:0]  radm_bypass_addr;
    input   [1:0]   radm_bypass_fmt;
    input   [2:0]   radm_bypass_tc;
    input   [2:0]   radm_bypass_attr;
    input   [15:0]  radm_bypass_reqid;
    input   [4:0]   radm_bypass_type;
    input   [9:0]   radm_bypass_tag;
    input           radm_bypass_func_num;
    input           radm_bypass_td;
    input           radm_bypass_poisoned;
    input   [9:0]   radm_bypass_dw_len;
    input           radm_bypass_rom_in_range;
    input   [3:0]   radm_bypass_first_be;
    input   [3:0]   radm_bypass_last_be;
    input           radm_bypass_io_req_in_range;
    input   [2:0]   radm_bypass_in_membar_range;
    input           radm_bypass_cpl_last;
    input   [2:0]   radm_bypass_cpl_status;
    input   [7:0]   radm_bypass_st;
    input   [15:0]  radm_bypass_cmpltr_id;
    input   [11:0]  radm_bypass_byte_cnt;
    input   [1:0]   radm_bypass_ats;
    input           radm_bypass_th;
    input   [1:0]   radm_bypass_ph;
    input           radm_bypass_bcm;
    // --------------------------------------------------------------------
    // MEM & IO I/F
    // --------------------------------------------------------------------
    input           mw_en;
    input           mr_en;
    input           iow_en;
    input           ior_en;
    input           cfg0w_en;
    input           cfg0r_en;
    input           op_start;
    input   [63:0]  mw_addr;
    input   [11:0]  mw_len;
    input   [127:0] mw_data;
    input   [7:0]   mw_data_be;
    input           mw_data_en;
    input   [63:0]  mr_addr;
    input   [11:0]  mr_len;
    input   [7:0]   mr_data_be;
    output  [127:0]  mr_data;
    output          mr_data_vld;
    input   [31:0]  iow_addr;
    input   [31:0]  iow_data;
    input   [31:0]  ior_addr;
    output  [31:0]  ior_data;
    output          ior_data_vld;
    input   [31:0]  cfg0w_addr;
    input   [31:0]  cfg0w_data;
    input   [31:0]  cfg0r_addr;
    output  [31:0]  cfg0r_data;
    output          cfg0r_data_vld;
    output          mw_op_over;
    output          mr_op_over;
    output          iow_op_over;
    output          ior_op_over;
    output          cfg0w_op_over;
    output          cfg0r_op_over;
    
    
// ====================================================================
// Parameter/wire/reg
// ====================================================================

    // Pipeline
    reg  [127:0] client0_tlp_data;
    reg  [63:0] client0_tlp_addr;
    reg  [15:0] client0_remote_req_id;
    reg  [7:0]  client0_tlp_byte_en;
    reg  [11:0] client0_cpl_byte_cnt;
    reg         client0_addr_align_en;
    reg  [2:0]  client0_tlp_tc;
    reg  [2:0]  client0_tlp_attr;
    reg  [2:0]  client0_cpl_status;
    reg         client0_cpl_bcm;
    reg         client0_tlp_dv;	//synthesis keep
    reg         client0_tlp_eot;//synthesis keep   
    reg         client0_tlp_bad_eot;
    reg         client0_tlp_hv;
    reg  [4:0]  client0_tlp_type;
    reg  [1:0]  client0_tlp_fmt;
    reg         client0_tlp_td;
    reg  [12:0] client0_tlp_byte_len;
    reg  [9:0]  client0_tlp_tid;
    reg         client0_tlp_ep;
    reg         client0_tlp_func_num;
    reg  [1:0]  client0_tlp_ats;
    reg  [7:0]  client0_tlp_st;
    reg         client0_tlp_nw;
    reg         client0_tlp_th;
    reg  [1:0]  client0_tlp_ph;
    reg         client0_tlp_atu_bypass;
    reg  [9:0]  client0_cpl_lookup_id;
    
    reg  [127:0] mw_data_reg;
    reg         mw_data_solo;
    wire        mw_fifo_rst;
    reg         mw_fifo_we;
    reg         mw_fifo_re;
    wire [127:0] mw_fifo_dout;
    reg  [127:0] mw_fifo_di;
    wire        mw_fifo_empty;
    
    reg  [ 7:0] mw_fifo_we_cnt;
    reg         mw_fifo_we_over;
    reg         mw_fifo_we_over_ff;
    reg  [ 7:0] mw_fifo_re_cnt;
    
    reg         tlp_mw_eot;
    reg         tlp_mw_eot_ff;
    reg         mw_fifo_re_ff;
    reg         mw_fifo_re_2ff;
    reg         op_start_ff;
    reg  [127:0] mw_fifo_dout_ff;
    
    reg  [6:0]  request_gen_csm;
    //reg  [2:0]  request_gen_nsm=0;
    localparam  REQUESTSM_IDLE      = 7'b000_0001,
                REQUESTSM_TLP_MW    = 7'b000_0010,
                REQUESTSM_TLP_MR    = 7'b000_0100,
                REQUESTSM_TLP_IOW   = 7'b000_1000,
                REQUESTSM_TLP_IOR   = 7'b001_0000,
                REQUESTSM_TLP_CFG0W = 7'b010_0000,
                REQUESTSM_TLP_CFG0R = 7'b100_0000;
    
    reg  [127:0] mr_data;
    reg         mr_data_vld;
    reg  [31:0] ior_data;
    reg         ior_data_vld;
    reg  [31:0] cfg0r_data;
    reg         cfg0r_data_vld;
    reg  [1:0]  mr_csm_ff;
    
    reg  [1:0]  mr_csm;
    //reg  [1:0]  mr_nsm=0;
    localparam  TRANSACTION_IDLE = 3'd0,
                TRANSACTION_REQ  = 3'd1,
                TRANSACTION_CPL  = 3'd2;
    reg  [8:0]  mr_cnt;
    
    reg  [1:0]  iow_csm;
    //reg  [1:0]  iow_nsm=0;
    reg  [1:0]  ior_csm;
    //reg  [1:0]  ior_nsm=0;
    reg  [1:0]  cfg0w_csm;
    //reg  [1:0]  cfg0w_nsm=0;
    reg  [1:0]  cfg0r_csm;
    //reg  [1:0]  cfg0r_nsm=0;
    
    reg  [9:0]  np_req_id;
    
    wire        cpl_flag;
    wire        cpl_status;
    wire        cpld_flag;
    wire        cpld_status;
    wire [127:0] cpld_data;
    wire [3:0]  cpld_data_vld;
    reg         cpld_flag_ff;
    reg         cpld_status_ff;
    reg         cpld_cont_flag;
        
    reg         mw_op_over;
    reg         mr_op_over;
    reg         iow_op_over;
    reg         ior_op_over;
    reg         cfg0w_op_over;
    reg         cfg0r_op_over;
// ====================================================================
// MEM/IO/CFG request
// ====================================================================

// --------------------------------------------------------------------
// MEM WR
// --------------------------------------------------------------------
// Save single DW/QW
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        mw_data_reg <= 0;
        mw_data_solo <= 0;
        end
    else
        begin
        if (mw_en & (mw_len == 4 | mw_len == 8 | mw_len==16))
            begin
            mw_data_solo <= 1;
            if (mw_data_en)
                mw_data_reg <= mw_data;
            end
        else
            mw_data_solo <= 0;
        end
    end

// Local buffer for memory burst write data
sfifo512x32 u_3dw_sfifo512x32(
    .dout           (mw_fifo_dout[127:96]), 
    .empty_flag     (mw_fifo_empty      ), 
    .full_flag      (), 
    .fifo_wrpointer (), 
    .fifo_rdpointer (), 
    .wrst           (mw_fifo_rst        ), 
    .rrst           (mw_fifo_rst        ), 
    .di             (mw_fifo_di[127:96]  ), 
    .clk            (core_clk           ), 
    .we             (mw_fifo_we         ), 
    .re             (mw_fifo_re         ));

sfifo512x32 u_2dw_sfifo512x32(
    .dout           (mw_fifo_dout[95:64]), 
    .empty_flag     (mw_fifo_empty      ), 
    .full_flag      (), 
    .fifo_wrpointer (), 
    .fifo_rdpointer (), 
    .wrst           (mw_fifo_rst        ), 
    .rrst           (mw_fifo_rst        ), 
    .di             (mw_fifo_di[95:64]  ), 
    .clk            (core_clk           ), 
    .we             (mw_fifo_we         ), 
    .re             (mw_fifo_re         ));
    
sfifo512x32 u_hdw_sfifo512x32(
	.dout           (mw_fifo_dout[63:32]), 
	.empty_flag     (mw_fifo_empty      ), 
	.full_flag      (), 
	.fifo_wrpointer (), 
	.fifo_rdpointer (), 
	.wrst           (mw_fifo_rst        ), 
	.rrst           (mw_fifo_rst        ), 
	.di             (mw_fifo_di[63:32]  ), 
	.clk            (core_clk           ), 
	.we             (mw_fifo_we         ), 
	.re             (mw_fifo_re         ));

sfifo512x32 u_ldw_sfifo512x32(
	.dout           (mw_fifo_dout[31:0] ), 
	.empty_flag     (                   ), 
	.full_flag      (), 
	.fifo_wrpointer (), 
	.fifo_rdpointer (), 
	.wrst           (mw_fifo_rst        ), 
	.rrst           (mw_fifo_rst        ), 
	.di             (mw_fifo_di[31:0]   ), 
	.clk            (core_clk           ), 
	.we             (mw_fifo_we         ), 
	.re             (mw_fifo_re         ));

assign mw_fifo_rst = ~core_rst_n;

always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        mw_fifo_di <= 0;
        mw_fifo_we <= 0;
        end
    else
       begin
            //mw_fifo_di <= mw_data;
            //mw_fifo_we <= mw_data_en; solo not write data to fifo
        if ( mw_en & (mw_len == 4 | mw_len == 8 |mw_len == 16 )) begin 
            mw_fifo_di <= 0;
            mw_fifo_we <= 0;
            end
        else begin
            mw_fifo_di <= mw_data;
            mw_fifo_we <= mw_data_en;
            end
        end
    end

// FIFO WR check
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        mw_fifo_we_cnt <= 0;
        mw_fifo_we_over <= 0;
        mw_fifo_we_over_ff <= 0;
        end
    else
        begin
        mw_fifo_we_over_ff <= mw_fifo_we_over;
        if (mw_en)
            begin
            if (mw_fifo_we)  //only not solo mode write data to fifo
                begin
                if (mw_fifo_we_cnt !== mw_len[11:4])
                    mw_fifo_we_cnt <= mw_fifo_we_cnt + 1;
                end
            if (mw_fifo_we_cnt == mw_len[11:4] & mw_fifo_we_cnt !== 0)
                mw_fifo_we_over <= 1;
            else
                mw_fifo_we_over <= 0;
            end
        else
            begin
            mw_fifo_we_cnt <= 0;
            mw_fifo_we_over <= 0;
            end
        end
    end

// FIFO RD

// FIFO RD
wire   mw_en_pulse;
reg    mw_en_pulse_d1;
reg    mw_en_pulse_d2;
wire   dv_vld;
wire   intervel_pulse;
reg    fifo_read_flag;
wire   fifo_rd_over;
wire   transfer_over;

reg                       client0_rgn_i;
reg                       client0_rgn_d1;
reg                       client0_rgn_d2;
reg                       client0_rgn_d3;
wire                      client0_rgn_rising;
wire                      client0_rgn_rising1;  
wire                      client0_rgn_rising2; 

reg  [11:0]   transfer_cnt;
reg  [127:0]   tmp_data;


assign dv_vld = ~xadm_client0_halt & client0_tlp_dv; //data to be transfered.

assign mw_en_pulse = mw_en & op_start & (mw_data_solo == 0); //only not solo need read fifo, generate start pluse

always @(posedge core_clk,negedge core_rst_n)
begin
    if(!core_rst_n)
        client0_rgn_i <= 0;
    else if (client0_tlp_eot )
        client0_rgn_i <= 0;
    else if (mw_en_pulse)
        client0_rgn_i <= 1;
end

always @(posedge core_clk,negedge core_rst_n)
begin
    if(!core_rst_n) begin
        client0_rgn_d1 <= 3'd0;
        client0_rgn_d2 <= 3'd0;
        client0_rgn_d3 <= 3'd0;
    end
    else begin
        client0_rgn_d1 <= client0_rgn_i;
        client0_rgn_d2 <= client0_rgn_d1;
        client0_rgn_d3 <= client0_rgn_d2;
    end
end

assign client0_rgn_rising = (~client0_rgn_d1) & client0_rgn_i;
assign client0_rgn_rising1 = (~client0_rgn_d2) & client0_rgn_d1;
assign client0_rgn_rising2 = (~client0_rgn_d3) & client0_rgn_d2;

assign fifo_rd_over = (mw_fifo_re == 1'b1 && mw_fifo_re_cnt == mw_len[11:4]-1) ? 1'b1 : 1'b0;

always@(posedge core_clk or negedge core_rst_n) begin
    if (!core_rst_n) 
        fifo_read_flag <= 0;
    else if (fifo_rd_over) 
        fifo_read_flag <= 1'b0;
    else if (client0_rgn_rising) //fifo read start
        fifo_read_flag <= 1;
end

always@(posedge core_clk or negedge core_rst_n) begin
    if (!core_rst_n) begin
        mw_fifo_re <= 0;
        end
    else begin
      if  ( fifo_rd_over | (xadm_client0_halt & client0_tlp_dv))  
            mw_fifo_re <= 0;
      else if ( client0_rgn_rising | (fifo_read_flag & ( dv_vld | client0_rgn_rising1 | client0_rgn_rising2) ) )  //| mw_en_pulse_d1 | mw_en_pulse_d2
            mw_fifo_re <= 1;
    end
end

always@(posedge core_clk or negedge core_rst_n) begin
    if (!core_rst_n) begin
        mw_fifo_re_cnt <= 0;
        end
    else begin
        if (fifo_rd_over)
            mw_fifo_re_cnt <= 0;
        else if (mw_fifo_re)
            mw_fifo_re_cnt <= mw_fifo_re_cnt + 1;
    end
end

assign intervel_pulse =  mw_fifo_re & xadm_client0_halt & client0_tlp_dv; //change data when this happen

reg    intervel_en_rgn;

wire [127:0]   xali_data;

assign xali_data = client0_rgn_i ? mw_fifo_dout : 64'h0;

always @(posedge core_clk,negedge core_rst_n)
begin
    if(!core_rst_n)
        intervel_en_rgn <= 1'b0;
    else if(dv_vld)// & xali_drden,tmp_data被消耗,
        intervel_en_rgn <= 1'b0;
    else if(intervel_pulse)
        intervel_en_rgn <= 1'b1;
    else ;
end

always @(posedge core_clk or negedge core_rst_n)
begin
 if (!core_rst_n) 
        tmp_data <= 0;
  else  if(intervel_pulse)
        tmp_data <= mw_fifo_dout;
  else ;
end


assign transfer_over = (client0_rgn_d2 && dv_vld && transfer_cnt == mw_len[11:4]-2) ? 1'b1 : 1'b0;

always@(posedge core_clk or negedge core_rst_n) begin
    if (!core_rst_n) 
        transfer_cnt <= 0;
    else if (client0_rgn_rising2)
        transfer_cnt <= 0;
    else if (client0_rgn_d2 & dv_vld) 
        transfer_cnt <= transfer_cnt + 1'b1;
 
end

always@(posedge core_clk or negedge core_rst_n) begin
    if (!core_rst_n) begin
        mw_en_pulse_d1 <= 0;
        mw_en_pulse_d2 <= 0;
        end
    else begin
        mw_en_pulse_d1 <= mw_en_pulse;
        mw_en_pulse_d2 <= mw_en_pulse_d1;
    end
end

always@(posedge core_clk or negedge core_rst_n) begin
    if (!core_rst_n) begin
        mw_fifo_dout_ff <= 0;
        //mw_fifo_dout_ff1 <= 0;
        //mw_fifo_dout_ff2 <= 0;
        end
    else begin
            mw_fifo_dout_ff <= mw_fifo_dout;
            //mw_fifo_dout_ff1 <= mw_fifo_dout_ff;
            //mw_fifo_dout_ff2 <= mw_fifo_dout_ff1;
    end
end

always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        tlp_mw_eot <= 0;
        tlp_mw_eot_ff <= 0;
        mw_fifo_re_ff <= 0;
        mw_fifo_re_2ff <= 0;
        
        end
    else
        begin
        if (mw_fifo_re & mw_fifo_re_cnt == (mw_len[11:4] - 1))
            tlp_mw_eot <= 1;
        else
            tlp_mw_eot <= 0;
            
        tlp_mw_eot_ff <= tlp_mw_eot;
        mw_fifo_re_ff <= mw_fifo_re;
        mw_fifo_re_2ff <= mw_fifo_re_ff;
        end
    end


always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        mw_op_over <= 0;
        end
    else
        begin
        if (mw_en)
            begin
            if (op_start)
                mw_op_over <= 0;
            else if (~xadm_client0_halt & client0_tlp_eot)
                mw_op_over <= 1;
            end
        else
            mw_op_over <= 0;
        end
    end

// --------------------------------------------------------------------
// MEM RD
// --------------------------------------------------------------------
// SM
/*
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        mr_csm <= TRANSACTION_IDLE;
        end
    else
        begin
        mr_csm <= mr_nsm;
        end
    end

always@(mr_csm, mr_nsm, mr_en, op_start_ff, xadm_client0_halt, client0_tlp_eot, cpld_flag_ff, mr_len, cpld_cont_flag, mr_cnt)
    begin
    if (mr_en)
        case (mr_csm)
            TRANSACTION_IDLE:   begin
                                if (op_start_ff)
                                    mr_nsm <= TRANSACTION_REQ;
                                end
            TRANSACTION_REQ:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    mr_nsm <= TRANSACTION_CPL;
                                end
            TRANSACTION_CPL:    begin
                                if ((cpld_flag_ff & (mr_len[11:4] <= 1)) // solo CLPD
                                    | (cpld_cont_flag & mr_cnt >= mr_len[11:4])) // burst CLPD
                                    mr_nsm <= TRANSACTION_IDLE;
                                end
        endcase
    end        
*/     
always@(posedge core_clk or negedge core_rst_n)
    begin
        
    if (!core_rst_n)        
    	mr_csm <= TRANSACTION_IDLE;        
	else if (mr_en)
        case (mr_csm)
            TRANSACTION_IDLE:   begin
                                if (op_start_ff)
                                    mr_csm <= TRANSACTION_REQ;
                                end
            TRANSACTION_REQ:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    mr_csm <= TRANSACTION_CPL;
                                end
            TRANSACTION_CPL:    begin
                                if ((cpld_flag_ff & (mr_len[11:4] <= 1)) 		 // solo CLPD
                                    | (cpld_cont_flag & mr_cnt >= mr_len[11:4])) // burst CLPD
                                    mr_csm <= TRANSACTION_IDLE;
                                end                                    
			default : mr_csm <= mr_csm;
        endcase
    end     

// count read back data
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        mr_cnt <= 0;
        cpld_flag_ff <= 0;
        cpld_status_ff <= 0;
        cpld_cont_flag <= 0;
        end
    else
        begin
        cpld_flag_ff <= cpld_flag;
        cpld_status_ff <= cpld_status;
        if (mr_csm == TRANSACTION_CPL)
            begin
            if (cpld_flag & cpld_status)
                cpld_cont_flag <= 1;
            if ((|cpld_data_vld==1'b1))
                mr_cnt <= mr_cnt + 1;
            end
        else
            begin
            cpld_cont_flag <= 0;
            mr_cnt <= 0;
            end
        end
    end

// Deliver read back data to upstream
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        mr_op_over <= 0;
        mr_data <= 0;
        mr_data_vld <= 0;
        mr_csm_ff <= 0;
        end
    else
        begin
        mr_csm_ff <= mr_csm;
        if (mr_en)
            begin
            if (op_start)
                mr_op_over <= 0;
            else if (mr_csm == TRANSACTION_IDLE & mr_csm_ff == TRANSACTION_CPL)
                mr_op_over <= 1;
            if ((|cpld_data_vld==1'b1))
                mr_data 	<= cpld_data;
            mr_data_vld <= (|cpld_data_vld==1'b1) ? 1'b1 : 1'b0;
            end
        else
            begin
            mr_op_over <= 0;
            mr_data_vld <= 0;
            end
        end
    end
    
// --------------------------------------------------------------------
// IO WR
// --------------------------------------------------------------------
// SM
/*
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        iow_csm <= TRANSACTION_IDLE;
        end
    else
        begin
        iow_csm <= iow_nsm;
        end
    end

always@(iow_csm, iow_nsm, iow_en, op_start_ff, xadm_client0_halt, client0_tlp_eot, cpl_flag)
    begin
    if (iow_en)
        case (iow_csm)
            TRANSACTION_IDLE:   begin
                                if (op_start_ff)
                                    iow_nsm <= TRANSACTION_REQ;
                                end
            TRANSACTION_REQ:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    iow_nsm <= TRANSACTION_CPL;
                                end
            TRANSACTION_CPL:    begin
                                if (cpl_flag)
                                    iow_nsm <= TRANSACTION_IDLE;
                                end
        endcase
    end        
*/    
always@(posedge core_clk or negedge core_rst_n)
    begin
    
	if(!core_rst_n)    
		iow_csm <= TRANSACTION_IDLE;	
	else if (iow_en)
        case (iow_csm)
            TRANSACTION_IDLE:   begin
                                if (op_start_ff)
                                    iow_csm <= TRANSACTION_REQ;
                                end
            TRANSACTION_REQ:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    iow_csm <= TRANSACTION_CPL;
                                end
            TRANSACTION_CPL:    begin
                                if (cpl_flag)
                                    iow_csm <= TRANSACTION_IDLE;
                                end                                    
			default : iow_csm <= iow_csm;
        endcase
    end   

always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        iow_op_over <= 0;
        end
    else
        begin
        if (iow_en)
            begin
            if (op_start)
                iow_op_over <= 0;
            else if (iow_csm == TRANSACTION_CPL & cpl_flag)
                iow_op_over <= 1;
            end
        else
            iow_op_over <= 0;
        end
    end
    
// --------------------------------------------------------------------
// IO RD
// --------------------------------------------------------------------
// SM
/*
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        ior_csm <= TRANSACTION_IDLE;
        end
    else
        begin
        ior_csm <= ior_nsm;
        end
    end

always@(ior_csm, ior_nsm, ior_en, op_start_ff, xadm_client0_halt, client0_tlp_eot, cpld_flag)
    begin
    if (ior_en)
        case (ior_csm)
            TRANSACTION_IDLE:   begin
                                if (op_start_ff)
                                    ior_nsm <= TRANSACTION_REQ;
                                end
            TRANSACTION_REQ:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    ior_nsm <= TRANSACTION_CPL;
                                end
            TRANSACTION_CPL:    begin
                                if (cpld_flag)
                                    ior_nsm <= TRANSACTION_IDLE;
                                end
        endcase
    end
*/    
always@(posedge core_clk or negedge core_rst_n)
    begin
	if(!core_rst_n)    
		ior_csm <= TRANSACTION_IDLE;
    else if (ior_en)
        case (ior_csm)
            TRANSACTION_IDLE:   begin
                                if (op_start_ff)
                                    ior_csm <= TRANSACTION_REQ;
                                end
            TRANSACTION_REQ:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    ior_csm <= TRANSACTION_CPL;
                                end
            TRANSACTION_CPL:    begin
                                if (cpld_flag)
                                    ior_csm <= TRANSACTION_IDLE;
                                end                                    
			default : ior_csm <= ior_csm;
        endcase
    end

// Deliver read back data to upstream
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        ior_op_over <= 0;
        ior_data <= 0;
        ior_data_vld = 0;
        end
    else
        begin
        if (ior_en)
            begin
            if (op_start)
                ior_op_over <= 0;
            else if (ior_csm == TRANSACTION_CPL & cpld_flag)
                ior_op_over <= 1;
                
            if ((|cpld_data_vld==1'b1))
                ior_data = cpld_data[31:0];
                
            ior_data_vld <= (|cpld_data_vld==1'b1) ? 1'b1 : 1'b0;
            
            end
        else
            begin
            ior_op_over <= 0;
            ior_data_vld <= 0;
            end
        end
    end

// --------------------------------------------------------------------
// CFG0 WR
// --------------------------------------------------------------------
// SM
/*
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        cfg0w_csm <= TRANSACTION_IDLE;
        end
    else
        begin
        cfg0w_csm <= cfg0w_nsm;
        end
    end

always@(cfg0w_csm, cfg0w_nsm, cfg0w_en, op_start_ff, xadm_client0_halt, client0_tlp_eot, cpl_flag)
    begin
    if (cfg0w_en)
        case (cfg0w_csm)
            TRANSACTION_IDLE:   begin
                                if (op_start_ff)
                                    cfg0w_nsm <= TRANSACTION_REQ;
                                end
            TRANSACTION_REQ:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    cfg0w_nsm <= TRANSACTION_CPL;
                                end
            TRANSACTION_CPL:    begin
                                if (cpl_flag)
                                    cfg0w_nsm <= TRANSACTION_IDLE;
                                end
        endcase
    end        
*/    
   
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        cfg0w_csm <= TRANSACTION_IDLE;
    else if (cfg0w_en)
        case (cfg0w_csm)
            TRANSACTION_IDLE:   begin
                                if (op_start_ff)
                                    cfg0w_csm <= TRANSACTION_REQ;
                                end
            TRANSACTION_REQ:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    cfg0w_csm <= TRANSACTION_CPL;
                                end
            TRANSACTION_CPL:    begin
                                if (cpl_flag)
                                    cfg0w_csm <= TRANSACTION_IDLE;
                                end                                    
			default : cfg0w_csm <= cfg0w_csm;
        endcase
    end   

always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        cfg0w_op_over <= 0;
        end
    else
        begin
        if (cfg0w_en)
            begin
            if (op_start)
                cfg0w_op_over <= 0;
            else if (cfg0w_csm == TRANSACTION_CPL & cpl_flag)
                cfg0w_op_over <= 1;
            end
        else
            cfg0w_op_over <= 0;
        end
    end
    
// --------------------------------------------------------------------
// CFG0 RD
// --------------------------------------------------------------------
// SM
/*
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        cfg0r_csm <= TRANSACTION_IDLE;
        end
    else
        begin
        cfg0r_csm <= cfg0r_nsm;
        end
    end

always@(cfg0r_csm, cfg0r_nsm, cfg0r_en, op_start_ff, xadm_client0_halt, client0_tlp_eot, cpld_flag)
    begin
    if (cfg0r_en)
        case (cfg0r_csm)
            TRANSACTION_IDLE:   begin
                                if (op_start_ff)
                                    cfg0r_nsm <= TRANSACTION_REQ;
                                end
            TRANSACTION_REQ:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    cfg0r_nsm <= TRANSACTION_CPL;
                                end
            TRANSACTION_CPL:    begin
                                if (cpld_flag)
                                    cfg0r_nsm <= TRANSACTION_IDLE;
                                end
        endcase
    end        
*/    
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        cfg0r_csm <= TRANSACTION_IDLE;
    else if (cfg0r_en)
        case (cfg0r_csm)
            TRANSACTION_IDLE:   begin
                                if (op_start_ff)
                                    cfg0r_csm <= TRANSACTION_REQ;
                                end
            TRANSACTION_REQ:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    cfg0r_csm <= TRANSACTION_CPL;
                                end
            TRANSACTION_CPL:    begin
                                if (cpld_flag)
                                    cfg0r_csm <= TRANSACTION_IDLE;
                                end                                    
			default : cfg0r_csm <= cfg0r_csm;
        endcase
    end

// Deliver read back data to upstream
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        cfg0r_op_over <= 0;
        cfg0r_data <= 0;
        cfg0r_data_vld <= 0;
        end
    else
        begin
        if (cfg0r_en)
            begin
            if (op_start)
                cfg0r_op_over <= 0;
            else if (cfg0r_csm == TRANSACTION_CPL & cpld_flag)
                cfg0r_op_over <= 1;
            if ((|cpld_data_vld==1'b1))
                cfg0r_data <= cpld_data[31:0];
            cfg0r_data_vld <= (|cpld_data_vld==1'b1) ? 1'b1 : 1'b0;
            end
        else
            begin
            cfg0r_op_over <= 0;
            cfg0r_data_vld <= 0;
            end
        end
    end
    
// --------------------------------------------------------------------
// Request Generation SM
// --------------------------------------------------------------------
// Pipe op_start for HV
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        op_start_ff <= 0;
        end
    else
        begin
        op_start_ff <= op_start;
        end
    end
 /*       
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        request_gen_csm <= REQUESTSM_IDLE;
        end
    else
        begin
        request_gen_csm <= request_gen_nsm;
        end
    end

always@(request_gen_csm, request_gen_nsm, op_start, xadm_client0_halt, client0_tlp_eot)
    begin
    case (request_gen_csm)
        REQUESTSM_IDLE:         begin
                                if (op_start)
                                    case ({mw_en, mr_en, iow_en, ior_en, cfg0w_en, cfg0r_en})
                                        6'b10_0000: begin
                                                    request_gen_nsm <= REQUESTSM_TLP_MW;
                                                    end
                                        6'b01_0000: begin
                                                    request_gen_nsm <= REQUESTSM_TLP_MR;
                                                    end
                                        6'b00_1000: begin
                                                    request_gen_nsm <= REQUESTSM_TLP_IOW;
                                                    end
                                        6'b00_0100: begin
                                                    request_gen_nsm <= REQUESTSM_TLP_IOR;
                                                    end
                                        6'b00_0010: begin
                                                    request_gen_nsm <= REQUESTSM_TLP_CFG0W;
                                                    end
                                        6'b00_0001: begin
                                                    request_gen_nsm <= REQUESTSM_TLP_CFG0R;
                                                    end
                                    endcase
                                end
        REQUESTSM_TLP_MW:       begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_nsm <= REQUESTSM_IDLE;
                                end
        REQUESTSM_TLP_MR:       begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_nsm <= REQUESTSM_IDLE;
                                end
        REQUESTSM_TLP_IOW:      begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_nsm <= REQUESTSM_IDLE;
                                end
        REQUESTSM_TLP_IOR:      begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_nsm <= REQUESTSM_IDLE;
                                end
        REQUESTSM_TLP_CFG0W:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_nsm <= REQUESTSM_IDLE;
                                end
        REQUESTSM_TLP_CFG0R:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_nsm <= REQUESTSM_IDLE;
                                end
    endcase
    end
*/    
always@(posedge core_clk or negedge core_rst_n)
begin
    if (!core_rst_n)
        begin
        request_gen_csm <= REQUESTSM_IDLE;
        end
    else begin        
    	case(request_gen_csm)
    	REQUESTSM_IDLE:         begin
                                if (op_start)
                                    case ({mw_en, mr_en, iow_en, ior_en, cfg0w_en, cfg0r_en})
                                        6'b10_0000: begin
                                                    request_gen_csm <= REQUESTSM_TLP_MW;
                                                    end
                                        6'b01_0000: begin
                                                    request_gen_csm <= REQUESTSM_TLP_MR;
                                                    end
                                        6'b00_1000: begin
                                                    request_gen_csm <= REQUESTSM_TLP_IOW;
                                                    end
                                        6'b00_0100: begin
                                                    request_gen_csm <= REQUESTSM_TLP_IOR;
                                                    end
                                        6'b00_0010: begin
                                                    request_gen_csm <= REQUESTSM_TLP_CFG0W;
                                                    end
                                        6'b00_0001: begin
                                                    request_gen_csm <= REQUESTSM_TLP_CFG0R;
                                                    end                                                    
										default : request_gen_csm <= request_gen_csm;
                                    endcase
                                end
        REQUESTSM_TLP_MW:       begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_csm <= REQUESTSM_IDLE;
                                end
        REQUESTSM_TLP_MR:       begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_csm <= REQUESTSM_IDLE;
                                end
        REQUESTSM_TLP_IOW:      begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_csm <= REQUESTSM_IDLE;
                                end
        REQUESTSM_TLP_IOR:      begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_csm <= REQUESTSM_IDLE;
                                end
        REQUESTSM_TLP_CFG0W:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_csm <= REQUESTSM_IDLE;
                                end
        REQUESTSM_TLP_CFG0R:    begin
                                if (~xadm_client0_halt & client0_tlp_eot)
                                    request_gen_csm <= REQUESTSM_IDLE;
                                end                                    
		default : request_gen_csm <= request_gen_csm;
		endcase 
    end
end 
   
// --------------------------------------------------------------------
// XALI TLP
// --------------------------------------------------------------------
always@(posedge core_clk or negedge core_rst_n)
    begin
    if (!core_rst_n)
        begin
        client0_tlp_data         <= 0;
        client0_tlp_addr         <= 0;
        client0_remote_req_id    <= rc_bdf;
        client0_tlp_byte_en      <= 0;
        client0_cpl_byte_cnt     <= 0;
        client0_addr_align_en    <= 0;
        client0_tlp_tc           <= 0;
        client0_tlp_attr         <= 0;
        client0_cpl_status       <= 0;
        client0_cpl_bcm          <= 0;
        client0_tlp_dv           <= 0;
        client0_tlp_eot          <= 0;
        client0_tlp_bad_eot      <= 0;
        client0_tlp_hv           <= 0;
        client0_tlp_type         <= 0;
        client0_tlp_fmt          <= 0;
        client0_tlp_td           <= 0;
        client0_tlp_byte_len     <= 0;
        client0_tlp_tid          <= 0;
        client0_tlp_ep           <= 0;
        client0_tlp_func_num     <= 0;
        client0_tlp_ats          <= 0;
        client0_tlp_st           <= 0;
        client0_tlp_nw           <= 0;
        client0_tlp_th           <= 0;
        client0_tlp_ph           <= 0;
        client0_tlp_atu_bypass   <= 1;
        client0_cpl_lookup_id    <= 0;
        np_req_id                <= 0;
        end
    else
        begin
        case (request_gen_csm)
            REQUESTSM_IDLE:         begin
                                    // control & status signals
                                    client0_tlp_hv <= 0;
                                    client0_tlp_dv <= 0;
                                    client0_tlp_eot <= 0;
                                    client0_tlp_bad_eot <= 0;
                                    client0_tlp_ep <= 0;
                                    client0_cpl_status <= 0;
                                    client0_addr_align_en <= 0;
                                    client0_tlp_byte_en <= 0;
                                    // Signals in Completion Lookup Table
                                    //client0_remote_req_id <= rc_bdf;
                                    //client0_cpl_byte_cnt <= 0;
                                    //client0_tlp_attr <= 0;
                                    //client0_tlp_addr <= 0;
                                    end
            REQUESTSM_TLP_MW :      begin
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        client0_tlp_hv <= 0;
                                    else if (client0_rgn_rising2 | (mw_data_solo == 1 & op_start_ff) )
                                        client0_tlp_hv <= 1;
                                        
                                    if (mw_data_solo)
                                        begin
                                        if (~xadm_client0_halt & client0_tlp_hv)
                                            client0_tlp_dv <= 0;
                                        else if (op_start_ff)
                                            client0_tlp_dv <= 1;
                                        end
                                    else 
                                        begin
                                        if (~xadm_client0_halt & client0_tlp_eot)
                                            client0_tlp_dv <= 0;
                                        else if (client0_rgn_rising2)
                                            client0_tlp_dv <= 1;
                                        end
                                        
                                    if (mw_data_solo)
                                        begin
                                        if (~xadm_client0_halt & client0_tlp_eot)
                                            client0_tlp_eot <= 0;
                                        else if (op_start_ff)
                                            client0_tlp_eot <= 1;
                                        end
                                    else
                                        begin
                                        if (~xadm_client0_halt & client0_tlp_eot)
                                            client0_tlp_eot <= 0;
                                        else if ( transfer_over ) //tlp_mw_eot_ff,tlp_mw_eot
                                            client0_tlp_eot <= 1;
                                        end
                                    client0_tlp_addr <= mw_addr;
                                    client0_tlp_byte_en <= mw_data_be;
                                    client0_tlp_byte_len <= {1'b0, mw_len};
                                    if (mw_data_solo)
                                        client0_tlp_data <= mw_data_reg;
                                    else begin
                                       if(intervel_en_rgn & dv_vld)
                                          client0_tlp_data <= tmp_data;
                                       else if(client0_rgn_rising2 | dv_vld)
                                          client0_tlp_data <=  xali_data;
                                    end
                                    
                                    client0_tlp_fmt <= FMT_3DW_DATA[1:0];
                                    client0_tlp_type <= MWR_TYPE;
                                    client0_tlp_tid <= 0;
                                    end
            REQUESTSM_TLP_MR :      begin
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        client0_tlp_hv <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_hv <= 1;
                                    client0_tlp_dv <= 0;
                                    if (~xadm_client0_halt & client0_tlp_eot)
                                        client0_tlp_eot <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_eot <= 1;
                                    client0_tlp_addr <= mr_addr;
                                    client0_tlp_byte_en <= mr_data_be;
                                    client0_tlp_byte_len <= {1'b0, mr_len};
                                    client0_tlp_fmt <= FMT_3DW[1:0];
                                    client0_tlp_type <= MRD_TYPE;
                                    client0_tlp_tid <= np_req_id;
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        np_req_id <= np_req_id + 1;
                                    end
            REQUESTSM_TLP_IOW :     begin
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        client0_tlp_hv <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_hv <= 1;
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        client0_tlp_dv <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_dv <= 1;
                                    if (~xadm_client0_halt & client0_tlp_eot)
                                        client0_tlp_eot <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_eot <= 1;
                                    client0_tlp_addr <= iow_addr;
                                    client0_tlp_byte_en <= 8'h0F;
                                    client0_tlp_byte_len <= 4;
                                    client0_tlp_data <= iow_data;
                                    client0_tlp_fmt <= IOWR_FMT[1:0];
                                    client0_tlp_type <= IOWR_TYPE;
                                    client0_tlp_tid <= np_req_id;
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        np_req_id <= np_req_id + 1;
                                    end
            REQUESTSM_TLP_IOR :     begin
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        client0_tlp_hv <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_hv <= 1;
                                    client0_tlp_dv <= 0;
                                    if (~xadm_client0_halt & client0_tlp_eot)
                                        client0_tlp_eot <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_eot <= 1;
                                    client0_tlp_addr <= ior_addr;
                                    client0_tlp_byte_en <= 8'h0F;
                                    client0_tlp_byte_len <= 4;
                                    client0_tlp_fmt <= IORD_FMT[1:0];
                                    client0_tlp_type <= IORD_TYPE;
                                    client0_tlp_tid <= np_req_id;
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        np_req_id <= np_req_id + 1;
                                    end
            REQUESTSM_TLP_CFG0W :   begin
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        client0_tlp_hv <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_hv <= 1;
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        client0_tlp_dv <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_dv <= 1;
                                    if (~xadm_client0_halt & client0_tlp_eot)
                                        client0_tlp_eot <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_eot <= 1;
                                    client0_tlp_addr <= {32'd0, ep_bdf[15:0], 4'd0, cfg0w_addr[11:2], 2'b00};
                                    client0_tlp_byte_en <= 8'h0F;
                                    client0_tlp_byte_len <= 4;
                                    client0_tlp_data <= cfg0w_data;
                                    client0_tlp_fmt <= CFGWR0_FMT[1:0];
                                    client0_tlp_type <= CFGWR0_TYPE;
                                    client0_tlp_tid <= np_req_id;
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        np_req_id <= np_req_id + 1;
                                    end
            REQUESTSM_TLP_CFG0R :   begin
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        client0_tlp_hv <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_hv <= 1;
                                    client0_tlp_dv <= 0;
                                    if (~xadm_client0_halt & client0_tlp_eot)
                                        client0_tlp_eot <= 0;
                                    else if (op_start_ff)
                                        client0_tlp_eot <= 1;
                                    client0_tlp_addr <= {32'd0, ep_bdf[15:0], 4'd0, cfg0r_addr[11:2], 2'b00};
                                    client0_tlp_byte_en <= 8'h0F;
                                    client0_tlp_byte_len <= 4;
                                    client0_tlp_fmt <= CFGRD0_FMT[1:0];
                                    client0_tlp_type <= CFGRD0_TYPE;
                                    client0_tlp_tid <= np_req_id;
                                    if (~xadm_client0_halt & client0_tlp_hv)
                                        np_req_id <= np_req_id + 1;
                                    end                                        
			default ;
        endcase
        end
    end

// ====================================================================
// MEM/IO/CFG completion
// ====================================================================
byps_cpl u_byps_cpl(
    .core_clk                    (core_clk                   ), 
    .core_rst_n                  (core_rst_n                 ),
    .rc_bdf                      (rc_bdf                     ),
    .ep_bdf                      (ep_bdf                     ),
    .radm_bypass_data            (radm_bypass_data           ),
    .radm_bypass_dwen            (radm_bypass_dwen           ),
    .radm_bypass_dv              (radm_bypass_dv             ),
    .radm_bypass_hv              (radm_bypass_hv             ),
    .radm_bypass_eot             (radm_bypass_eot            ),
    .radm_bypass_dllp_abort      (radm_bypass_dllp_abort     ),
    .radm_bypass_tlp_abort       (radm_bypass_tlp_abort      ),
    .radm_bypass_ecrc_err        (radm_bypass_ecrc_err       ),
    .radm_bypass_addr            (radm_bypass_addr           ),
    .radm_bypass_fmt             (radm_bypass_fmt            ),
    .radm_bypass_tc              (radm_bypass_tc             ),
    .radm_bypass_attr            (radm_bypass_attr           ),
    .radm_bypass_reqid           (radm_bypass_reqid          ),
    .radm_bypass_type            (radm_bypass_type           ),
    .radm_bypass_tag             (radm_bypass_tag            ),
    .radm_bypass_func_num        (radm_bypass_func_num       ),
    .radm_bypass_td              (radm_bypass_td             ),
    .radm_bypass_poisoned        (radm_bypass_poisoned       ),
    .radm_bypass_dw_len          (radm_bypass_dw_len         ),
    .radm_bypass_rom_in_range    (radm_bypass_rom_in_range   ),
    .radm_bypass_first_be        (radm_bypass_first_be       ),
    .radm_bypass_last_be         (radm_bypass_last_be        ),
    .radm_bypass_io_req_in_range (radm_bypass_io_req_in_range),
    .radm_bypass_in_membar_range (radm_bypass_in_membar_range),
    .radm_bypass_cpl_last        (radm_bypass_cpl_last       ),
    .radm_bypass_cpl_status      (radm_bypass_cpl_status     ),
    .radm_bypass_st              (radm_bypass_st             ),
    .radm_bypass_cmpltr_id       (radm_bypass_cmpltr_id      ),
    .radm_bypass_byte_cnt        (radm_bypass_byte_cnt       ),
    .radm_bypass_ats             (radm_bypass_ats            ),
    .radm_bypass_th              (radm_bypass_th             ),
    .radm_bypass_ph              (radm_bypass_ph             ),
    .radm_bypass_bcm             (radm_bypass_bcm            ),
    
    .cpl_flag                    (cpl_flag                   ),
    .cpl_status                  (cpl_status                 ),
    .cpld_flag                   (cpld_flag                  ),
    .cpld_status                 (cpld_status                ),
    .cpld_data                   (cpld_data                  ),
    .cpld_data_vld               (cpld_data_vld              )
    );

endmodule
