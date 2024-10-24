#Makefile脚本设计
#-------------------------------------------------------
#其中.PHONY可以指定对应哪些关键词进行make操作。
.PHONY: run_vcs clean
#这样 make run_vcs执行vcs语句，make sim执行simv语句，make dve打开波形文件，make clean清除一些冗余文件。

#SIMV_NAME = BDMA_PRJ 
SGDMA_FILE = sgdma128_src.f
LIBRARY_FILE = ph1a400_lib.f
TOP_MOD = tb_sgdma_fsim
CASE_NUM = CASE41
TEST_MODE = DEBUG_MODE
FSDB_SWITCH = FSDB_ON
ALL_DEFINE = +define+RTL_SIM+$(CASE_NUM)+$(FSDB_SWITCH)+$(TEST_MODE) 
ALL_INCDIR = +incdir+../def/ \
			 +incdir+../../src/sgdma_ip/def 
			 
DIR_CASE_NUM = $(shell echo $(CASE_NUM)|tr A-Z a-z)		

VCS_PATH = $(VERDI_HOME)/share/PLI/VCS/linux64/novas.tab \
            $(VERDI_HOME)/share/PLI/VCS/linux64/pli.a

VCS = vcs \
	-full64 \
	+v2k \
	-sverilog \
	-lca \
	+vc \
	-debug_all \
	-notice \
	-Mupdate \
	-error=noZMMCM \
	+notimingcheck \
	-kdb \
	+nospecy \
	+LDFLAGS \
	-timescale=1ns/1ns \
	-f $(LIBRARY_FILE) \
	-f $(SGDMA_FILE) \
	-top $(TOP_MOD) \
	$(ALL_INCDIR) \
	$(ALL_DEFINE) \
	-P $(VCS_PATH) \
	-o simv \
   	-l vcs_com.log 
#    -o $(SIMV_NAME) 

all:run_mkdir run_vcs run_compare   

run_mkdir:
	if [ ! -d "$(DIR_CASE_NUM)" ]; then mkdir "$(DIR_CASE_NUM)"; fi;       
	              
run_vcs: 
	$(VCS) \
	+define+SIM_FSDB \
	-R \
	+fsdb \
	+autoflush \
	-l vcs_sim.log 

run_verdi:
	verdi -ssf ./$(CASE_NUM)/tb_sgdma_fsim.fsdb -sswr ./$(CASE)/signal.rc \
	-nologo	-l verdi.log &
run_compare:
	chmod +x ./compare_output_result.do 
	./compare_output_result.do $(CASE_NUM) 


clean:
	@rm -rf csrc DVEfiles simv simv.daidir ucli.key novas* VCS* *dat
   
#Please fix above issue and compile again.


