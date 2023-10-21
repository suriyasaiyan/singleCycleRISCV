module controlUnit(
    input wire [6:0] instruction,
    output wire branch, memRead, memToReg, memWrite, aluSrc, regWrite,
    output wire [1:0] aluOp,
    // output wire is_BRANCH, is_LOAD, is_STORE, is_IMM, is_ALU
);

    wire [6:0] opCode;
    assign opCode = instruction[6:0];

    wire [7:0] controlSignals;

    always @* begin

        case(opCode) 
            `B_type: controlSignals = `B_format;
            `R_type: controlSignals = `R_format;
            `I_type: controlSignals = `I_format;
            `L_type: controlSignals = `L_format;
            `S_type: controlSignals = `S_format;
            default: controlSignals = 8'b00000000; 
        endcase

        // // Update flags based on opCode
        // is_BRANCH    = (opCode == `B_type);
        // is_LOAD      = (opCode == `L_type);
        // is_STORE     = (opCode == `S_type);
        // is_IMM       = (opCode == `I_type);
        // is_ALU       = (opCode == `R_type);

        assign {aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]} = controlSignals;

    end
endmodule
