module controlUnit(
   input [6:0] instruction, //opcode
   output reg branch, memRead, memToReg, memWrite, aluSrc, regWrite,
   output reg [1:0] aluOp
);
   localparam
       R_type = 7'b0110011,
       I_type = 7'b0010011,
       L_type = 7'b0000011,
       S_type = 7'b0100011,
       B_type = 7'b1100011;

reg [7:0] controlSignals;

always @(*) begin
       case(instruction)
           R_type: controlSignals = 8'b00100010;
           I_type: controlSignals = 8'b10100000;
           L_type: controlSignals = 8'b11110000;
           S_type: controlSignals = 8'b1x001000;
           B_type: controlSignals = 8'b0x000101;
           default: controlSignals = 8'b00000000;
       endcase
   end

assign {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]} = controlSignals;

endmodule