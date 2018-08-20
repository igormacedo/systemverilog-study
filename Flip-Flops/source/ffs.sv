module flipflopD (
    d, async_reset, clk, q
);

input d, async_reset, clk;
output reg q;

always @(posedge clk or posedge async_reset)
begin
    q <= d;
end

endmodule

module flipflopRS (
    r, s, async_reset, clk, q, q_bar
);

input r, s, async_reset, clk;
output reg q, q_bar;

always @(posedge clk or posedge async_reset)
begin
    if (s == 1 && r == 0) begin
        q <= 1;
        q_bar <= 0;
    end
    else if (r == 1 && s == 0) begin
        q <= 0;
        q_bar <= 1;
    end
    else if (r == 0 && s == 0) begin
        q <= q;
        q_bar <= q_bar;
    end
    else begin
        q <= 1'bx;
        q_bar <= 1'bx;
    end
end

endmodule

module flipflopJK (
    j, k, async_reset, clk, q, q_bar
);

input j, k, async_reset, clk;
output reg q, q_bar;

initial begin
    q=1'b0;
    q_bar=1'b1;
end

always @(posedge clk or posedge async_reset)
begin
    case({j,k})
        {1'b0,1'b0}: begin q<=q; q_bar<=q_bar; end
        {1'b0,1'b1}: begin q<=0; q_bar<=1;     end
        {1'b1,1'b0}: begin q<=1; q_bar<=0; end
        {1'b1,1'b1}: begin q<=~q; q_bar<=~q_bar; end
    endcase
end

endmodule