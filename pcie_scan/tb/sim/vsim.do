vlib work
vmap work
 vlog -work work  -sv -f sim.f -suppress GroupWarning +define+RTL_SIM  +define+CASE1 +define+GEN0 +define+FSDB_OFF +define+SIM_MODE -l vlog.log 
 vsim -64 -batch -voptargs=+acc +notimingchecks -t 1ps -pli /exportEDA/SYNOPSYS/verdi/Verdi_O-2018.09-SP2/share/PLI/MODELSIM/linux64/novas_fli.so -L /users/bswang/sgdma_subsys/al_libs_25044 -L work work.tb_sgdma_fsim -l vsim.log -do vsim_run.do 
