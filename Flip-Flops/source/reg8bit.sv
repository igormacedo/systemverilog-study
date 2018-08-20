module reg8bit (
    inp, clk, outp, reset
);

input clk, reset;
input[7:0] inp;
output[7:0] outp;


genvar i;
generate
    for(i = 0; i < 8; i = i + 1) begin
        flipflopD ffd(
            .d (inp[i]),
            .clk (clk),
            .q (outp[i]),
            .async_reset (reset)
        );
    end
endgenerate

endmodule