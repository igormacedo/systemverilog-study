module fulladder (
    a, b, c_in,
    sum, c_out
);

input a, b, c_in;
output sum, c_out;

wire sum_hafladder1, sum_halfadder2;
wire carry_halfadder1, carry_halfadder2;

halfadder ha1 (
    .a (a),
    .b (b),
    .out (sum_hafladder1),
    .carry (carry_halfadder1)
);

halfadder ha2 (
    .a (c_in),
    .b (sum_hafladder1),
    .out (sum_halfadder2),
    .carry (carry_halfadder2)
);

assign sum = sum_halfadder2;
assign c_out = carry_halfadder1 | carry_halfadder2;

endmodule