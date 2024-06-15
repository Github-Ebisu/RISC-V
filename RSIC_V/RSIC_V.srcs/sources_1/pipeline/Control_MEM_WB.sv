module Control_MEM_WB (
    input logic clock, reset,
    input logic reg_write_in,
    input logic [1:0] WB_sel_in,

    output logic reg_write_out,
    output logic [1:0] WB_sel_out
);

    always_ff @(posedge clock) begin
        if (reset) begin
            reg_write_out <= 0;
            WB_sel_out <= 0;
        end else begin
            reg_write_out <= reg_write_in;
            WB_sel_out <= WB_sel_in;
        end
    end

endmodule
