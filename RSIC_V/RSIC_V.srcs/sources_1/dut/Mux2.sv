module Mux2 #(
    parameter data_bus = 32
) (
    input logic select,
    input logic [data_bus-1:0] In0,
    input logic [data_bus-1:0] In1,
    output logic [data_bus-1:0] DataOut
);
	always_comb begin
		if (select) DataOut <= In1;
		else DataOut <= In0;
	end
endmodule