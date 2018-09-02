class counter_environment extends uvm_env;
    `uvm_component_utils(counter_environment)

    counter_agent c_agent;
    counter_scoreboard c_scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        c_agent = counter_agent::type_id::create(.name("c_agent"),.parent(this));
        c_scoreboard = counter_scoreboard::type_id::create(.name("c_scoreboard"),.parent(this));
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        c_agent.agent_ap_output.connect(c_scoreboard.sb_export_output);
        c_agent.agent_ap_input.connect(c_scoreboard.sb_export_input);
    endfunction
endclass