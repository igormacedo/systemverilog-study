module ff_tb;

reg q, bq, clk, reset;
wire out, bout;

flipflopD ffd(
    .d (q),
    .async_reset (reset),
    .clk (clk),
    .out (out)
);

integer i;

initial begin
    $dumpfile("build/wave.vcd");
    $dumpvars(0, ff_tb);
    $display("Testing flip flop D");
    $display("d\tclock\treset\tout");
    $monitor("%b\t%b\t%b\t%b",q,clk,reset,out);

    q = 0;
    reset = 0;
    clk = 1;
    #1;

    $finish;
end

endmodule