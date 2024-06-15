module Control_EX_MEM (
    input logic clock, reset,
    input logic reg_write_in,
    input logic mem_read_in,
    input logic mem_write_in,
    input logic [1:0] WB_sel_in, 

    output logic reg_write_out,
    output logic mem_read_out,
    output logic mem_write_out,
    output logic [1:0] WB_sel_out
);

    always_ff @(posedge clock) begin
        if (reset) begin
            reg_write_out <= 0;
            mem_read_out <= 0;
            mem_write_out <= 0;
            WB_sel_out <= 0;
        end
        else begin
            reg_write_out <= reg_write_in;
            mem_read_out <= mem_read_in;
            mem_write_out <= mem_write_in;
            WB_sel_out <= WB_sel_in;
        end
        
    end

endmodule