`define WORDSIZE 32

module topRiscvWrapper(
    input clk, reset 
);

    // --------------IF stage--------------
    
    wire [WORDSIZE-1:0] PC_readAddress;         // Output from programCounter to instructionMemory
    wire [WORDSIZE-1:0] instruction;            // Output from instructionMemory
    wire [WORDSIZE-1:0] pcSrc;                  // PC source signal
    wire [WORDSIZE-1:0] immExt;                 // Extended immediate from the IF stage to the ID stage

    // --------------ID stage--------------
    
    wire [WORDSIZE-1:0] rs1, rs2, rd;           // Outputs from instructionDecoder to registerFile
    wire [6:0] op;                              // Output from instructionDecoder to controlUnit
    wire [2:0] funct3;                          // Output from instructionDecoder to controlUnit
    wire funct73_r;                             // Output from instructionDecoder to aluControl
    wire branch, memRead, memToReg;             // Outputs from controlUnit to various stages
    wire memWrite, aluSrc, regWrite;            // Outputs from controlUnit to various stages
    wire [1:0] aluOp;                           // Output from controlUnit to aluControl
    wire [3:0] aluCtl;                          // Output from aluControl to ALU

    // --------------Immediate Generation and Register File--------------
    
    wire [WORDSIZE-1:0] extendedImmediate;      // Output from immediateGenerator
    wire [WORDSIZE-1:0] writeData;              // Output from registerFile
    wire [WORDSIZE-1:0] readData1, readData2;   // Outputs from registerFile to aluMux and ALU
    
    // --------------EX Stage--------------
    
    wire [WORDSIZE-1:0] alu_in2;                // Output from aluMux to ALU
    wire [WORDSIZE-1:0] aluResult;              // Output from ALU
    wire aluZero;                               // Output from ALU
    wire [WORDSIZE-1:0] readMemoryData;         // Output from dataMemory
    
    // --------------WB Stage--------------
    
    wire [WORDSIZE-1:0] writeDataToReg;         // Output from writeBackMux

    // =========='IF stage'==========

    programCounter #(WORDSIZE) pc(
        .reset(reset),
        .clk(clk),
        .pcSrc(pcSrc),
        .immExt(immExt)
        .PC(PC_readAddress)
    ); // output: PC readAddress

    instructionMemory #(5, WORDSIZE) im(
        .readAddress(PC_readAddress),
        .instruction(instruction)
    ); // output: the [31:0] instruction

    // =========='ID stage'==========

    instructionDecoder id (
        .instruction(instruction),
        .rs1(rs1), .rs2(rs2), .rd(rd),
        .op(op), 
        .funct3(funct3),
        .funct73_r(funct73_r)
    ); // decomposes instruction

    controlUnit cu (
        .instruction(op),
        .branch(branch), .memRead(memRead), .memToReg(memToReg),
        .memWrite(memWrite), .aluSrc(aluSrc), .regWrite(regWrite),
        .aluOp(aluOp),
        .is_BRANCH(is_BRANCH), .is_LOAD(is_LOAD), 
        .is_STORE(is_STORE), .is_IMM(is_IMM), .is_ALU(is_ALU)
    ); // output: Control signals are set

    aluControl ac (
        .instruction(funct73_r),
        .aluOp(aluOp),
        .aluCtl(aluCtl)
    ); // output: 4'b ALU control 

    immediateGenerator #(WORDSIZE, WORDSIZE) ig(
        .instruction(op),
        .immediate(extendedImmediate)
    );

    registerFile #(5, WORDSIZE) rf(
        .clk(clk), .reset(reset), .regWrite(regWrite),
        .readReg1(rs1), .readReg2(rs2),
        .writeReg(rd),
        .writeData(writeData),
        .readData1(readData1), .readData2(readData2)
    ); // output: read Data from rs1, rs2 registers

    // =========='EX stage'==========

    aluMux #(WORDSIZE) amux(
        .readData2(readData2), immediate(extendedImmediate),
        .aluSrc(aluSrc)
    );

    alu #(WORDSIZE) au(
        .in1(readData1), .in2(alu_in2), .ctl(aluCtl),
        .result(aluResult),
        .zero(aluZero)
    ); 

    dataMemory #(5, WORDSIZE) dm(
        .memRead(memRead), .memWrite(memWrite), .clk(clk),
        .address(aluResult), .writeData(readData2),
        .readData(readMemoryData)
    );

    // // =========='WB stage'==========

    writeBackMux #(WORDSIZE) wbMux(
        .memToReg(memToReg),
        .readData(readMemoryData), .aluResult(aluResult),
        .writeData(writeDataToReg)
        
    );

endmodule