module registerFile #(
    parameter ADDRSIZE =32,
    WORDSIZE =32
) (
    input clk, regWrite, rst, 
    input [4:0] readReg1, readReg2, writeReg,
    input [31:0] writeData,
    output [31:0] readData1, readData2
);
    integer i;
    reg [WORDSIZE -1:0] registerFile [0:ADDRSIZE -1]; //32 regs with 32 bit each

    initial begin
        
        registerFile[0] = 32'h00000000;
        for (i = 1; i < ADDRSIZE; i = i + 1) 
            registerFile[i] = 32'h00000000;
    end

    reg [4:0] readReg1_addr, readReg2_addr;

    always@(posedge clk or posedge rst) begin
        
        //updating the sources
        readReg1_addr <= readReg1;
        readReg2_addr <= readReg2;

        if (rst) begin
            for(i = 1; i < ADDRSIZE; i = i + 1) 
                registerFile[i] <= 32'h00000000;
        end

        else if (regWrite==1 & writeReg!=5'h00) 
            registerFile[writeReg] <= writeData;
        
    end

    assign readData1 <= registerFile[readReg1];
    assign readData2 <= registerFile[readReg2];

endmodule