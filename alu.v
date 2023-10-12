module alu #(
    parameter REGSIZE = 64
) (
    input [REGSIZE-1:0] in1, in2,
    input [3:0] ctl,
    output [REGSIZE-1:0] result,
    output zero
);

    function [REGSIZE-1:0] aluOperation (
        input [REGSIZE-1:0] a,
        input [REGSIZE-1:0] b,
        input [3:0] ctl
    );
        case (ctl)
            4'b0000: return a & b;
            4'b0001: return a | b;
            4'b0010: return a + b;
            4'b0110: return a - b;
            default: return 0;
        endcase
    endfunction

    assign result = aluOperation(in1, in2, ctl);
    assign zero = (result == 0);

endmodule
