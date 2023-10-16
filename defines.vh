// IMM and ALU

`define AND 4'b0000
`define OR  4'b0001
`define ADD 4'b0010
`define SUB 4'b0110


// Control Unit; OPCodes of Instructions

`define R_type 7'b0110011
`define I_type 7'b0010011
`define L_type 7'b0000011
`define S_type 7'b0100011
`define B_type 7'b1100011


// Control Signals
//aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp[1:0]

`define R_format 8'b00100010
`define I_format 8'b10100000
`define L_format 8'b11110000
`define S_format 8'b1x001000
`define B_format 8'b0x000101