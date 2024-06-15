// For Forwarding 

module ForwardingUnit
(
    input logic [4:0] ID_EX_read_reg_1,
    input logic [4:0] ID_EX_read_reg_2,
    input logic [4:0] MEM_WB_rd,
    input logic [4:0] EX_MEM_rd,
    input logic mem_write_EX_MEM,
    input logic EX_MEM_reg_write,
    input logic MEM_WB_reg_write,

    output logic [1:0] Forward_A,
    output logic [1:0] Forward_B
);

    always_comb begin
        // Forward from EX/MEM stage 
        if ((EX_MEM_reg_write) && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_read_reg_1))
            Forward_A = 2'b10;
        // Forward from MEM/WB stage 
        else if ((MEM_WB_reg_write) && (MEM_WB_rd != 0) && (MEM_WB_rd == ID_EX_read_reg_1))
            Forward_A = 2'b01;
        else
            Forward_A = 2'b00;
    end

    always_comb begin
        // Forward from EX/MEM stage 
        if ((EX_MEM_reg_write) && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_read_reg_2))
            Forward_B = 2'b10;
        // Forward from MEM/WB stage 
        else if ((MEM_WB_reg_write) && (MEM_WB_rd != 0) && (MEM_WB_rd == ID_EX_read_reg_2))
            Forward_B = 2'b01;
        else
            Forward_B = 2'b00;
    end

endmodule
