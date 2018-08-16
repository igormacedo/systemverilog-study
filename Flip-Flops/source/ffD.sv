module flipflopD (
    d, async_reset, clk, out
);

input d, async_reset, clk;
output reg out;

always @(posedge clk or posedge async_reset)
begin
    out <= d;
end

endmodule