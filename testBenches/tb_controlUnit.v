`timescale 1ns / 1ps
`include "defines.vh"

module tb_controlUnit;
    reg [6:0] instruction;
    wire branch, memRead, memToReg, memWrite, aluSrc, regWrite;
    wire [1:0] aluOp;

    controlUnit uut(
        .instruction(instruction),
        .branch(branch), .memRead(memRead), .memToReg(memToReg), 
        .memWrite(memWrite), .aluSrc(aluSrc), .regWrite(regWrite),
        .aluOp(aluOp)
    );
      initial begin

        instruction = `R_type;
        #10;
        if ({aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]} == `R_format) 
        $display("Test PASSED:%b = %b", {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]}, `R_format );
        else $display("Test failed");
        
        instruction = `I_type;
        #10;
        if ({aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]} == `I_format) 
        $display("Test PASSED:%b = %b", {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]}, `I_format );
        else $display("Test failed");
        
        instruction = `L_type;
        #10;
        if ({aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]} == `L_format) 
        $display("Test PASSED:%b = %b", {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]}, `L_format );
        else $display("Test failed");
        
        instruction = `S_type;
        #10;
        if ({aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]} == `S_format) 
        $display("Test PASSED:%b = %b", {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]}, `S_format );
        else $display("Test failed %b != %b", {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]}, `S_format );

        instruction = `B_type;
        #10;
        if ({aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]} == `B_format) 
        $display("Test PASSED:%b = %b", {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]}, `B_format );
        else $display("Test failed %b = %b", {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]}, `B_format);
        
    $finish;
  end

endmodule
