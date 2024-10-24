create_clock [get_ports app_auxclk]  -period 10  -waveform {0 5} -name aux_clk
create_clock -name core_clk -period 8 -waveform {0 1} [get_pins {u_sgdma_subsys/u_ep_core/uep_PH1_PHY_PCIE.core_clk}]
create_generated_clock  -name pll_out_clk -source [get_pins {u_sgdma_subsys/u_ep_core/uep_PH1_PHY_PCIE.core_clk}] -master_clock core_clk -divide_by 1 [get_pins {u_sgdma_subsys/u_sys_ctrl/u_sys_pll/pll_inst.clkc[1]}]

set_false_path  -from [get_clocks {aux_clk}] -to [get_clocks {pll_out_clk}]
set_false_path  -from [get_clocks {pll_out_clk}] -to [get_clocks {aux_clk}]
set_clock_latency -clock [get_clocks pll_out_clk] -max -source -0.11
set_clock_latency -clock [get_clocks pll_out_clk] -min -source -0.03
#set_multicycle_path -setup -from [get_clocks pll_out_clk] -to [get_clocks {core_clk}] 2