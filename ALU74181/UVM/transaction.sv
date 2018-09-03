class alu_transaction extends uvm_sequence_item;
    //inputs
    rand bit[3:0] a, b;
  	rand bit c_in;
    bit[3:0] s;
    bit m;
    
    //outputs
    bit[4:0] f;

    //`uvm_object_utils(alu_transaction)
    `uvm_object_utils_begin(alu_transaction)
        `uvm_field_int(a, UVM_ALL_ON)
        `uvm_field_int(b, UVM_ALL_ON)
        `uvm_field_int(s, UVM_ALL_ON)
        `uvm_field_int(m, UVM_ALL_ON)
        `uvm_field_int(c_in, UVM_ALL_ON)
        `uvm_field_int(f, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "alu_transaction");
        super.new(name);
    endfunction

endclass