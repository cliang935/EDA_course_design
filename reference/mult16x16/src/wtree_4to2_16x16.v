/*****************************************************
*  
*  Filename    : wtree_4to2_16x16.v
*  Author      : lucky_yuhua@aliyun.com
*  Create Date : 2019-08-01
*  Last Modify : 2019-08-01
*  Purpose     : this module process 9 18bit partial product
*                Carry Save Adder
*                Wallace tree using 5-3 compressing mode
*****************************************************/

`timescale 1ns/1ps

`include "mult16_def.v"
module wtree_4to2_16x16(
  input    wire        clk    ,
  input    wire        rstn   ,
  input    wire [17:0] pp1    , 
  input    wire [17:0] pp2    , 
  input    wire [17:0] pp3    , 
  input    wire [17:0] pp4    , 
  input    wire [17:0] pp5    , 
  input    wire [17:0] pp6    , 
  input    wire [17:0] pp7    , 
  input    wire [17:0] pp8    , 
  input    wire [17:0] pp9    , 
  output   wire [31:0] final_p
);

wire [17:0] pp1_w;
wire [17:0] pp2_w;
wire [17:0] pp3_w;
wire [17:0] pp4_w;
wire [17:0] pp5_w;
wire [17:0] pp6_w;
wire [17:0] pp7_w;
wire [17:0] pp8_w;
wire [15:0] pp9_w; 
// ================ if necessary, pipeline pp1~pp9 here for timing ===============
`ifdef MULT16_PIPE_PPN
reg  [17:0] pp1_ff;
reg  [17:0] pp2_ff;
reg  [17:0] pp3_ff;
reg  [17:0] pp4_ff;
reg  [17:0] pp5_ff;
reg  [17:0] pp6_ff;
reg  [17:0] pp7_ff;
reg  [17:0] pp8_ff;
reg  [15:0] pp9_ff; 
always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    pp1_ff  <= 18'b0;
    pp2_ff  <= 18'b0;
    pp3_ff  <= 18'b0;
    pp4_ff  <= 18'b0;
    pp5_ff  <= 18'b0;
    pp6_ff  <= 18'b0;
    pp7_ff  <= 18'b0;
    pp8_ff  <= 18'b0;
    pp9_ff  <= 16'b0;
  end
  else begin
    pp1_ff  <= pp1      ;
    pp2_ff  <= pp2      ;
    pp3_ff  <= pp3      ;
    pp4_ff  <= pp4      ;
    pp5_ff  <= pp5      ;
    pp6_ff  <= pp6      ;
    pp7_ff  <= pp7      ;
    pp8_ff  <= pp8      ;
    pp9_ff  <= pp9[15:0];
  end
end
assign pp1_w  = pp1_ff ;
assign pp2_w  = pp2_ff ;
assign pp3_w  = pp3_ff ;
assign pp4_w  = pp4_ff ;
assign pp5_w  = pp5_ff ;
assign pp6_w  = pp6_ff ;
assign pp7_w  = pp7_ff ;
assign pp8_w  = pp8_ff ;
assign pp9_w  = pp9_ff ;
`else
assign pp1_w  = pp1      ;
assign pp2_w  = pp2      ;
assign pp3_w  = pp3      ;
assign pp4_w  = pp4      ;
assign pp5_w  = pp5      ;
assign pp6_w  = pp6      ;
assign pp7_w  = pp7      ;
assign pp8_w  = pp8      ;
assign pp9_w  = pp9[15:0];
`endif

// ================ first stage ================
wire [24:0] stg1_s1, stg1_c1, stg1_co1;
wire [23:0] stg1_s2, stg1_c2, stg1_co2;

counter_5to3 u_a11_0 (.i0(pp1_w[0 ]), .i1(1'b0     ), .i2(1'b0     ), .i3(1'b0     ), .ci(1'b0        ), .s(stg1_s1[0 ]), .c(stg1_c1[0 ]), .co(stg1_co1[0 ]));
counter_5to3 u_a11_1 (.i0(pp1_w[1 ]), .i1(1'b0     ), .i2(1'b0     ), .i3(1'b0     ), .ci(stg1_co1[0 ]), .s(stg1_s1[1 ]), .c(stg1_c1[1 ]), .co(stg1_co1[1 ]));
counter_5to3 u_a11_2 (.i0(pp1_w[2 ]), .i1(pp2_w[0 ]), .i2(1'b0     ), .i3(1'b0     ), .ci(stg1_co1[1 ]), .s(stg1_s1[2 ]), .c(stg1_c1[2 ]), .co(stg1_co1[2 ]));
counter_5to3 u_a11_3 (.i0(pp1_w[3 ]), .i1(pp2_w[1 ]), .i2(1'b0     ), .i3(1'b0     ), .ci(stg1_co1[2 ]), .s(stg1_s1[3 ]), .c(stg1_c1[3 ]), .co(stg1_co1[3 ]));
counter_5to3 u_a11_4 (.i0(pp1_w[4 ]), .i1(pp2_w[2 ]), .i2(pp3_w[0 ]), .i3(1'b0     ), .ci(stg1_co1[3 ]), .s(stg1_s1[4 ]), .c(stg1_c1[4 ]), .co(stg1_co1[4 ]));
counter_5to3 u_a11_5 (.i0(pp1_w[5 ]), .i1(pp2_w[3 ]), .i2(pp3_w[1 ]), .i3(1'b0     ), .ci(stg1_co1[4 ]), .s(stg1_s1[5 ]), .c(stg1_c1[5 ]), .co(stg1_co1[5 ]));
counter_5to3 u_a11_6 (.i0(pp1_w[6 ]), .i1(pp2_w[4 ]), .i2(pp3_w[2 ]), .i3(pp4_w[0 ]), .ci(stg1_co1[5 ]), .s(stg1_s1[6 ]), .c(stg1_c1[6 ]), .co(stg1_co1[6 ]));
counter_5to3 u_a11_7 (.i0(pp1_w[7 ]), .i1(pp2_w[5 ]), .i2(pp3_w[3 ]), .i3(pp4_w[1 ]), .ci(stg1_co1[6 ]), .s(stg1_s1[7 ]), .c(stg1_c1[7 ]), .co(stg1_co1[7 ]));
counter_5to3 u_a11_8 (.i0(pp1_w[8 ]), .i1(pp2_w[6 ]), .i2(pp3_w[4 ]), .i3(pp4_w[2 ]), .ci(stg1_co1[7 ]), .s(stg1_s1[8 ]), .c(stg1_c1[8 ]), .co(stg1_co1[8 ]));
counter_5to3 u_a11_9 (.i0(pp1_w[9 ]), .i1(pp2_w[7 ]), .i2(pp3_w[5 ]), .i3(pp4_w[3 ]), .ci(stg1_co1[8 ]), .s(stg1_s1[9 ]), .c(stg1_c1[9 ]), .co(stg1_co1[9 ]));
counter_5to3 u_a11_10(.i0(pp1_w[10]), .i1(pp2_w[8 ]), .i2(pp3_w[6 ]), .i3(pp4_w[4 ]), .ci(stg1_co1[9 ]), .s(stg1_s1[10]), .c(stg1_c1[10]), .co(stg1_co1[10]));
counter_5to3 u_a11_11(.i0(pp1_w[11]), .i1(pp2_w[9 ]), .i2(pp3_w[7 ]), .i3(pp4_w[5 ]), .ci(stg1_co1[10]), .s(stg1_s1[11]), .c(stg1_c1[11]), .co(stg1_co1[11]));
counter_5to3 u_a11_12(.i0(pp1_w[12]), .i1(pp2_w[10]), .i2(pp3_w[8 ]), .i3(pp4_w[6 ]), .ci(stg1_co1[11]), .s(stg1_s1[12]), .c(stg1_c1[12]), .co(stg1_co1[12]));
counter_5to3 u_a11_13(.i0(pp1_w[13]), .i1(pp2_w[11]), .i2(pp3_w[9 ]), .i3(pp4_w[7 ]), .ci(stg1_co1[12]), .s(stg1_s1[13]), .c(stg1_c1[13]), .co(stg1_co1[13]));
counter_5to3 u_a11_14(.i0(pp1_w[14]), .i1(pp2_w[12]), .i2(pp3_w[10]), .i3(pp4_w[8 ]), .ci(stg1_co1[13]), .s(stg1_s1[14]), .c(stg1_c1[14]), .co(stg1_co1[14]));
counter_5to3 u_a11_15(.i0(pp1_w[15]), .i1(pp2_w[13]), .i2(pp3_w[11]), .i3(pp4_w[9 ]), .ci(stg1_co1[14]), .s(stg1_s1[15]), .c(stg1_c1[15]), .co(stg1_co1[15]));
counter_5to3 u_a11_16(.i0(pp1_w[16]), .i1(pp2_w[14]), .i2(pp3_w[12]), .i3(pp4_w[10]), .ci(stg1_co1[15]), .s(stg1_s1[16]), .c(stg1_c1[16]), .co(stg1_co1[16]));
counter_5to3 u_a11_17(.i0(pp1_w[17]), .i1(pp2_w[15]), .i2(pp3_w[13]), .i3(pp4_w[11]), .ci(stg1_co1[16]), .s(stg1_s1[17]), .c(stg1_c1[17]), .co(stg1_co1[17]));
counter_5to3 u_a11_18(.i0(pp1_w[17]), .i1(pp2_w[16]), .i2(pp3_w[14]), .i3(pp4_w[12]), .ci(stg1_co1[17]), .s(stg1_s1[18]), .c(stg1_c1[18]), .co(stg1_co1[18]));
counter_5to3 u_a11_19(.i0(pp1_w[17]), .i1(pp2_w[17]), .i2(pp3_w[15]), .i3(pp4_w[13]), .ci(stg1_co1[18]), .s(stg1_s1[19]), .c(stg1_c1[19]), .co(stg1_co1[19]));
counter_5to3 u_a11_20(.i0(pp1_w[17]), .i1(pp2_w[17]), .i2(pp3_w[16]), .i3(pp4_w[14]), .ci(stg1_co1[19]), .s(stg1_s1[20]), .c(stg1_c1[20]), .co(stg1_co1[20]));
counter_5to3 u_a11_21(.i0(pp1_w[17]), .i1(pp2_w[17]), .i2(pp3_w[17]), .i3(pp4_w[15]), .ci(stg1_co1[20]), .s(stg1_s1[21]), .c(stg1_c1[21]), .co(stg1_co1[21]));
counter_5to3 u_a11_22(.i0(pp1_w[17]), .i1(pp2_w[17]), .i2(pp3_w[17]), .i3(pp4_w[16]), .ci(stg1_co1[21]), .s(stg1_s1[22]), .c(stg1_c1[22]), .co(stg1_co1[22]));
counter_5to3 u_a11_23(.i0(pp1_w[17]), .i1(pp2_w[17]), .i2(pp3_w[17]), .i3(pp4_w[17]), .ci(stg1_co1[22]), .s(stg1_s1[23]), .c(stg1_c1[23]), .co(stg1_co1[23]));
counter_5to3 u_a11_24(.i0(pp1_w[17]), .i1(pp2_w[17]), .i2(pp3_w[17]), .i3(pp4_w[17]), .ci(stg1_co1[23]), .s(stg1_s1[24]), .c(stg1_c1[24]), .co(stg1_co1[24]));

counter_5to3 u_a12_0 (.i0(pp5_w[0 ]), .i1(1'b0     ), .i2(1'b0     ), .i3(1'b0     ), .ci(1'b0        ), .s(stg1_s2[0 ]), .c(stg1_c2[0 ]), .co(stg1_co2[0 ]));
counter_5to3 u_a12_1 (.i0(pp5_w[1 ]), .i1(1'b0     ), .i2(1'b0     ), .i3(1'b0     ), .ci(stg1_co2[0 ]), .s(stg1_s2[1 ]), .c(stg1_c2[1 ]), .co(stg1_co2[1 ]));
counter_5to3 u_a12_2 (.i0(pp5_w[2 ]), .i1(pp6_w[0 ]), .i2(1'b0     ), .i3(1'b0     ), .ci(stg1_co2[1 ]), .s(stg1_s2[2 ]), .c(stg1_c2[2 ]), .co(stg1_co2[2 ]));
counter_5to3 u_a12_3 (.i0(pp5_w[3 ]), .i1(pp6_w[1 ]), .i2(1'b0     ), .i3(1'b0     ), .ci(stg1_co2[2 ]), .s(stg1_s2[3 ]), .c(stg1_c2[3 ]), .co(stg1_co2[3 ]));
counter_5to3 u_a12_4 (.i0(pp5_w[4 ]), .i1(pp6_w[2 ]), .i2(pp7_w[0 ]), .i3(1'b0     ), .ci(stg1_co2[3 ]), .s(stg1_s2[4 ]), .c(stg1_c2[4 ]), .co(stg1_co2[4 ]));
counter_5to3 u_a12_5 (.i0(pp5_w[5 ]), .i1(pp6_w[3 ]), .i2(pp7_w[1 ]), .i3(1'b0     ), .ci(stg1_co2[4 ]), .s(stg1_s2[5 ]), .c(stg1_c2[5 ]), .co(stg1_co2[5 ]));
counter_5to3 u_a12_6 (.i0(pp5_w[6 ]), .i1(pp6_w[4 ]), .i2(pp7_w[2 ]), .i3(pp8_w[0 ]), .ci(stg1_co2[5 ]), .s(stg1_s2[6 ]), .c(stg1_c2[6 ]), .co(stg1_co2[6 ]));
counter_5to3 u_a12_7 (.i0(pp5_w[7 ]), .i1(pp6_w[5 ]), .i2(pp7_w[3 ]), .i3(pp8_w[1 ]), .ci(stg1_co2[6 ]), .s(stg1_s2[7 ]), .c(stg1_c2[7 ]), .co(stg1_co2[7 ]));
counter_5to3 u_a12_8 (.i0(pp5_w[8 ]), .i1(pp6_w[6 ]), .i2(pp7_w[4 ]), .i3(pp8_w[2 ]), .ci(stg1_co2[7 ]), .s(stg1_s2[8 ]), .c(stg1_c2[8 ]), .co(stg1_co2[8 ]));
counter_5to3 u_a12_9 (.i0(pp5_w[9 ]), .i1(pp6_w[7 ]), .i2(pp7_w[5 ]), .i3(pp8_w[3 ]), .ci(stg1_co2[8 ]), .s(stg1_s2[9 ]), .c(stg1_c2[9 ]), .co(stg1_co2[9 ]));
counter_5to3 u_a12_10(.i0(pp5_w[10]), .i1(pp6_w[8 ]), .i2(pp7_w[6 ]), .i3(pp8_w[4 ]), .ci(stg1_co2[9 ]), .s(stg1_s2[10]), .c(stg1_c2[10]), .co(stg1_co2[10]));
counter_5to3 u_a12_11(.i0(pp5_w[11]), .i1(pp6_w[9 ]), .i2(pp7_w[7 ]), .i3(pp8_w[5 ]), .ci(stg1_co2[10]), .s(stg1_s2[11]), .c(stg1_c2[11]), .co(stg1_co2[11]));
counter_5to3 u_a12_12(.i0(pp5_w[12]), .i1(pp6_w[10]), .i2(pp7_w[8 ]), .i3(pp8_w[6 ]), .ci(stg1_co2[11]), .s(stg1_s2[12]), .c(stg1_c2[12]), .co(stg1_co2[12]));
counter_5to3 u_a12_13(.i0(pp5_w[13]), .i1(pp6_w[11]), .i2(pp7_w[9 ]), .i3(pp8_w[7 ]), .ci(stg1_co2[12]), .s(stg1_s2[13]), .c(stg1_c2[13]), .co(stg1_co2[13]));
counter_5to3 u_a12_14(.i0(pp5_w[14]), .i1(pp6_w[12]), .i2(pp7_w[10]), .i3(pp8_w[8 ]), .ci(stg1_co2[13]), .s(stg1_s2[14]), .c(stg1_c2[14]), .co(stg1_co2[14]));
counter_5to3 u_a12_15(.i0(pp5_w[15]), .i1(pp6_w[13]), .i2(pp7_w[11]), .i3(pp8_w[9 ]), .ci(stg1_co2[14]), .s(stg1_s2[15]), .c(stg1_c2[15]), .co(stg1_co2[15]));
counter_5to3 u_a12_16(.i0(pp5_w[16]), .i1(pp6_w[14]), .i2(pp7_w[12]), .i3(pp8_w[10]), .ci(stg1_co2[15]), .s(stg1_s2[16]), .c(stg1_c2[16]), .co(stg1_co2[16]));
counter_5to3 u_a12_17(.i0(pp5_w[17]), .i1(pp6_w[15]), .i2(pp7_w[13]), .i3(pp8_w[11]), .ci(stg1_co2[16]), .s(stg1_s2[17]), .c(stg1_c2[17]), .co(stg1_co2[17]));
counter_5to3 u_a12_18(.i0(pp5_w[17]), .i1(pp6_w[16]), .i2(pp7_w[14]), .i3(pp8_w[12]), .ci(stg1_co2[17]), .s(stg1_s2[18]), .c(stg1_c2[18]), .co(stg1_co2[18]));
counter_5to3 u_a12_19(.i0(pp5_w[17]), .i1(pp6_w[17]), .i2(pp7_w[15]), .i3(pp8_w[13]), .ci(stg1_co2[18]), .s(stg1_s2[19]), .c(stg1_c2[19]), .co(stg1_co2[19]));
counter_5to3 u_a12_20(.i0(pp5_w[17]), .i1(pp6_w[17]), .i2(pp7_w[16]), .i3(pp8_w[14]), .ci(stg1_co2[19]), .s(stg1_s2[20]), .c(stg1_c2[20]), .co(stg1_co2[20]));
counter_5to3 u_a12_21(.i0(pp5_w[17]), .i1(pp6_w[17]), .i2(pp7_w[17]), .i3(pp8_w[15]), .ci(stg1_co2[20]), .s(stg1_s2[21]), .c(stg1_c2[21]), .co(stg1_co2[21]));
counter_5to3 u_a12_22(.i0(pp5_w[17]), .i1(pp6_w[17]), .i2(pp7_w[17]), .i3(pp8_w[16]), .ci(stg1_co2[21]), .s(stg1_s2[22]), .c(stg1_c2[22]), .co(stg1_co2[22]));
counter_5to3 u_a12_23(.i0(pp5_w[17]), .i1(pp6_w[17]), .i2(pp7_w[17]), .i3(pp8_w[17]), .ci(stg1_co2[22]), .s(stg1_s2[23]), .c(stg1_c2[23]), .co(stg1_co2[23]));

wire [24:0] stg1_s1_w, stg1_c1_w;
wire [23:0] stg1_s2_w, stg1_c2_w;
wire [15:0] pp9_w1;
//================ if necessary, pipeline stg1_s* and stg1_c* here for timing ================
`ifdef MULT16_PIPE_STG1
reg [24:0] stg1_s1_ff, stg1_c1_ff;
reg [23:0] stg1_s2_ff, stg1_c2_ff;
reg [15:0] pp9_ff1;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg1_s1_ff     <= 25'b0;
    stg1_c1_ff     <= 25'b0;
    stg1_s2_ff     <= 24'b0;
    stg1_c2_ff     <= 24'b0;
    pp9_ff1        <= 16'b0;
  end
  else begin
    stg1_s1_ff     <= stg1_s1;
    stg1_c1_ff     <= stg1_c1;
    stg1_s2_ff     <= stg1_s2;
    stg1_c2_ff     <= stg1_c2;
    pp9_ff1        <= pp9_w  ;
  end
end
assign stg1_s1_w   = stg1_s1_ff;
assign stg1_c1_w   = stg1_c1_ff;
assign stg1_s2_w   = stg1_s2_ff;
assign stg1_c2_w   = stg1_c2_ff;
assign pp9_w1      = pp9_ff1   ;
`else
assign stg1_s1_w   = stg1_s1;
assign stg1_c1_w   = stg1_c1;
assign stg1_s2_w   = stg1_s2;
assign stg1_c2_w   = stg1_c2;
assign pp9_w1      = pp9_w  ;
`endif

//================ second stage ================

wire [31:0] stg2_s1, stg2_c1, stg2_co1;

counter_5to3 u_a21_0 (.i0(stg1_s1_w[0 ]), .i1(1'b0         ), .i2(1'b0         ), .i3(1'b0         ), .ci(1'b0        ), .s(stg2_s1[0 ]), .c(stg2_c1[0 ]), .co(stg2_co1[0 ]));
counter_5to3 u_a21_1 (.i0(stg1_s1_w[1 ]), .i1(stg1_c1_w[0 ]), .i2(1'b0         ), .i3(1'b0         ), .ci(stg2_co1[0 ]), .s(stg2_s1[1 ]), .c(stg2_c1[1 ]), .co(stg2_co1[1 ]));
counter_5to3 u_a21_2 (.i0(stg1_s1_w[2 ]), .i1(stg1_c1_w[1 ]), .i2(1'b0         ), .i3(1'b0         ), .ci(stg2_co1[1 ]), .s(stg2_s1[2 ]), .c(stg2_c1[2 ]), .co(stg2_co1[2 ]));
counter_5to3 u_a21_3 (.i0(stg1_s1_w[3 ]), .i1(stg1_c1_w[2 ]), .i2(1'b0         ), .i3(1'b0         ), .ci(stg2_co1[2 ]), .s(stg2_s1[3 ]), .c(stg2_c1[3 ]), .co(stg2_co1[3 ]));
counter_5to3 u_a21_4 (.i0(stg1_s1_w[4 ]), .i1(stg1_c1_w[3 ]), .i2(1'b0         ), .i3(1'b0         ), .ci(stg2_co1[3 ]), .s(stg2_s1[4 ]), .c(stg2_c1[4 ]), .co(stg2_co1[4 ]));
counter_5to3 u_a21_5 (.i0(stg1_s1_w[5 ]), .i1(stg1_c1_w[4 ]), .i2(1'b0         ), .i3(1'b0         ), .ci(stg2_co1[4 ]), .s(stg2_s1[5 ]), .c(stg2_c1[5 ]), .co(stg2_co1[5 ]));
counter_5to3 u_a21_6 (.i0(stg1_s1_w[6 ]), .i1(stg1_c1_w[5 ]), .i2(1'b0         ), .i3(1'b0         ), .ci(stg2_co1[5 ]), .s(stg2_s1[6 ]), .c(stg2_c1[6 ]), .co(stg2_co1[6 ]));
counter_5to3 u_a21_7 (.i0(stg1_s1_w[7 ]), .i1(stg1_c1_w[6 ]), .i2(1'b0         ), .i3(1'b0         ), .ci(stg2_co1[6 ]), .s(stg2_s1[7 ]), .c(stg2_c1[7 ]), .co(stg2_co1[7 ]));
counter_5to3 u_a21_8 (.i0(stg1_s1_w[8 ]), .i1(stg1_c1_w[7 ]), .i2(stg1_s2_w[0 ]), .i3(1'b0         ), .ci(stg2_co1[7 ]), .s(stg2_s1[8 ]), .c(stg2_c1[8 ]), .co(stg2_co1[8 ]));
counter_5to3 u_a21_9 (.i0(stg1_s1_w[9 ]), .i1(stg1_c1_w[8 ]), .i2(stg1_s2_w[1 ]), .i3(stg1_c2_w[0 ]), .ci(stg2_co1[8 ]), .s(stg2_s1[9 ]), .c(stg2_c1[9 ]), .co(stg2_co1[9 ]));
counter_5to3 u_a21_10(.i0(stg1_s1_w[10]), .i1(stg1_c1_w[9 ]), .i2(stg1_s2_w[2 ]), .i3(stg1_c2_w[1 ]), .ci(stg2_co1[9 ]), .s(stg2_s1[10]), .c(stg2_c1[10]), .co(stg2_co1[10]));
counter_5to3 u_a21_11(.i0(stg1_s1_w[11]), .i1(stg1_c1_w[10]), .i2(stg1_s2_w[3 ]), .i3(stg1_c2_w[2 ]), .ci(stg2_co1[10]), .s(stg2_s1[11]), .c(stg2_c1[11]), .co(stg2_co1[11]));
counter_5to3 u_a21_12(.i0(stg1_s1_w[12]), .i1(stg1_c1_w[11]), .i2(stg1_s2_w[4 ]), .i3(stg1_c2_w[3 ]), .ci(stg2_co1[11]), .s(stg2_s1[12]), .c(stg2_c1[12]), .co(stg2_co1[12]));
counter_5to3 u_a21_13(.i0(stg1_s1_w[13]), .i1(stg1_c1_w[12]), .i2(stg1_s2_w[5 ]), .i3(stg1_c2_w[4 ]), .ci(stg2_co1[12]), .s(stg2_s1[13]), .c(stg2_c1[13]), .co(stg2_co1[13]));
counter_5to3 u_a21_14(.i0(stg1_s1_w[14]), .i1(stg1_c1_w[13]), .i2(stg1_s2_w[6 ]), .i3(stg1_c2_w[5 ]), .ci(stg2_co1[13]), .s(stg2_s1[14]), .c(stg2_c1[14]), .co(stg2_co1[14]));
counter_5to3 u_a21_15(.i0(stg1_s1_w[15]), .i1(stg1_c1_w[14]), .i2(stg1_s2_w[7 ]), .i3(stg1_c2_w[6 ]), .ci(stg2_co1[14]), .s(stg2_s1[15]), .c(stg2_c1[15]), .co(stg2_co1[15]));
counter_5to3 u_a21_16(.i0(stg1_s1_w[16]), .i1(stg1_c1_w[15]), .i2(stg1_s2_w[8 ]), .i3(stg1_c2_w[7 ]), .ci(stg2_co1[15]), .s(stg2_s1[16]), .c(stg2_c1[16]), .co(stg2_co1[16]));
counter_5to3 u_a21_17(.i0(stg1_s1_w[17]), .i1(stg1_c1_w[16]), .i2(stg1_s2_w[9 ]), .i3(stg1_c2_w[8 ]), .ci(stg2_co1[16]), .s(stg2_s1[17]), .c(stg2_c1[17]), .co(stg2_co1[17]));
counter_5to3 u_a21_18(.i0(stg1_s1_w[18]), .i1(stg1_c1_w[17]), .i2(stg1_s2_w[10]), .i3(stg1_c2_w[9 ]), .ci(stg2_co1[17]), .s(stg2_s1[18]), .c(stg2_c1[18]), .co(stg2_co1[18]));
counter_5to3 u_a21_19(.i0(stg1_s1_w[19]), .i1(stg1_c1_w[18]), .i2(stg1_s2_w[11]), .i3(stg1_c2_w[10]), .ci(stg2_co1[18]), .s(stg2_s1[19]), .c(stg2_c1[19]), .co(stg2_co1[19]));
counter_5to3 u_a21_20(.i0(stg1_s1_w[20]), .i1(stg1_c1_w[19]), .i2(stg1_s2_w[12]), .i3(stg1_c2_w[11]), .ci(stg2_co1[19]), .s(stg2_s1[20]), .c(stg2_c1[20]), .co(stg2_co1[20]));
counter_5to3 u_a21_21(.i0(stg1_s1_w[21]), .i1(stg1_c1_w[20]), .i2(stg1_s2_w[13]), .i3(stg1_c2_w[12]), .ci(stg2_co1[20]), .s(stg2_s1[21]), .c(stg2_c1[21]), .co(stg2_co1[21]));
counter_5to3 u_a21_22(.i0(stg1_s1_w[22]), .i1(stg1_c1_w[21]), .i2(stg1_s2_w[14]), .i3(stg1_c2_w[13]), .ci(stg2_co1[21]), .s(stg2_s1[22]), .c(stg2_c1[22]), .co(stg2_co1[22]));
counter_5to3 u_a21_23(.i0(stg1_s1_w[23]), .i1(stg1_c1_w[22]), .i2(stg1_s2_w[15]), .i3(stg1_c2_w[14]), .ci(stg2_co1[22]), .s(stg2_s1[23]), .c(stg2_c1[23]), .co(stg2_co1[23]));
counter_5to3 u_a21_24(.i0(stg1_s1_w[24]), .i1(stg1_c1_w[23]), .i2(stg1_s2_w[16]), .i3(stg1_c2_w[15]), .ci(stg2_co1[23]), .s(stg2_s1[24]), .c(stg2_c1[24]), .co(stg2_co1[24]));
counter_5to3 u_a21_25(.i0(stg1_s1_w[24]), .i1(stg1_c1_w[24]), .i2(stg1_s2_w[17]), .i3(stg1_c2_w[16]), .ci(stg2_co1[24]), .s(stg2_s1[25]), .c(stg2_c1[25]), .co(stg2_co1[25]));
counter_5to3 u_a21_26(.i0(stg1_s1_w[24]), .i1(stg1_c1_w[24]), .i2(stg1_s2_w[18]), .i3(stg1_c2_w[17]), .ci(stg2_co1[25]), .s(stg2_s1[26]), .c(stg2_c1[26]), .co(stg2_co1[26]));
counter_5to3 u_a21_27(.i0(stg1_s1_w[24]), .i1(stg1_c1_w[24]), .i2(stg1_s2_w[19]), .i3(stg1_c2_w[18]), .ci(stg2_co1[26]), .s(stg2_s1[27]), .c(stg2_c1[27]), .co(stg2_co1[27]));
counter_5to3 u_a21_28(.i0(stg1_s1_w[24]), .i1(stg1_c1_w[24]), .i2(stg1_s2_w[20]), .i3(stg1_c2_w[19]), .ci(stg2_co1[27]), .s(stg2_s1[28]), .c(stg2_c1[28]), .co(stg2_co1[28]));
counter_5to3 u_a21_29(.i0(stg1_s1_w[24]), .i1(stg1_c1_w[24]), .i2(stg1_s2_w[21]), .i3(stg1_c2_w[20]), .ci(stg2_co1[28]), .s(stg2_s1[29]), .c(stg2_c1[29]), .co(stg2_co1[29]));
counter_5to3 u_a21_30(.i0(stg1_s1_w[24]), .i1(stg1_c1_w[24]), .i2(stg1_s2_w[22]), .i3(stg1_c2_w[21]), .ci(stg2_co1[29]), .s(stg2_s1[30]), .c(stg2_c1[30]), .co(stg2_co1[30]));
counter_5to3 u_a21_31(.i0(stg1_s1_w[24]), .i1(stg1_c1_w[24]), .i2(stg1_s2_w[23]), .i3(stg1_c2_w[22]), .ci(stg2_co1[30]), .s(stg2_s1[31]), .c(stg2_c1[31]), .co(stg2_co1[31]));

wire [31:0] stg2_s1_w, stg2_c1_w;
wire [15:0] pp9_w2;
//================ if necessary, pipeline stg2_s* and stg2_c* here for timing ================
`ifdef MULT16_PIPE_STG2
reg [31:0] stg2_s1_ff, stg2_c1_ff;
reg [15:0] pp9_ff2;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg2_s1_ff     <= 32'b0;
    stg2_c1_ff     <= 32'b0;
    pp9_ff2        <= 16'b0;
  end
  else begin
    stg2_s1_ff     <= stg2_s1;
    stg2_c1_ff     <= stg2_c1;
    pp9_ff2        <= pp9_w1 ;
  end
end
assign stg2_s1_w   = stg2_s1_ff;
assign stg2_c1_w   = stg2_c1_ff;
assign pp9_w2      = pp9_ff2;
`else
assign stg2_s1_w   = stg2_s1;
assign stg2_c1_w   = stg2_c1;
assign pp9_w2      = pp9_w1 ;
`endif

//================ third stage ================

wire [31:0] stg3_s1, stg3_c1;
assign stg3_s1[0] = stg2_s1_w[0];
assign stg3_c1[0] = 1'b0;
half_adder u_a31_1 (.a(stg2_s1_w[ 1]), .b(stg2_c1_w[ 0]),                  .s(stg3_s1[ 1]), .co(stg3_c1[ 1]));
half_adder u_a31_2 (.a(stg2_s1_w[ 2]), .b(stg2_c1_w[ 1]),                  .s(stg3_s1[ 2]), .co(stg3_c1[ 2]));
half_adder u_a31_3 (.a(stg2_s1_w[ 3]), .b(stg2_c1_w[ 2]),                  .s(stg3_s1[ 3]), .co(stg3_c1[ 3]));
half_adder u_a31_4 (.a(stg2_s1_w[ 4]), .b(stg2_c1_w[ 3]),                  .s(stg3_s1[ 4]), .co(stg3_c1[ 4]));
half_adder u_a31_5 (.a(stg2_s1_w[ 5]), .b(stg2_c1_w[ 4]),                  .s(stg3_s1[ 5]), .co(stg3_c1[ 5]));
half_adder u_a31_6 (.a(stg2_s1_w[ 6]), .b(stg2_c1_w[ 5]),                  .s(stg3_s1[ 6]), .co(stg3_c1[ 6]));
half_adder u_a31_7 (.a(stg2_s1_w[ 7]), .b(stg2_c1_w[ 6]),                  .s(stg3_s1[ 7]), .co(stg3_c1[ 7]));
half_adder u_a31_8 (.a(stg2_s1_w[ 8]), .b(stg2_c1_w[ 7]),                  .s(stg3_s1[ 8]), .co(stg3_c1[ 8]));
half_adder u_a31_9 (.a(stg2_s1_w[ 9]), .b(stg2_c1_w[ 8]),                  .s(stg3_s1[ 9]), .co(stg3_c1[ 9]));
half_adder u_a31_10(.a(stg2_s1_w[10]), .b(stg2_c1_w[ 9]),                  .s(stg3_s1[10]), .co(stg3_c1[10]));
half_adder u_a31_11(.a(stg2_s1_w[11]), .b(stg2_c1_w[10]),                  .s(stg3_s1[11]), .co(stg3_c1[11]));
half_adder u_a31_12(.a(stg2_s1_w[12]), .b(stg2_c1_w[11]),                  .s(stg3_s1[12]), .co(stg3_c1[12]));
half_adder u_a31_13(.a(stg2_s1_w[13]), .b(stg2_c1_w[12]),                  .s(stg3_s1[13]), .co(stg3_c1[13]));
half_adder u_a31_14(.a(stg2_s1_w[14]), .b(stg2_c1_w[13]),                  .s(stg3_s1[14]), .co(stg3_c1[14]));
half_adder u_a31_15(.a(stg2_s1_w[15]), .b(stg2_c1_w[14]),                  .s(stg3_s1[15]), .co(stg3_c1[15]));
full_adder u_a31_16(.a(stg2_s1_w[16]), .b(stg2_c1_w[15]), .ci(pp9_w2[ 0]), .s(stg3_s1[16]), .co(stg3_c1[16]));
full_adder u_a31_17(.a(stg2_s1_w[17]), .b(stg2_c1_w[16]), .ci(pp9_w2[ 1]), .s(stg3_s1[17]), .co(stg3_c1[17]));
full_adder u_a31_18(.a(stg2_s1_w[18]), .b(stg2_c1_w[17]), .ci(pp9_w2[ 2]), .s(stg3_s1[18]), .co(stg3_c1[18]));
full_adder u_a31_19(.a(stg2_s1_w[19]), .b(stg2_c1_w[18]), .ci(pp9_w2[ 3]), .s(stg3_s1[19]), .co(stg3_c1[19]));
full_adder u_a31_20(.a(stg2_s1_w[20]), .b(stg2_c1_w[19]), .ci(pp9_w2[ 4]), .s(stg3_s1[20]), .co(stg3_c1[20]));
full_adder u_a31_21(.a(stg2_s1_w[21]), .b(stg2_c1_w[20]), .ci(pp9_w2[ 5]), .s(stg3_s1[21]), .co(stg3_c1[21]));
full_adder u_a31_22(.a(stg2_s1_w[22]), .b(stg2_c1_w[21]), .ci(pp9_w2[ 6]), .s(stg3_s1[22]), .co(stg3_c1[22]));
full_adder u_a31_23(.a(stg2_s1_w[23]), .b(stg2_c1_w[22]), .ci(pp9_w2[ 7]), .s(stg3_s1[23]), .co(stg3_c1[23]));
full_adder u_a31_24(.a(stg2_s1_w[24]), .b(stg2_c1_w[23]), .ci(pp9_w2[ 8]), .s(stg3_s1[24]), .co(stg3_c1[24]));
full_adder u_a31_25(.a(stg2_s1_w[25]), .b(stg2_c1_w[24]), .ci(pp9_w2[ 9]), .s(stg3_s1[25]), .co(stg3_c1[25]));
full_adder u_a31_26(.a(stg2_s1_w[26]), .b(stg2_c1_w[25]), .ci(pp9_w2[10]), .s(stg3_s1[26]), .co(stg3_c1[26]));
full_adder u_a31_27(.a(stg2_s1_w[27]), .b(stg2_c1_w[26]), .ci(pp9_w2[11]), .s(stg3_s1[27]), .co(stg3_c1[27]));
full_adder u_a31_28(.a(stg2_s1_w[28]), .b(stg2_c1_w[27]), .ci(pp9_w2[12]), .s(stg3_s1[28]), .co(stg3_c1[28]));
full_adder u_a31_29(.a(stg2_s1_w[29]), .b(stg2_c1_w[28]), .ci(pp9_w2[13]), .s(stg3_s1[29]), .co(stg3_c1[29]));
full_adder u_a31_30(.a(stg2_s1_w[30]), .b(stg2_c1_w[29]), .ci(pp9_w2[14]), .s(stg3_s1[30]), .co(stg3_c1[30]));
full_adder u_a31_31(.a(stg2_s1_w[31]), .b(stg2_c1_w[30]), .ci(pp9_w2[15]), .s(stg3_s1[31]), .co(stg3_c1[31]));

wire [31:0] stg3_s1_w, stg3_c1_w;
//================ if necessary, pipeline stg3_s* and stg3_c* here for timing ================
`ifdef MULT16_PIPE_STG3
reg [31:0] stg3_s1_ff, stg3_c1_ff;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg3_s1_ff   <= 32'b0;
    stg3_c1_ff   <= 32'b0;
  end
  else begin
    stg3_s1_ff   <= stg3_s1;
    stg3_c1_ff   <= stg3_c1;
  end
end
assign stg3_s1_w   = stg3_s1_ff ;
assign stg3_c1_w   = stg3_c1_ff ;
`else
assign stg3_s1_w   = stg3_s1;
assign stg3_c1_w   = stg3_c1;
`endif

//================ forth stage ===============
wire [31:0] stg4_s;
assign stg4_s = stg3_s1_w + {stg3_c1_w[30:0], 1'b0};  

//================ if necessary, pipeline stg4_s here for timing ================
`ifdef MULT16_PIPE_STG4
reg [31:0] stg4_s_ff;
always @(posedge clk or negedge rstn) begin
  if(~rstn)
    stg4_s_ff <= 32'b0;
  else
    stg4_s_ff <= stg4_s;
end
assign final_p = stg4_s_ff;                    
`else
assign final_p = stg4_s;                     
`endif

endmodule

