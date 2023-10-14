`inclue "defines.vh"

module alu #(
    parameter WORDSIZE = 32
) (
    input [WORDSIZE-1:0] in1, in2,
    input [3:0] ctl,
    output [WORDSIZE-1:0] result,
    output zero
);

    function [WORDSIZE-1:0] aluOperation (
        input [WORDSIZE-1:0] a,
        input [WORDSIZE-1:0] b,
        input [3:0] ctl
    );
        case (ctl)
            `AND:    return a & b;
            `OR:     return a | b;
            `ADD:    return a + b;
            `SUB:    return a - b;
            default: return 0;
        endcase
    endfunction

    assign result = aluOperation(in1, in2, ctl);
    assign zero = (result == 0);

endmodule
