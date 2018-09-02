class counter_sequence extends uvm_sequence#(counter_transaction);
    `uvm_object_utils(counter_sequence)

    function new(string name = "counter_sequence");
        super.new(name);
    endfunction

    task body();
        counter_transaction c_transaction;
        integer count = 0;
        bit wasLastEnable = 0;
 		
      
        repeat(100) begin
            c_transaction = counter_transaction::type_id::create(.name("c_transaction"), .contxt(get_full_name()));
            c_transaction.enable.rand_mode(0);
            
            if (wasLastEnable) begin
                c_transaction.enable = 0;
            end
            
            if (count%3 == 0) begin
                c_transaction.enable.rand_mode(1);
            end
            
            start_item(c_transaction);
            assert(c_transaction.randomize());
            //`uvm_info("c_transaction", c_transaction.sprint(), UVM_LOW);
            
            if (c_transaction.enable) begin
                wasLastEnable = 1;
            end
            
            finish_item(c_transaction);
            count++;
        end
    endtask
endclass