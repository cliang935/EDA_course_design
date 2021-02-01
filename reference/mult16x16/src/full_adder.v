/*****************************************************
*  
*  Filename    : full_adder.v
*  Author      : lucky_yuhua@aliyun.com
*  Create Date : 2019-08-01
*  Last Modify : 2019-08-01
*  Purpose     :
*
*****************************************************/

`timescale 1ns/1ps

module full_adder(input   wire a,
                  input   wire b,
		  input   wire ci,
		  output  wire s,
		  output  wire co);

  assign s  = a ^ b ^ ci;
  assign co = (a & b) | (a & ci) | (b & ci);
endmodule


