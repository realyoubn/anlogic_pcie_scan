


`timescale 1ns / 1ps

module ep_dbi_init_mux(

    input          core_clk	                    	       ,	// pcie core_clk inpupt	
    input          pcie_rst_n	                               ,	// pcie perst_n input 
    input          core_rst_n_pll                              ,
    input          dbi_init_disable                	       ,	// set 1'b1 to disable init function 

    input [31:0]   ext_drp_dbi_din 			       ,	// external dbi bus , for user used 
    input [3:0]    ext_drp_dbi_wr 			       ,
    input [31:0]   ext_drp_dbi_addr 			       ,
    input          ext_drp_dbi_cs 			       ,
    input          ext_drp_dbi_cs2_exp 			       ,
    input [1:0]    ext_drp_dbi_vfunc_num 		       ,
    input          ext_drp_dbi_vfunc_active 		       ,
    input [2:0]    ext_drp_dbi_bar_num 			       ,
    input          ext_drp_dbi_rom_access 		       ,
    input          ext_drp_dbi_io_access 		       ,
    input          ext_drp_dbi_func_num 		       ,
    input          ext_drp_app_dbi_ro_wr_disable 	       ,
    output	   ext_drp_lbc_dbi_ack			       ,	   
    output [31:0]  ext_drp_lbc_dbi_dout			       ,
    
    input  	       ext_app_app_ltssm_enable		       ,	// external ltssm_enable , for user used 

    output reg [31:0]  drp_dbi_din 			       ,	// pcie dbi bus , mux between internal and external
    output reg [3:0]   drp_dbi_wr 			       ,
    output reg [31:0]  drp_dbi_addr 			       ,	   
    output reg         drp_dbi_cs 			       ,
    output reg         drp_dbi_cs2_exp 			       ,
    output reg [1:0]   drp_dbi_vfunc_num 		       ,
    output reg         drp_dbi_vfunc_active 		       ,
    output reg [2:0]   drp_dbi_bar_num 			       ,
    output reg         drp_dbi_rom_access 		       ,
    output reg         drp_dbi_io_access 		       ,
    output reg         drp_dbi_func_num 		       ,
    output reg         drp_app_dbi_ro_wr_disable 	       ,
    input  wire        drp_lbc_dbi_ack		               ,	   
    input  wire [31:0] drp_lbc_dbi_dout			       ,
    
    output reg	       app_app_ltssm_enable	          		// pcie ltssm_enable , mux between internal and external  					
 );
 
 
 
// ====================================================================
// Parameter/wire/reg
// ====================================================================
	
    localparam 	TIMEOUT = 8'd200;    
    parameter  	INT_DBI_IDLE  = 6'b00_0001,
      		INT_DBI_WR    = 6'b00_0010,
      		INT_DBI_WAIT1 = 6'b00_0100,
		INT_DBI_WAIT2 = 6'b00_1000,
                INT_DBI_CHK   = 6'b01_0000,
                INT_DBI_DONE  = 6'b10_0000;
 
 
//internal register and combination siangls
    reg  [5:0]	 int_drp_dbi_state; 		 
    reg  [5:0]	 int_drp_dbi_cnt=6'd0;
    reg 	 int_drp_rst_n;
    reg  [6:0]	 int_cfg_addr;
    wire [67:0]	 int_cfg_data;
    reg          int_drp_dbi_done=0;
    reg  [3:0]   int_drp_wait_cnt;
    
    reg  [31:0]  int_drp_dbi_din=0;
    reg  [3:0]   int_drp_dbi_wr=0;
    reg  [31:0]  int_drp_dbi_addr=0;  
    reg          int_drp_dbi_cs=0;
    reg          int_drp_dbi_cs2_exp=0;
    reg  [1:0]   int_drp_dbi_vfunc_num=0;
    reg          int_drp_dbi_vfunc_active=0;
    reg  [2:0]   int_drp_dbi_bar_num=0;
    reg          int_drp_dbi_rom_access=0;
    reg          int_drp_dbi_io_access=0;
    reg          int_drp_dbi_func_num=0;
    reg          int_drp_app_dbi_ro_wr_disable=0;
    reg          int_app_app_ltssm_enable=0;     
    reg  [7:0]   cnt_timeout;
    wire         handshake_ok;
    wire         ack_timeout;
    reg  [67:0]  int_cfg_data_d1;
    reg  [2:0]   cnt;
    reg          int_drp_dbi_done_d1;

// pcie cfg initial vaule 
 ep_cfg_rom u_pcie_cfg_rom( 
    .doa		(int_cfg_data	), 
    .addra		(int_cfg_addr	), 
    .clka		(core_clk	) 
    //.rsta		(1'b0		) 
);
// rom cfg_data delay for timing 
always@(posedge core_clk or negedge pcie_rst_n)begin
    if(!pcie_rst_n)begin
    	int_cfg_data_d1 <= 'd0;
    end
    else begin 
    	int_cfg_data_d1 <= int_cfg_data;
    end
end
//cs handshake ack
assign handshake_ok =  int_drp_dbi_cs & drp_lbc_dbi_ack;
always@(posedge core_clk or negedge pcie_rst_n)begin
    if(!pcie_rst_n)
        cnt_timeout <= 8'd0;
    else if(handshake_ok)
        cnt_timeout <= 8'd0;
    else if(int_drp_dbi_cs)
        cnt_timeout <= cnt_timeout + 8'd1;
    else;
end
assign ack_timeout = (cnt_timeout==TIMEOUT-1)? 1'b1:1'b0;

// internal dbi states 
always@(posedge core_clk or negedge pcie_rst_n) begin 
	if(!pcie_rst_n) begin 
    	int_app_app_ltssm_enable <= 1'b0;
    	int_drp_dbi_din 	 <= 32'd0;
    	int_drp_dbi_wr 	 	 <= 4'd0;
    	int_drp_dbi_addr 	 <= 32'd0;  
    	int_drp_dbi_cs 		 <= 1'b0;
    	int_drp_dbi_cs2_exp 	 <= 1'b0;
    	int_drp_dbi_vfunc_num 	 <= 2'd0;
    	int_drp_dbi_vfunc_active <= 1'b0;
    	int_drp_dbi_bar_num 	 <= 3'd0;
    	int_drp_dbi_rom_access 	 <= 1'b0;
    	int_drp_dbi_io_access 	 <= 1'b0;
    	int_drp_dbi_func_num 	 <= 1'b0;
    	int_drp_app_dbi_ro_wr_disable <= 1'b0; 
        int_drp_dbi_state	      <= INT_DBI_IDLE; 
        int_cfg_addr		      <= 7'd0;
        int_drp_wait_cnt              <= 4'b0;          
        int_drp_dbi_done	      <= dbi_init_disable;	    
    end else begin 
    	case(int_drp_dbi_state)
    		INT_DBI_IDLE: begin 
                int_drp_wait_cnt  <= int_drp_wait_cnt + 1'b1;           
                if(int_drp_wait_cnt[3]&core_rst_n_pll)
            	    int_drp_dbi_state <= INT_DBI_WR;

            end 
            INT_DBI_WR: begin 
            	int_drp_dbi_vfunc_num   <= int_cfg_data_d1[65:64];
                int_drp_dbi_vfunc_active<= int_cfg_data_d1[60];
                int_drp_dbi_func_num    <= int_cfg_data_d1[56];
                int_drp_app_dbi_ro_wr_disable <= int_cfg_data_d1[47];
                int_drp_dbi_cs2_exp	      <= int_cfg_data_d1[44];
                int_drp_dbi_addr  	      <= {20'd0,int_cfg_data_d1[43:32]};
            	int_drp_dbi_din	  	      <= int_cfg_data_d1[31:0];
            	int_drp_dbi_wr    	      <= 4'hf;
                int_drp_dbi_cs		      <= 1'b1;
                
                if(ack_timeout)
                     int_drp_dbi_cs <= 1'b0;
                else if( handshake_ok ) begin 
            		int_drp_dbi_state     <= INT_DBI_WAIT1;
                        int_drp_dbi_cs	      <= 1'b0;
		        int_cfg_addr          <= int_cfg_addr + 1'b1;
                end 
            end 
            
            INT_DBI_WAIT1 : begin 
                int_drp_dbi_state <= INT_DBI_WAIT2;
            end

	    INT_DBI_WAIT2 : begin 
                int_drp_dbi_state <= INT_DBI_CHK;
            end
            
            INT_DBI_CHK:begin 
                int_drp_wait_cnt  <= 'd0;
            	if( int_cfg_data_d1[43:32] == 'd0 && int_cfg_data_d1[31:0] == 'd0 ) begin   
                	int_drp_dbi_state <= INT_DBI_DONE;
                end 
                else begin 
                	int_drp_dbi_state <= INT_DBI_IDLE;
                end 
            end 
            
            INT_DBI_DONE:begin 
            	int_drp_dbi_state <= INT_DBI_DONE;
           		int_drp_dbi_done  <= 1'b1;
            end 
            
        	default : int_drp_dbi_state <= INT_DBI_IDLE;      
        endcase 
    end 
end 
// int_drp_dbi_done delay for external dbi cs
always@(posedge core_clk or negedge pcie_rst_n) begin 
	if(!pcie_rst_n) 
		cnt <= 3'd0;
	else if(int_drp_dbi_done)
		cnt <= cnt + 1'b1;
	else 
		cnt <= cnt;
end
always@(posedge core_clk or negedge pcie_rst_n) begin 
	if(!pcie_rst_n) 
		int_drp_dbi_done_d1 <= 3'd0;
	else if(cnt == 3'd3)
		int_drp_dbi_done_d1 <= int_drp_dbi_done;
	else 
		int_drp_dbi_done_d1 <= int_drp_dbi_done_d1;
end
// mux for internal and external dbi bus
assign	    ext_drp_lbc_dbi_ack	 = int_drp_dbi_done_d1 ? drp_lbc_dbi_ack    :  1'b0  ;	   
assign	    ext_drp_lbc_dbi_dout = int_drp_dbi_done_d1 ? drp_lbc_dbi_dout   :  31'd0 ;

// used aysnc for post_sim  
// if core_clk is not ready,this signals will be highz in sync reset
always@(posedge core_clk or negedge pcie_rst_n) begin 
	if(!pcie_rst_n)begin 
    	app_app_ltssm_enable <= 1'b0;
        drp_dbi_din	     <= 'd0;
        drp_dbi_wr	     <= 'd0;
    	drp_dbi_addr	     <= 'd0;
        drp_dbi_cs	     <= 'd0;
        drp_dbi_cs2_exp	     <= 'd0;
        drp_dbi_vfunc_num    <= 'd0;
        drp_dbi_vfunc_active <= 'd0;
        drp_dbi_bar_num      <= 'd0;
        drp_dbi_rom_access   <= 'd0;
        drp_dbi_io_access    <= 'd0;
        drp_dbi_func_num     <= 'd0;
        drp_app_dbi_ro_wr_disable <= 'd0;
    end else if( int_drp_dbi_done_d1 ) begin 
    	app_app_ltssm_enable <= ext_app_app_ltssm_enable;
        drp_dbi_din	     <= ext_drp_dbi_din;
        drp_dbi_wr	     <= ext_drp_dbi_wr;
    	drp_dbi_addr	     <= ext_drp_dbi_addr;
        drp_dbi_cs	     <= ext_drp_dbi_cs;
        drp_dbi_cs2_exp	     <= ext_drp_dbi_cs2_exp;
        drp_dbi_vfunc_num    <= ext_drp_dbi_vfunc_num;
        drp_dbi_vfunc_active <= ext_drp_dbi_vfunc_active;
        drp_dbi_bar_num      <= ext_drp_dbi_bar_num;
        drp_dbi_rom_access   <= ext_drp_dbi_rom_access;
        drp_dbi_io_access    <= ext_drp_dbi_io_access;
        drp_dbi_func_num     <= ext_drp_dbi_func_num;
        drp_app_dbi_ro_wr_disable <= ext_drp_app_dbi_ro_wr_disable;
    end else begin 
    	app_app_ltssm_enable <= int_app_app_ltssm_enable ;
        drp_dbi_din	     <= int_drp_dbi_din;
        drp_dbi_wr	     <= int_drp_dbi_wr;
    	drp_dbi_addr	     <= int_drp_dbi_addr;
        drp_dbi_cs	     <= int_drp_dbi_cs;
        drp_dbi_cs2_exp	     <= int_drp_dbi_cs2_exp;
        drp_dbi_vfunc_num    <= int_drp_dbi_vfunc_num;
        drp_dbi_vfunc_active <= int_drp_dbi_vfunc_active;
        drp_dbi_bar_num      <= int_drp_dbi_bar_num;
        drp_dbi_rom_access   <= int_drp_dbi_rom_access;
        drp_dbi_io_access    <= int_drp_dbi_io_access;
        drp_dbi_func_num     <= int_drp_dbi_func_num;
        drp_app_dbi_ro_wr_disable <= int_drp_app_dbi_ro_wr_disable;
    end
end 





endmodule