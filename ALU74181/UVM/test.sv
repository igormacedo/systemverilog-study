class alu_test extends uvm_test;
    `uvm_component_utils(alu_test)

    alu_environment a_env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        a_env = alu_environment::type_id::create(.name("a_env"),.parent(this));
    endfunction

    task run_phase(uvm_phase phase);
        alu_sequence a_seq;

        phase.raise_objection(.obj(this));
            a_seq = alu_sequence::type_id::create(.name("a_seq"),.parent(this));
            assert(a_seq.randomize());
            a_seq.start(a_env.a_agent.a_sequencer);
        phase.drop_objection(.obj(this));
    endtask
endclass