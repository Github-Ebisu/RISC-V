module Mux3 #(
    parameter data_bus = 32
) (
    input  logic [1:0] select,
    input  logic [data_bus-1:0] In0,
    input  logic [data_bus-1:0] In1,
    input  logic [data_bus-1:0] In2,
    output logic [data_bus-1:0] DataOut
);
	always_comb begin
        case (select)
            2'b00: DataOut <= In0;
            2'b01: DataOut <= In1;
            2'b10: DataOut <= In2;
            default: begin
                DataOut <= 32'hX;
            end
        endcase
	end
endmodule