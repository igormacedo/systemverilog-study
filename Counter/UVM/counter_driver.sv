class counter_driver extends uvm_driver#(counter_transaction);

    protected virtual counter_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_resource_db#(virtual counter_if)::read_by_name(.scope("ifs"), .name("counter_if"), .val(vif)))
            `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
    endfunction

    task run_phase(uvm_phase phase);
        drive();
    endtask

    task drive();
        counter_transaction c_tx;
        vif.sig_if_enable = 1'b0;
        vif.sig_if_value_in = 4'b0;
        //vif.sig_if_out = 4'b0;
        //vif.sig_if_clock = 1'b0;

        forever begin
            seq_item_port.get_next_item(c_tx);
            
            @(posedge vif.sig_if_clock);
            if (c_tx.enable) begin
                vif.sig_if_enable = c_tx.enable;
                vif.sig_if_value_in = c_tx.value_in;
            end
            //vif.sig_if_out = c_tx.out;
            seq_item_port.item_done();
        end
        
    endtask

endclass