module ALUcontrol(
    input logic[2:0] alu_op,
    input logic[6:0] func7,
    input logic[2:0] func3,

    output logic[3:0] alu_control_out
);
    always_comb begin
        case (alu_op)   
            // R type
            3'b001: begin               
                case ({func7, func3})
                    10'b0000000_000: alu_control_out = 4'b0000; //  ADD
                    10'b0100000_000: alu_control_out = 4'b1000; //  SUB
                    10'b0000000_001: alu_control_out = 4'b0001; //  SLL
                    10'b0000000_010: alu_control_out = 4'b0010; //  SLT
                    10'b0000000_011: alu_control_out = 4'b0011; //  SLTU
                    10'b0000000_100: alu_control_out = 4'b0100; //  XOR
                    10'b0000000_101: alu_control_out = 4'b0101; //  SRL
                    10'b0100000_101: alu_control_out = 4'b1001; //  SRA
                    10'b0000000_110: alu_control_out = 4'b0110; //  OR
                    10'b0000000_111: alu_control_out = 4'b0111; //  AND
                endcase
            end

            // I type - 9 types
            3'b010: begin
                case (func3)
                    3'b001: begin
                        if (func7 == 7'b0000000) begin
                            alu_control_out = 4'b0001; // SLLI
                        end
                    end
                    3'b000: alu_control_out = 4'b0000; //  ADDI
                    3'b010: alu_control_out = 4'b0010; //  SLTI
                    3'b011: alu_control_out = 4'b0011; //  SLTIU
                    3'b100: alu_control_out = 4'b0100; //  XORI
                    3'b101: begin
                        if (func7 == 7'b000_0000) begin
                            alu_control_out = 4'b0101; // SRLI
                        end
                        if (func7 == 7'b010_0000) begin
                            alu_control_out = 4'b1001; // SRAI
                        end
                    end
                    3'b110: alu_control_out = 4'b0110; //  ORI
                    3'b111: alu_control_out = 4'b0111; //  ANDI 
                endcase
            end
            
             // LW,SW 
            3'b011: alu_control_out = 4'b0000; // ADD

            // B type
            3'b100: alu_control_out = 4'b0000; // ADD

            // J type
            3'b101: alu_control_out = 4'b0000; // ADD

            // U type
            3'b110: alu_control_out = 4'b1010; // LUI 
            3'b111: alu_control_out = 4'b0000; // ADD 
        endcase
    end
endmodule

