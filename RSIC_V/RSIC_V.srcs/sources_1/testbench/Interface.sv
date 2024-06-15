`ifndef GUARD_INTERFACE
`define GUARD_INTERFACE


////////////////////////////////////////////
// Interface for the input side of switch.//
// Reset signal is also passed hear. //
////////////////////////////////////////////
interface input_interface(input bit clock);
    
    logic reset;
    logic [31:0] addr;
    logic [31:0] data;


    clocking cb@(posedge clock);
        // default input #1ns output #1ns;
        
        output reset;
        output addr;
        output data;

    endclocking

    modport IP(clocking cb, output reset, input clock);

endinterface

/////////////////////////////////////////////////
// Interface for the output side of the switch.//
// output_interface is for only one output port//
/////////////////////////////////////////////////

interface output_interface(input bit clock);
    


    clocking cb@(posedge clock);
        // default input #1 output #1;

    endclocking

    modport OP(clocking cb,input clock);

endinterface


//////////////////////////////////////////////////

`endif