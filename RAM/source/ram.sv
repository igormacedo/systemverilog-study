module ram(
    data_in,
    data_out,
    addr,
    enable,
    clk,
    write_en
);

input enable, write_en, clk;
input[15:0] data_in;
input[7:0] addr;
output reg[15:0] data_out;

reg[15:0] memory[0:255];

always @(posedge clk) begin
    if (enable == 1) begin
        if (write_en == 1) begin
            memory[addr] <= data_in;
            data_out <= data_in;
        end else begin
            data_out <= memory[addr];
        end
    end else begin
        data_out <= 15'bz;
    end
end

endmodule