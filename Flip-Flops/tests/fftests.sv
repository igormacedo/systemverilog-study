module ff_tb;

reg in1, in2, clk, reset;
wire q, q_bar;

flipflopD ffd(
    .d (in1),
    .async_reset (reset),
    .clk (clk),
    .q (q)
);

flipflopRS ffrs(
    .s (in1),
    .r (in2),
    .async_reset (reset),
    .clk (clk),
    .q (q),
    .q_bar (q_bar)
);

flipflopJK ffjk(
    .j (in1),
    .k (in2),
    .async_reset (reset),
    .clk (clk),
    .q (q),
    .q_bar (q_bar)
);


initial begin
in1 = 0;
in2 = 1;
reset = 0;
clk = 0;
end

always #3 clk=~clk;
always #5 in1=~in1;
always #10 in2=~in2;

initial begin
    $dumpfile("build/wave.vcd");
    $dumpvars(0, ff_tb);
    $display("Testing flip flop D");
    $display("d\tclock\treset\tout");
    $monitor("%b\t%b\t%b\t%b",in1,clk,reset,q);
    #100 

    $display("Testing flip flop R-S");
    $display("d\tclock\treset\tout");
    $monitor("%b\t%b\t%b\t%b\t%b\t%b",in1,in2,clk,reset,q,q_bar);
    #100

    $display("Testing flip flop JK");
    $display("d\tclock\treset\tout");
    $monitor("%b\t%b\t%b\t%b\t%b\t%b",in1,in2,clk,reset,q,q_bar);
    #100
    
    $finish;
end

endmodule