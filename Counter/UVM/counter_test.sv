class counter_test extends uvm_test;
    `uvm_component_utils(counter_test)

    counter_environment c_env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        c_env = counter_environment::type_id::create(.name("c_env"),.parent(this));
    endfunction

    task run_phase(uvm_phase phase);
        counter_sequence c_seq;

        phase.raise_objection(.obj(this));
            c_seq = counter_sequence::type_id::create(.name("c_seq"),.parent(this));
            assert(c_seq.randomize());
            c_seq.start(c_env.c_agent.c_sequencer);
        phase.drop_objection(.obj(this));
    endtask
endclass