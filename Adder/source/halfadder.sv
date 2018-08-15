module halfadder (
    a, b,
    out, carry
);

input a;
input b;
output out;
output carry;

assign out = a ^ b;
assign carry = a & b;

endmodule