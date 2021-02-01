/*****************************************************
*  
*  Filename    : counter_5to3.v
*  Author      : lucky_yuhua@aliyun.com
*  Create Date : 2020-03-10
*  Last Modify : 2020-03-10
*  Purpose     :
*
*****************************************************/
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


