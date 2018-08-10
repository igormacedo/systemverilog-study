module and_gate (
in_a    ,
in_b    ,
out
);

input   in_a;
input   in_b;

output  out;

assign out = in_a & in_b;

endmodule