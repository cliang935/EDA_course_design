/*****************************************************
*  
*  Filename    : wtree_3to2_16x16.v
*  Author      : lucky_yuhua@aliyun.com
*  Create Date : 2019-08-01
*  Last Modify : 2019-08-01
*  Purpose     : this module process 9 18bit partial product
*                Carry Save Adder
*                Wallace tree using 3-2 compressing mode
*****************************************************/

`timescale 1ns/1ps

`include "mult16_def.v"
module wtree_3to2_16x16(
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
wire [21:0] stg1_s1, stg1_c1;
wire [21:0] stg1_s2, stg1_c2;
wire [19:0] stg1_s3, stg1_c3;

assign stg1_s1[1:0]   = pp1_w[1:0];
assign stg1_c1[1:0]   = 2'b0;
half_adder u_a11_2 (.a(pp1_w[ 2]), .b(pp2_w[ 0]),                 .s(stg1_s1[ 2]), .co(stg1_c1[ 2]));
half_adder u_a11_3 (.a(pp1_w[ 3]), .b(pp2_w[ 1]),                 .s(stg1_s1[ 3]), .co(stg1_c1[ 3]));
full_adder u_a11_4 (.a(pp1_w[ 4]), .b(pp2_w[ 2]), .ci(pp3_w[ 0]), .s(stg1_s1[ 4]), .co(stg1_c1[ 4]));
full_adder u_a11_5 (.a(pp1_w[ 5]), .b(pp2_w[ 3]), .ci(pp3_w[ 1]), .s(stg1_s1[ 5]), .co(stg1_c1[ 5]));
full_adder u_a11_6 (.a(pp1_w[ 6]), .b(pp2_w[ 4]), .ci(pp3_w[ 2]), .s(stg1_s1[ 6]), .co(stg1_c1[ 6]));
full_adder u_a11_7 (.a(pp1_w[ 7]), .b(pp2_w[ 5]), .ci(pp3_w[ 3]), .s(stg1_s1[ 7]), .co(stg1_c1[ 7]));
full_adder u_a11_8 (.a(pp1_w[ 8]), .b(pp2_w[ 6]), .ci(pp3_w[ 4]), .s(stg1_s1[ 8]), .co(stg1_c1[ 8]));
full_adder u_a11_9 (.a(pp1_w[ 9]), .b(pp2_w[ 7]), .ci(pp3_w[ 5]), .s(stg1_s1[ 9]), .co(stg1_c1[ 9]));
full_adder u_a11_10(.a(pp1_w[10]), .b(pp2_w[ 8]), .ci(pp3_w[ 6]), .s(stg1_s1[10]), .co(stg1_c1[10]));
full_adder u_a11_11(.a(pp1_w[11]), .b(pp2_w[ 9]), .ci(pp3_w[ 7]), .s(stg1_s1[11]), .co(stg1_c1[11]));
full_adder u_a11_12(.a(pp1_w[12]), .b(pp2_w[10]), .ci(pp3_w[ 8]), .s(stg1_s1[12]), .co(stg1_c1[12]));
full_adder u_a11_13(.a(pp1_w[13]), .b(pp2_w[11]), .ci(pp3_w[ 9]), .s(stg1_s1[13]), .co(stg1_c1[13]));
full_adder u_a11_14(.a(pp1_w[14]), .b(pp2_w[12]), .ci(pp3_w[10]), .s(stg1_s1[14]), .co(stg1_c1[14]));
full_adder u_a11_15(.a(pp1_w[15]), .b(pp2_w[13]), .ci(pp3_w[11]), .s(stg1_s1[15]), .co(stg1_c1[15]));
full_adder u_a11_16(.a(pp1_w[16]), .b(pp2_w[14]), .ci(pp3_w[12]), .s(stg1_s1[16]), .co(stg1_c1[16]));
full_adder u_a11_17(.a(pp1_w[17]), .b(pp2_w[15]), .ci(pp3_w[13]), .s(stg1_s1[17]), .co(stg1_c1[17]));
full_adder u_a11_18(.a(pp1_w[17]), .b(pp2_w[16]), .ci(pp3_w[14]), .s(stg1_s1[18]), .co(stg1_c1[18]));
full_adder u_a11_19(.a(pp1_w[17]), .b(pp2_w[17]), .ci(pp3_w[15]), .s(stg1_s1[19]), .co(stg1_c1[19]));
full_adder u_a11_20(.a(pp1_w[17]), .b(pp2_w[17]), .ci(pp3_w[16]), .s(stg1_s1[20]), .co(stg1_c1[20]));
full_adder u_a11_21(.a(pp1_w[17]), .b(pp2_w[17]), .ci(pp3_w[17]), .s(stg1_s1[21]), .co(stg1_c1[21]));

assign stg1_s2[1:0]   = pp4_w[1:0];
assign stg1_c2[1:0]   = 2'b0;
half_adder u_a12_2 (.a(pp4_w[ 2]), .b(pp5_w[ 0]),                 .s(stg1_s2[ 2]), .co(stg1_c2[ 2]));
half_adder u_a12_3 (.a(pp4_w[ 3]), .b(pp5_w[ 1]),                 .s(stg1_s2[ 3]), .co(stg1_c2[ 3]));
full_adder u_a12_4 (.a(pp4_w[ 4]), .b(pp5_w[ 2]), .ci(pp6_w[ 0]), .s(stg1_s2[ 4]), .co(stg1_c2[ 4]));
full_adder u_a12_5 (.a(pp4_w[ 5]), .b(pp5_w[ 3]), .ci(pp6_w[ 1]), .s(stg1_s2[ 5]), .co(stg1_c2[ 5]));
full_adder u_a12_6 (.a(pp4_w[ 6]), .b(pp5_w[ 4]), .ci(pp6_w[ 2]), .s(stg1_s2[ 6]), .co(stg1_c2[ 6]));
full_adder u_a12_7 (.a(pp4_w[ 7]), .b(pp5_w[ 5]), .ci(pp6_w[ 3]), .s(stg1_s2[ 7]), .co(stg1_c2[ 7]));
full_adder u_a12_8 (.a(pp4_w[ 8]), .b(pp5_w[ 6]), .ci(pp6_w[ 4]), .s(stg1_s2[ 8]), .co(stg1_c2[ 8]));
full_adder u_a12_9 (.a(pp4_w[ 9]), .b(pp5_w[ 7]), .ci(pp6_w[ 5]), .s(stg1_s2[ 9]), .co(stg1_c2[ 9]));
full_adder u_a12_10(.a(pp4_w[10]), .b(pp5_w[ 8]), .ci(pp6_w[ 6]), .s(stg1_s2[10]), .co(stg1_c2[10]));
full_adder u_a12_11(.a(pp4_w[11]), .b(pp5_w[ 9]), .ci(pp6_w[ 7]), .s(stg1_s2[11]), .co(stg1_c2[11]));
full_adder u_a12_12(.a(pp4_w[12]), .b(pp5_w[10]), .ci(pp6_w[ 8]), .s(stg1_s2[12]), .co(stg1_c2[12]));
full_adder u_a12_13(.a(pp4_w[13]), .b(pp5_w[11]), .ci(pp6_w[ 9]), .s(stg1_s2[13]), .co(stg1_c2[13]));
full_adder u_a12_14(.a(pp4_w[14]), .b(pp5_w[12]), .ci(pp6_w[10]), .s(stg1_s2[14]), .co(stg1_c2[14]));
full_adder u_a12_15(.a(pp4_w[15]), .b(pp5_w[13]), .ci(pp6_w[11]), .s(stg1_s2[15]), .co(stg1_c2[15]));
full_adder u_a12_16(.a(pp4_w[16]), .b(pp5_w[14]), .ci(pp6_w[12]), .s(stg1_s2[16]), .co(stg1_c2[16]));
full_adder u_a12_17(.a(pp4_w[17]), .b(pp5_w[15]), .ci(pp6_w[13]), .s(stg1_s2[17]), .co(stg1_c2[17]));
full_adder u_a12_18(.a(pp4_w[17]), .b(pp5_w[16]), .ci(pp6_w[14]), .s(stg1_s2[18]), .co(stg1_c2[18]));
full_adder u_a12_19(.a(pp4_w[17]), .b(pp5_w[17]), .ci(pp6_w[15]), .s(stg1_s2[19]), .co(stg1_c2[19]));
full_adder u_a12_20(.a(pp4_w[17]), .b(pp5_w[17]), .ci(pp6_w[16]), .s(stg1_s2[20]), .co(stg1_c2[20]));
full_adder u_a12_21(.a(pp4_w[17]), .b(pp5_w[17]), .ci(pp6_w[17]), .s(stg1_s2[21]), .co(stg1_c2[21]));

assign stg1_s3[1:0]   = pp7_w[1:0];
assign stg1_c3[1:0]   = 2'b0;
half_adder u_a13_2 (.a(pp7_w[ 2]), .b(pp8_w[ 0]),                 .s(stg1_s3[ 2]), .co(stg1_c3[ 2]));
half_adder u_a13_3 (.a(pp7_w[ 3]), .b(pp8_w[ 1]),                 .s(stg1_s3[ 3]), .co(stg1_c3[ 3]));
full_adder u_a13_4 (.a(pp7_w[ 4]), .b(pp8_w[ 2]), .ci(pp9_w[ 0]), .s(stg1_s3[ 4]), .co(stg1_c3[ 4]));
full_adder u_a13_5 (.a(pp7_w[ 5]), .b(pp8_w[ 3]), .ci(pp9_w[ 1]), .s(stg1_s3[ 5]), .co(stg1_c3[ 5]));
full_adder u_a13_6 (.a(pp7_w[ 6]), .b(pp8_w[ 4]), .ci(pp9_w[ 2]), .s(stg1_s3[ 6]), .co(stg1_c3[ 6]));
full_adder u_a13_7 (.a(pp7_w[ 7]), .b(pp8_w[ 5]), .ci(pp9_w[ 3]), .s(stg1_s3[ 7]), .co(stg1_c3[ 7]));
full_adder u_a13_8 (.a(pp7_w[ 8]), .b(pp8_w[ 6]), .ci(pp9_w[ 4]), .s(stg1_s3[ 8]), .co(stg1_c3[ 8]));
full_adder u_a13_9 (.a(pp7_w[ 9]), .b(pp8_w[ 7]), .ci(pp9_w[ 5]), .s(stg1_s3[ 9]), .co(stg1_c3[ 9]));
full_adder u_a13_10(.a(pp7_w[10]), .b(pp8_w[ 8]), .ci(pp9_w[ 6]), .s(stg1_s3[10]), .co(stg1_c3[10]));
full_adder u_a13_11(.a(pp7_w[11]), .b(pp8_w[ 9]), .ci(pp9_w[ 7]), .s(stg1_s3[11]), .co(stg1_c3[11]));
full_adder u_a13_12(.a(pp7_w[12]), .b(pp8_w[10]), .ci(pp9_w[ 8]), .s(stg1_s3[12]), .co(stg1_c3[12]));
full_adder u_a13_13(.a(pp7_w[13]), .b(pp8_w[11]), .ci(pp9_w[ 9]), .s(stg1_s3[13]), .co(stg1_c3[13]));
full_adder u_a13_14(.a(pp7_w[14]), .b(pp8_w[12]), .ci(pp9_w[10]), .s(stg1_s3[14]), .co(stg1_c3[14]));
full_adder u_a13_15(.a(pp7_w[15]), .b(pp8_w[13]), .ci(pp9_w[11]), .s(stg1_s3[15]), .co(stg1_c3[15]));
full_adder u_a13_16(.a(pp7_w[16]), .b(pp8_w[14]), .ci(pp9_w[12]), .s(stg1_s3[16]), .co(stg1_c3[16]));
full_adder u_a13_17(.a(pp7_w[17]), .b(pp8_w[15]), .ci(pp9_w[13]), .s(stg1_s3[17]), .co(stg1_c3[17]));
full_adder u_a13_18(.a(pp7_w[17]), .b(pp8_w[16]), .ci(pp9_w[14]), .s(stg1_s3[18]), .co(stg1_c3[18]));
full_adder u_a13_19(.a(pp7_w[17]), .b(pp8_w[17]), .ci(pp9_w[15]), .s(stg1_s3[19]), .co(stg1_c3[19]));



wire [21:0] stg1_s1_w, stg1_c1_w;
wire [21:0] stg1_s2_w, stg1_c2_w;
wire [19:0] stg1_s3_w, stg1_c3_w;
//================ if necessary, pipeline stg1_s* and stg1_c* here for timing ================
`ifdef MULT16_PIPE_STG1
reg [21:0] stg1_s1_ff, stg1_c1_ff;
reg [21:0] stg1_s2_ff, stg1_c2_ff;
reg [19:0] stg1_s3_ff, stg1_c3_ff;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg1_s1_ff <= 22'b0;
    stg1_c1_ff <= 22'b0;
    stg1_s2_ff <= 22'b0;
    stg1_c2_ff <= 22'b0;
    stg1_s3_ff <= 20'b0;
    stg1_c3_ff <= 20'b0;
  end
  else begin
    stg1_s1_ff <= stg1_s1;
    stg1_c1_ff <= stg1_c1;
    stg1_s2_ff <= stg1_s2;
    stg1_c2_ff <= stg1_c2;
    stg1_s3_ff <= stg1_s3;
    stg1_c3_ff <= stg1_c3;
  end
end
assign stg1_s1_w = stg1_s1_ff;
assign stg1_c1_w = stg1_c1_ff;
assign stg1_s2_w = stg1_s2_ff;
assign stg1_c2_w = stg1_c2_ff;
assign stg1_s3_w = stg1_s3_ff;
assign stg1_c3_w = stg1_c3_ff;
`else
assign stg1_s1_w = stg1_s1;
assign stg1_c1_w = stg1_c1;
assign stg1_s2_w = stg1_s2;
assign stg1_c2_w = stg1_c2;
assign stg1_s3_w = stg1_s3;
assign stg1_c3_w = stg1_c3;
`endif

//================ second stage ================

wire [27:0] stg2_s1, stg2_c1;
wire [24:0] stg2_s2, stg2_c2;

assign stg2_s1[0] = stg1_s1_w[0];
assign stg2_c1[0] = 1'b0; 
half_adder u_a21_1 (.a(stg1_s1_w[ 1]), .b(stg1_c1_w[ 0]),                     .s(stg2_s1[ 1]), .co(stg2_c1[ 1]));
half_adder u_a21_2 (.a(stg1_s1_w[ 2]), .b(stg1_c1_w[ 1]),                     .s(stg2_s1[ 2]), .co(stg2_c1[ 2]));
half_adder u_a21_3 (.a(stg1_s1_w[ 3]), .b(stg1_c1_w[ 2]),                     .s(stg2_s1[ 3]), .co(stg2_c1[ 3]));
half_adder u_a21_4 (.a(stg1_s1_w[ 4]), .b(stg1_c1_w[ 3]),                     .s(stg2_s1[ 4]), .co(stg2_c1[ 4]));
half_adder u_a21_5 (.a(stg1_s1_w[ 5]), .b(stg1_c1_w[ 4]),                     .s(stg2_s1[ 5]), .co(stg2_c1[ 5]));
full_adder u_a21_6 (.a(stg1_s1_w[ 6]), .b(stg1_c1_w[ 5]), .ci(stg1_s2_w[ 0]), .s(stg2_s1[ 6]), .co(stg2_c1[ 6]));
full_adder u_a21_7 (.a(stg1_s1_w[ 7]), .b(stg1_c1_w[ 6]), .ci(stg1_s2_w[ 1]), .s(stg2_s1[ 7]), .co(stg2_c1[ 7]));
full_adder u_a21_8 (.a(stg1_s1_w[ 8]), .b(stg1_c1_w[ 7]), .ci(stg1_s2_w[ 2]), .s(stg2_s1[ 8]), .co(stg2_c1[ 8]));
full_adder u_a21_9 (.a(stg1_s1_w[ 9]), .b(stg1_c1_w[ 8]), .ci(stg1_s2_w[ 3]), .s(stg2_s1[ 9]), .co(stg2_c1[ 9]));
full_adder u_a21_10(.a(stg1_s1_w[10]), .b(stg1_c1_w[ 9]), .ci(stg1_s2_w[ 4]), .s(stg2_s1[10]), .co(stg2_c1[10]));
full_adder u_a21_11(.a(stg1_s1_w[11]), .b(stg1_c1_w[10]), .ci(stg1_s2_w[ 5]), .s(stg2_s1[11]), .co(stg2_c1[11]));
full_adder u_a21_12(.a(stg1_s1_w[12]), .b(stg1_c1_w[11]), .ci(stg1_s2_w[ 6]), .s(stg2_s1[12]), .co(stg2_c1[12]));
full_adder u_a21_13(.a(stg1_s1_w[13]), .b(stg1_c1_w[12]), .ci(stg1_s2_w[ 7]), .s(stg2_s1[13]), .co(stg2_c1[13]));
full_adder u_a21_14(.a(stg1_s1_w[14]), .b(stg1_c1_w[13]), .ci(stg1_s2_w[ 8]), .s(stg2_s1[14]), .co(stg2_c1[14]));
full_adder u_a21_15(.a(stg1_s1_w[15]), .b(stg1_c1_w[14]), .ci(stg1_s2_w[ 9]), .s(stg2_s1[15]), .co(stg2_c1[15]));
full_adder u_a21_16(.a(stg1_s1_w[16]), .b(stg1_c1_w[15]), .ci(stg1_s2_w[10]), .s(stg2_s1[16]), .co(stg2_c1[16]));
full_adder u_a21_17(.a(stg1_s1_w[17]), .b(stg1_c1_w[16]), .ci(stg1_s2_w[11]), .s(stg2_s1[17]), .co(stg2_c1[17]));
full_adder u_a21_18(.a(stg1_s1_w[18]), .b(stg1_c1_w[17]), .ci(stg1_s2_w[12]), .s(stg2_s1[18]), .co(stg2_c1[18]));
full_adder u_a21_19(.a(stg1_s1_w[19]), .b(stg1_c1_w[18]), .ci(stg1_s2_w[13]), .s(stg2_s1[19]), .co(stg2_c1[19]));
full_adder u_a21_20(.a(stg1_s1_w[20]), .b(stg1_c1_w[19]), .ci(stg1_s2_w[14]), .s(stg2_s1[20]), .co(stg2_c1[20]));
full_adder u_a21_21(.a(stg1_s1_w[21]), .b(stg1_c1_w[20]), .ci(stg1_s2_w[15]), .s(stg2_s1[21]), .co(stg2_c1[21]));
full_adder u_a21_22(.a(stg1_s1_w[21]), .b(stg1_c1_w[21]), .ci(stg1_s2_w[16]), .s(stg2_s1[22]), .co(stg2_c1[22]));
full_adder u_a21_23(.a(stg1_s1_w[21]), .b(stg1_c1_w[21]), .ci(stg1_s2_w[17]), .s(stg2_s1[23]), .co(stg2_c1[23]));
full_adder u_a21_24(.a(stg1_s1_w[21]), .b(stg1_c1_w[21]), .ci(stg1_s2_w[18]), .s(stg2_s1[24]), .co(stg2_c1[24]));
full_adder u_a21_25(.a(stg1_s1_w[21]), .b(stg1_c1_w[21]), .ci(stg1_s2_w[19]), .s(stg2_s1[25]), .co(stg2_c1[25]));
full_adder u_a21_26(.a(stg1_s1_w[21]), .b(stg1_c1_w[21]), .ci(stg1_s2_w[20]), .s(stg2_s1[26]), .co(stg2_c1[26]));
full_adder u_a21_27(.a(stg1_s1_w[21]), .b(stg1_c1_w[21]), .ci(stg1_s2_w[21]), .s(stg2_s1[27]), .co(stg2_c1[27]));

assign stg2_s2[4:0] = stg1_c2_w[4:0];
assign stg2_c2[4:0] = 5'b0; 
half_adder u_a22_5 (.a(stg1_c2_w[ 5]), .b(stg1_s3_w[ 0]),                     .s(stg2_s2[ 5]), .co(stg2_c2[ 5]));
full_adder u_a22_6 (.a(stg1_c2_w[ 6]), .b(stg1_s3_w[ 1]), .ci(stg1_c3_w[ 0]), .s(stg2_s2[ 6]), .co(stg2_c2[ 6]));
full_adder u_a22_7 (.a(stg1_c2_w[ 7]), .b(stg1_s3_w[ 2]), .ci(stg1_c3_w[ 1]), .s(stg2_s2[ 7]), .co(stg2_c2[ 7]));
full_adder u_a22_8 (.a(stg1_c2_w[ 8]), .b(stg1_s3_w[ 3]), .ci(stg1_c3_w[ 2]), .s(stg2_s2[ 8]), .co(stg2_c2[ 8]));
full_adder u_a22_9 (.a(stg1_c2_w[ 9]), .b(stg1_s3_w[ 4]), .ci(stg1_c3_w[ 3]), .s(stg2_s2[ 9]), .co(stg2_c2[ 9]));
full_adder u_a22_10(.a(stg1_c2_w[10]), .b(stg1_s3_w[ 5]), .ci(stg1_c3_w[ 4]), .s(stg2_s2[10]), .co(stg2_c2[10]));
full_adder u_a22_11(.a(stg1_c2_w[11]), .b(stg1_s3_w[ 6]), .ci(stg1_c3_w[ 5]), .s(stg2_s2[11]), .co(stg2_c2[11]));
full_adder u_a22_12(.a(stg1_c2_w[12]), .b(stg1_s3_w[ 7]), .ci(stg1_c3_w[ 6]), .s(stg2_s2[12]), .co(stg2_c2[12]));
full_adder u_a22_13(.a(stg1_c2_w[13]), .b(stg1_s3_w[ 8]), .ci(stg1_c3_w[ 7]), .s(stg2_s2[13]), .co(stg2_c2[13]));
full_adder u_a22_14(.a(stg1_c2_w[14]), .b(stg1_s3_w[ 9]), .ci(stg1_c3_w[ 8]), .s(stg2_s2[14]), .co(stg2_c2[14]));
full_adder u_a22_15(.a(stg1_c2_w[15]), .b(stg1_s3_w[10]), .ci(stg1_c3_w[ 9]), .s(stg2_s2[15]), .co(stg2_c2[15]));
full_adder u_a22_16(.a(stg1_c2_w[16]), .b(stg1_s3_w[11]), .ci(stg1_c3_w[10]), .s(stg2_s2[16]), .co(stg2_c2[16]));
full_adder u_a22_17(.a(stg1_c2_w[17]), .b(stg1_s3_w[12]), .ci(stg1_c3_w[11]), .s(stg2_s2[17]), .co(stg2_c2[17]));
full_adder u_a22_18(.a(stg1_c2_w[18]), .b(stg1_s3_w[13]), .ci(stg1_c3_w[12]), .s(stg2_s2[18]), .co(stg2_c2[18]));
full_adder u_a22_19(.a(stg1_c2_w[19]), .b(stg1_s3_w[14]), .ci(stg1_c3_w[13]), .s(stg2_s2[19]), .co(stg2_c2[19]));
full_adder u_a22_20(.a(stg1_c2_w[20]), .b(stg1_s3_w[15]), .ci(stg1_c3_w[14]), .s(stg2_s2[20]), .co(stg2_c2[20]));
full_adder u_a22_21(.a(stg1_c2_w[21]), .b(stg1_s3_w[16]), .ci(stg1_c3_w[15]), .s(stg2_s2[21]), .co(stg2_c2[21]));
full_adder u_a22_22(.a(stg1_c2_w[21]), .b(stg1_s3_w[17]), .ci(stg1_c3_w[16]), .s(stg2_s2[22]), .co(stg2_c2[22]));
full_adder u_a22_23(.a(stg1_c2_w[21]), .b(stg1_s3_w[18]), .ci(stg1_c3_w[17]), .s(stg2_s2[23]), .co(stg2_c2[23]));
full_adder u_a22_24(.a(stg1_c2_w[21]), .b(stg1_s3_w[19]), .ci(stg1_c3_w[18]), .s(stg2_s2[24]), .co(stg2_c2[24]));

wire [27:0] stg2_s1_w, stg2_c1_w;
wire [24:0] stg2_s2_w, stg2_c2_w;
//================ if necessary, pipeline stg2_s* and stg2_c* here for timing ================
`ifdef MULT16_PIPE_STG2
reg [27:0] stg2_s1_ff, stg2_c1_ff;
reg [24:0] stg2_s2_ff, stg2_c2_ff;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg2_s1_ff <= 28'b0;
    stg2_c1_ff <= 28'b0;
    stg2_s2_ff <= 25'b0;
    stg2_c2_ff <= 25'b0;
  end
  else begin
    stg2_s1_ff <= stg2_s1;
    stg2_c1_ff <= stg2_c1;
    stg2_s2_ff <= stg2_s2;
    stg2_c2_ff <= stg2_c2;
  end
end
assign stg2_s1_w = stg2_s1_ff;
assign stg2_c1_w = stg2_c1_ff;
assign stg2_s2_w = stg2_s2_ff;
assign stg2_c2_w = stg2_c2_ff;
`else
assign stg2_s1_w = stg2_s1;
assign stg2_c1_w = stg2_c1;
assign stg2_s2_w = stg2_s2;
assign stg2_c2_w = stg2_c2;
`endif

//================ third stage ================

wire [31:0] stg3_s1, stg3_c1;

assign stg3_s1[0] = stg2_s1_w[0];
assign stg3_c1[0] = 1'b0;
half_adder u_a31_1 (.a(stg2_s1_w[ 1]), .b(stg2_c1_w[ 0]),                     .s(stg3_s1[ 1]), .co(stg3_c1[ 1]));
half_adder u_a31_2 (.a(stg2_s1_w[ 2]), .b(stg2_c1_w[ 1]),                     .s(stg3_s1[ 2]), .co(stg3_c1[ 2]));
half_adder u_a31_3 (.a(stg2_s1_w[ 3]), .b(stg2_c1_w[ 2]),                     .s(stg3_s1[ 3]), .co(stg3_c1[ 3]));
half_adder u_a31_4 (.a(stg2_s1_w[ 4]), .b(stg2_c1_w[ 3]),                     .s(stg3_s1[ 4]), .co(stg3_c1[ 4]));
half_adder u_a31_5 (.a(stg2_s1_w[ 5]), .b(stg2_c1_w[ 4]),                     .s(stg3_s1[ 5]), .co(stg3_c1[ 5]));
half_adder u_a31_6 (.a(stg2_s1_w[ 6]), .b(stg2_c1_w[ 5]),                     .s(stg3_s1[ 6]), .co(stg3_c1[ 6]));
full_adder u_a31_7 (.a(stg2_s1_w[ 7]), .b(stg2_c1_w[ 6]), .ci(stg2_s2_w[ 0]), .s(stg3_s1[ 7]), .co(stg3_c1[ 7]));
full_adder u_a31_8 (.a(stg2_s1_w[ 8]), .b(stg2_c1_w[ 7]), .ci(stg2_s2_w[ 1]), .s(stg3_s1[ 8]), .co(stg3_c1[ 8]));
full_adder u_a31_9 (.a(stg2_s1_w[ 9]), .b(stg2_c1_w[ 8]), .ci(stg2_s2_w[ 2]), .s(stg3_s1[ 9]), .co(stg3_c1[ 9]));
full_adder u_a31_10(.a(stg2_s1_w[10]), .b(stg2_c1_w[ 9]), .ci(stg2_s2_w[ 3]), .s(stg3_s1[10]), .co(stg3_c1[10]));
full_adder u_a31_11(.a(stg2_s1_w[11]), .b(stg2_c1_w[10]), .ci(stg2_s2_w[ 4]), .s(stg3_s1[11]), .co(stg3_c1[11]));
full_adder u_a31_12(.a(stg2_s1_w[12]), .b(stg2_c1_w[11]), .ci(stg2_s2_w[ 5]), .s(stg3_s1[12]), .co(stg3_c1[12]));
full_adder u_a31_13(.a(stg2_s1_w[13]), .b(stg2_c1_w[12]), .ci(stg2_s2_w[ 6]), .s(stg3_s1[13]), .co(stg3_c1[13]));
full_adder u_a31_14(.a(stg2_s1_w[14]), .b(stg2_c1_w[13]), .ci(stg2_s2_w[ 7]), .s(stg3_s1[14]), .co(stg3_c1[14]));
full_adder u_a31_15(.a(stg2_s1_w[15]), .b(stg2_c1_w[14]), .ci(stg2_s2_w[ 8]), .s(stg3_s1[15]), .co(stg3_c1[15]));
full_adder u_a31_16(.a(stg2_s1_w[16]), .b(stg2_c1_w[15]), .ci(stg2_s2_w[ 9]), .s(stg3_s1[16]), .co(stg3_c1[16]));
full_adder u_a31_17(.a(stg2_s1_w[17]), .b(stg2_c1_w[16]), .ci(stg2_s2_w[10]), .s(stg3_s1[17]), .co(stg3_c1[17]));
full_adder u_a31_18(.a(stg2_s1_w[18]), .b(stg2_c1_w[17]), .ci(stg2_s2_w[11]), .s(stg3_s1[18]), .co(stg3_c1[18]));
full_adder u_a31_19(.a(stg2_s1_w[19]), .b(stg2_c1_w[18]), .ci(stg2_s2_w[12]), .s(stg3_s1[19]), .co(stg3_c1[19]));
full_adder u_a31_20(.a(stg2_s1_w[20]), .b(stg2_c1_w[19]), .ci(stg2_s2_w[13]), .s(stg3_s1[20]), .co(stg3_c1[20]));
full_adder u_a31_21(.a(stg2_s1_w[21]), .b(stg2_c1_w[20]), .ci(stg2_s2_w[14]), .s(stg3_s1[21]), .co(stg3_c1[21]));
full_adder u_a31_22(.a(stg2_s1_w[22]), .b(stg2_c1_w[21]), .ci(stg2_s2_w[15]), .s(stg3_s1[22]), .co(stg3_c1[22]));
full_adder u_a31_23(.a(stg2_s1_w[23]), .b(stg2_c1_w[22]), .ci(stg2_s2_w[16]), .s(stg3_s1[23]), .co(stg3_c1[23]));
full_adder u_a31_24(.a(stg2_s1_w[24]), .b(stg2_c1_w[23]), .ci(stg2_s2_w[17]), .s(stg3_s1[24]), .co(stg3_c1[24]));
full_adder u_a31_25(.a(stg2_s1_w[25]), .b(stg2_c1_w[24]), .ci(stg2_s2_w[18]), .s(stg3_s1[25]), .co(stg3_c1[25]));
full_adder u_a31_26(.a(stg2_s1_w[26]), .b(stg2_c1_w[25]), .ci(stg2_s2_w[19]), .s(stg3_s1[26]), .co(stg3_c1[26]));
full_adder u_a31_27(.a(stg2_s1_w[27]), .b(stg2_c1_w[26]), .ci(stg2_s2_w[20]), .s(stg3_s1[27]), .co(stg3_c1[27]));
full_adder u_a31_28(.a(stg2_s1_w[27]), .b(stg2_c1_w[27]), .ci(stg2_s2_w[21]), .s(stg3_s1[28]), .co(stg3_c1[28]));
full_adder u_a31_29(.a(stg2_s1_w[27]), .b(stg2_c1_w[27]), .ci(stg2_s2_w[22]), .s(stg3_s1[29]), .co(stg3_c1[29]));
full_adder u_a31_30(.a(stg2_s1_w[27]), .b(stg2_c1_w[27]), .ci(stg2_s2_w[23]), .s(stg3_s1[30]), .co(stg3_c1[30]));
full_adder u_a31_31(.a(stg2_s1_w[27]), .b(stg2_c1_w[27]), .ci(stg2_s2_w[24]), .s(stg3_s1[31]), .co(stg3_c1[31]));

wire [31:0] stg3_s1_w, stg3_c1_w;
wire [23:0] stg2_c2_w2;
//================ if necessary, pipeline stg3_s* and stg3_c* here for timing ================
//in the next stage
`ifdef MULT16_PIPE_STG3
reg [31:0] stg3_s1_ff, stg3_c1_ff;
reg [23:0] stg2_c2_ff2;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg3_s1_ff  <= 32'b0;
    stg3_c1_ff  <= 32'b0;
    stg2_c2_ff2 <= 24'b0;
  end
  else begin
    stg3_s1_ff  <= stg3_s1         ;
    stg3_c1_ff  <= stg3_c1         ;
    stg2_c2_ff2 <= stg2_c2_w[23:0] ;
  end
end
assign stg3_s1_w  = stg3_s1_ff ;
assign stg3_c1_w  = stg3_c1_ff ;
assign stg2_c2_w2 = stg2_c2_ff2;
`else
assign stg3_s1_w  = stg3_s1;
assign stg3_c1_w  = stg3_c1;
assign stg2_c2_w2 = stg2_c2_w[23:0];
`endif

//================ forth stage ===============
wire [31:0] stg4_s1, stg4_c1;

assign stg4_s1[0] = stg3_s1_w[0];
assign stg4_c1[0] = 1'b0;
half_adder u_a41_1 (.a(stg3_s1_w[ 1]), .b(stg3_c1_w[ 0]),                      .s(stg4_s1[ 1]), .co(stg4_c1[ 1]));
half_adder u_a41_2 (.a(stg3_s1_w[ 2]), .b(stg3_c1_w[ 1]),                      .s(stg4_s1[ 2]), .co(stg4_c1[ 2]));
half_adder u_a41_3 (.a(stg3_s1_w[ 3]), .b(stg3_c1_w[ 2]),                      .s(stg4_s1[ 3]), .co(stg4_c1[ 3]));
half_adder u_a41_4 (.a(stg3_s1_w[ 4]), .b(stg3_c1_w[ 3]),                      .s(stg4_s1[ 4]), .co(stg4_c1[ 4]));
half_adder u_a41_5 (.a(stg3_s1_w[ 5]), .b(stg3_c1_w[ 4]),                      .s(stg4_s1[ 5]), .co(stg4_c1[ 5]));
half_adder u_a41_6 (.a(stg3_s1_w[ 6]), .b(stg3_c1_w[ 5]),                      .s(stg4_s1[ 6]), .co(stg4_c1[ 6]));
half_adder u_a41_7 (.a(stg3_s1_w[ 7]), .b(stg3_c1_w[ 6]),                      .s(stg4_s1[ 7]), .co(stg4_c1[ 7]));
full_adder u_a41_8 (.a(stg3_s1_w[ 8]), .b(stg3_c1_w[ 7]), .ci(stg2_c2_w2[ 0]), .s(stg4_s1[ 8]), .co(stg4_c1[ 8]));
full_adder u_a41_9 (.a(stg3_s1_w[ 9]), .b(stg3_c1_w[ 8]), .ci(stg2_c2_w2[ 1]), .s(stg4_s1[ 9]), .co(stg4_c1[ 9]));
full_adder u_a41_10(.a(stg3_s1_w[10]), .b(stg3_c1_w[ 9]), .ci(stg2_c2_w2[ 2]), .s(stg4_s1[10]), .co(stg4_c1[10]));
full_adder u_a41_11(.a(stg3_s1_w[11]), .b(stg3_c1_w[10]), .ci(stg2_c2_w2[ 3]), .s(stg4_s1[11]), .co(stg4_c1[11]));
full_adder u_a41_12(.a(stg3_s1_w[12]), .b(stg3_c1_w[11]), .ci(stg2_c2_w2[ 4]), .s(stg4_s1[12]), .co(stg4_c1[12]));
full_adder u_a41_13(.a(stg3_s1_w[13]), .b(stg3_c1_w[12]), .ci(stg2_c2_w2[ 5]), .s(stg4_s1[13]), .co(stg4_c1[13]));
full_adder u_a41_14(.a(stg3_s1_w[14]), .b(stg3_c1_w[13]), .ci(stg2_c2_w2[ 6]), .s(stg4_s1[14]), .co(stg4_c1[14]));
full_adder u_a41_15(.a(stg3_s1_w[15]), .b(stg3_c1_w[14]), .ci(stg2_c2_w2[ 7]), .s(stg4_s1[15]), .co(stg4_c1[15]));
full_adder u_a41_16(.a(stg3_s1_w[16]), .b(stg3_c1_w[15]), .ci(stg2_c2_w2[ 8]), .s(stg4_s1[16]), .co(stg4_c1[16]));
full_adder u_a41_17(.a(stg3_s1_w[17]), .b(stg3_c1_w[16]), .ci(stg2_c2_w2[ 9]), .s(stg4_s1[17]), .co(stg4_c1[17]));
full_adder u_a41_18(.a(stg3_s1_w[18]), .b(stg3_c1_w[17]), .ci(stg2_c2_w2[10]), .s(stg4_s1[18]), .co(stg4_c1[18]));
full_adder u_a41_19(.a(stg3_s1_w[19]), .b(stg3_c1_w[18]), .ci(stg2_c2_w2[11]), .s(stg4_s1[19]), .co(stg4_c1[19]));
full_adder u_a41_20(.a(stg3_s1_w[20]), .b(stg3_c1_w[19]), .ci(stg2_c2_w2[12]), .s(stg4_s1[20]), .co(stg4_c1[20]));
full_adder u_a41_21(.a(stg3_s1_w[21]), .b(stg3_c1_w[20]), .ci(stg2_c2_w2[13]), .s(stg4_s1[21]), .co(stg4_c1[21]));
full_adder u_a41_22(.a(stg3_s1_w[22]), .b(stg3_c1_w[21]), .ci(stg2_c2_w2[14]), .s(stg4_s1[22]), .co(stg4_c1[22]));
full_adder u_a41_23(.a(stg3_s1_w[23]), .b(stg3_c1_w[22]), .ci(stg2_c2_w2[15]), .s(stg4_s1[23]), .co(stg4_c1[23]));
full_adder u_a41_24(.a(stg3_s1_w[24]), .b(stg3_c1_w[23]), .ci(stg2_c2_w2[16]), .s(stg4_s1[24]), .co(stg4_c1[24]));
full_adder u_a41_25(.a(stg3_s1_w[25]), .b(stg3_c1_w[24]), .ci(stg2_c2_w2[17]), .s(stg4_s1[25]), .co(stg4_c1[25]));
full_adder u_a41_26(.a(stg3_s1_w[26]), .b(stg3_c1_w[25]), .ci(stg2_c2_w2[18]), .s(stg4_s1[26]), .co(stg4_c1[26]));
full_adder u_a41_27(.a(stg3_s1_w[27]), .b(stg3_c1_w[26]), .ci(stg2_c2_w2[19]), .s(stg4_s1[27]), .co(stg4_c1[27]));
full_adder u_a41_28(.a(stg3_s1_w[28]), .b(stg3_c1_w[27]), .ci(stg2_c2_w2[20]), .s(stg4_s1[28]), .co(stg4_c1[28]));
full_adder u_a41_29(.a(stg3_s1_w[29]), .b(stg3_c1_w[28]), .ci(stg2_c2_w2[21]), .s(stg4_s1[29]), .co(stg4_c1[29]));
full_adder u_a41_30(.a(stg3_s1_w[30]), .b(stg3_c1_w[29]), .ci(stg2_c2_w2[22]), .s(stg4_s1[30]), .co(stg4_c1[30]));
full_adder u_a41_31(.a(stg3_s1_w[31]), .b(stg3_c1_w[30]), .ci(stg2_c2_w2[23]), .s(stg4_s1[31]), .co(stg4_c1[31]));

wire [31:0] stg4_s1_w, stg4_c1_w;
//================ if necessary, pipeline stg4_s* and stg4_c* here for timing ================
`ifdef MULT16_PIPE_STG4
reg [31:0] stg4_s1_ff, stg4_c1_ff;

always @(posedge clk or negedge rstn) begin
  if(~rstn) begin
    stg4_s1_ff <= 32'b0;
    stg4_c1_ff <= 32'b0;
  end
  else begin
    stg4_s1_ff <= stg4_s1;
    stg4_c1_ff <= stg4_c1;
  end
end
assign stg4_s1_w = stg4_s1_ff;
assign stg4_c1_w = stg4_c1_ff;
`else
assign stg4_s1_w = stg4_s1;
assign stg4_c1_w = stg4_c1;
`endif

//================ fifth stage ===============
wire [31:0] stg5_s;
assign stg5_s = stg4_s1_w + {stg4_c1_w[30:0], 1'b0};  

//================ if necessary, pipeline stg5_s here for timing ================
`ifdef MULT16_PIPE_STG5
reg [31:0] stg5_s_ff;
always @(posedge clk or negedge rstn) begin
  if(~rstn)
    stg5_s_ff <= 32'b0;
  else
    stg5_s_ff <= stg5_s;
end
assign final_p = stg5_s_ff;                    
`else
assign final_p = stg5_s;                      
`endif

endmodule

