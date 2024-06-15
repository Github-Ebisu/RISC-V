`ifndef GUARD_TOP
`define GUARD_TOP

// Test bench nạp lệnh gián tiếp vào Imem
// Dành cho lab05

module top();

    /////////////////////////////////////////////////////
    // Clock Declaration and Generation //
    /////////////////////////////////////////////////////
    parameter StimulationCycle = 10;
    bit SystemClock;


    initial
    forever begin
        #(StimulationCycle/2)
        SystemClock = ~SystemClock;
    end 

    /////////////////////////////////////////////////////
    // Input interface instance //
    /////////////////////////////////////////////////////

    input_interface input_intf(SystemClock);

    /////////////////////////////////////////////////////
    // output interface instance //
    /////////////////////////////////////////////////////

    output_interface output_intf(SystemClock);

    /////////////////////////////////////////////////////
    // Program block Testcase instance //
    /////////////////////////////////////////////////////

    testcase TC (input_intf,output_intf);

    /////////////////////////////////////////////////////
    // DUT instance and signal connection //
    /////////////////////////////////////////////////////


    DUT cpu (
        .clock(SystemClock),
        .reset(input_intf.reset)
    );

    initial begin
        SystemClock = 0;
        #16;
        
        // cpu.datapath.instructionMemory.Imemory[0] = 32'hfe010113;
        // cpu.datapath.instructionMemory.Imemory[1] = 32'h00112e23;
        // cpu.datapath.instructionMemory.Imemory[2] = 32'h02010413;
        // cpu.datapath.instructionMemory.Imemory[3] = 32'hfe042623;
        // cpu.datapath.instructionMemory.Imemory[4] = 32'h00f00793;
        // cpu.datapath.instructionMemory.Imemory[5] = 32'hfef42623;
        // cpu.datapath.instructionMemory.Imemory[6] = 32'h00000793;
        // cpu.datapath.instructionMemory.Imemory[7] = 32'h00078513;
        // cpu.datapath.instructionMemory.Imemory[8] = 32'h01c12083;
        // cpu.datapath.instructionMemory.Imemory[9] = 32'h01812403;
        // cpu.datapath.instructionMemory.Imemory[10] = 32'h02010113;
        // cpu.datapath.instructionMemory.Imemory[11] = 32'h00008067;

        
        // // Test case 01 : add
        // // add x7, x4, x5
        // // Đưa 15 vào x4, 20 vào x5
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.registerFile.Registers[5] = 20;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h005203b3;

        // // Test case 02 : sub
        // // sub x7, x4, x5
        // // Đưa 15 vào x4, 20 vào x5
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.registerFile.Registers[5] = 20;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h405203b3;

        // // Test case 03 : sll
        // // sll x7, x4, x5
        // // Đưa 15 vào x4, 2 vào x5
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.registerFile.Registers[5] = 2;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h005213b3;

        // // Test case 04 : slt
        // // TH1 : x4 < x5
        // // slt x7, x4, x5
        // // Đưa 15 vào x4, 20 vào x5
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.registerFile.Registers[5] = 20;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h005223b3;

        // // Test case 04 : slt
        // // Th2 : x4 > x5
        // // slt x7, x4, x5
        // // Đưa 15 vào x4, -20 vào x5
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.registerFile.Registers[5] = -20;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h005223b3;

        // // Test case 05 : sltu
        // // sltu x7, x4, x5
        // // Đưa 15 vào x4, -20 vào x5
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.registerFile.Registers[5] = -20;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h005233b3;

        // // Test case 06 : xor
        // // xor x7, x4, x5
        // // Đưa 15 vào x4, -20 vào x5
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.registerFile.Registers[5] = -20;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h005243b3;

        // // Test case 07 : srl
        // // srl x7, x4, x5
        // // Đưa 15 vào x4, 2 vào x5
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.registerFile.Registers[5] = 2;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h005253b3;

        // // Test case 08 : sra
        // // sra x7, x4, x5
        // // Đưa -15 vào x4, 2 vào x5
        // cpu.datapath.registerFile.Registers[4] = -15;
        // cpu.datapath.registerFile.Registers[5] = 2;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h405253b3;

        // // Test case 09 : or
        // // or x7, x4, x5
        // // Đưa 15 vào x4, 27 vào x5
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.registerFile.Registers[5] = 27;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h005263b3;


        // // Test case 10 : and
        // // and x7, x4, x5
        // // Đưa 15 vào x4, 27 vào x5
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.registerFile.Registers[5] = 27;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h005273b3;

        // // Test case 11 : addi
        // // addi x7, x4, 20
        // // Đưa 15 vào x4
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h01420393;

        // // Test case 12 : slti
        // // TH1 : x4 > 3
        // // slti x7, x4, 3
        // // Đưa 15 vào x4
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h00322393;

        // // Test case 12 : slti
        // // TH2 : x4 < 30
        // // slti x7, x4, 30
        // // Đưa 15 vào x4
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h01e22393;

        // // Test case 13 : sltiu
        // // sltiu x7, x4, -3
        // // Đưa 15 vào x4
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'hffd23393;


        // // Test case 14 : xori
        // // xori x7, x4, -3
        // // Đưa -15 vào x4
        // cpu.datapath.registerFile.Registers[4] = -15;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'hffd24393;

        // // Test case 15 : andi
        // // andi x7, x4, -3
        // // Đưa 15 vào x4
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'hffd27393;

        // // Test case 16 : slli
        // // slli x7, x4, 3
        // // Đưa 15 vào x4
        // cpu.datapath.registerFile.Registers[4] = 15;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h00321393;

        // // Test case 17 : srli
        // // srli x7, x4, 3
        // // Đưa 20 vào x4
        // cpu.datapath.registerFile.Registers[4] = 20;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h00325393;

        // // Test case 18 : srai
        // // srai x7, x4, 3
        // // Đưa -20 vào x4
        // cpu.datapath.registerFile.Registers[4] = -15;
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h40325393;



        // /* Test case 19 : beq, bne
        // addi x3, x0 ,5
        // addi x4, x0, 8
        // add x1, x3, x4
        // addi x10, x0, 25
        // beq x10, x1, correct
        // bne x10, x1, fail
        // correct: 
        //     addi x12, zero, 0xaa
        //     j end
        // fail:
        //     addi x12, zero, 0xbb
        //     j end
        // end:
        // */
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h00500193;
        // cpu.datapath.instructionMemory.Imemory[1] = 32'h00800213;
        // cpu.datapath.instructionMemory.Imemory[2] = 32'h004180b3;
        // cpu.datapath.instructionMemory.Imemory[3] = 32'h01900513;
        // cpu.datapath.instructionMemory.Imemory[4] = 32'h00150463;
        // cpu.datapath.instructionMemory.Imemory[5] = 32'h00151663;
        // cpu.datapath.instructionMemory.Imemory[6] = 32'h0aa00613;
        // cpu.datapath.instructionMemory.Imemory[7] = 32'h00c0006f;
        // cpu.datapath.instructionMemory.Imemory[8] = 32'h0bb00613;
        // cpu.datapath.instructionMemory.Imemory[9] = 32'h0040006f;

        /* Test case 20 : blt
        addi x3, x0 ,2
        addi x4, x0, 8
        add x1, x3, x4
        addi x10, x0, 25
        blt x10, x1, correct
        bge x10, x1, fail
        correct: 
            addi x12, zero, 0xaa
            j end
        fail:
            addi x12, zero, 0xbb
            j end
        end:
        */
        cpu.datapath.instructionMemory.Imemory[0] = 32'h00200193;
        cpu.datapath.instructionMemory.Imemory[1] = 32'h00800213;
        cpu.datapath.instructionMemory.Imemory[2] = 32'h004180b3;
        cpu.datapath.instructionMemory.Imemory[3] = 32'h01900513;
        cpu.datapath.instructionMemory.Imemory[4] = 32'h00154463;
        cpu.datapath.instructionMemory.Imemory[5] = 32'h00155663;
        cpu.datapath.instructionMemory.Imemory[6] = 32'h0aa00613;
        cpu.datapath.instructionMemory.Imemory[7] = 32'h00c0006f;
        cpu.datapath.instructionMemory.Imemory[8] = 32'h0bb00613;
        cpu.datapath.instructionMemory.Imemory[9] = 32'h0040006f;
     
     
        // // /* Test case 21 : lui
        // // lui x10, 0x12345
        // // */
        // // cpu.datapath.instructionMemory.Imemory[0] = 32'h12345537;

        // /* Test case 22 : auipc
        // auipc x10, 20
        // */
        // cpu.datapath.instructionMemory.Imemory[0] = 32'h00014517;

        // Test case 22:
        /* C++ :
            int mul(int a){
                return a*2;
            }

            int main(){
                int sum = 0;
                for (int i = 0; i < 10; i++){
                    sum += mul(i);
                    sum -= 1;
                }
                return 0;
            }

            Assembly code : 
            
            j main
            mul:
                addi    sp,sp,-32
                sw      ra,28(sp)
                sw      s0,24(sp)
                addi    s0,sp,32
                sw      a0,-20(s0)
                lw      a5,-20(s0)
                slli    a5,a5,1
                mv      a0,a5
                lw      ra,28(sp)
                lw      s0,24(sp)
                addi    sp,sp,32
                jr      ra

            main:
                addi    sp,sp,-32
                sw      ra,28(sp)
                sw      s0,24(sp)
                addi    s0,sp,32
                sw      zero,-20(s0)
                sw      zero,-24(s0)
                j       L4

            L5:
                lw      a0,-24(s0)
                call    mul
                mv      a4,a0
                lw      a5,-20(s0)
                add     a5,a5,a4
                sw      a5,-20(s0)
                lw      a5,-20(s0)
                addi    a5,a5,-1
                sw      a5,-20(s0)
                lw      a5,-24(s0)
                addi    a5,a5,1
                sw      a5,-24(s0)

            L4:
                lw      a4,-24(s0)
                li      a5,9
                ble     a4,a5,L5
                li      a5,0
                mv      a0,a5
                lw      ra,28(sp)
                lw      s0,24(sp)
                addi    sp,sp,32
                jr      ra

        */

        // Test case 22 :Nạp trực tiếp vào Imem, chạy file Testbench.sv

    end


endmodule


`endif