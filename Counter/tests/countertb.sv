`timescale 1ns/1ns

module counter_tb;

logic clk, enable;
logic[3:0] inp, out;

counter4bit dut(
    .clk (clk),
    .enable (enable),
    .value_in (inp),
    .out (out)
);

initial begin
    enable = '0;
    clk = 0;
    #10;
    enable = '1; 
    inp = 4'b0010;
    #2; 
    enable = '0;
end

always #1 clk <= ~clk;

endmodule
