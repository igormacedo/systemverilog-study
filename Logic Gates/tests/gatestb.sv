module gate_tb;

reg input_a, input_b;
wire out_and_sgn;
wire out_or_sgn;
wire out_xor_sgn;
wire out_nand_sgn;

initial begin
    $display ("Port Values");
    $monitor ("A=%b, B=%b, Out_and=%b, Out_or=%b, Out_xor=%b, Out_nand=%b", input_a, input_b, out_and_sgn, out_or_sgn, out_xor_sgn, out_nand_sgn);
    #0 input_a = 0;
    #0 input_b = 0;

    #5 input_a = 1;

    #10 input_b = 1;

    #15 input_a = 0;


    #15  $finish;

end

gate dut (
    .in_a (input_a),
    .in_b (input_b),
    .out_and (out_and_sgn),
    .out_or (out_or_sgn),
    .out_xor (out_xor_sgn),
    .out_nand (out_nand_sgn)
);

endmodule