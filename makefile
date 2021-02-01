dc:
	dc_shell -f ./dc.tcl | tee ./dc.log

fm:
	fm_shell -f ./fm.tcl | tee ./fm.log

vcs:
	vcs ./db/*.v ./tb/*.v ./results/*.v -top testbench -debug_all -l run.log +v2k -negdelay +neg_tchk +maxdelays

clean:
	rm -rf csrc simv.* simv *.key *.vpd *.log *.svf *.txt
	rm -rf ../DVEfiles ../synopsys_cache_O-2018.06-SP1
	rm -rf DVEfiles
