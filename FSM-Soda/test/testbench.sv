// Code your testbench here
// or browse Examples

//`include "design.sv"

module dut_tb;

  logic clock, reset, button_press;
  coin_sensor sensor;
  logic release_soda;
  logic[2:0] change;
  
  sodamachine dut(
    .clock(clock),
    .reset(reset),
    .sensor(sensor),
    .button_press(button_press),
    .release_soda(release_soda),
    .change(change)
  );
  
  initial begin
  	clock = 0;
  end
  
  always #1 clock = ~clock;
  
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, dut_tb);
    
    #1; reset = 1; #1; reset = 0;
    
    #2; sensor = QUARTER;
    #2; sensor = QUARTER;
    
    #2 button_press = 1;
    
    #2;
    
    $finish;
  end
  
endmodule
