module counter4bit(
    input logic clk,
    input logic[3:0] value_in,
    input logic enable,
    output logic[3:0] out);

    always_ff @(posedge clk) begin
        if (enable) begin
            out = value_in;
        end else begin
            out = out + 1;
        end
    end

endmodule
