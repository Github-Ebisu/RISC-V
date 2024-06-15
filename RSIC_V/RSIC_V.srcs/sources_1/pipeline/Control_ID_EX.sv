module Control_ID_EX (
    input logic clock, reset,
    input logic [2:0] alu_op_in,
    input logic branch_op_in,
    input logic mem_write_in,
    input logic mem_read_in,
    input logic reg_write_in,
    input logic A_sel_in,
    input logic B_sel_in,
    input logic [1:0] WB_sel_in,
    input logic PC_sel_in,

    
    output logic [2:0] alu_op_out,
    output logic branch_op_out,
    output logic mem_write_out,
    output logic mem_read_out,
    output logic reg_write_out,
    output logic A_sel_out,
    output logic B_sel_out,
    output logic [1:0] WB_sel_out,
    output logic PC_sel_out
    );

    always_ff @( posedge clock) begin
        if (reset) begin
            alu_op_out <= 3'b000;
            branch_op_out <= 1'b0;
            mem_write_out <= 1'b0;
            mem_read_out <= 1'b0;
            reg_write_out <= 1'b0;
            A_sel_out <= 1'b0;
            B_sel_out <= 1'b0;
            WB_sel_out <= 2'b00;
            PC_sel_out <= 1'b0;
        end else begin
            alu_op_out <= alu_op_in;
            branch_op_out <= branch_op_in;
            mem_write_out <= mem_write_in;
            mem_read_out <= mem_read_in;
            reg_write_out <= reg_write_in;
            A_sel_out <= A_sel_in;
            B_sel_out <= B_sel_in;
            WB_sel_out <= WB_sel_in;
            PC_sel_out <= PC_sel_in;
        end
    end
    
endmodule
