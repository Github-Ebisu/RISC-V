module MEM_WB #(
    parameter data_bus = 32
) (
    input logic clock,
    input logic reset,
    input logic [data_bus-1:0] read_data_in,
    input logic [data_bus-1:0] ALU_result_in,
    input logic [4:0] Rd_in,
    input logic [data_bus-1:0] PC_add_4_in,

    output logic [data_bus-1:0] read_data_out,
    output logic [data_bus-1:0] ALU_result_out,
    output logic [4:0] Rd_out,
    output logic [data_bus-1:0] PC_add_4_out
);

    always_ff @(posedge clock) begin
        if (reset) begin
            read_data_out <= 0;
            ALU_result_out <= 0;
            Rd_out <= 0;
            PC_add_4_out <= 0;
        end else begin
            read_data_out <= read_data_in;
            ALU_result_out <= ALU_result_in;
            Rd_out <= Rd_in;
            PC_add_4_out <= PC_add_4_in;
        end
    end

endmodule
