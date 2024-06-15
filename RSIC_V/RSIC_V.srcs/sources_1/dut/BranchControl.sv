module BranchControl(
    input  logic branch_op,
    input  logic [2:0] func3,
    input  logic BrLT,
    input  logic BrEq,

    output logic BrUn,
    output logic Branch_sel
);
    always_comb begin
        case ({branch_op,func3})
            // B type - 6 types

            4'b1_000: begin //  BEQ
                BrUn = 1'b0; 
                if (BrEq) begin
                    Branch_sel = 1'b1;
                end
                else begin
                    Branch_sel = 1'b0;
                end 
            end
    
            4'b1_001: begin //  BNE
                BrUn = 1'b0; 
                if (!BrEq) begin
                    Branch_sel = 1'b1;
                end
                else begin
                    Branch_sel = 1'b0;
                end 
            end 

            4'b1_100: begin //  BLT
                BrUn = 1'b0; 
                if (BrLT) begin
                    Branch_sel = 1'b1;
                end
                else begin
                    Branch_sel = 1'b0;
                end 
            end 
            
            4'b1_101: begin //  BGE
                BrUn = 1'b0; 
                if (!BrLT) begin
                    Branch_sel = 1'b1;
                end
                else begin
                    Branch_sel = 1'b0;
                end 
            end 

            4'b1_110: begin//  BLTU
                BrUn = 1'b1; 
                if (BrLT) begin
                    Branch_sel = 1'b1;
                end
                else begin
                    Branch_sel = 1'b0;
                end 
            end 

            4'b1_111: begin //  BGEU
                BrUn = 1'b1; 
                if (!BrLT) begin
                    Branch_sel = 1'b1;
                end
                else begin
                    Branch_sel = 1'b0;
                end 
            end

            default: begin
                Branch_sel <= 1'b0;
                BrUn <= 1'bX;
            end
        endcase
    end
endmodule