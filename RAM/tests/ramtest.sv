module ramtb;

reg[15:0] din;
reg[7:0] addr;
reg enable, write_en, clk;
wire[15:0] dout;

ram rd(
    .data_in(din),
    .data_out(dout),
    .addr(addr),
    .clk(clk),
    .enable(enable),
    .write_en(write_en)
);

integer i;

initial begin
    din = 0;
    addr = 0;
    enable = 1;
    write_en = 1;
    clk = 0;

    for (i = 0; i < 255; i = i + 1) begin
        rd.memory[i] = i;
    end
    
end

always #1 clk <= ~clk;

initial begin
    $dumpfile("build/wave.vcd");
    $dumpvars(0, ramtb);

    for (i = 0; i < 256; i = i + 1) begin
        din <= i*2;
        addr <= i;
        if (i == 250) begin
            enable <= ~enable;
        end

        if (i == 150) begin
            write_en <= ~write_en;
        end
        #2;
    end

    $finish;
end

endmodule