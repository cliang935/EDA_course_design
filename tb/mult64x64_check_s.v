`timescale 1ns/10ps

module mult64x64_check_s(clk, rstn, a, b, p);
input         clk, rstn;
input  signed [63:0] a, b;
output signed [127:0] p;

wire [127:0] p_w;
assign p_w = a * b;

reg [127:0] p;
always@(posedge clk or negedge rstn)
	if(!rstn) p <= 0;
	else      p <= p_w;

endmodule