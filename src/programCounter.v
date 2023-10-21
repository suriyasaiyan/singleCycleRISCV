module Adress_Generator #(
    parameter WORDSIZE =  32,
    PC_INIT_VAL = 32'b0
)(
    input reset,clk,
    input pcSrc, // the AND of branch and Zero
    input [WORDSIZE-1:0] immExt, // output of the immediate Generator
    output reg [WORDSIZE-1:0] PC
);
    initial currentAddress = PC_INIT_VAL;

    reg[31:0] pcNext;

    always @(*) begin
            pcNext <= pcSrc?  PC + immExt : PC + 4;
        end

    always @(posedge clk or posedge reset) begin
        if (rst)
            PC <= PC_INIT_VAL;
        else
            PC <= pcNext;    
    end 
    

endmodule