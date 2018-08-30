module counter4bit(
    input logic clk,
    input logic[3:0] value_in,
    input logic enable,
    output logic[3:0] out);

var logic[3:0] counter;

always_ff @(posedge clk) begin
    if (enable) begin
        counter <= value_in;
    end else begin
        counter <= counter + 1;
    end
end

assign out = counter;

endmodule
