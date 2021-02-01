quit -sim
vlog {./src/*.v}
vsim -gui -novopt work.testbench
add wave -color yellow sim:/testbench/clk
add wave sim:/testbench/rstn
add wave sim:/testbench/tc
add wave sim:/testbench/oper_a
add wave sim:/testbench/oper_b
add wave sim:/testbench/product
add wave sim:/testbench/product_ref
add wave sim:/testbench/cnt
run -all