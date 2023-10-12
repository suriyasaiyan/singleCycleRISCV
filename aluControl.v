module aluControl(
  input [3:0] instruction; // INSTRUCTION [30, 14- 12] 30th bit: func7, 14-12:func3
  input [1:0] aluOp;       // Signal from Main Control
  output reg [3:0] aluCtl;
);

  localparam
    AND = 4'b0000,
    OR  = 4'b0001,
    ADD = 4'b0010,
    SUB = 4'b0110;

  always @(*) begin
    case ({aluOp, instruction})
      6'b00_xxxx: aluCtl <= ADD; // load and Store
      6'bx1_xxxx: aluCtl <= SUB; // beq or bneq
      6'b1x_0000: aluCtl <= ADD; // R-type instructions
      6'b1x_1000: aluCtl <= SUB;
      6'b1x_0111: aluCtl <= AND;
      6'b1x_0110: aluCtl <= OR;
      default: aluCtl <= ADD; // don't know what to default
    endcase
  end

endmodule