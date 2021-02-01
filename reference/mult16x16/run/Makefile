test := default
seed := 111
LOG_DIR := ../log
SRC_DIR := ../src
WAVE_DIR := ../wave
INC_DIR := +incdir+../src+$(DC_HOME)/dw/sim_ver
PLI_PATH := /eda/synopsys/verdi_old/share/PLI/VCS/LINUX64
PLI_PARAM = -P $(PLI_PATH)/verdi.tab $(PLI_PATH)/pli.a

SRC_LST := $(SRC_DIR)/src.lst

COMP_OPT := -sverilog \
			+v2k \
			-full64 \
			-timescale=1ns/1ps \
			-debug_all \
			+notimingchecks \
			+nospecify \
			+lint=TFIPC-L \

RUN_OPT := +UVM_NO_RELNOTES \
		   +UVM_TESTNAME=$(test) \
		   +ntb_random_seed=$(seed) \
		   -l $(LOG_DIR)/$(test)_$(seed).log

comp: 
	vcs $(COMP_OPT) $(PLI_PARAM) $(INC_DIR) -l $(LOG_DIR)/comp.log -f $(SRC_LST)

run: comp
	./simv $(RUN_OPT)

run_gui: comp
	./simv $(RUN_OPT) -gui -full64

verdi:
	verdi -sverilog +v2k +define+$(intdef)+$(casedef) $(INC_DIR) -f $(SRC_LST) $(LIB)

clean:
	rm -rf image.bin csrc simv* vc_hdrs.h ucli.key urg* DVEfiles inter.vpd novas* verdiLog .inter.vpd.uvm

clean_all: clean
	rm -rf ../log/* ../wave/*
