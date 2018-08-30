class counter_transaction extends uvm_sequence_item;
    rand bit[3:0] value_in;
    rand bit enable;
    bit[3:0] value_out;

    //`uvm_object_utils(counter_transaction)
    `uvm_object_utils_begin(counter_transaction)
        `uvm_field_int(value_in, UVM_ALL_ON)
        `uvm_field_int(value_out, UVM_ALL_ON)
        `uvm_field_int(enable, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "counter_transaction");
        super.new(name);
    endfunction

    //There is no constraint for this sequence_item
endclass