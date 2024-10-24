//////////////////////////////////////////////////////////////
//  Copyright(c) 2011-2022 Anlogic, Inc.
//  All Right Reserved.
//////////////////////////////////////////////////////////////
//  Company       : Anlogic
//  Filename      : ph1_pcie_ctrl.v
//  Author        : Dexin - dexin.guo@anlogic.com
//  Last Modified : 2023-07-12 14:31:03
//  Create        : 2023-06-16 11:05:00
//  Description   :
//
///////////////////////////////////////////////////////////////

module ph1_pcie_ctrl#(
    parameter   AUX_FREQ    =  50_000_000,
    parameter   PHASE_CNT   =  16
)(

    input   wire            core_clk,
    input   wire            aux_clk,

    input   wire            core_rst_n,
    input   wire            rdlh_link_up,

    output  reg             gen1_ready,
    input   wire            dbi_done,

    output  wire            user_clk,
    output  reg             user_link

 );


// ====================================================================
// Parameter|Wire|Reg
// ====================================================================

localparam                  IDLE                =   8'b0000_0001,
                            INIT_GEN1           =   8'b0000_0010,
                            WAIT_DBI            =   8'b0000_0100,
                            WAIT_LINK           =   8'b0000_1000,
                            GEN2                =   8'b0001_0000,
                            GEN3                =   8'b0010_0000,
                            JUDGE               =   8'b0100_0000,
                            DONE                =   8'b1000_0000;
`ifdef RTL_SIM
localparam                  PLL_IDLE_CNT        =   (100_000/(1_000_000_000/AUX_FREQ)),      // delay 100us
                            PLL_IDLE_WIDTH      =   $clog2(PLL_IDLE_CNT);
localparam                  LINK_WAIT_CNT       =   (10_000/(1_000_000_000/AUX_FREQ)),       // delay 10us
                            LINK_WAIT_WIDTH     =   $clog2(LINK_WAIT_CNT);
`else
localparam                  PLL_IDLE_CNT        =   (1_000_000/(1_000_000_000/AUX_FREQ)),    // delay 1ms
                            PLL_IDLE_WIDTH      =   $clog2(PLL_IDLE_CNT);
localparam                  LINK_WAIT_CNT       =   (1_000_000/(1_000_000_000/AUX_FREQ)),    // delay 1ms
                            LINK_WAIT_WIDTH     =   $clog2(LINK_WAIT_CNT);
`endif
localparam                  PLL_LOCK_CNT        =   (100_000/(1_000_000_000/AUX_FREQ)),      // delay 100us
                            PLL_LOCK_WIDTH      =   $clog2(PLL_LOCK_CNT);
localparam                  AUX_10US_CNT        =   (10_000/(1_000_000_000/AUX_FREQ)),       // delay 10us
                            AUX_10US_WIDTH      =   $clog2(AUX_10US_CNT);
localparam                  PLL_CFG_NUM         =   6;

reg     [7:0]               ph1_pcie_cfg_st                 ;
reg                         dbi_done_aux                    ;
reg                         dbi_done_aux_dly                ;
reg                         rdlh_link_up_aux                ;
reg                         rdlh_link_up_aux_dly            ;
reg                         user_link_aux                   ;
reg                         user_link_aux_dly               ;
reg                         gen1_ready_aux                  ;
reg                         gen1_ready_aux_dly              ;
wire                        pll_lock                        ;
reg                         pll_lock_aux                    ;
reg                         pll_lock_aux_dly                ;

reg                         pll_rst_n                       ;
reg                         pll_ready                       ;
reg     [PLL_IDLE_WIDTH:0]  pll_idle_cnt                    ;
reg     [LINK_WAIT_WIDTH:0] link_wait_cnt                   ;
reg     [PLL_LOCK_WIDTH:0]  pll_lock_cnt                    ;
reg     [AUX_10US_WIDTH:0]  aux_10us_cnt                    ;
reg     [11:0]              core_10us_cnt                   ;
reg     [11:0]              core_10us_cnt_aux               ;
reg     [11:0]              core_10us_cnt_aux_dly           ;
reg     [2:0]               lock_gen                        ;
reg     [16:0]              gen1_cfg_data[PLL_CFG_NUM-1:0]  ;
reg     [16:0]              gen2_cfg_data[PLL_CFG_NUM-1:0]  ;
reg     [16:0]              gen3_cfg_data[PLL_CFG_NUM-1:0]  ;

// pll drp configuration user interface
reg                         pll_drp_sel                     ;
wire                        pll_drp_rd =1'b0                ;
reg                         pll_drp_wr                      ;
reg     [7:0]               pll_drp_addr                    ;
reg     [7:0]               pll_drp_wdata                   ;
wire                        pll_drp_err                     ;
wire                        pll_drp_rdy                     ;
wire    [7:0]               pll_drp_rdata                   ;
reg     [3:0]               pll_drp_cnt                     ;

// ====================================================================
// Main Code
// ====================================================================

// input pipeline
always@( posedge aux_clk  )
begin
    dbi_done_aux        <= dbi_done;
    dbi_done_aux_dly    <= dbi_done_aux;
    rdlh_link_up_aux    <= rdlh_link_up;
    rdlh_link_up_aux_dly<= rdlh_link_up_aux;
    pll_lock_aux        <= pll_lock;
    pll_lock_aux_dly    <= pll_lock_aux;
end

// output pipeline
always@( posedge user_clk or negedge core_rst_n ) begin
    if( !core_rst_n ) begin
    user_link_aux_dly   <= 1'b0;
    user_link           <= 1'b0;
    gen1_ready_aux_dly  <= 1'b0;
    gen1_ready          <= 1'b0;
    end else begin
    user_link_aux_dly   <= user_link_aux;
    user_link           <= user_link_aux_dly;
    gen1_ready_aux_dly  <= gen1_ready_aux;
    gen1_ready          <= gen1_ready_aux_dly;
    end
end

//--------------------------------------------
//  pcie cfg main state
//--------------------------------------------
always@( posedge aux_clk or negedge core_rst_n )
begin
    if( !core_rst_n ) begin
        ph1_pcie_cfg_st <= IDLE;
        user_link_aux   <= 1'b0;
        gen1_ready_aux  <= 1'b0;
        pll_idle_cnt    <= {PLL_IDLE_WIDTH{1'b0}};
        link_wait_cnt   <= {LINK_WAIT_WIDTH{1'b0}};                   
    end else begin
        case( ph1_pcie_cfg_st )
            IDLE : begin
                ph1_pcie_cfg_st <= pll_idle_cnt == PLL_IDLE_CNT ? INIT_GEN1 : IDLE;
                user_link_aux   <= 1'b0;
                gen1_ready_aux  <= 1'b0;
                pll_idle_cnt    <= pll_idle_cnt + 1'b1;
            end

            INIT_GEN1 : begin
                ph1_pcie_cfg_st <= pll_ready ? WAIT_DBI : INIT_GEN1 ;
            end

            WAIT_DBI : begin
                gen1_ready_aux  <= 1'b1;
                ph1_pcie_cfg_st <= (dbi_done_aux_dly & rdlh_link_up_aux_dly)  ? WAIT_LINK : WAIT_DBI   ;
            end

            WAIT_LINK : begin
                link_wait_cnt   <= link_wait_cnt + 1'b1;
                ph1_pcie_cfg_st <= link_wait_cnt == LINK_WAIT_CNT ? JUDGE : WAIT_LINK;
            end

            JUDGE: begin
                ph1_pcie_cfg_st <= lock_gen[0] ? DONE :
                                   lock_gen[1] ? GEN2 :
                                   lock_gen[2] ? GEN3 : JUDGE;
            end

            GEN3 : begin
                ph1_pcie_cfg_st <= pll_ready  ? DONE  : GEN3        ;
            end

            GEN2 : begin
                ph1_pcie_cfg_st <= pll_ready  ? DONE  : GEN2        ;
            end

            DONE: begin
                ph1_pcie_cfg_st <= pll_ready  ? DONE  : JUDGE		;
                user_link_aux   <= 1'b1                             ;
            end
        default:;
        endcase
    end
end

always@( posedge user_clk or negedge core_rst_n ) begin
    if( !core_rst_n ) begin
        core_10us_cnt <= 12'd0;
    end else if( ph1_pcie_cfg_st == JUDGE )  begin
        core_10us_cnt <= core_10us_cnt + 1'b1;
    end else begin
        core_10us_cnt <= 12'd0;
    end
end

always@( posedge aux_clk or negedge core_rst_n ) begin
    if( !core_rst_n ) begin
        aux_10us_cnt <= {AUX_10US_WIDTH{1'b0}};
    end else if( ph1_pcie_cfg_st == JUDGE )  begin
        if( aux_10us_cnt != AUX_10US_CNT )
            aux_10us_cnt <= aux_10us_cnt + 1'b1;
    end else begin
        aux_10us_cnt <= {AUX_10US_WIDTH{1'b0}};
    end
end

always@( posedge aux_clk ) begin
    core_10us_cnt_aux    <= core_10us_cnt;
    core_10us_cnt_aux_dly<= core_10us_cnt_aux;
end

always@( posedge aux_clk or negedge core_rst_n ) begin
    if( !core_rst_n ) begin
        lock_gen <= 3'b000;
    end else if( ph1_pcie_cfg_st == JUDGE && aux_10us_cnt == AUX_10US_CNT )  begin
        if( core_10us_cnt_aux_dly >= 550 && core_10us_cnt_aux_dly <= 700 ) begin
            lock_gen <= 3'b001;
        end else if( core_10us_cnt_aux_dly >= 1100 && core_10us_cnt_aux_dly <= 1300 ) begin
            lock_gen <= 3'b010;
        end else if( core_10us_cnt_aux_dly >= 2400 && core_10us_cnt_aux_dly <= 2600 ) begin
            lock_gen <= 3'b100;
        end
    end else begin
        lock_gen <= 3'b000;
    end
end

//--------------------------------------------
//  pll drp configurtaion interface
//--------------------------------------------
always@( posedge aux_clk or negedge core_rst_n )
begin
    if( !core_rst_n ) begin
        pll_drp_sel   <= 1'b0;
        pll_drp_wr    <= 1'b0;
        pll_drp_addr  <= 8'd0;
        pll_drp_wdata <= 8'd0;
        pll_drp_cnt   <= 4'd0;
    end else begin
        case( ph1_pcie_cfg_st )

            INIT_GEN1 : begin
                pll_drp_addr  <= gen1_cfg_data[pll_drp_cnt][7:0];
                pll_drp_wdata <= gen1_cfg_data[pll_drp_cnt][15:8];
                pll_drp_sel   <= ( pll_drp_cnt < PLL_CFG_NUM )  ? 1'b1              : 1'b0 ;
                pll_drp_wr    <= ( pll_drp_cnt < PLL_CFG_NUM )  ? 1'b1              : 1'b0 ;
                pll_drp_cnt   <= ( pll_drp_cnt != PLL_CFG_NUM+4 ) ? pll_drp_cnt + 1'b1: pll_drp_cnt;
            end

            GEN2 : begin
                pll_drp_addr  <= gen2_cfg_data[pll_drp_cnt][7:0];
                pll_drp_wdata <= gen2_cfg_data[pll_drp_cnt][15:8];
                pll_drp_sel   <= ( pll_drp_cnt < PLL_CFG_NUM )  ? 1'b1              : 1'b0 ;
                pll_drp_wr    <= ( pll_drp_cnt < PLL_CFG_NUM )  ? 1'b1              : 1'b0 ;
                pll_drp_cnt   <= ( pll_drp_cnt != PLL_CFG_NUM+4 ) ? pll_drp_cnt + 1'b1: pll_drp_cnt;
            end

            GEN3 : begin
                pll_drp_addr  <= gen3_cfg_data[pll_drp_cnt][7:0];
                pll_drp_wdata <= gen3_cfg_data[pll_drp_cnt][15:8];
                pll_drp_sel   <= ( pll_drp_cnt < PLL_CFG_NUM )  ? 1'b1              : 1'b0 ;
                pll_drp_wr    <= ( pll_drp_cnt < PLL_CFG_NUM )  ? 1'b1              : 1'b0 ;
                pll_drp_cnt   <= ( pll_drp_cnt != PLL_CFG_NUM+4 ) ? pll_drp_cnt + 1'b1: pll_drp_cnt;
            end

        default: pll_drp_cnt <= 4'd0;
        endcase
    end
end

// pll_rst_n, befor drp pll, reset pll
always@( posedge aux_clk or negedge core_rst_n )
begin
    if( !core_rst_n ) begin
        pll_rst_n <= 1'b0;
    end else if( pll_drp_cnt == PLL_CFG_NUM+2 ) begin
        pll_rst_n <= 1'b0;
    end else begin
        pll_rst_n <= 1'b1;
    end
end

// pll_lock_cnt
always@( posedge aux_clk or negedge core_rst_n )
begin
    if( !core_rst_n ) begin
        pll_lock_cnt <= {PLL_LOCK_WIDTH{1'b0}};
    end else if( pll_lock_aux_dly==1'b0 || ph1_pcie_cfg_st==IDLE ) begin
        pll_lock_cnt <= {PLL_LOCK_WIDTH{1'b0}};
    end else if( pll_lock_cnt == PLL_LOCK_CNT  )  begin
        pll_lock_cnt <= pll_lock_cnt;
    end else begin
        pll_lock_cnt <= pll_lock_cnt + 1'b1;
    end
end


// pll_ready
always@( posedge aux_clk or negedge core_rst_n )
begin
    if( !core_rst_n ) begin
        pll_ready    <= 1'b0;
    end else if( pll_lock_cnt==PLL_LOCK_CNT ) begin
        pll_ready    <= 1'b1;
    end else begin
        pll_ready    <= 1'b0;
    end
end


wire	 core_clk_buf;

PH1_PHY_SCLK_V2 u_pll_clk(
    .ce(1'b1),
    .clkin(core_clk),
    .clkout(core_clk_ref)
    );



pcie_core_pll u_pcie_core_pll(
  .refclk           (core_clk_ref   ),
  .reset            (!pll_rst_n     ),
  .drp_clk          (aux_clk        ),
  .drp_rstn         (1'b1           ),
  .drp_sel          (pll_drp_sel    ),
  .drp_rd           (pll_drp_rd     ),
  .drp_wr           (pll_drp_wr     ),
  .drp_addr         (pll_drp_addr   ),
  .drp_wdata        (pll_drp_wdata  ),
  .lock             (pll_lock       ),
  .drp_err          (pll_drp_err    ),
  .drp_rdy          (pll_drp_rdy    ),
  .drp_rdata        (pll_drp_rdata  ),
  .clk0_out         (),
  .clk1_out         (user_clk       )
);

// pll cfg data
always@( posedge aux_clk ) begin

    gen1_cfg_data[0]    <= 16'h0c_24;  // 0.5 : 8  / 0.25 : c
    gen1_cfg_data[1]    <= 16'h0e_25;
    gen1_cfg_data[2]    <= 16'h0f_27;
    gen1_cfg_data[3]    <= 16'h0c_28;
    gen1_cfg_data[4]    <= 16'h0e_29;
    gen1_cfg_data[5]    <= 16'h0f_2b;

    //gen1_cfg_data[6]    <= 16'h08_24;
    //gen1_cfg_data[7]    <= 16'h08_24;
    //gen1_cfg_data[8]    <= 16'h08_24;
    //gen1_cfg_data[9]    <= 16'h08_24;

    gen2_cfg_data[0]    <= 16'h06_24;   // 0.5 : 4 / 0.25 : 6
    gen2_cfg_data[1]    <= 16'h06_25;
    gen2_cfg_data[2]    <= 16'h07_27;
    gen2_cfg_data[3]    <= 16'h06_28;
    gen2_cfg_data[4]    <= 16'h06_29;
    gen2_cfg_data[5]    <= 16'h07_2b;

    gen3_cfg_data[0]    <= 16'h03_24;   // 0.5 : 2 / 0.25 : 3
    gen3_cfg_data[1]    <= 16'h02_25;
    gen3_cfg_data[2]    <= 16'h03_27;
    gen3_cfg_data[3]    <= 16'h03_28;
    gen3_cfg_data[4]    <= 16'h02_29;
    gen3_cfg_data[5]    <= 16'h03_2b;
end

endmodule
