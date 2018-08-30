// 'include "counter.sv"
// 'include "counter_if.sv"

module counter_tb_top;
    import uvm_pkg::*;

    counter_if vif();

    counter4bit dut(
        .clk (vif.sig_if_clock),
        .enable (vif.sig_if_enable),
        .value_in (vif.sig_if_value_in),
        .out (vif.sig_if_out)
    );
    
    // Initializes clock
    initial begin
        vif.sig_if_clock = 1'b1;
    end

    //Generates clock
    always #1 vif.sig_if_clock = ~vif.sig_if_clock;

    initial begin
        $dumpfile("dump.vcd"); $dumpvars;
        //Gets the interface form the resources db
        uvm_resource_db#(virtual counter_if)::set(.scope("ifs"), .name("counter_if"), .val(vif));
        run_test();
    end
    
endmodule