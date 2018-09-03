import uvm_pkg::*;

`include "transaction.sv"
`include "sequencer.sv"
`include "sequence.sv"
`include "monitors.sv"
`include "driver.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"
`include "alu.sv"
`include "interface.sv"

module alu_tb_top;

    alu_if vif();

    alu74181 dut(
        .s (vif.sig_if_s),
        .a (vif.sig_if_a),
        .b (vif.sig_if_b),
        .m (vif.sig_if_m),
        .c_in (vif.sig_if_c_in),
        .f (vif.sig_if_f)
    );
    
    // Initializes clock
    initial begin
        vif.clock = 1'b1;
    end

    //Generates clock
    always #1 vif.clock = ~vif.clock;

    initial begin
        $dumpfile("dump.vcd"); $dumpvars(0,dut);
        //Gets the interface form the resources db
        uvm_resource_db#(virtual alu_if)::set(.scope("ifs"), .name("alu_if"), .val(vif));
        run_test();
    end
    
endmodule