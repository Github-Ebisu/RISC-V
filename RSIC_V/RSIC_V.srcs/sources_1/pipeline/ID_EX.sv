module ID_EX #(
    parameter data_bus = 32
) (
    input logic clock, reset, enable,
    input logic [data_bus-1:0] read_data_1_in, read_data_2_in, PC_in, PC_add_4_in,
    input logic [4:0] read_reg_1_in, read_reg_2_in, Rd_in, 
    input logic [data_bus-1:0] Imm_extended_in,
    input logic [6:0] function7_in,
    input logic [2:0] function3_in,

    output logic [data_bus-1:0] read_data_1_out, read_data_2_out, PC_out, PC_add_4_out,
    output logic [4:0] read_reg_1_out, read_reg_2_out, Rd_out, 
    output logic [data_bus-1:0] Imm_extended_out,
    output logic [6:0] function7_out,
    output logic [2:0] function3_out
);

    always_ff @(posedge clock) begin
        if (enable) begin
            if (reset) begin
                read_data_1_out <= 0; 
                read_data_2_out <= 0;
                PC_out <= 0; 
                read_reg_1_out <= 0;
                read_reg_2_out <= 0;
                Rd_out <= 0;
                Imm_extended_out <= 0;
                function7_out <= 0;
                function3_out <= 0;
                PC_add_4_out <= 0;
            end
            else begin
                read_data_1_out <= read_data_1_in; 
                read_data_2_out <= read_data_2_in;
                PC_out <= PC_in;
                PC_add_4_out <= PC_add_4_in;
                read_reg_1_out <= read_reg_1_in;
                read_reg_2_out <= read_reg_2_in;
                Rd_out <= Rd_in;
                Imm_extended_out <= Imm_extended_in;
                function7_out <= function7_in;
                function3_out <= function3_in;
            end
        end

    end

endmodule