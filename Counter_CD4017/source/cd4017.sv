module cd4017(
    input logic clock,
    input logic reset,
    input logic clock_inhibit,
    output logic [9:0] number_bit,
    output logic carry_out
);

always_ff @(posedge clock) begin
    priority if (reset) begin
        number_bit <= 10'b0000000001;
    end else if (clock_inhibit) begin
        number_bit <= number_bit;
    end else begin
        number_bit <= number_bit << 1; 
    end

    if (number_bit[4:0]) begin
        carry_out <= 1;
    end else begin
        carry_out <= 0;
    end
end
endmodule