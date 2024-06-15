`timescale 1ns / 1ps
// Test bench dành cho nạp lệnh trực tiếp vào Imem

module TopTest;

    localparam data_bus = 32;
    localparam num_Imem_registers = 256;
    localparam num_regFile_registers = 32;
    localparam num_Dmem_registers = 256;

    logic clock;
    logic reset;



  DUT dut (
        .clock(clock),
        .reset(reset)
  );
  // Clock generation
  always #5 clock = ~clock;

  initial begin
    // Initialize signals
    clock = 0;
    reset = 1;

    #16;
    reset = 0;

  end


endmodule
