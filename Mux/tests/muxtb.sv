module mux_2_tb;

reg[1:0] inp;
reg sel;
wire out_sgn;

integer  i;

mux_2 dut (
    .in_a (inp[0]),
    .in_b (inp[1]),
    .select (sel),
    .out (out_sgn)
);

initial 
begin
    $dumpfile("build/wave.vcd");
    $dumpvars(0, mux_2_tb);
    $display ("input1\tinput2\tselect\tout");
    $monitor ("%b\t%b\t%b\t%b", inp[0], inp[1], sel, out_sgn);
    
    for( i = 0; i <= 3; i = i + 1)
    begin
      inp = i;
      sel = 0;  #1;
      sel = 1;  #1;
      $display("-----------------------------------------");
    end

    #12; 
    inp[0] = 0;
    sel = 1;
    #8;

    $finish;
end
endmodule