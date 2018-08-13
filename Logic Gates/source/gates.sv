module gate (
in_a    ,
in_b    ,
out_and ,
out_or  ,
out_xor ,
out_nand
);

input   in_a;
input   in_b;

output  out_and;
output  out_or;
output  out_xor;
output  out_nand;

assign out_and = in_a & in_b;
assign out_or = in_a | in_b;
assign out_xor = in_a ^ in_b;
assign out_nand = ~(in_a & in_b);


endmodule