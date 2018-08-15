module fulladder4bit (
    a, b, c_in,
    sum, c_out
);

input[3:0] a, b;
input c_in;
output[3:0] sum;
output c_out;

wire[3:0] sum_hafladder1;
wire[3:0] carry_out_halfadder1, carry_out_halfadder2;
wire[3:0] carry_in_halfadder2;

assign carry_in_halfadder2[0] = c_in;

genvar i;
generate
for (i = 0; i <= 3; i = i + 1)
begin

    halfadder ha1 (
        .a (a[i]),
        .b (b[i]),
        .out (sum_hafladder1[i]),
        .carry (carry_out_halfadder1[i])
    );

    halfadder ha2 (
        .a (carry_in_halfadder2[i]),
        .b (sum_hafladder1[i]),
        .out (sum[i]),
        .carry (carry_out_halfadder2[i])
    );

    //assign sum = sum_halfadder2;
    if (i < 3) begin
        assign carry_in_halfadder2[i+1] = carry_out_halfadder1[i] | carry_out_halfadder2[i];
    end
end
endgenerate

assign c_out = carry_out_halfadder1[3] | carry_out_halfadder2[3];

endmodule