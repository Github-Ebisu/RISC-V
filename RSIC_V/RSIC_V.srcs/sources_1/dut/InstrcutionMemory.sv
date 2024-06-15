`timescale 1ns / 1ps

module InstructionMemory #(
    parameter data_bus = 32,
    parameter num_registers = 256
) (
    input logic clock,
    input logic reset,

    input logic [data_bus-1:0] read_address,
    output logic [data_bus-1:0] instruction_out,

    // test
    input logic write_en,
    input logic [data_bus-1:0] instruction_in
);

    reg [data_bus-1:0] Imemory [num_registers-1:0];

   /// initialize memory for simulation  /////////
//   initial begin
//       #17 
//       $readmemh("instructions.mem", Imemory);
//   end
   ///////////////////////////////////////////////

    always_ff @(posedge clock) begin
        if (reset == 1'b1) begin
            for (int i=0; i < num_registers; i = i+1) begin
                Imemory[i] <= 32'hXXXX_XXXX;  
            end
        end 
        if (write_en == 1'b1) begin
            Imemory[read_address>>2] <= instruction_in;
        end
    end

   assign instruction_out = Imemory[read_address>>2];

endmodule