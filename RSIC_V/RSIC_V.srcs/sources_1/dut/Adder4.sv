module Adder4 #(
    parameter data_bus = 32
) (
    input logic [data_bus-1:0] data_in, 
    output logic [data_bus-1:0] data_out);
    assign data_out = data_in + 4;
endmodule