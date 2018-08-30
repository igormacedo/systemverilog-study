class counter_sequence extends uvm_sequence#(counter_transaction);
    `uvm_sequence_utils(counter_sequence, counter_sequencer)

    function new(string name = "counter_sequence");
        super.new(name);
    endfunction

    task body();
        counter_transaction c_transaction;
        repeat(15) begin
            c_transaction = counter_transaction::type_id::create(.name("c_transaction"), .contxt(get_full_name()));

            start_item(c_transaction);
            assert(c_transaction.randomize());
            //`uvm_info("c_transaction", c_transaction.sprint(), UVM_LOW);
            finish_item(c_transaction);
        end
    endtask
endclass