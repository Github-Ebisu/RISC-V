module BranchComparasion #(
    parameter data_bus = 32
) (
    input logic BrUn,
    input logic [data_bus-1:0] read_data1,
    input logic [data_bus-1:0] read_data2,

    output logic BrEq,
    output logic BrLT
);
    always_comb begin
        if (read_data1 == read_data2) begin
            BrEq <= 1;
            BrLT <= 0;
        end 
        else begin
            if (BrUn) begin
                if (read_data1 < read_data2) begin
                    BrEq <= 0;
                    BrLT <= 1;   
                end
                else begin
                    BrEq <= 0;
                    BrLT <= 0;
                end
            end else begin
               if (($signed(read_data1) < $signed(read_data2))) begin
                    BrEq <= 0;
                    BrLT <= 1;
               end
               else begin
                    BrEq <= 0;
                    BrLT <= 0;
               end
            end
        end
    end


endmodule