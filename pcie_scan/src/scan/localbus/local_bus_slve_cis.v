`timescale 1ns/1ps

module local_bus_slve_cis (
               
input                          lb_clk,
input                          lb_reset_n,
input 			               rx ,
output  			           tx ,
output reg                     lb_crc_error_n,
output reg                     ubus_identify,

//----------------------------------REG-----------------------------

input   [31:0]                 nd2reg_0 , 
input   [31:0]                 nd2reg_1 ,
input   [31:0]                 nd2reg_2 ,
input   [31:0]                 nd2reg_3 ,
input   [31:0]                 nd2reg_4 ,
input   [31:0]                 nd2reg_5 ,
input   [31:0]                 nd2reg_6 ,
input   [31:0]                 nd2reg_7 ,

output reg [31:0]              reg2nd_0  ,
output reg [31:0]              reg2nd_1  ,
output reg [31:0]              reg2nd_2  ,
output reg [31:0]              reg2nd_3  ,
output reg [31:0]              reg2nd_4  ,
output reg [31:0]              reg2nd_5  ,
output reg [31:0]              reg2nd_6  ,
output reg [31:0]              reg2nd_7  , 
output reg [31:0]              reg2nd_8  , 
output reg [31:0]              reg2nd_9  , 
output reg [31:0]              reg2nd_10 , 
output reg [31:0]              reg2nd_11 , 
output reg [31:0]              reg2nd_12 , 
output reg [31:0]              reg2nd_13 , 
output reg [31:0]              reg2nd_14 , 
output reg [31:0]              reg2nd_15 
              

);

   
//Regist tab -----------------------------------------------------------------------------------------------------

reg[31:0]                      reg0   ;                        
reg[31:0]                      reg1   ;                        
reg[31:0]                      reg2   ;                        
reg[31:0]                      reg3   ;                        
reg[31:0]                      reg4   ;                        
reg[31:0]                      reg5   ;                        
reg[31:0]                      reg6   ;                        
reg[31:0]                      reg7   ;                        
reg[31:0]                      reg8   ;                        
reg[31:0]                      reg9   ;                        
reg[31:0]                      reg10  ;                        
reg[31:0]                      reg11  ;                        
reg[31:0]                      reg12  ;                        
reg[31:0]                      reg13  ;                        
reg[31:0]                      reg14  ;                        
reg[31:0]                      reg15  ;                        





//Local bus ------------------------------------------------------------------------------------------------------

reg 						 frame_n_td0,frame_n_td1,frame_n_td2;  // rx_done 
reg 						 frame_n;
wire 					     slv_rw_start;
wire 					     data_transfer_done;
reg [7:0] 					 byte0;
reg [7:0] 					 byte1;

wire 					     rd_en;
wire 					     wr_en;
wire 					     idle_en;

reg[2:0]                     byte_cnt;
(*keep*) wire[7:0]                    rx_byte;//synthesis keep 
wire                         rx_done;

always @ (posedge lb_clk) begin
  if (~lb_reset_n) begin
        frame_n     <= 1'b0;
        frame_n_td0 <= 1'b0;
        frame_n_td1 <= 1'b0;
        frame_n_td2 <= 1'b0;
  end
  else begin 
        frame_n     <= rx_done;
        frame_n_td0 <= frame_n;
        frame_n_td1 <= frame_n_td0;
        frame_n_td2 <= frame_n_td1;
  end
end

assign    slv_rw_start = frame_n_td0 & ~frame_n & idle_en;




//-------------------------------------- Local bus CRC ------------------------------------------------
reg[4:0]      slv_state,slv_nstate;

reg       cmd_err,d16_err0,d16_err1;
reg       wr_en_d0 ,wr_en_d1;

reg [7:0] reg_byte0;
reg [7:0] reg_byte1;
reg [7:0] reg_byte2;
reg [7:0] reg_byte3;
reg [7:0] reg_byte4;
reg [7:0] reg_byte5;

reg[31:0] slv_ip2_bus;

reg [3:0] crc4_i;
reg [3:0] crc4_o;
wire      crc4_err;
wire[3:0] crc4_wire;

always @ (posedge lb_clk) begin
  if (~lb_reset_n) 
        lb_crc_error_n <= 1'b1;
  else if (slv_rw_start)
        lb_crc_error_n <= 1'b1;
  else 
        lb_crc_error_n <= (~cmd_err) & (~d16_err0) & (~d16_err1);

end


reg slv_rw_start_d0,slv_rw_start_d1,slv_rw_start_d2,slv_rw_start_d3;


always @ (posedge lb_clk) begin
  if (~lb_reset_n) 
   begin
     slv_rw_start_d0 <= 1'b0;
     slv_rw_start_d1 <= 1'b0;
     slv_rw_start_d2 <= 1'b0;
     slv_rw_start_d3 <= 1'b0;
   end
  else 
   begin
     slv_rw_start_d0 <= slv_rw_start;
     slv_rw_start_d1 <= slv_rw_start_d0;
     slv_rw_start_d2 <= slv_rw_start_d1;
     slv_rw_start_d3 <= slv_rw_start_d2;
   end    

end



wire en_data_parity;

assign en_data_parity = (byte_cnt == 3'b011)  ? 1'b1 : 1'b0;

reg[7:0] data_parity;

always @ (posedge lb_clk) begin
     if (~lb_reset_n)
        data_parity <= 8'h00;
     else if (slv_rw_start_d3 ) 
        data_parity <= 8'h00;
    else if ( slv_state[2] & en_data_parity)
        data_parity <= reg_byte1;
end 

wire   reg_rw_en;
reg    reg_rw_en_td0,reg_rw_en_td1,reg_rw_en_td2,reg_rw_en_td3,reg_rw_en_td4;


wire   cmd_decyt_ci , d0_decyt_ci, d1_decyt_ci ;
reg    cmd_decyt_ci_td0 , d0_decyt_ci_td0, d1_decyt_ci_td0 ;
reg    cmd_decyt_ci_td1 , d0_decyt_ci_td1, d1_decyt_ci_td1 ;
reg    cmd_decyt_ci_td2 , cmd_decyt_ci_td3, cmd_decyt_ci_td4;



wire   pos_cmd_decyt_ci;
wire   pos_d0_decyt_ci;
wire   pos_d1_decyt_ci;

assign cmd_decyt_ci = (byte_cnt == 3'b010)  ? 1'b1 : 1'b0;
assign d0_decyt_ci  = (byte_cnt == 3'b101)  ? 1'b1 : 1'b0;
assign d1_decyt_ci  =  reg_rw_en;

always @ (posedge lb_clk) begin
     if (~lb_reset_n)
        begin
         cmd_decyt_ci_td0 <= 1'b0;
         cmd_decyt_ci_td1 <= 1'b0;
         cmd_decyt_ci_td2 <= 1'b0;
         cmd_decyt_ci_td3 <= 1'b0;
         cmd_decyt_ci_td4 <= 1'b0;
       end
      else
       begin
         cmd_decyt_ci_td0 <= cmd_decyt_ci;
         cmd_decyt_ci_td1 <= cmd_decyt_ci_td0;
         cmd_decyt_ci_td2 <= cmd_decyt_ci_td1;
         cmd_decyt_ci_td3 <= cmd_decyt_ci_td2;
         cmd_decyt_ci_td4 <= cmd_decyt_ci_td3;
       end
end 






assign pos_cmd_decyt_ci = ~cmd_decyt_ci_td0 & cmd_decyt_ci;


always @ (posedge lb_clk) begin
     if (~lb_reset_n)
        begin
         d0_decyt_ci_td0 <= 1'b0;
         d0_decyt_ci_td1 <= 1'b0;
       end
     else
       begin
         d0_decyt_ci_td0 <= d0_decyt_ci;
         d0_decyt_ci_td1 <= d0_decyt_ci_td0;
       end
end 



assign pos_d0_decyt_ci = ~d0_decyt_ci_td0 & d0_decyt_ci;


always @ (posedge lb_clk) begin
     if (~lb_reset_n)
        begin
         d1_decyt_ci_td0 <= 1'b0;
         d1_decyt_ci_td1 <= 1'b0;
       end
     else
       begin
         d1_decyt_ci_td0 <= d1_decyt_ci;
         d1_decyt_ci_td1 <= d1_decyt_ci_td0;
       end
end 


assign pos_d1_decyt_ci = ~d1_decyt_ci_td0 & d1_decyt_ci;

reg [15:0] data_i;

always @ (posedge lb_clk) begin
  if (~lb_reset_n) 
   data_i <= 16'b0;
  else if (pos_cmd_decyt_ci) 
   data_i <= {byte0[7],4'b0000,byte0[2:0],byte1};  //byte1 --addr  , byte0 --cmd
  else if (pos_d0_decyt_ci)
   data_i <= {reg_byte2,reg_byte3};
  else if (pos_d1_decyt_ci)
   data_i <= {reg_byte4,reg_byte5};

end

always @ (posedge lb_clk) begin
  if (~lb_reset_n) 
   crc4_i <= 4'h0;
  else if (slv_rw_start_d1)
   crc4_i <= 4'h0;
  else if (slv_rw_start_d2) 
   crc4_i <=  byte0[6:3]; // CMD CRC4 parity 
  else if (d0_decyt_ci_td0)
   crc4_i <=   data_parity[7:4];
  else if (d1_decyt_ci_td0)
   crc4_i <=   data_parity[3:0];

end


always @ (posedge lb_clk) begin
  if (~lb_reset_n) 
     crc4_o <= 4'b0;
  else if (slv_rw_start_d1)
     crc4_o <= 4'b0;
  else 
     crc4_o <= crc4_wire;
end

assign  crc4_err = (crc4_o == crc4_i) ? 1'b0 : 1'b1;



always @ (posedge lb_clk) begin
  if (~lb_reset_n) 
   cmd_err <= 1'b0;
  else if (slv_rw_start ) 
   cmd_err <= 1'b0; // 
  else if (cmd_decyt_ci_td1 ) 
   cmd_err <= crc4_err ;
end

always @ (posedge lb_clk) begin
  if (~lb_reset_n) 
   d16_err0 <= 1'b0;
  else if (slv_rw_start ) 
   d16_err0 <= 1'b0; // 
  else if (d0_decyt_ci_td1 & slv_state[2] ) 
   d16_err0 <= crc4_err ;
end

always @ (posedge lb_clk) begin
  if (~lb_reset_n) 
   d16_err1 <= 1'b0;
  else if (slv_rw_start ) 
   d16_err1 <= 1'b0; // 
  else if (~data_transfer_done & d1_decyt_ci_td1  & slv_state[2]) 
   d16_err1 <= crc4_err ;
end

wire [3:0] crc4_0000;
assign     crc4_0000 = 4'b0000;

//---decypt CRC4 
CRC4_D16 u0 (
              .Data        (data_i              ),
              .crc         (crc4_0000           ),
              .nextCRC4_D16(crc4_wire           )

      );

//---encypt CRC4 d0 d1


wire [7:0] encypt_crc4;

CRC4_D16 u1 (
              .Data         (slv_ip2_bus[31:16]  ),
              .crc          (crc4_0000           ),
              .nextCRC4_D16 (encypt_crc4[7:4]    )

            );

CRC4_D16 u2 (
              .Data         (slv_ip2_bus[15:0]   ),
              .crc          (crc4_0000           ),
              .nextCRC4_D16 (encypt_crc4[3:0]    )

            );

wire switch_en;

reg [2:0] rx_done_cnt;

always @ (posedge lb_clk) begin
     if (~lb_reset_n)
      begin
        rx_done_cnt  <= 3'b0;
      end
     else if (idle_en)
      begin
        rx_done_cnt  <= 3'b0;
      end
     else if ( rx_done )    rx_done_cnt <= rx_done_cnt + 1'b1;
end

wire rx_done_cnt6;
wire rx_done_cnt1;


assign rx_done_cnt6 = (rx_done_cnt == 3'd6) ? 1'b1 : 1'b0;
assign rx_done_cnt1 = (rx_done_cnt == 3'd1) ? 1'b1 : 1'b0;

reg rx_done_cnt6_td;
reg rx_done_cnt1_td;

always @ (posedge lb_clk) begin
     if (~lb_reset_n)
      begin
        rx_done_cnt6_td <= 1'b0;
      end
      else begin
        rx_done_cnt6_td <= rx_done_cnt6;
      end
end

always @ (posedge lb_clk) begin
     if (~lb_reset_n)
      begin
        rx_done_cnt1_td <= 1'b0;
      end
      else begin
        rx_done_cnt1_td <= rx_done_cnt1;
      end
end




//--------------------------------------- Slave State Machine -----------------------------------------


parameter     SLV_IDLE       = 5'b00001,
              SLV_RW_SWITCH  = 5'b00010,
              SLV_WR         = 5'b00100,
              SLV_RD         = 5'b01000,
              SLV_WAIT       = 5'b10000;



               
always @(posedge lb_clk) begin
     if (~lb_reset_n)
           slv_state <= SLV_IDLE;
     else  slv_state <= slv_nstate; 
end

always @( * ) begin
   slv_nstate = slv_state;
   case (slv_state)
     SLV_IDLE      :  slv_nstate =   slv_rw_start                         ?  SLV_RW_SWITCH : SLV_IDLE;   
     SLV_RW_SWITCH :  slv_nstate =   byte0[2] ?  SLV_WAIT     : byte0[7]  ?  SLV_WR        : SLV_RD;
     SLV_WR        :  slv_nstate =   reg_rw_en_td4 & data_transfer_done   ?  SLV_IDLE      : SLV_WR;
     SLV_RD        :  slv_nstate =   reg_rw_en_td2 & data_transfer_done   ?  SLV_IDLE      : SLV_RD;
     SLV_WAIT      :  slv_nstate =   byte0[7] & rx_done_cnt6_td           ?  SLV_IDLE      : ~byte0[7] & rx_done_cnt1_td ? SLV_IDLE : SLV_WAIT; 
    default        :  slv_nstate =   SLV_IDLE;
   endcase 
end 



assign  idle_en    = slv_state[0] ;
assign  rd_en      = slv_state[3] ;
assign  wr_en      = slv_state[2] & rx_done ;
assign  switch_en  = slv_state[1] ;

always @ (posedge lb_clk) begin
   if (~lb_reset_n)
    begin
      wr_en_d0 <=1'b0;
      wr_en_d1 <=1'b0;
    end
   else 
    begin
      wr_en_d0 <= wr_en;
      wr_en_d1 <= wr_en_d0;
    end
end



wire en_addr ;
assign en_addr = (byte_cnt == 3'b001)  ? 1'b1: 1'b0;


reg rd_en_td0,rd_en_td1;

always @ (posedge lb_clk) begin
     if (~lb_reset_n)
	  begin
        rd_en_td0 <=1'b0;
        rd_en_td1 <=1'b0;
	  end
     else 
	  begin
        rd_en_td0 <= en_addr & frame_n_td2 & rd_en;
        rd_en_td1 <= rd_en_td0;
	  end

   end




wire [2:0] frame_length;

always @ (posedge lb_clk) begin
     if (~lb_reset_n) begin
          byte0 <= 8'b0;
     end
     else
     begin if (slv_rw_start & idle_en)
        byte0 <= rx_byte;
     end             
end

always @ (posedge lb_clk) begin
     if (~lb_reset_n) begin
          byte1 <= 8'b0;
     end
     else
     begin
        byte1 <= rx_byte;
     end             
end


//assign    frame_length     = byte0[6:0];
assign    frame_length     = 3'b1; // only keep burst function -- if used crc , burst function need to revise again

always @ (posedge lb_clk) begin
     if (~lb_reset_n) begin
          reg_byte1 <= 8'b0;
          reg_byte2 <= 8'b0;
          reg_byte3 <= 8'b0;
          reg_byte4 <= 8'b0;
          reg_byte5 <= 8'b0;
     end
     else if (wr_en) begin
        case(byte_cnt)
          3'b010 : reg_byte1 <= rx_byte;
          3'b011 : reg_byte2 <= rx_byte;
          3'b100 : reg_byte3 <= rx_byte;
          3'b101 : reg_byte4 <= rx_byte;
          3'b110 : reg_byte5 <= rx_byte;
        endcase 
     end
end



always @ (posedge lb_clk) begin
     if (~lb_reset_n) begin
          reg_byte0 <= 8'b0;
     end
     else if (wr_en & en_addr ) begin
          reg_byte0 <= rx_byte;
     end
     else if (rd_en & en_data_parity) begin
          reg_byte0 <= rx_byte;
     end
end



wire      pos_reg_rw_en;
wire      tx_done;
//------------------------byte counter ----------------------------------------

always @ (posedge lb_clk) begin
     if (~lb_reset_n)
        byte_cnt <= 3'b0;
     else if (switch_en | reg_rw_en_td4 | ((slv_state == SLV_WAIT)&(slv_nstate == SLV_IDLE) ))
	    byte_cnt  <= 3'b0; 
     else if (frame_n_td2 |  (rd_en & tx_done)  | rd_en_td0) 
        byte_cnt  <= byte_cnt + 1;
end

assign reg_rw_en = (byte_cnt== 3'b111) ? 1'b1 : 1'b0;


//------------------------Register Frame length number counter ----------------
//reg[6:0]   reg_cnt;
reg[2:0]   reg_cnt;
always @ (posedge lb_clk) begin
    if (~lb_reset_n)
        reg_cnt <= 7'b0;
    else if (switch_en)
        reg_cnt <= 7'b0;
    else if (pos_reg_rw_en | (rd_en & reg_rw_en_td1))
        reg_cnt <= reg_cnt + 1; 
end

assign data_transfer_done = (reg_cnt == frame_length) ? 1'b1 : 1'b0;  // if REQUEST FRAME_LENGTH == REG_CNT ,SEND OUT DATA_TRANSFER DONE


//------------------------------------------------------------------------
reg[3:0]  tx_valid; 

always @ (posedge lb_clk) begin
    if (~lb_reset_n)
    begin
        tx_valid <= 4'b0 ;
    end
    else if (rd_en)
    begin
        tx_valid <= {tx_valid[2:0],tx_done};
    end
end


//------------------------------------------------------------------------

always @ (posedge lb_clk) begin
    if (~lb_reset_n)
    begin
        reg_rw_en_td0 <= 1'b0 ;
        reg_rw_en_td1 <= 1'b0 ;
        reg_rw_en_td2 <= 1'b0 ;
        reg_rw_en_td3 <= 1'b0 ;
        reg_rw_en_td4 <= 1'b0 ;
    end
    else
    begin
        reg_rw_en_td0 <= reg_rw_en;
        reg_rw_en_td1 <= reg_rw_en_td0;
        reg_rw_en_td2 <= reg_rw_en_td1;
        reg_rw_en_td3 <= reg_rw_en_td2;
        reg_rw_en_td4 <= reg_rw_en_td3;
    end
end




assign pos_reg_rw_en = ~reg_rw_en_td4 & reg_rw_en_td3;


reg [31:0] slv_bus2ip_data;

always @ (posedge lb_clk) begin
    if (~lb_reset_n)
        slv_bus2ip_data <=32'b0;
    else if (reg_rw_en )      //Every 4 byt_cnt cycle enable 8 bit LOCAL BUS DATA pack into SLAVE IP
        slv_bus2ip_data <= {reg_byte2,reg_byte3,reg_byte4,reg_byte5};
end


//---------------------------------------------------------------------------------
//  Register address counter
//---------------------------------------------------------------------------------
parameter DATA_WID    = 32;
parameter MCU_REG_NUM = 16;
parameter ADDR_WID    = 7;


reg  [7:0] slv_addr;

always @ (posedge lb_clk) begin
    if (~lb_reset_n)
        slv_addr <= 8'b0;
    else if (en_data_parity)
        slv_addr <= reg_byte0 ;// TO MAKE SURE START ADDRESS INSIDE REG0~~~~63;
      else if ((reg_rw_en_td1&wr_en) | (data_transfer_done&rd_en)) 
        slv_addr <= slv_addr + 1;     // Every 4 byte_cnt cycle enable reg_rw  ---->  slv_addr = slv_addr + 1 ;

   end

wire slv_addr_out_range;

assign slv_addr_out_range = (slv_addr > MCU_REG_NUM) ? 1'b1 : 1'b0;

reg [31:0] slv_mcu_din;

always @ (posedge lb_clk) begin
     if (~lb_reset_n)
      begin
        slv_mcu_din     <= 32'b0;
      end
     else if (switch_en)
      begin
        slv_mcu_din     <= 32'b0;
      end
     else if ( reg_rw_en_td0 )    slv_mcu_din <= slv_bus2ip_data;
end



wire  mcu_wr;

assign mcu_wr = pos_reg_rw_en & (~slv_addr_out_range) & slv_state[2];


reg [2:0] tx_done_cnt;

always @ (posedge lb_clk) begin
     if (~lb_reset_n)
      begin
        tx_done_cnt  <= 3'b0;
      end
     else if (switch_en)
      begin
        tx_done_cnt  <= 3'b0;
      end
     else if ( tx_done )    tx_done_cnt <= tx_done_cnt + 1'b1;
end

always @ (posedge lb_clk) begin
     if (~lb_reset_n)
      begin
        ubus_identify  <= 1'b0;
      end
     else if (rd_en)
      begin
        ubus_identify  <= 1'b1;
      end
     else if ( tx_done_cnt == 3'd5 )    ubus_identify <= 1'b0;
end









// ------------UART INSTANCE ---------------------------------------------------- 
wire[7:0] tx_byte;

//---add this logic to aviod rx wrong data trigger when system power up  
wire rx_done_tmp; 

assign  rx_done = (( slv_state == SLV_IDLE) && ((~rx_byte[1]) || (~rx_byte[0])))   ? 1'b0: rx_done_tmp ;
     

//---add this logic to aviod rx wrong data trigger when system power up  

uart_2dsp 
//#(
//	.BF_N(23),
//	.CLKFREQ(48000000),
//	.BAUDRATE(115200)
//)
u_uart_2dsp(
.clk(lb_clk),//8M
.rst_n(lb_reset_n),
 
.rx(rx),
.tx(tx),
 //test
.rx_negn(),
 
.rx_byte(rx_byte),  
.rx_done(rx_done_tmp),  
.tx_byte(tx_byte), 
.tx_valid(tx_valid[3] | (cmd_decyt_ci_td4  & rd_en )),
.tx_done(tx_done) 
);
//-------------------------------------------------------------------------------

always @(posedge lb_clk) begin
    if (~lb_reset_n)
     begin
        reg0    <= 32'h00000000;
        reg1    <= 32'h00002010;
        reg2    <= 32'h00000000;
        reg3    <= 32'haaaaf044;
        reg4    <= 32'h00000000;
        reg5    <= 32'h017a0204;
        reg6    <= 32'h017a01da;
        reg7    <= 32'h00000000;
        reg8    <= 32'h017a00c9;
        reg9    <= 32'h017a01da;
        reg10   <= 32'h00000000;
        reg11   <= 32'h000afa3f;
        reg12   <= 32'h00000355;
        reg13   <= 32'h00000000;
        reg14   <= 32'h00000000;
        reg15   <= 32'h00010002;

     end
    else if (mcu_wr)
     begin
      case (slv_addr)
        0   : reg0    <= slv_mcu_din; 
        1   : reg1    <= slv_mcu_din; 
        2   : reg2    <= slv_mcu_din; 
        3   : reg3    <= slv_mcu_din; 
        4   : reg4    <= slv_mcu_din; 
        5   : reg5    <= slv_mcu_din; 
        6   : reg6    <= slv_mcu_din; 
        7   : reg7    <= slv_mcu_din; 
        8   : reg8    <= slv_mcu_din; 
        9   : reg9    <= slv_mcu_din; 
        10  : reg10   <= slv_mcu_din; 
        11  : reg11   <= slv_mcu_din; 
        12  : reg12   <= slv_mcu_din; 
        13  : reg13   <= slv_mcu_din; 
        14  : reg14   <= slv_mcu_din; 
        15  : reg15   <= slv_mcu_din; 
      endcase    
     end
          
 end




always @ (posedge lb_clk) begin
     if (~lb_reset_n)
           slv_ip2_bus <= 32'b0;
	 else
	   if  (slv_addr_out_range)
           slv_ip2_bus <= 32'b0;
	   else 
         begin
          case (slv_addr)
		    0   :  slv_ip2_bus <=  nd2reg_0         ;
		    1   :  slv_ip2_bus <=  nd2reg_1         ;
		    2   :  slv_ip2_bus <=  nd2reg_2         ;
		    3   :  slv_ip2_bus <=  nd2reg_3    		;
		    4   :  slv_ip2_bus <=  nd2reg_4		    ;//reg4
		    5   :  slv_ip2_bus <=  nd2reg_5         ;
		    6   :  slv_ip2_bus <=  nd2reg_6     ;
		    7   :  slv_ip2_bus <=  nd2reg_7         ;
		    8   :  slv_ip2_bus <=  reg8         ;
		    9   :  slv_ip2_bus <=  reg9         ;
		    10  :  slv_ip2_bus <=  reg10        ;
		    11  :  slv_ip2_bus <=  reg11        ;
		    12  :  slv_ip2_bus <=  reg12        ;
		    13  :  slv_ip2_bus <=  reg13        ;
		    14  :  slv_ip2_bus <=  reg14        ;
		    15  :  slv_ip2_bus <=  reg15        ;
            
            
           endcase
          end
end

   //------------------------ READ OUPUT -------------------------------------------------
   reg [7:0] slv_data;//synthesis keep 



always @( posedge lb_clk) begin
	 if (~lb_reset_n)
         slv_data <= 32'b0;
     else if (cmd_decyt_ci_td3  & rd_en)
         slv_data <= encypt_crc4;
     else if (rd_en)
        case(byte_cnt)
          3'b100: slv_data <= slv_ip2_bus[31:24]; 
          3'b101: slv_data <= slv_ip2_bus[23:16];
          3'b110: slv_data <= slv_ip2_bus[15:8];
          3'b111: slv_data <= slv_ip2_bus[7:0];
        endcase
      else        slv_data <= 8'h00;
   end


 assign  tx_byte = slv_data;



   always @ (*) begin

      reg2nd_0        = reg0  ;
      reg2nd_1        = reg1  ;
      reg2nd_2        = reg2  ;
      reg2nd_3        = reg3  ;
      reg2nd_4        = reg4  ;
      reg2nd_5        = reg5  ;
      reg2nd_6        = reg6  ;
      reg2nd_7        = reg7  ;
      reg2nd_8        = reg8  ;
      reg2nd_9        = reg9  ;
      reg2nd_10       = reg10 ;
      reg2nd_11       = reg11 ;
      reg2nd_12       = reg12 ;
      reg2nd_13       = reg13 ;
      reg2nd_14       = reg14 ;
      reg2nd_15       = reg15 ;

   end



endmodule
