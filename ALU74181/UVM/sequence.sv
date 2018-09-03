class alu_sequence extends uvm_sequence#(alu_transaction);
    `uvm_object_utils(alu_sequence)

    function new(string name = "alu_sequence");
        super.new(name);
    endfunction

    task body();
        alu_transaction a_transaction;

        integer s;
        bit m = 0;
        repeat (2) begin
            m = ~m;
            
            for ( s = 0; s <16; s++) begin
                a_transaction = alu_transaction::type_id::create(.name("a_transaction"), .contxt(get_full_name()));

                repeat(10) begin
                    start_item(a_transaction);
                    assert(a_transaction.randomize());
                    a_transaction.s = s;
                    a_transaction.m = m;
                    finish_item(a_transaction);
                end
            end
        end

    endtask
endclass