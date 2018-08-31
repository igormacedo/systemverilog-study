class counter_agent extends uvm_agent;
    `uvm_component_utisl(counter_agent);

    //Analysis port to connect monitor to scoreboard
    uvm_analysis_port#(counter_transaction) agent_ap_output;
    uvm_analysis_port#(counter_transaction) agent_ap_input;

    counter_sequencer c_sequencer;
    counter_driver    c_driver;
    counter_monitor_input c_mon_input;
    counter_monitor_output c_mon_output;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        agent_ap_output = new(.name("agent_ap_output"), .parent(this));
        agent_ap_input = new(.name("agent_ap_input"),.parent(this));

        c_sequencer = counter_sequencer::type_id::create(.name("c_sequencer"),.parent(this));
        c_driver = counter_driver::type_id::create(.name("c_driver"),.parent(this));
        c_mon_output = counter_monitor_output::type_id::create(.name("c_mon_output"),.parent(this));
        c_mon_input = counter_monitor_input::type_id::create(.name("c_mon_input"),.parent(this));
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        c_driver.seq_item_port.connect(c_sequencer.seq_item_port);
        c_mon_output.mon_ap_output.connect(agent_ap_output);
        c_mon_input.mon_ap_input.connect(agent_ap_input);
    endfunction
endclass

    