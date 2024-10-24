
module swith( 
input APB_M_0_clk,
input rst_sof_n,
input user_clk,
input user_resetn,
input [7:0]dout,
input frontwr,
input tlast,
input [31:0]m_axil_wdata,
input si,
input c2h0r_run,
input s0_axis_c2h_rst,
output reg [127:0]pcie_data,
output reg pcie_valid,
output reg pcie_start,
output reg pcie_stop,
output reg led0,
input led1A_r

);
parameter IDLE=3'b000,
          STARTWAIT=3'b001,
          START=3'b011,
          SIWAIT=3'b010,
          STOP=3'b110;
reg [2:0]state=IDLE;
reg datatem_en0;
reg datatem_en1;
reg datatem_en2;
reg data_en;

reg [3:0]data_cnt;
reg [127:0]datatem;
reg [127:0]data;
reg [3:0]state_cnt; 
reg    stop;
reg    start;

always@(posedge user_clk,negedge user_resetn)
begin 
	if(!user_resetn) begin
		state <= IDLE;
        // state_cnt <= 4'b0;
         pcie_start <= 1'b0;
         pcie_stop <= 1'b0;
         led0<=1'b0;
        end
		else begin
		case(state)
			IDLE:begin
            	// pcie_start <= 1'b0;
        		// pcie_stop <= 1'b0;
				if(c2h0r_run) begin
				state <= STARTWAIT;
				end
			end
			STARTWAIT:begin
				if(led1A_r) begin
					state <= SIWAIT;
				end
			end
			SIWAIT:begin
				if(si) begin
					state <= START;
                    led0<=1'b1;
				end
			end
			START:begin
            	// pcie_start <= 1'b1;
				if(s0_axis_c2h_rst) begin
					// state <= STOPWAIT;
					state <= IDLE;
                    led0<=1'b0;
				end
			end
		endcase
		end
end

always@(posedge user_clk,negedge user_resetn)
begin 
	if(!user_resetn) begin
		start <= 1'b0;
        stop <= 1'b0;
        end
	else if(m_axil_wdata == 32'h1234abcd)begin
		start <= 1'b1;
		stop <= 1'b0;
		end
	else if(m_axil_wdata == 32'h11223344)begin
		stop <= 1'b1;
		start <= 1'b0;
		end
	else begin
		start <= 1'b0;
        stop <= 1'b0;
	end
end

always @(posedge APB_M_0_clk or negedge rst_sof_n) begin
    if(!rst_sof_n) begin
		data_en <= 1'b0;
        datatem <= 128'b0;
		data <= 128'b0;
		data_cnt <= 4'b0;
    end 
	else if(state == IDLE) begin
		data_en <= 1'b0;
        datatem <= 128'b0;
		data <= 128'b0;
		data_cnt <= 4'b0;
	end
	else if(state == START) begin
	if(frontwr)begin
	if(data_cnt == 4'hF) begin
		data_en <= 1'b1;
		data_cnt <= 4'b0;
		data <= {dout,datatem[127:8]};
	end
	else begin
		data_en <= 1'b0;
		data_cnt <= data_cnt + 1'b1;
		datatem <= {dout,datatem[127:8]};
	end
    end
	else begin
		data_en <= 1'b0;
	end
	end
    
	// else if(state == STOP) begin
	// 	case(data_cnt)
	// 	4'h0: begin
	// 		data_en <= 1'b0;
	// 	end
	// 	4'h1: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{120{1'b1}},datatem[127:120]};
	// 	end
	// 	4'h2: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{112{1'b1}},datatem[127:112]};
	// 	end
	// 	4'h3: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{104{1'b1}},datatem[127:104]};
	// 	end
	// 	4'h4: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{96{1'b1}},datatem[127:96]};
	// 	end
	// 	4'h5: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{88{1'b1}},datatem[127:88]};
	// 	end
	// 	4'h6: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{80{1'b1}},datatem[127:80]};
	// 	end
	// 	4'h7: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{72{1'b1}},datatem[127:72]};
	// 	end
	// 	4'h8: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{64{1'b1}},datatem[127:64]};
	// 	end
	// 	4'h9: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{56{1'b1}},datatem[127:56]};
	// 	end
	// 	4'hA: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{48{1'b1}},datatem[127:48]};
	// 	end
	// 	4'hB: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{40{1'b1}},datatem[127:40]};
	// 	end
	// 	4'hC: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{32{1'b1}},datatem[127:32]};
	// 	end
	// 	4'hD: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{24{1'b1}},datatem[127:24]};
	// 	end
	// 	4'hE: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{16{1'b1}},datatem[127:16]};
	// 	end
	// 	4'hF: begin
	// 		data_en <= 1'b1;
	// 		data_cnt <= 4'b0;
	// 		data <= {{8{1'b1}},datatem[127:8]};
	// 	end
	// 	endcase
	// end
	else begin
		data_en <= 1'b0;
	end
end
always @(posedge user_clk or negedge user_resetn) begin
    if(!user_resetn) begin
        datatem_en0 <= 1'b0;
		datatem_en1 <= 1'b0;
		datatem_en2 <= 1'b0;
    end
    else begin
        datatem_en0 <= data_en;
        datatem_en1 <= datatem_en0;
		datatem_en2 <= datatem_en1;
    end
end
wire pcie_en = datatem_en1 && (!datatem_en2);

always @(posedge user_clk or negedge user_resetn) begin
    if(!user_resetn) begin
        pcie_valid <= 1'b0;
        pcie_data <= 128'b0;
    end
    else if(pcie_en) begin
        pcie_valid <= 1'b1;
        pcie_data <= data;
    end
    else begin
        pcie_valid <= 1'b0;
        pcie_data <= 128'b0;
    end
end
endmodule
