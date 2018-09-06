typedef enum {  Q_BIT   = 0,
                D_BIT   = 1,
                N_BIT   = 2 } coin_bit;

typedef enum logic [2:0] {  QUARTER = 3'b001 << Q_BIT,
                            DIME    = 3'b001 << D_BIT,
                            NICKEL  = 3'b001 << N_BIT} coin_sensor; 

module sodamachine(
    input   logic       clock, reset,
    input   coin_sensor sensor,
    input   logic       button_press,
    output  logic       release_soda,
    output  logic[2:0]  change    
);

enum {  zero_BIT    = 0,
        total5_BIT  = 1,
        total10_BIT = 2,
        total15_BIT = 3,
        total20_BIT = 4,
        total25_BIT = 5,
        total30_BIT = 6,
        total35_BIT = 7,
        total40_BIT = 8,
        total45_BIT = 9,
        total50_BIT = 10 } state_bit ;

enum logic[10:0] {  ZERO_CENTS          = 11'b00000000001 << zero_BIT,
                    FIVE_CENTS          = 11'b00000000001  << total5_BIT,
                    TEN_CENTS           = 11'b00000000001  << total10_BIT,
                    FIFTEEN_CENTS       = 11'b00000000001  << total15_BIT,
                    TWENTY_CENTS        = 11'b00000000001  << total20_BIT,
                    TWENTYFIVE_CENTS    = 11'b00000000001  << total25_BIT,
                    THIRTY_CENTS        = 11'b00000000001  << total30_BIT,
                    THIRTYFIVE_CENTS    = 11'b00000000001  << total35_BIT,
                    FOURTY_CENTS        = 11'b00000000001  << total40_BIT,
                    FOURTYFIVE_CENTS    = 11'b00000000001  << total45_BIT,
                    FIFTY_CENTS         = 11'b00000000001  << total50_BIT }  state, next;

always_ff @(posedge clock, posedge reset) begin
    if (reset)  state <= ZERO_CENTS;
    else        state <= next;
end

always_comb begin: set_next_state
    next = state;
    unique case (1'b1)
        state[zero_BIT]: begin      if (sensor[Q_BIT]) next = TWENTYFIVE_CENTS;
                                    if (sensor[D_BIT]) next = TEN_CENTS;
                                    if (sensor[N_BIT]) next = FIVE_CENTS;
        end

        state[total5_BIT]: begin    if (sensor[Q_BIT]) next = THIRTY_CENTS;
                                    if (sensor[D_BIT]) next = FIFTEEN_CENTS;
                                    if (sensor[N_BIT]) next = TEN_CENTS;
        end

        state[total10_BIT]: begin   if (sensor[Q_BIT]) next = THIRTYFIVE_CENTS;
                                    if (sensor[D_BIT]) next = TWENTY_CENTS;
                                    if (sensor[N_BIT]) next = FIFTEEN_CENTS;
        end
        
        state[total15_BIT]: begin   if (sensor[Q_BIT]) next = FOURTY_CENTS;
                                    if (sensor[D_BIT]) next = TWENTYFIVE_CENTS;
                                    if (sensor[N_BIT]) next = TWENTY_CENTS;
        end
        
        state[total20_BIT]: begin   if (sensor[Q_BIT]) next = FOURTYFIVE_CENTS;
                                    if (sensor[D_BIT]) next = THIRTY_CENTS;
                                    if (sensor[N_BIT]) next = TWENTYFIVE_CENTS;
        end
        
        state[total25_BIT]: begin   if (sensor[Q_BIT]) next = FIFTY_CENTS;
                                    if (sensor[D_BIT]) next = THIRTYFIVE_CENTS;
                                    if (sensor[N_BIT]) next = THIRTY_CENTS;
        end

        state[total30_BIT]: if (button_press)   next = ZERO_CENTS;
        
        state[total35_BIT]: if (button_press)   next = ZERO_CENTS;
        
        state[total40_BIT]: if (button_press)   next = ZERO_CENTS;
        
        state[total45_BIT]: if (button_press)   next = ZERO_CENTS;
        
        state[total50_BIT]: if (button_press)   next = ZERO_CENTS;
    endcase
end: set_next_state

always_comb begin: set_outputs
    {release_soda, change} = 4'b0000;
    unique case (1'b1)
        state[zero_BIT]: begin release_soda = 0; change = 0; end
        state[total5_BIT]: begin release_soda = 0; change = 0; end
        state[total10_BIT]: begin release_soda = 0; change = 0; end
        state[total15_BIT]: begin release_soda = 0; change = 0; end
        state[total20_BIT]: begin release_soda = 0; change = 0; end
        state[total25_BIT]: begin release_soda = 0; change = 0; end
        state[total30_BIT]: begin release_soda = 1; change = 0; end
        state[total35_BIT]: begin release_soda = 1; change = 3'b001; end
        state[total40_BIT]: begin release_soda = 1; change = 3'b010; end
        state[total45_BIT]: begin release_soda = 1; change = 3'b011; end
        state[total50_BIT]: begin release_soda = 1; change = 3'b100; end
    endcase
end : set_outputs

endmodule