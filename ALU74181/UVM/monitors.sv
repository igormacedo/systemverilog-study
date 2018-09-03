class alu_monitor_output extends uvm_monitor;
    `uvm_component_utils(alu_monitor_output)

    uvm_analysis_port#(alu_transaction) mon_ap_output;

    virtual alu_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_resource_db#(virtual alu_if)::read_by_name(.scope("ifs"), .name("alu_if"), .val(vif)))
            `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
        
        mon_ap_output = new(.name("mon_ap_output"), .parent(this));
    endfunction
    
    task run_phase(uvm_phase phase);
        alu_transaction a_tx;
        a_tx = alu_transaction::type_id::create(.name("a_tx"), .contxt(get_full_name()));

        forever begin
            @(posedge vif.clock);
            a_tx.f = vif.sig_if_f;
            mon_ap_output.write(a_tx);
        end
    endtask
endclass

class alu_monitor_input extends uvm_monitor;
    `uvm_component_utils(alu_monitor_input)

    uvm_analysis_port#(alu_transaction) mon_ap_input;

    virtual alu_if vif;
    //alu_transaction a_tx_cg;

    // covergroup alu_cg;
    //     reset_cp: coverpoint a_tx_cg.reset;
    //     clock_inhibit_cp: coverpoint a_tx_cg.clock_inhibit;
    //     cross reset_cp, clock_inhibit_cp;
    // endgroup

    function new(string name, uvm_component parent);
        super.new(name, parent);
        //alu_cg = new;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_resource_db#(virtual alu_if)::read_by_name(.scope("ifs"), .name("alu_if"), .val(vif)))
            `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
        
        mon_ap_input = new(.name("mon_ap_input"), .parent(this));
    endfunction
    
    task run_phase(uvm_phase phase);
        //code here
        alu_transaction a_tx;
        a_tx = alu_transaction::type_id::create(.name("a_tx"), .contxt(get_full_name()));

        forever begin
            @(posedge vif.clock);
            a_tx.s = vif.sig_if_s;
            a_tx.a = vif.sig_if_a;
            a_tx.b = vif.sig_if_b;
            a_tx.m = vif.sig_if_m;
            a_tx.c_in = vif.sig_if_c_in;


            //a_tx_cg = a_tx;
            //alu_cg.sample();

            mon_ap_input.write(a_tx);
        end

    endtask
endclass
