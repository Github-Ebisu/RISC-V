//`include "pipeline"

module Datapath #(
    parameter data_bus = 32,
    parameter num_Imem_registers = 256,
    parameter num_regFile_registers = 32,
    parameter num_Dmem_registers = 256
) (
    input logic clock,
    input logic reset,

    input logic [2:0] alu_op,
    input logic branch_op,
    input logic mem_write,
    input logic mem_read,
    input logic reg_write,

    input logic [2:0] Imm_sel,
    input logic A_sel,
    input logic B_sel,
    input logic [1:0] WB_sel,
    input logic PC_sel,

    output logic [6:0] op_code
);
    // Stall and Forwarding
    logic stall_bus;
    logic flush_IF_ID_bus;
    logic flush_ID_EX_bus;
    logic [1:0] Forward_A;
    logic [1:0] Forward_B;

    // PC
    logic [data_bus-1:0] PC_add_4_bus;
    logic [data_bus-1:0] PC_in_bus;
    logic [data_bus-1:0] PC_out_bus;
    
    // IMem
    logic [data_bus-1:0] instruction_out;


    // IF/ID
    logic [data_bus-1:0] PC_IF_ID;
    logic [data_bus-1:0] PC_add_4_IF_ID;
    logic [data_bus-1:0] instruction_IF_ID;

    // RegFile
    logic [data_bus-1:0] read_data_1_bus;
    logic [data_bus-1:0] read_data_2_bus;
    logic [data_bus-1:0] write_back_bus;
    // ImmGen
    logic [data_bus-1:0] imm_bus;

    // ID/EX
    logic [2:0] alu_op_ID_EX;
    logic branch_op_ID_EX;
    logic mem_write_ID_EX;
    logic mem_read_ID_EX;
    logic reg_write_ID_EX;
    logic A_sel_ID_EX;
    logic B_sel_ID_EX;
    logic [1:0] WB_sel_ID_EX;
    logic PC_sel_ID_EX;

    logic [data_bus-1:0] read_data_1_ID_EX, read_data_2_ID_EX, PC_ID_EX, PC_add_4_ID_EX;
    logic [4:0] read_reg_1_ID_EX, read_reg_2_ID_EX, Rd_ID_EX; 
    logic [data_bus-1:0] Imm_extended_ID_EX;
    logic [6:0] function7_ID_EX;
    logic [2:0] function3_ID_EX;

    // Branch Unit
    logic Branch_sel;
    logic BrUn_bus;
    logic BrLT_bus;
    logic BrEq_bus;

    // ALU
    logic [3:0] alu_control_bus; 
    logic [data_bus-1:0] A_bus;
    logic [data_bus-1:0] B_bus;
    logic [data_bus-1:0] Forward_A_bus;
    logic [data_bus-1:0] Forward_B_bus;
    logic [data_bus-1:0] alu_result_bus;

    // EX/MEM
    logic reg_write_EX_MEM;
    logic mem_read_EX_MEM;
    logic mem_write_EX_MEM;
    logic [1:0] WB_sel_EX_MEM;

    logic [data_bus-1:0] ALU_result_EX_MEM, read_data_2_EX_MEM;
    logic [4:0] Rd_EX_MEM;
    logic [data_bus-1:0] PC_add_4_EX_MEM;

    // DMem
    logic [data_bus-1:0] Dmem_bus;

    // MEM/WB
    logic reg_write_MEM_WB;
    logic [1:0] WB_sel_MEM_WB;

    logic [data_bus-1:0] read_data_MEM_WB;
    logic [data_bus-1:0] ALU_result_MEM_WB;
    logic [4:0] Rd_MEM_WB;
    logic [data_bus-1:0] PC_add_4_MEM_WB;



    HazardUnit hazardUnit (
        .IF_ID_read_reg_1(instruction_IF_ID[19:15]),
        .IF_ID_read_reg_2(instruction_IF_ID[24:20]),
        .ID_EX_rd(Rd_ID_EX),
        .ID_EX_MemRead(mem_read_ID_EX),
        .ID_EX_PC_sel(PC_sel_ID_EX),
        .Branch_sel(Branch_sel), 
        .stall(stall_bus),
        .flush_IF_ID(flush_IF_ID_bus),
        .flush_ID_EX(flush_ID_EX_bus)
    );

    ForwardingUnit forwardingUnit(
        .ID_EX_read_reg_1(read_reg_1_ID_EX),
        .ID_EX_read_reg_2(read_reg_2_ID_EX),
        .MEM_WB_rd(Rd_MEM_WB),
        .EX_MEM_rd(Rd_EX_MEM),
        .EX_MEM_reg_write(reg_write_EX_MEM),
        .MEM_WB_reg_write(reg_write_MEM_WB),
        .Forward_A(Forward_A),
        .Forward_B(Forward_B)
    );

    Mux2 #(
        .data_bus(data_bus) 
    ) mux2_PC(
        .select(PC_sel_ID_EX | Branch_sel), // 
        .In0(PC_add_4_bus),
        .In1(alu_result_bus),

        .DataOut(PC_in_bus)
    );

    ProgramCounter #(
        .data_bus(data_bus)
    ) programCounter(
        .clock(clock),
        .reset(reset),//
        .enable(!stall_bus),
        .PC_in(PC_in_bus),
        
        .PC_out(PC_out_bus),

        // test
        .test_reset(test_reset)
    );

    Adder4 #(
        .data_bus(data_bus)
    ) adder4(
        .data_in(PC_out_bus),

        .data_out(PC_add_4_bus)
    );

    InstructionMemory #(
        .data_bus(data_bus), 
        .num_registers(num_Imem_registers)
    ) instructionMemory(
        .clock(clock),
        .reset(reset),
        .read_address(PC_out_bus),
        
        .instruction_out(instruction_out),

        // test
        .write_en(write_en),
        .instruction_in(instruction_in)
    );

    IF_ID #(
        .data_bus(data_bus)
    ) IF_ID_stage(
        .clock(clock),
        .reset(reset | flush_IF_ID_bus),
        .enable(!stall_bus),

        .PC_in(PC_out_bus),
        .PC_add_4_in(PC_add_4_bus),
        .Instruction_in(instruction_out),

        .Instruction_out(instruction_IF_ID),
        .PC_out(PC_IF_ID),
        .PC_add_4_out(PC_add_4_IF_ID)

    );

    RegisterFile #(
        .data_bus(data_bus), 
        .num_registers(num_regFile_registers)
    ) registerFile(
        .clock(clock),
        .reset(reset),
        .reg_write(reg_write_MEM_WB),
        .read_reg1(instruction_IF_ID[19:15]),
        .read_reg2(instruction_IF_ID[24:20]),
        .Rd(Rd_MEM_WB),
        .write_data(write_back_bus),

        .read_data1(read_data_1_bus),
        .read_data2(read_data_2_bus)
    );

    ImmGen #(
        .data_bus(data_bus)
    ) immGen(
        .Imm_sel(Imm_sel),
        .instruction(instruction_IF_ID),
        
        .imm(imm_bus)
    );

    Control_ID_EX control_ID_EX (
        .clock(clock), 
        .reset(reset | flush_ID_EX_bus),
        .alu_op_in(alu_op),
        .branch_op_in(branch_op),
        .mem_write_in(mem_write),
        .mem_read_in(mem_read),
        .reg_write_in(reg_write),
        .A_sel_in(A_sel),   
        .B_sel_in(B_sel),  
        .WB_sel_in(WB_sel),
        .PC_sel_in(PC_sel),

        .alu_op_out(alu_op_ID_EX),
        .branch_op_out(branch_op_ID_EX),
        .mem_write_out(mem_write_ID_EX),
        .mem_read_out(mem_read_ID_EX),
        .reg_write_out(reg_write_ID_EX),
        .A_sel_out(A_sel_ID_EX),
        .B_sel_out(B_sel_ID_EX),
        .WB_sel_out(WB_sel_ID_EX),
        .PC_sel_out(PC_sel_ID_EX)
    );

    ID_EX #(
        .data_bus(data_bus)
    ) ID_EX_stage(
        .clock(clock), 
        .reset(reset | flush_ID_EX_bus), 
        .enable(!stall_bus),
        .read_data_1_in(read_data_1_bus),
        .read_data_2_in(read_data_2_bus),
        .PC_in(PC_IF_ID),
        .PC_add_4_in(PC_add_4_IF_ID),
        .read_reg_1_in(instruction_IF_ID[19:15]),
        .read_reg_2_in(instruction_IF_ID[24:20]),
        .Rd_in(instruction_IF_ID[11:7]), 
        .Imm_extended_in(imm_bus),
        .function7_in(instruction_IF_ID[31:25]),
        .function3_in(instruction_IF_ID[14:12]),

        .read_data_1_out(read_data_1_ID_EX),
        .read_data_2_out(read_data_2_ID_EX), 
        .PC_out(PC_ID_EX),
        .PC_add_4_out(PC_add_4_ID_EX),
        .read_reg_1_out(read_reg_1_ID_EX),
        .read_reg_2_out(read_reg_2_ID_EX),
        .Rd_out(Rd_ID_EX), 
        .Imm_extended_out(Imm_extended_ID_EX),
        .function7_out(function7_ID_EX),
        .function3_out(function3_ID_EX)
    );


    BranchControl branchControl(
        .branch_op(branch_op_ID_EX),  
        .func3(function3_ID_EX),
        .BrLT(BrLT_bus),
        .BrEq(BrEq_bus),

        .BrUn(BrUn_bus),
        .Branch_sel(Branch_sel)
    );

    BranchComparasion #(
        .data_bus(data_bus)
    ) branchComparasion(
        .BrUn(BrUn_bus),
        .read_data1(Forward_A_bus),
        .read_data2(Forward_B_bus),

        .BrEq(BrEq_bus),
        .BrLT(BrLT_bus)
    );

    // Forwarding A
    Mux3 #(
        .data_bus(data_bus) 
    ) mux3_Forward_A(
        .select(Forward_A),
        .In0(read_data_1_ID_EX),
        .In1(write_back_bus),
        .In2(ALU_result_EX_MEM),

        .DataOut(Forward_A_bus)
    );


    // A Select
    Mux2 #(
        .data_bus(data_bus) 
    ) mux2_A(
        .select(A_sel_ID_EX), 
        .In0(Forward_A_bus),
        .In1(PC_ID_EX),

        .DataOut(A_bus)
    );


    // Forwarding B
    Mux3 #(
        .data_bus(data_bus) 
    ) mux3_Forward_B(
        .select(Forward_B),
        .In0(read_data_2_ID_EX),
        .In1(write_back_bus),
        .In2(ALU_result_EX_MEM),

        .DataOut(Forward_B_bus)
    );

    // B Select
    Mux2 #(
        .data_bus(data_bus) 
    ) mux2_B(
        .select(B_sel_ID_EX),
        .In0(Forward_B_bus),
        .In1(Imm_extended_ID_EX),  

        .DataOut(B_bus)
    );


    ALUcontrol aluControl(
        .alu_op(alu_op_ID_EX),
        .func7(function7_ID_EX),
        .func3(function3_ID_EX),

        .alu_control_out(alu_control_bus)
    );


    ALU #(
        .data_bus(data_bus)
    ) alu(
        .alu_control_in(alu_control_bus),
        .A(A_bus),
        .B(B_bus),

        .result(alu_result_bus)
    );

    Control_EX_MEM control_EX_MEM(
        .clock(clock), 
        .reset(reset),
        .reg_write_in(reg_write_ID_EX),
        .mem_read_in(mem_read_ID_EX),
        .mem_write_in(mem_write_ID_EX),
        .WB_sel_in(WB_sel_ID_EX), 
        .reg_write_out(reg_write_EX_MEM),
        .mem_read_out(mem_read_EX_MEM),
        .mem_write_out(mem_write_EX_MEM),
        .WB_sel_out(WB_sel_EX_MEM)
    );

    EX_MEM #(
        .data_bus(data_bus)
    ) EX_MEM_stage(
        .clock(clock), 
        .reset(reset),
        .ALU_result_in(alu_result_bus), 
        .read_data_2_in(Forward_B_bus),
        .Rd_in(Rd_ID_EX),
        .PC_add_4_in(PC_add_4_ID_EX),

        .ALU_result_out(ALU_result_EX_MEM), 
        .read_data_2_out(read_data_2_EX_MEM),
        .Rd_out(Rd_EX_MEM),
        .PC_add_4_out(PC_add_4_EX_MEM)        
    );

    DataMemory #(
        .data_bus(data_bus), 
        .num_registers(num_Dmem_registers)
    ) dataMemory(
        .clock(clock),
        .reset(reset),
        .mem_write(mem_write_EX_MEM),
        .mem_read(mem_read_EX_MEM),
        .address(ALU_result_EX_MEM),
        .write_data(read_data_2_EX_MEM),

        .read_data(Dmem_bus)
    );

    Control_MEM_WB control_MEM_WB(
        .clock(clock), 
        .reset(reset),
        .reg_write_in(reg_write_EX_MEM),
        .WB_sel_in(WB_sel_EX_MEM),
        .reg_write_out(reg_write_MEM_WB),
        .WB_sel_out(WB_sel_MEM_WB)  
    );

    MEM_WB #(
        .data_bus(data_bus)
    ) MEM_WB_stage(
        .clock(clock), 
        .reset(reset),
        .read_data_in(Dmem_bus),
        .ALU_result_in(ALU_result_EX_MEM),
        .PC_add_4_in(PC_add_4_EX_MEM),
        .Rd_in(Rd_EX_MEM),

        .read_data_out(read_data_MEM_WB),
        .ALU_result_out(ALU_result_MEM_WB),
        .Rd_out(Rd_MEM_WB),
        .PC_add_4_out(PC_add_4_MEM_WB) 
    );

    Mux3 #(
        .data_bus(data_bus) 
    ) mux3_Dmem(
        .select(WB_sel_MEM_WB),
        .In0(read_data_MEM_WB),
        .In1(ALU_result_MEM_WB),
        .In2(PC_add_4_MEM_WB),

        .DataOut(write_back_bus)
    );

    assign op_code = instruction_IF_ID[6:0];

endmodule