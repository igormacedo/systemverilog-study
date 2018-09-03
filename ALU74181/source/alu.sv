module alu74181(
    input logic[3:0] s,
    input logic[3:0] a,
    input logic[3:0] b,
    input logic m, c_in,
    output logic[4:0] f
);

always_comb begin
    if (m) begin
        case (s)
            4'b0000 : f = ~a;
            4'b0001 : f = ~(a + b);
            4'b0010 : f = ~a & b;
            4'b0011 : f = '0;
            4'b0100 : f = ~(a & b);
            4'b0101 : f = ~b;
            4'b0110 : f = a ^ b;
            4'b0111 : f = a & ~b;
            4'b1000 : f = ~a + b;
            4'b1001 : f = ~(a ^ b);
            4'b1010 : f = b;
            4'b1011 : f = a & b;
            4'b1100 : f = 1;
            4'b1101 : f = a + ~b;
            4'b1110 : f = a + b;
            4'b1111 : f = a;
            default : f = '0;
        endcase
    end else begin
        case (s)
            4'b0000 : f = a + c_in;
            4'b0001 : f = a + b + c_in;
            4'b0010 : f = a + ~b + c_in;
            4'b0011 : f = -1 + c_in;
            4'b0100 : f = a + (a & ~b) + c_in;
            4'b0101 : f = (a + b) + (a & ~b) + c_in;
            4'b0110 : f = a - b - 1 + c_in;
            4'b0111 : f = (a & ~b) - 1 + c_in;
            4'b1000 : f = a + (a & b) + c_in;
            4'b1001 : f = a + b + c_in;
            4'b1010 : f = (a + ~b) + (a & b) + c_in;
            4'b1011 : f = (a & b) - 1 + c_in;
            4'b1100 : f = a + ( a << 1) + c_in;
            4'b1101 : f = (a + b) + a + c_in;
            4'b1110 : f = (a + ~b) + a + c_in;
            4'b1111 : f = a - 1 + c_in;
            default : f = '0;
        endcase
    end
end
endmodule