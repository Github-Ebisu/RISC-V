module DataMemory #(
    parameter data_bus = 32,
    parameter num_registers = 256
) (
    input logic clock,
    input logic reset,
    input logic mem_write,
    input logic mem_read,

    input logic [data_bus-1:0] address,
    input logic [data_bus-1:0] write_data,
    output logic [data_bus-1:0] read_data
);

    reg [data_bus-1:0] Dmemory [num_registers-1:0];

    always_ff @(posedge clock) begin
        if (reset == 1'b1) begin
            for (int i=0; i < num_registers; i = i+1) begin
                Dmemory[i] <= 32'hXXXX_XXXX;  
            end
        end 
        else if (mem_write == 1'b1) begin
            Dmemory[address] <= write_data;  
        end
    end

    assign read_data = (mem_read) ? Dmemory[address] : 32'h0;

endmodule
    
