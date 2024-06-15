module RegisterFile #(
    parameter data_bus = 32,
    parameter num_registers = 32
) (
    input logic clock,
    input logic reset,
    input logic reg_write,

    input logic [4:0] read_reg1,
    input logic [4:0] read_reg2,
    input logic [4:0] Rd,
    input logic [data_bus-1:0] write_data,

    output logic [data_bus-1:0] read_data1,
    output logic [data_bus-1:0] read_data2
);

    reg [data_bus-1:0] Registers [num_registers-1:0];

    initial begin
        #17 
        Registers[0] = 32'h0000_0000;
        Registers[2] = 32'h0000_00FF;
    end

    always_ff @(negedge clock) begin
        if (reset == 1'b1) begin
            for (int i=0; i < num_registers; i = i+1) begin
                Registers[i] <= 32'hXXXX_XXXX;  
            end
        end 
        else if (reg_write == 1'b1) begin
            if (Rd != 0) begin 
                Registers[Rd] <= write_data;
            end  
        end
    end

    assign read_data1 = Registers[read_reg1];
    assign read_data2 = Registers[read_reg2];

endmodule