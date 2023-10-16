`include "defines.vh"
`include "immediateGenerator.v"

module tb_immediateGenerator;
    reg [31:0] instruction;
    wire [31:0] immediate;

    immediateGenerator uut(
        .instruction(instruction),
        .immediate(immediate)
    );

    initial begin
        instruction = 32'b111111001110_00001_000_01110_0010011;
        #10;
        if (immediate == 32'hFFFFFFCE)
            $display("Test PASSED: immediate = %h", immediate);
        else
            $display("Test failed: immediate = %h", immediate);
        
        instruction = 32'hFFFFFFCE;
        #10;
        if (immediate == 32'b11111111111111111111111111001110)
            $display("Test PASSED: immediate = %h", immediate);
        else
            $display("Test failed: immediate = %h", immediate);
        
        instruction = 32'b1111110_01110_00001_000_01110_0100011;
        #10;
        if (immediate == 32'hFFFFFFCE)
            $display("Test PASSED: immediate = %h", immediate);
        else
            $display("Test failed: immediate = %h", immediate);

        instruction = 32'b1_111110_01110_00001_000_0111_0_1100011;
        #10;
        if (immediate == 32'hFFFFFBE7)
            $display("Test PASSED: immediate = %h", immediate);
        else
            $display("Test failed: immediate = %h", immediate);

        $finish;
    end
endmodule
