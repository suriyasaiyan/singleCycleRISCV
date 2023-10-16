`include "defines.vh"

module alu #(
    parameter WORDSIZE = 32
) (
    input [WORDSIZE-1:0] in1, in2,
    input [3:0] ctl,
    output reg [WORDSIZE-1:0] result,
    output zero
);

    always @(*) begin
        case (ctl)
            `AND: result = in1 & in2;
            `OR:  result = in1 | in2;
            `ADD: result = in1 + in2;
            `SUB: result = in1 - in2;
            default: result = 0;
        endcase
    end

    assign zero = (result == 0);

endmodule
