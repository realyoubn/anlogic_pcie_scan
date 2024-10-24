quit -sim

if [file exists work] { 
	file delete -force work 
	} 

if {![file exists work]} { 
	vlib work 
	}
	
vlog -sv +define+RTL_SIM +define+GEN2 +define+CASE41 +define+DEBUG_MODE \
	 -work work  -sv -f ../sim/sgdma128_src.f -suppress GroupWarning	

   

vsim  -voptargs="+acc" -nowlfopt -t 1ps -L /users/dxguo/Cmplib/TD_5_6_35557_0803/work tb_sgdma_fsim -l log.txt

# 0View the simulation results 
view structure 
view signals 
view wave
do ./wave.do

#run 800us
run -all
chmod +x ./compare_output_result.do
./compare_output_result.do CASE41

