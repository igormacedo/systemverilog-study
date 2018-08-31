class counter_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(counter_scoreboard)

    uvm_analysis_export #(counter_transaction) sb_export_output;
    uvm_analysis_export #(counter_transaction) sb_export_input;

    uvm_tlm_analysis_fifo #(counter_transaction) output_fifo;
    uvm_tlm_analysis_fifo #(counter_transaction) input_fifo;

    counter_transaction c_tx_output;
    counter_transaction c_tx_input;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        c_tx_input = new("c_tx_input");
        c_tx_output = new("c_tx_output");
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sb_export_input = new("sb_export_input", this);
        sb_export_output = new("sb_export_output", this);
        output_fifo = new("output_fifo", this);
        input_fifo = new("input_fifo", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        sb_export_input.connect(input_fifo.analysis_export);
        sb_export_output.connect(output_fifo.analysis_export);
    endfunction

    task run();
        forever begin
            output_fifo.get(c_tx_output);
            input_fifo.get(c_tx_input);
            $display("data coming to scoreboard, change to see and compare");
        end
    endtask
endclass