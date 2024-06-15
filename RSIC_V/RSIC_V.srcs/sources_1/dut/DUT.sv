`timescale 1ns / 1ps


module DUT #(
    parameter data_bus = 32,
    parameter num_Imem_registers = 256,
    parameter num_regFile_registers = 32,
    parameter num_Dmem_registers = 256
) (
    input logic clock,
    input logic reset
);

    logic[6:0] op_code;
    logic [2:0] alu_op;
    logic branch_op;
    logic mem_write;
    logic mem_read;
    logic reg_write;
    logic [2:0] Imm_sel;
    logic A_sel;
    logic B_sel;
    logic [1:0] WB_sel;
    logic PC_sel;


    Datapath #(
        .data_bus(data_bus),
        .num_Imem_registers(num_Imem_registers),
        .num_regFile_registers(num_regFile_registers),
        .num_Dmem_registers(num_Dmem_registers)
    ) datapath(
        .clock(clock),
        .reset(reset),
        .alu_op(alu_op),
        .branch_op(branch_op),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .reg_write(reg_write),
        .Imm_sel(Imm_sel),
        .A_sel(A_sel),
        .B_sel(B_sel),
        .WB_sel(WB_sel),
        .PC_sel(PC_sel),

        .op_code(op_code)
    );

    ControlUnit controlUnit(
        .clock(clock),
        .reset(reset),
        .op_code(op_code),

        .alu_op(alu_op),
        .branch_op(branch_op),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .reg_write(reg_write),
        .Imm_sel(Imm_sel),
        .A_sel(A_sel),
        .B_sel(B_sel),
        .WB_sel(WB_sel),
        .PC_sel(PC_sel)
    );

endmodule