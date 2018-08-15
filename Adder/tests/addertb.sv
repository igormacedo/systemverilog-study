module adder_tb;

reg[1:0] inp_ha, inp_a;
reg c_in;
wire sum_ha, sum_a, carry_ha, carry_a;

reg[3:0] inpA_4bitfa, inpB_4bitfa;
wire[3:0] sum_4bitfa;
wire carry_out_4bitfa;
wire[4:0] total_sum_debug;

halfadder dut1 (
    .a (inp_ha[0]),
    .b (inp_ha[1]),
    .out (sum_ha),
    .carry (carry_ha)
);

fulladder dut2 (
    .a (inp_a[0]),
    .b (inp_a[1]),
    .c_in (c_in),
    .sum (sum_a),
    .c_out (carry_a)
);

fulladder4bit dut3 (
    .a (inpA_4bitfa),
    .b (inpB_4bitfa),
    .c_in (c_in),
    .sum (sum_4bitfa),
    .c_out (carry_out_4bitfa)
);

integer i;
integer f;

assign total_sum_debug = {carry_out_4bitfa, sum_4bitfa};

initial
begin
    $dumpfile("build/wave.vcd");
    $dumpvars(0, adder_tb);
    $display("Half-adder test");
    $display("A\tB\tSum\tCarry_out");
    $monitor("%b\t%b\t%b\t%b", inp_ha[0], inp_ha[1], sum_ha, carry_ha);

    for (i = 0; i <= 3; i = i + 1)
    begin
        inp_ha = i; #1;
    end

    $display("\n\nFull-adder test");
    $display("A\tB\tc_in\tSum\tc_out");
    $monitor("%b\t%b\t%b\t%b\t%b", inp_a[0], inp_a[1], c_in, sum_a, carry_a);

    for (i = 0; i <= 3; i = i + 1)
    begin
        inp_a = i; 
        c_in = 0; #1;
        c_in = 1; #1;
    end

    $display("\n\n4bit Full-adder test");
    $display("A\tB\tc_in\tSum\tc_out");
    $monitor("%d\t%d\t%b\t%d", inpA_4bitfa, inpB_4bitfa, c_in, total_sum_debug);

    for (i = 0; i <= 15; i = i + 1)
    begin
        for (f = 0; f <= 15; f = f + 1)
        begin
            inpA_4bitfa = i;
            inpB_4bitfa = f; 
            c_in = 0; #1;
            c_in = 1; #1;
        end
    end

    $finish;
end

endmodule