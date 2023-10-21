`include "defines.vh"

module immediateGenerator
#(
    parameter IMMSIZE = 32
)(
    input [6:0] instruction,
    output reg [IMMSIZE -1:0] immediate
);

    always @(*) begin

        case(instruction) 
            `I_type, `L_type: immediate = {{20{instruction[31]}}, instruction[31:20]};
            `S_type: immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            `B_type: immediate = {{21{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8]};

        endcase
    end

endmodule