remove_design -designs
##########################
#set library             #
##########################
set search_path [list ./db]
set target_library  { smic13_ss.db }
set link_library    { *  smic13_ss.db }
#set symbol_library {smic13_ss.sdb}

##########################
#void warning Info       #
##########################
suppress_message  VER-130
suppress_message  VER-129
suppress_message  VER-318
suppress_message  ELAB-311
suppress_message  VER-936

################################
#read&amp;link&amp;Check design#
################################
read_file -format verilog {./src/counter_5to3.v}
read_file -format verilog {./src/full_adder.v}
read_file -format verilog {./src/half_adder.v}
read_file -format verilog {./src/booth_r4_64x64.v}
read_file -format verilog {./src/wtree_4to2_64x64.v}
read_file -format verilog {./src/mult64x64_top.v}

#analyze –format verilog ~/example1.v
#elaborate EXAMPLE1

current_design mult64x64_top  
uniquify
check_design

#############################
#   define IO port name     #
#############################
set clk [get_ports i_clk]  
set rst_n [get_ports i_rstn]

set general_inputs [list i_multa_ns, i_multb_ns, i_multa, i_multb]
set outputs [get_ports o_product]

#############################
#    set_constraints        #
#############################
#1 set constraints for clock signals
create_clock -n clock $clk -period 20 -waveform {0 10} 
set_dont_touch_network [get_clocks clock]  
set_drive 0 $clk  
set_ideal_network [get_ports clk]
#2 set constraints for reset signals
set_dont_touch_network $rst_n
set_drive 0 $rst_n
set_ideal_network [get_ports rst_n]

#2 set input delay
set_input_delay -clock clock 8 $general_inputs
#7 set output delay
set_output_delay -clock clock 8 $outputs
#5 set design rule constraints
set_max_fanout 4 $general_inputs
set_max_transition 0.6 [get_designs "mult64x64_top"]
#6 set area constraint
set_max_area 0 

#############################
#   compile_design          #
#############################
compile -map_effort medium
##########################
# write *.db and *.v     #
##########################
write -f ddc -hier -output ./results/mult.ddc 
write -f verilog -hier -output ./results/mult_netlist.v 
write_sdc -version 2.1 ./results/mult.sdc
write_sdf -version 2.1 ./results/mult.sdf  

##########################
# generate reports       #
##########################
#1
report_area > ./results/mult.area_rpt 
#2
report_constraint -all_violators > ./results/mult.constraint_rpt
#3
report_timing > ./results/mult.timing_rpt

# 启动DC
# dc_shell -f ./mima.tcl | tee ./mima.log

