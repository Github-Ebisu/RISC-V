// For Stalling -> LW

module HazardUnit
(
    input logic [4:0] IF_ID_read_reg_1,
    input logic [4:0] IF_ID_read_reg_2,
    input logic [4:0] ID_EX_rd,
    input logic ID_EX_MemRead,
    input logic ID_EX_PC_sel,
    input logic Branch_sel,
    output bit stall,
    output bit flush_IF_ID,
    output bit flush_ID_EX

);
    // If Execute stage is LW
    assign stall = (ID_EX_MemRead & (!(ID_EX_PC_sel | Branch_sel))) ? ((ID_EX_rd == IF_ID_read_reg_1) || (ID_EX_rd == IF_ID_read_reg_2)) : 0;
    assign flush_IF_ID = (ID_EX_PC_sel | Branch_sel) ? 1 : 0;
    assign flush_ID_EX = stall | flush_IF_ID;
endmodule
