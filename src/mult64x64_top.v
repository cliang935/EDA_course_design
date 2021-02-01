`timescale 1ns/10ps

module mult64x64_top (
        input              i_clk     ,
		input              i_rstn    ,
		input  wire        i_multa_ns,     // 0-multa is usigned, 1-multa is signed
		input  wire        i_multb_ns,     // 0-multb is usigned, 1-multb is signed
        input  wire [63:0] i_multa   ,     // Multiplicand 
        input  wire [63:0] i_multb   ,     // Multiplier
		 output wire [127:0] o_product
		 );

// internal connection
// partical product
wire [65:0] pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10;
wire [65:0] pp11, pp12, pp13, pp14, pp15, pp16, pp17, pp18, pp19, pp20;
wire [65:0] pp21, pp22, pp23, pp24, pp25, pp26, pp27, pp28, pp29, pp30, pp31, pp32, pp33;
wire [127:0] final_p;

booth_r4_64x64 booth_r4_64x64_u0(
  .i_multa_ns  (i_multa_ns),
  .i_multb_ns  (i_multb_ns),
  .i_multa     (i_multa   ),
  .i_multb     (i_multb   ),
  .o_pp1       (pp1),
  .o_pp2       (pp2),
  .o_pp3       (pp3),
  .o_pp4       (pp4),
  .o_pp5       (pp5),
  .o_pp6       (pp6),
  .o_pp7       (pp7),
  .o_pp8       (pp8),
  .o_pp9       (pp9),
  .o_pp10      (pp10),
  .o_pp11      (pp11),
  .o_pp12      (pp12),
  .o_pp13      (pp13),
  .o_pp14      (pp14),
  .o_pp15      (pp15),
  .o_pp16      (pp16),
  .o_pp17      (pp17),
  .o_pp18      (pp18),
  .o_pp19      (pp19),
  .o_pp20      (pp20),
  .o_pp21      (pp21),
  .o_pp22      (pp22),
  .o_pp23      (pp23),
  .o_pp24      (pp24),
  .o_pp25      (pp25),
  .o_pp26      (pp26),
  .o_pp27      (pp27),
  .o_pp28      (pp28),
  .o_pp29      (pp29),
  .o_pp30      (pp30),
  .o_pp31      (pp31),
  .o_pp32      (pp32),
  .o_pp33      (pp33)
);

wtree_4to2_64x64 wtree_4to2_64x64_u0(
  .clk         (i_clk      ),
  .rstn        (i_rstn     ),
  .pp1         (pp1        ),
  .pp2         (pp2        ),
  .pp3         (pp3        ),
  .pp4         (pp4        ),
  .pp5         (pp5        ),
  .pp6         (pp6        ),
  .pp7         (pp7        ),
  .pp8         (pp8        ),
  .pp9         (pp9        ),
  .pp10        (pp10       ),
  .pp11        (pp11       ),
  .pp12        (pp12       ),
  .pp13        (pp13       ),
  .pp14        (pp14       ),
  .pp15        (pp15       ),
  .pp16        (pp16       ),
  .pp17        (pp17       ),
  .pp18        (pp18       ),
  .pp19        (pp19       ),
  .pp20        (pp20       ),
  .pp21        (pp21       ),
  .pp22        (pp22       ),
  .pp23        (pp23       ),
  .pp24        (pp24       ),
  .pp25        (pp25       ),
  .pp26        (pp26       ),
  .pp27        (pp27       ),
  .pp28        (pp28       ),
  .pp29        (pp29       ),
  .pp30        (pp30       ),
  .pp31        (pp31       ),
  .pp32        (pp32       ),
  .pp33        (pp33       ),
  .final_p     (final_p    )
);

assign o_product = final_p;

endmodule
