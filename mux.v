module aluMux #(
    parameter WORDSIZE = 32
)(
    input [WORDSIZE-1:0] readData2, immediate,
    input aluSrc,
    output [WORDSIZE-1:0] alu_in2
);
    
    assign alu_in2 = aluSrc ? immediate : readData2;
endmodule



module writeBackMux #(
    parameter WORDSIZE =32      
)(
    input [WORDSIZE -1 : 0] readData, aluResult,
    input memToReg,
    output [WORDSIZE -1:0] writeData
)
    assign writeData = memToReg ? readData : aluResult;
endmodule