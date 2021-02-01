/*****************************************************
*  
*  Filename    : half_adder.v
*  Author      : lucky_yuhua@aliyun.com
*  Create Date : 2019-08-01
*  Last Modify : 2019-08-01
*  Purpose     :
*
*****************************************************/

`timescale 1ns/1ps

module half_adder(input   wire a,
                  input   wire b,
		  output  wire s,
		  output  wire co);

  assign s  = a ^ b;
  assign co = a & b;
endmodule


