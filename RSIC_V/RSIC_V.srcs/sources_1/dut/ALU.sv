module ALU #(
    parameter data_bus = 32,
    parameter alu_control_bus = 4
) (
    input logic[alu_control_bus-1:0] alu_control_in,
    input logic[data_bus-1:0] A,
    input logic[data_bus-1:0] B,
    output logic[data_bus-1:0] result
);
localparam [3:0] ADD  =  4'b0000, 
                 SUB  =  4'b1000, 
                 SLL  =  4'b0001, 
                 SLT  =  4'b0010, 
                 SLTU =  4'b0011, 
                 XOR  =  4'b0100, 
                 SRL  =  4'b0101, 
                 SRA  =  4'b1001, 
                 OR   =  4'b0110, 
                 AND  =  4'b0111,
                 LUI  =  4'b1010;



    always_comb begin
        case (alu_control_in)
            ADD: begin
                result = A + B;
            end

            SUB: begin
                result = A - B;
            end

            SLL: begin
                result = A << B;
            end

            SLT: begin
                result = $signed(A) < $signed(B);
            end

            SLTU: begin
                result =  A < B;
            end

            XOR: begin
                result = A ^ B;
            end

            SRL: begin
                result = A >> B;
            end

            SRA: begin
                result = $signed(A) >>> B;
            end

            OR: begin
                result = A | B;
            end

            AND: begin
                result = A & B;
            end

            LUI: begin
                result = B;
            end
            
            default: begin
                result = 0;
            end
        endcase
    end

endmodule