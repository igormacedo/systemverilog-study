class alu_environment extends uvm_env;
    `uvm_component_utils(alu_environment)

    alu_agent a_agent;
    alu_scoreboard a_scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        a_agent = alu_agent::type_id::create(.name("a_agent"),.parent(this));
        a_scoreboard = alu_scoreboard::type_id::create(.name("a_scoreboard"),.parent(this));
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        a_agent.agent_ap_output.connect(a_scoreboard.sb_export_output);
        a_agent.agent_ap_input.connect(a_scoreboard.sb_export_input);
    endfunction
endclass