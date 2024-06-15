module ImmGen #(
    parameter data_bus = 32
) (
    input logic[2:0] Imm_sel,
    input logic[data_bus-1:0] instruction,
    output logic[data_bus-1:0] imm
);
    
    always_comb begin
        if (Imm_sel == 3'b000) // I-type and LW, Jalr
                // srai  
                if((instruction[31:25] == 7'b010_0000) && (instruction[14:12] == 3'b101) && (instruction[6:0] == 7'b0010011)) begin
                    imm = {{20{instruction[31]}}, instruction[31], 1'b0, instruction[29:20]};
                end
                else begin
                    imm = {{20{instruction[31]}}, instruction[31:20]};
                end
        else if (Imm_sel == 3'b001)  // S-type
                imm = {{20{instruction[31]}}, instruction[31:25],instruction[11:7]};
        else if (Imm_sel == 3'b010)    // B-type
                imm = {
                        {19{instruction[31]}}, 
                        instruction[31],
                        instruction[7],
                        instruction[30:25],
                        instruction[11:8],
                        1'b0
                    };
        else if (Imm_sel == 3'b011)    // J-type
                imm = {
                        {12{instruction[31]}}, 
                        instruction[19:12],
                        instruction[20],
                        instruction[30:21],
                        1'b0
                    };
        else if (Imm_sel == 3'b100)  begin  // U-type
                imm = {instruction[31:12], 12'b0};
            end
        else
            imm = 32'hX;
    end

endmodule