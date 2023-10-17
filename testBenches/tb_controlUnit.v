`include "defines.vh"
`include "controlUnit.v"

module tb_controlUnit;
    reg clk;
    reg [6:0] instruction;
    wire branch, memRead, memToReg, memWrite, aluSrc, regWrite;
    wire [1:0] aluOp;
    reg [7:0] controlSignals;
    reg [6:0] pattern [0:4];
    integer i;

    // Instantiate the controlUnit module
    controlUnit uut(
        .clk(clk),
        .instruction(instruction),
        .branch(branch),
        .memRead(memRead),
        .memToReg(memToReg),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .regWrite(regWrite),
        .aluOp(aluOp)
    );

    initial begin
        clk = 0;

        pattern[0] = `R_type;
        pattern[1] = `I_type;
        pattern[2] = `L_type;
        pattern[3] = `S_type;
        pattern[4] = `B_type;

        for (i = 0; i < 10; i = i + 1) begin
            #5 instruction = pattern[$random % 5];
            #10 controlSignals = {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]};
        end

        $finish;
    end

    always #5 clk = ~clk;

endmodule
