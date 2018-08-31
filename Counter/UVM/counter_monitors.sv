class counter_monitor_output extends uvm_monitor;
    `uvm_component_utils(counter_monitor_output)

    uvm_analysis_port#(counter_transaction) mon_ap_output;

    virtual counter_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_resource_db#(virtual counter_if)::read_by_name(.scope("ifs"), .name("counter_if"), .val(vif)))
            `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
        
        mon_ap_output = new(.name("mon_ap_output"), .parent(this));
    endfunction
    
    task run_phase(uvm_phase phase);
        //code here
        counter_transaction c_tx;
        c_tx = counter_transaction::type_id::create(.name("c_tx"), .contxt(get_full_name()));

        forever begin
            @(posedge vif.sig_if_clock);
            c_tx.value_out = vif.sig_if_out;
            mon_ap_output.write(c_tx);
        end
    endtask
endclass

class counter_monitor_input extends uvm_monitor;
    `uvm_component_utils(counter_monitor_input)

    uvm_analysis_port#(counter_transaction) mon_ap_input;

    virtual counter_if vif;
    counter_transaction c_tx_cg;

    covergroup counter_cg;
        value_in_cp: coverpoint c_tx_cg.value_in;
        //cross value_in_cp;
    endgroup

    function new(string name, uvm_component parent);
        super.new(name, parent);
        counter_cg = new;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_resource_db#(virtual counter_if)::read_by_name(.scope("ifs"), .name("counter_if"), .val(vif)))
            `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
        
        mon_ap_input = new(.name("mon_ap_input"), .parent(this));
    endfunction
    
    task run_phase(uvm_phase phase);
        //code here
        counter_transaction c_tx;
        c_tx = counter_transaction::type_id::create(.name("c_tx"), .contxt(get_full_name()));

        forever begin
            @(posedge vif.sig_if_clock);
            c_tx.enable = vif.sig_if_enable;
            c_tx.value_in = vif.sig_if_value_in;

            c_tx_cg = c_tx;
            counter_cg.sample();

            mon_ap_input.write(c_tx);
        end

    endtask
endclass

