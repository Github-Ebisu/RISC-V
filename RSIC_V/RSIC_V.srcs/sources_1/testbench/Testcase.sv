`ifndef GUARD_TESTCASE
`define GUARD_TESTCASE


program testcase (
    input_interface.IP input_intf,
    output_interface.OP output_intf
);
    Environment env;

    initial begin
        $display(" ******************* Start of testcase ****************");
        env = new(input_intf,output_intf);
        env.run();
        #1000;
    end

    final
    $display(" ******************** End of testcase *****************");

endprogram
`endif