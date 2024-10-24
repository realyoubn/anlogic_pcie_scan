
`include "../../sgdma_ip/def/para_def.vh"
module usr_regrw(
	input    wire   usr_rst_n,
	input	 wire   usr_clk,
			  
 	input   wire   m0_axis_h2c_rst_i,
	input   wire   s0_axis_c2h_rst_i,
                 
	input	 wire   usr_regrw_run_i,
//  output   wire   data_rst_flag,
	input    wire   [31:0]   m_axil_awaddr_i,
	input 	 wire   [2:0]    m_axil_awprot_i,	
	input 	 wire   m_axil_awvalid_i,		
	output   wire   m_axil_awready_o,		
	input 	 wire   [31:0]   m_axil_wdata_i,	
	input 	 wire   [3:0] 	  m_axil_wstrb_i,	
	input 	 wire   m_axil_wvalid_i,		
	output   wire   m_axil_wready_o,	
	output   wire   m_axil_bvalid_o,	
	output   wire   [1:0]    m_axil_bresp_o,	
	input 	 wire   m_axil_bready_i,	
	input 	 wire   [31:0]   m_axil_araddr_i,	
	input 	 wire   [2:0]    m_axil_arprot_i,	
	input    wire   m_axil_arvalid_i,		
	output   wire   m_axil_arready_o,	
	output   wire   [31:0]   m_axil_rdata_o,	
	output   wire   [1:0]    m_axil_rresp_o,	
	output   wire   m_axil_rvalid_o,		
	input    wire   m_axil_rready_i,
    
    input    wire   [31:0]   usr_h2c0err_num_i,
	output   wire   [1:0]    usr_lp0rw_md_o,
    output   reg    [31:0]   bram_di,
    output   reg    [19:0]   bram_wraddr,
    output   wire   bram_wren
);


//---Variable definition;
reg    m_axil_awready;
wire   aw_handshake_ok;
//reg    [19:0]   bram_wraddr;
reg    m_axil_wready;
wire   w_handshake_ok;
//reg    [31:0]   bram_di;
wire   [31:0]   bram_do;
reg    wt_wren_rgn0;
reg    wt_wren_rgn1;
//wire   bram_wren;
wire   b_handshake_ok;
reg    m_axil_bvalid;
reg    [1:0]    m_axil_bresp;
reg    m_axil_arready;
wire   ar_handshake_ok;
wire   [19:0]   bram_rdaddr;
wire   bram_rden;
reg    bram_rden_d1;
reg    m_axil_rvalid;
wire   r_handshake_ok;
reg    [31:0]   m_axil_rdata;
reg    m_axil_rresp;
reg    data_rst_flag_temp;
reg    data_rst_flag_temp_ff;
reg    [19:0]   bram_rdaddr_d1;
reg    regrw_run_d1;
wire   regrw_run_falling;

always@(posedge usr_clk,negedge usr_rst_n)
begin 
	if(!usr_rst_n) 
		regrw_run_d1 <= `DLY 1'b0;
	else 
		regrw_run_d1 <= `DLY usr_regrw_run_i;
end
assign regrw_run_falling = (~usr_regrw_run_i) & regrw_run_d1;
//---Write address channel;
always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)
		m_axil_awready <= `DLY 1'b0;
	else 
		m_axil_awready <= `DLY ~m_axil_awready;//---($random%2);
end
assign m_axil_awready_o = m_axil_awready;
assign aw_handshake_ok = m_axil_awready & m_axil_awvalid_i;
always @(posedge usr_clk)
begin
	if(aw_handshake_ok)
		bram_wraddr <= `DLY m_axil_awaddr_i[19:0];
	else ;
end
//---Write data channel;
always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)
		m_axil_wready <= `DLY 1'b0;
	else 
		m_axil_wready <= `DLY ~m_axil_wready;//---($random%2);
end
assign m_axil_wready_o = m_axil_wready;
assign w_handshake_ok = m_axil_wready & m_axil_wvalid_i;
always @(posedge usr_clk)
begin
	if(w_handshake_ok)
		bram_di <= `DLY m_axil_wdata_i;
	else ;
end
always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)
		wt_wren_rgn0 <= `DLY 1'b0;
	else if(bram_wren | regrw_run_falling)
		wt_wren_rgn0 <= `DLY 1'b0;
	else if(aw_handshake_ok)
		wt_wren_rgn0 <= `DLY 1'b1;
	else ;
end
always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)
		wt_wren_rgn1 <= `DLY 1'b0;
	else if(bram_wren | regrw_run_falling)
		wt_wren_rgn1 <= `DLY 1'b0;
	else if(w_handshake_ok)
		wt_wren_rgn1 <= `DLY 1'b1;
	else ;
end	
assign bram_wren = wt_wren_rgn0 & wt_wren_rgn1;
//---Write response channel;
assign b_handshake_ok = m_axil_bvalid & m_axil_bready_i;
always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)
		m_axil_bvalid <= `DLY 1'b0;
	else if(b_handshake_ok | regrw_run_falling)
		m_axil_bvalid <= `DLY 1'b0;
	else if(bram_wren)
		m_axil_bvalid <= `DLY 1'b1;
	else ;
end
assign m_axil_bvalid_o = m_axil_bvalid;
always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)
		m_axil_bresp <= `DLY 2'b00;
	else if(regrw_run_falling)
		m_axil_bresp <= `DLY 2'b00;
	else if(bram_wren)
		m_axil_bresp <= `DLY (bram_wraddr[19:16]!=`USR_BS_ADDRH) ? 2'b11 : 2'b00;
	else ;
end
assign m_axil_bresp_o = m_axil_bresp;
ram512x32 u_ram512x32( 
	.dia(bram_di), 
	.addra(bram_wraddr[10:2]), 
	.cea(bram_wren), 
	.clka(usr_clk),
	.dob(bram_do), 
	.addrb(bram_rdaddr[10:2]), 
	.ceb(bram_rden)
);
//---Read address channel;
always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)
		m_axil_arready <= `DLY 1'b0;
	else 
		m_axil_arready <= `DLY ~m_axil_arready;//---($random%2);
end
assign m_axil_arready_o = m_axil_arready;
assign ar_handshake_ok = m_axil_arvalid_i & m_axil_arready;
assign bram_rdaddr = m_axil_araddr_i[19:0];
assign bram_rden = ar_handshake_ok;
always @(posedge usr_clk)
begin
	if(ar_handshake_ok)
	    bram_rdaddr_d1 <= `DLY bram_rdaddr;
    else ;
end
always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n) 
		bram_rden_d1 <= `DLY 1'b0;
	else 
		bram_rden_d1 <= `DLY bram_rden;
end
//---Read response channel;
always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)
		m_axil_rvalid <= `DLY 1'b0;
	else if(r_handshake_ok | regrw_run_falling)
		m_axil_rvalid <= `DLY 1'b0;
	else if(bram_rden_d1)
		m_axil_rvalid <= `DLY 1'b1;
	else ;
end
assign m_axil_rvalid_o = m_axil_rvalid;
assign r_handshake_ok = m_axil_rvalid & m_axil_rready_i;

always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)
		m_axil_rdata <= `DLY 32'd0;
	else if(bram_rden_d1) begin
    	if(bram_rdaddr_d1[15:2]==14'd1) 
        	m_axil_rdata <= `DLY usr_h2c0err_num_i;
        else	
        	m_axil_rdata <= `DLY bram_do;
    end
	else ;
end

assign m_axil_rdata_o = m_axil_rdata;
always @(posedge usr_clk,negedge usr_rst_n)
begin
	if(!usr_rst_n)
		m_axil_rresp <= `DLY 2'b00;
	else if(regrw_run_falling)
		m_axil_rresp <= `DLY 2'b00;
	else if(bram_rden_d1)
		m_axil_rresp <= `DLY (bram_rdaddr_d1[19:16]!=`USR_BS_ADDRH) ? 2'b11 : 2'b00;
	else ;
end
assign m_axil_rresp_o = m_axil_rresp;

//---Define loopback mode;
reg   [1:0]   usr_lp0rw_md;
always@(posedge usr_clk,negedge usr_rst_n)
begin 
	if(!usr_rst_n) 
    	usr_lp0rw_md <= `DLY 2'b11;
    else if(bram_wren==1'b1 && bram_wraddr[15:0]==16'd0)
		usr_lp0rw_md <= bram_di[1:0];
    else begin
    	if(m0_axis_h2c_rst_i)
        	usr_lp0rw_md[1] <= 1'b0;
        else ;
        if(s0_axis_c2h_rst_i)
        	usr_lp0rw_md[0] <= 1'b0;
        else ;
     end
end
assign usr_lp0rw_md_o = usr_lp0rw_md;

endmodule
/*	
	output   [2:0]    usr_prg_payload_o,
	output   [2:0]    usr_prg_read_o,
	
	input    [31:0]   usr_h2c0_nerr_i, 
	input	 [2:0]	  usr_eff_payload_i,
	input	 [2:0]	  usr_eff_read_i	
reg	   [31:0]	usr_wraddr;

reg    [2:0]    usr_prg_payload;
reg    [2:0]    usr_prg_read;
reg    m_axil_bvalid;
reg    m_axil_rvalid;
reg    [31:0]   m_axil_rdata;

assign m_axil_awready_o = 1'b1;  

always @(posedge usr_clk)
begin 
	if( m_axil_awvalid_i &  m_axil_awready_o )
		usr_wraddr	<= m_axil_awaddr_i;
	else ;
end

assign m_axil_wready_o = 1'b1;

always@(posedge usr_clk or negedge usr_rst_n) 
begin
	if(!usr_rst_n) begin
		usr_prg_payload <= 3'b001;
		usr_prg_read <= 3'b001;
	end
	else if(m_axil_wvalid_i & m_axil_wready_o) begin
		case (usr_wraddr[15:0])
			USR_PRG_PAYLOAD : usr_prg_payload <= m_axil_wdata_i[2:0];
			USR_PRG_READ : usr_prg_read <= m_axil_wdata_i[2:0];
			default: ;
		endcase
	end
	else ;
end
assign usr_prg_payload_o = usr_prg_payload;
assign usr_prg_read_o = usr_prg_read;

always@(posedge usr_clk or negedge usr_rst_n ) 
begin 
	if(!usr_rst_n)  
		m_axil_bvalid <= 1'b0;
	else if(m_axil_bvalid & m_axil_bready_i)  
		m_axil_bvalid <= 1'b0;
	else if(m_axil_wvalid_i & m_axil_wready_o)  
		m_axil_bvalid <= 1'b1;
	else ;
end
assign m_axil_bvalid_o = m_axil_bvalid;
assign m_axil_bresp_o = 2'b00;


assign m_axil_arready_o = 1'b1;

always@(posedge usr_clk or negedge usr_rst_n)
begin 
	if(!usr_rst_n)
		m_axil_rvalid <= 1'b0;
	else if(m_axil_rvalid & m_axil_rready_i)
		m_axil_rvalid <= 1'b0;
	else if(m_axil_arvalid_i & m_axil_arready_o)
		m_axil_rvalid <= 1'b1;
	else ;
end
assign m_axil_rvalid_o = m_axil_rvalid;

always@(posedge usr_clk or negedge usr_rst_n ) 
begin 
	if(!usr_rst_n)
		m_axil_rdata <= 32'd0;
	else if(m_axil_arvalid_i & m_axil_arready_o) begin
		case(m_axil_araddr_i[15:0])
			USR_PRG_PAYLOAD : m_axil_rdata <= {26'd0,usr_eff_payload_i,3'd0};
			USR_PRG_READ : m_axil_rdata <= {26'd0,usr_eff_read_i,3'd0};
			USR_H2C0_NERR : m_axil_rdata <= usr_h2c0_nerr_i;
			default : ; 
		endcase
	end
	else ;
end
assign m_axil_rdata_o = m_axil_rdata;
assign	m_axil_rresp_o = 2'b00;*/
