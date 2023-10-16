// here initially declared output as reg, faced an error
// ERROR: concurrent assignement to a non-net is not permitted
// changed to wire

`include "defines.vh"

module controlUnit(
   input [6:0] instruction, //opcode
   output wire branch, memRead, memToReg, memWrite, aluSrc, regWrite,
   output wire [1:0] aluOp
);

reg [7:0] controlSignals;
always @(*) begin
       case(instruction)
           `R_type: controlSignals = `R_format;
           `I_type: controlSignals = `I_format;
           `L_type: controlSignals = `L_format;
           `S_type: controlSignals = `S_format;
           `B_type: controlSignals = `B_format;
           default: controlSignals = 8'b00000000;
       endcase
   end
assign {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]} = controlSignals;
endmodule