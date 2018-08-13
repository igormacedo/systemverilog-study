module mux_2 (
in_a, in_b, select, out
);

input in_a;
input in_b;
input select;
output out;

wire w1, w2, w3, w4;

nand n1(w1, select, select);
nand n2(w2,select, in_a);
nand n3(w3, w1, in_b);
nand n4(out, w2, w3);

endmodule