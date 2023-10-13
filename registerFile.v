module registerFile (
    input clk, regWrite, rst, 
    input [4:0] readReg1, readReg2, writeReg,
    input [31:0] writeData,
    output [31:0] readData1, readData2
);
    integer i;
    reg [31:0] registerFile [31:0]; //32 regs with 32 bit each
    initial registerFile[0] = 32'h00000000; 
    reg [4:0] readReg1_addr, readReg2_addr;

    always@(posedge clk or posedge rst) begin
        
        //updating the sources
        readReg1_addr <= readReg1;
        readReg2_addr <= readReg2;

        if (rst) begin
            for(i = 1; i < 32; i = i + 1) 
                registerFile[i] <= 32'h00000000;
        end

        else if (regWrite==1 & writeReg!=5'h00) 
            registerFile[writeReg] <= writeData;
        
    end

    assign readData1 <= registerFile[readReg1];
    assign readData2 <= registerFile[readReg2];

endmodule