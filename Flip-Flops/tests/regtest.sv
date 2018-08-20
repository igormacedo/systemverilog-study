module reg_tb;

reg clk, reset;
reg[7:0] inp;
wire[7:0] out;

reg8bit regis(
    .inp (inp),
    .clk (clk),
    .reset (reset),
    .outp (out)
);

integer i;

initial begin
    $dumpfile("build/wave.vcd");
    $dumpvars(0, reg_tb);
    $display("Input\tClock\tReset\tOutput");
    $monitor("%d\t%b\t%b\t%d",inp,clk,reset,out);

    reset = 0;
    clk = 0;

    for (i = 0; i < 256; i = i + 1) begin
        inp <= i;
        clk <= ~clk;
        #1;
        clk <= ~clk;
        #1;
    end

    $finish;
end

endmodule