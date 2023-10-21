module instructionDecoder (

    input [31:0] instruction,
    output reg [4:0] rs1, rs2, rd,
    output reg [6:0] op,
    output reg [2:0] funct3,
    output reg [6:0] funct7_r,
    output reg [11:0] immediate_il, immediate_s, immediate_b
);
    always @(*) begin

        // R, I, L formats
        rs1 <= instruction[19:15];
        rs2 <= instruction[24:20];
        rd <= instruction[11:7];

        // Opcode & funct3 common for RILSB 
        op <= instruction[6:0];
        funct3 <= instruction[14:12];

        // funct7_3 for alu control  only for R format
        funct73_r <= {instruction[30], instruction[14:12]};

        // Immediate value of I and L instructions
        immediate_il <= instruction[31:20]; 

        // Immediate values of Store and Branch Instructions
        immediate_s <= {instruction[31:25], instruction[11:7]};
        immediate_b <= {instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
        
    end
endmodule
