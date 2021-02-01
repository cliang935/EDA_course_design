`timescale 1ns/10ps

module counter_5to3 (
  input   wire  i0,
  input   wire  i1, 
  input   wire  i2,
  input   wire  i3,
  input   wire  ci,
  output  wire  s,
  output  wire  c,
  output  wire  co
);

  wire s_temp = i0^i1^i2^i3;
  assign s  = ci^s_temp;
  assign co = (i0|i1) & (i2|i3);
  assign c  = (ci&s_temp) | ~(s_temp | ~((i0&i1) | (i2&i3)));
endmodule


