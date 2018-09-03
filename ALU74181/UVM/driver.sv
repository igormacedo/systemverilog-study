class alu_driver extends uvm_driver#(alu_transaction);
    `uvm_component_utils(alu_driver)

    protected virtual alu_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_resource_db#(virtual alu_if)::read_by_name(.scope("ifs"), .name("alu_if"), .val(vif)))
            `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
    endfunction

    task run_phase(uvm_phase phase);
        drive();
    endtask

    task drive();
        alu_transaction a_tx;
        vif.sig_if_a = '0;
        vif.sig_if_b = '0;
        vif.sig_if_s = '0;
        vif.sig_if_m = '0;
        vif.sig_if_c_in = '0;

        forever begin
            seq_item_port.get_next_item(a_tx);

            @(posedge vif.clock);
            vif.sig_if_a = a_tx.a;
            vif.sig_if_b = a_tx.b;
            vif.sig_if_s = a_tx.s;
            vif.sig_if_m = a_tx.m;
            vif.sig_if_c_in = a_tx.c_in;
            seq_item_port.item_done();
        end
    endtask
endclass