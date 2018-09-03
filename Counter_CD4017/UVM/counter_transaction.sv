class counter_transaction extends uvm_sequence_item;
    rand bit reset;
    rand bit clock_inhibit;
    
    bit carry_out;
    bit[9:0] number_bit;

    //`uvm_object_utils(counter_transaction)
    `uvm_object_utils_begin(counter_transaction)
        `uvm_field_int(reset, UVM_ALL_ON)
        `uvm_field_int(clock_inhibit, UVM_ALL_ON)
        `uvm_field_int(carry_out, UVM_ALL_ON)
        `uvm_field_int(number_bit, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "counter_transaction");
        super.new(name);
    endfunction

    constraint rst_constraint { 
        reset dist { 0 := 9, 1 := 1};
    }; 

    constraint clock_constraint { 
        clock_inhibit dist { 0 := 9, 1 := 1};
     };
endclass