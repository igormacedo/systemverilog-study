class alu_agent extends uvm_agent;
    `uvm_component_utils(alu_agent)

    //Analysis port to connect monitor to scoreboard
    uvm_analysis_port#(alu_transaction) agent_ap_output;
    uvm_analysis_port#(alu_transaction) agent_ap_input;

    alu_sequencer a_sequencer;
    alu_driver    a_driver;
    alu_monitor_input a_mon_input;
    alu_monitor_output a_mon_output;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        agent_ap_output = new(.name("agent_ap_output"), .parent(this));
        agent_ap_input = new(.name("agent_ap_input"),.parent(this));

        a_sequencer = alu_sequencer::type_id::create(.name("a_sequencer"),.parent(this));
        a_driver = alu_driver::type_id::create(.name("a_driver"),.parent(this));
        a_mon_output = alu_monitor_output::type_id::create(.name("a_mon_output"),.parent(this));
        a_mon_input = alu_monitor_input::type_id::create(.name("a_mon_input"),.parent(this));
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        a_driver.seq_item_port.connect(a_sequencer.seq_item_export);
        a_mon_output.mon_ap_output.connect(agent_ap_output);
        a_mon_input.mon_ap_input.connect(agent_ap_input);
    endfunction
endclass
