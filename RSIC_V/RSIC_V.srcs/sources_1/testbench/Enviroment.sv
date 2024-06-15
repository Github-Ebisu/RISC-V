`ifndef GUARD_ENV
`define GUARD_ENV
//`include "Packet.sv"

class Environment;

    virtual input_interface.IP input_intf;
    virtual output_interface.OP output_intf;
    //Packet pkt;
    
    function new (virtual input_interface.IP input_intf_new, virtual output_interface.OP output_intf_new );

        this.input_intf = input_intf_new;
        this.output_intf = output_intf_new;
       //this.pkt = new();

        $display(" %0d : Environment : created env object",$time);

    endfunction : new

    function void build();
        $display(" %0d : Environment : start of build() method",$time);
        // for(int i = 0; i < 10; i++)begin
        //     if (this.pkt.randomize())  begin
        //         $display ("\n------ %0d : Pkt: Randomization Successes full. ------",$time);
        //         cpu.datapath.instructionMemory.Imemory[i] = pkt.instruction;
        //     end
        // end

        $display(" %0d : Environment : end of build() method",$time);
    endfunction :build

    task reset();
        $display(" %0d : Environment : start of reset() method",$time);
        
            // Reset the DUT
            input_intf.reset <= 1;
            // repeat (3) @ input_intf.clock;
            #16
            input_intf.reset <= 0;

        $display(" %0d : Environment : end of reset() method",$time);
    endtask : reset

    task cfg_dut();
        $display(" %0d : Environment : start of cfg_dut() method",$time);
            
        $display(" %0d : Environment : end of cfg_dut() method",$time);
    endtask : cfg_dut

    task start();
        $display(" %0d : Environment : start of start() method", $time);

        $display(" %0d : Environment : end of start() method", $time);
    endtask : start

    task wait_for_end();
        $display(" %0d : Environment : start of wait_for_end() method",$time);
        repeat(10000) @(input_intf.clock);  
        $display(" %0d : Environment : end of wait_for_end() method",$time);
    endtask : wait_for_end


    task run();
        $display(" %0d : Environment : start of run() method",$time);
        build();
        reset();
        cfg_dut();
        start();
        wait_for_end();
        report();
        $display(" %0d : Environment : end of run() method",$time);
    endtask : run


    task report();
    endtask : report

endclass

`endif
