module immediateGenerator(
    input [31:0] instruction,
    output [31:0] immediate
);

    localparam
       R_type = 7'b0110011,
       I_type = 7'b0010011,
       L_type = 7'b0000011,
       S_type = 7'b0100011,
       B_type = 7'b1100011;

    always @(*) begin

        case(instruction[6:0]) 
            I_type, L_type: immediate = {{20{instruction[31]}}, instruction[31:20]};
            S_type: immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            B_type: immediate = {{51{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0 };

        endcase
    end

endmodule