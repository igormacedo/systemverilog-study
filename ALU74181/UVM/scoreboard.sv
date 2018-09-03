class alu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(alu_scoreboard)

    uvm_analysis_export #(alu_transaction) sb_export_output;
    uvm_analysis_export #(alu_transaction) sb_export_input;

    uvm_tlm_analysis_fifo #(alu_transaction) output_fifo;
    uvm_tlm_analysis_fifo #(alu_transaction) input_fifo;

    alu_transaction a_tx_output;
    alu_transaction a_tx_input;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        a_tx_input = new("a_tx_input");
        a_tx_output = new("a_tx_output");
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

        $display("======================= COMPARISON =====================\n");
      `uvm_info("PACKET_COMP","\t\tm\ts\ta\tb\tc\tf\n", UVM_LOW)
      
        forever begin
            output_fifo.get(a_tx_output);
            input_fifo.get(a_tx_input);

          `uvm_info("PACKET_COMP", $sformatf("\t\t%b\t%b\t%b(%d)\t%b(%d)\t%b\t%b(%d)\n",a_tx_input.m, a_tx_input.s, a_tx_input.a, a_tx_input.a, a_tx_input.b, a_tx_input.b, a_tx_input.c_in, a_tx_output.f, a_tx_output.f), UVM_LOW)
        end
    endtask
endclass