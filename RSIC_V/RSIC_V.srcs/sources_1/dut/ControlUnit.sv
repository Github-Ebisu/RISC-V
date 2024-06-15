module ControlUnit (
    input logic clock,
    input logic reset,
    input logic[6:0] op_code,

    output logic [2:0] alu_op,
    output logic branch_op,
    output logic mem_write,
    output logic mem_read,
    output logic reg_write,

    output logic [2:0] Imm_sel,
    output logic A_sel,
    output logic B_sel,
    output logic [1:0] WB_sel,
    output logic PC_sel
);
    
    // Opcode
    localparam  IDLE    = 7'b000_0000,
                R_TYPE  = 7'b011_0011,
                I_TYPE  = 7'b001_0011,   
                LW      = 7'b000_0011,  
                SW      = 7'b010_0011, 
                B_TYPE  = 7'b110_0011,
                JAL     = 7'b110_1111,
                JALR    = 7'b110_0111,
                LUI     = 7'b011_0111, 
                AUIPC   = 7'b001_0111;

    // Reset
    always_ff @(posedge clock) begin
        if (reset == 1'b1) begin
                alu_op <= 3'b000;
                branch_op <= 1'b0;
                mem_write <= 1'b0;
                mem_read <= 1'b0;
                reg_write <= 1'b0;
                A_sel <= 1'b0;
                B_sel <= 1'b0;
                Imm_sel <= 3'bXXX;
                WB_sel <= 2'bXX;
                PC_sel <= 1'b0;
        end
    end

    // Logic circuit for output    
    always_comb begin
        case (op_code)
            IDLE: begin
                alu_op <= 3'b000;
                branch_op <= 1'b0;
                mem_write <= 1'b0;
                mem_read <= 1'b0;
                reg_write <= 1'b0;
                A_sel <= 1'b0;
                B_sel <= 1'b0;
                Imm_sel <= 3'bXXX;
                WB_sel <= 2'bXX;
                PC_sel <= 1'b0;
            end    

            R_TYPE: begin
                alu_op <= 3'b001;
                branch_op <= 1'b0;
                mem_write <= 1'b0;
                mem_read <= 1'b0;
                reg_write <= 1'b1;
                A_sel <= 1'b0;
                B_sel <= 1'b0;
                Imm_sel <= 3'bXXX;
                WB_sel <= 2'b01;
                PC_sel <= 1'b0;
            end

            I_TYPE: begin
                alu_op <= 3'b010;
                branch_op <= 1'b0;
                mem_write <= 1'b0;
                mem_read <= 1'b0;
                reg_write <= 1'b1;
                A_sel <= 1'b0;
                B_sel <= 1'b1;
                Imm_sel <= 3'b000;
                WB_sel <= 2'b01;
                PC_sel <= 1'b0;
            end
            
            LW: begin
                alu_op <= 3'b011;
                branch_op <= 1'b0;
                mem_write <= 1'b0;
                mem_read <= 1'b1;
                reg_write <= 1'b1;
                A_sel <= 1'b0;
                B_sel <= 1'b1;
                Imm_sel <= 3'b000;
                WB_sel <= 2'b00;
                PC_sel <= 1'b0;
            end

            SW: begin
                alu_op <= 3'b011;
                branch_op <= 1'b0;
                mem_write <= 1'b1;
                mem_read <= 1'b0;
                reg_write <= 1'b0;
                A_sel <= 1'b0;
                B_sel <= 1'b1;
                Imm_sel <= 3'b001;
                WB_sel <= 2'bXX;
                PC_sel <= 1'b0;
            end

            B_TYPE: begin
                alu_op <= 3'b100;
                branch_op <= 1'b1;
                mem_write <= 1'b0;
                mem_read <= 1'b0;
                reg_write <= 1'b0;
                A_sel <= 1'b1;
                B_sel <= 1'b1;
                Imm_sel <= 3'b010;
                WB_sel <= 2'bXX;
                PC_sel <= 1'b0;
            end

            JAL: begin
                alu_op <= 3'b101;
                branch_op <= 1'b0;  
                mem_write <= 1'b0;
                mem_read <= 1'b1;
                reg_write <= 1'b1;
                A_sel <= 1'b1;
                B_sel <= 1'b1;
                Imm_sel <= 3'b011; 
                WB_sel <= 2'b10;
                PC_sel <= 1'b1;  
            end

            JALR: begin
                alu_op <= 3'b101;
                branch_op <= 1'b0;  
                mem_write <= 1'b0;
                mem_read <= 1'b1;
                reg_write <= 1'b1;
                A_sel <= 1'b0;
                B_sel <= 1'b1;
                Imm_sel <= 3'b000;
                WB_sel <= 2'b10;
                PC_sel <= 1'b1;
            end

            LUI: begin
                alu_op <= 3'b110;
                branch_op <= 1'b0;  
                mem_write <= 1'b0;
                mem_read <= 1'b0;
                reg_write <= 1'b1;
                A_sel <= 1'bX; 
                B_sel <= 1'b1; 
                Imm_sel <= 3'b100;
                WB_sel <= 2'b01; 
                PC_sel <= 1'b0;
            end

            AUIPC: begin
                alu_op <= 3'b111;
                branch_op <= 1'b0;  
                mem_write <= 1'b0;
                mem_read <= 1'b0;
                reg_write <= 1'b1;
                A_sel <= 1'b1; 
                B_sel <= 1'b1; 
                Imm_sel <= 3'b100;
                WB_sel <= 2'b01; 
                PC_sel <= 1'b0;
            end

        endcase
    end

endmodule