`include "defines.vh"

module immediateGenerator
#(
    parameter INTRSIZE = 32,
    IMMSIZE = 32
)(
    input [INTRSIZE -1:0] instruction,
    output [IMMSIZE -1:0] immediate
);

    always @(*) begin

        case(instruction[6:0]) 
            I_type, L_type: immediate = {{20{instruction[31]}}, instruction[31:20]};
            S_type: immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            B_type: immediate = {{51{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0 };

        endcase
    end

endmodule