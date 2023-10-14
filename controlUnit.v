`include "defines.vh"

module controlUnit(
   input [6:0] instruction, //opcode
   output reg branch, memRead, memToReg, memWrite, aluSrc, regWrite,
   output reg [1:0] aluOp
);

reg [7:0] controlSignals;

always @(*) begin
       case(instruction)
           `R_type: controlSignals = 8'b00100010;
           `I_type: controlSignals = 8'b10100000;
           `L_type: controlSignals = 8'b11110000;
           `S_type: controlSignals = 8'b1x001000;
           `B_type: controlSignals = 8'b0x000101;
           default: controlSignals = 8'b00000000;
       endcase
   end

assign {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]} = controlSignals;

endmodule