`timescale 1ns/10ps

module mult64x64_check_us(a, b, p);

input [63:0] a, b;

output[127:0] p;

assign p = a * b;

endmodule