`timescale 1ns/10ps
`define clk_period 20

module testbench;
parameter OPWIDTH = 64;

reg clk;
reg rstn;
reg [OPWIDTH-1:0]     oper_a;
reg [OPWIDTH-1:0]     oper_b;
reg                   tc;

wire [2*OPWIDTH-1:0] product;
wire [2*OPWIDTH-1:0] product_ref;

initial begin
	$sdf_annotate("./results/mult.sdf", mult64x64_top_u0);
end

initial begin
	$vcdplusfile("mult.vpd");
	$vcdpluson();
end

initial clk  = 1'b1;
always #(`clk_period/2) clk = ~clk;
    
initial begin
	rstn = 0;
	oper_a = 0;
	oper_b = 0;
	#(`clk_period*10);
	rstn = 1;
	repeat(100)begin
		oper_a = $random();
		oper_b = $random();
		#(`clk_period*10);
	end
	$finish;
end

// ======================= unsigned test =====================================
mult64x64_check_us mult64x64_check_us_u0(.a(oper_a), .b(oper_b), .p(product_ref));
initial tc = 1'b0;


/*/ ======================= signed test =====================================
mult64x64_check_s mult64x64_check_s_u0(.clk(clk), .rstn(rstn), .a(oper_a), .b(oper_b), .p(product_ref));
initial tc = 1'b1;*/

// rtl simulation -> outcome delay 5 clk
// Gate level simulation -> set outcome delay at 8 clk

reg [7:0] cnt;
reg [7:0] jishu;
initial begin
	cnt = 0;
	jishu = 0;
	repeat(100)begin
		jishu = jishu + 1;
		@(product);
		#(`clk_period);
		if(product == product_ref) cnt = cnt; else cnt = cnt + 1;
	end
end

mult64x64_top mult64x64_top_u0(
    .o_product (product),
    .i_multa_ns(tc     ),
    .i_multb_ns(tc     ),
    .i_multa   (oper_a ),
    .i_multb   (oper_b ),
    .i_rstn    (rstn   ),
    .i_clk     (clk    )
    );
	 
endmodule

