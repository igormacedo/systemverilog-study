module and_gate_tb;

reg input_a, input_b;
wire out_sgn;

initial begin
    $display ("Port Values");
    $monitor ("A=%b, B=%b, Out=%b", input_a, input_b, out_sgn);
    #0 input_a = 0;
    #0 input_b = 0;

    #5 input_a = 1;

    #10 input_b = 1;

    #15 input_a = 0;


    #15  $finish;

end

and_gate dut (
    .in_a (input_a),
    .in_b (input_b),
    .out (out_sgn)
);

endmodule