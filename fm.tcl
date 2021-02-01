set synopsys_auto_setup true

#set_svf ./default.svf

set TOP mult64x64_top
set hdlin_dwroot /tools/snps/syn201806

read_db ./db/smic13_ss.db
#read_db /tools/snps/syn201806/libraries/syn/dw_foundation.sldb
#read_db /tools/snps/syn201806/libraries/syn/standard.sldb

read_verilog -container r -libname WORK ./src/counter_5to3.v
read_verilog -container r -libname WORK ./src/full_adder.v
read_verilog -container r -libname WORK ./src/half_adder.v
read_verilog -container r -libname WORK ./src/booth_r4_64x64.v
read_verilog -container r -libname WORK ./src/wtree_4to2_64x64.v
read_verilog -container r -libname WORK ./src/mult64x64_top.v
set_top r:/WORK/${TOP}

read_verilog -container r -libname WORK ./src/counter_5to3.v
read_verilog -container r -libname WORK ./src/full_adder.v
read_verilog -container r -libname WORK ./src/half_adder.v
read_verilog -container r -libname WORK ./src/booth_r4_64x64.v
read_verilog -container r -libname WORK ./src/wtree_4to2_64x64.v
read_verilog -container r -libname WORK ./src/mult64x64_top.v
read_verilog -container i -libname WORK ./results/mult_netlist.v
set_top i:/WORK/${TOP}

match
report_unmatched_points > ./results/report_unmatched_points.rpt
report_matched_points > ./results/report_matched_points.rpt

verify
#verify r:/WORK/${TOP} i:/WORK/${TOP}
report_failing > ./results/report_failing.rpt
report_passing > ./results/report_passing.rpt

sh date

# 启动FM
# fm_shell -f ./fm.tcl | tee ./fm.log
