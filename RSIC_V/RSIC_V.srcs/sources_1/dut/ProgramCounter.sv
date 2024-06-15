module ProgramCounter #(
    parameter data_bus = 32
) (
    input logic clock,
    input logic reset,
    input logic enable,
    input logic test_reset,
    input logic [data_bus-1:0] PC_in,
    output logic [data_bus-1:0] PC_out
);
    always_ff @(posedge clock) begin//
        if (enable) begin
            if (reset == 1'b1) begin
                PC_out <= 32'h0;
            end 
            else if (test_reset == 1'b1) begin
                PC_out <= 32'h0;
            end 
            else begin
                PC_out <= PC_in;
            end
        end
    end
endmodule