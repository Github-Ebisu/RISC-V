module IF_ID #(
    parameter data_bus = 32
) (
    input logic clock,
    input logic reset,
    input logic enable,

    input logic [data_bus-1:0] PC_in,
    input logic [data_bus-1:0] PC_add_4_in,
    input logic [data_bus-1:0] Instruction_in,

    output logic [data_bus-1:0] Instruction_out,
    output logic [data_bus-1:0] PC_out,
    output logic [data_bus-1:0] PC_add_4_out

);

    always_ff @( posedge clock) begin
        if (enable) begin 
            if (reset) begin // Synchrnous Clear
                Instruction_out <= 0;
                PC_out <= 0;
                PC_add_4_out <= 0 ;
            end
            
            else begin	 
                Instruction_out <= Instruction_in;
                PC_out <= PC_in;
                PC_add_4_out <= PC_add_4_in;
            end
        end
    end
endmodule