/*registerFile.v

parameters: ADDRSIZE - No of bits to address a registerFile
            WORDSIZE - size of each register

localparam RFSIZE - no of registers to specify the memory

changes required: need to hardwire reg0 to 0 and we shouldn't be able to access it.
*/

module registerFile #(
    parameter ADDRSIZE =5, 
    WORDSIZE = 32
) (
    input clk, regWrite, reset, 
    input [ADDRSIZE -1:0] readReg1, readReg2, writeReg,
    input [WORDSIZE -1:0] writeData,
    output wire [WORDSIZE -1:0] readData1, readData2
);
    localparam RFSIZE = 1 << 5; // 2^ADDRSIZE, regFileSize
    integer i;
    reg [WORDSIZE -1:0] registerFile [0:RFSIZE -1]; //32 regs, 32 bit each

    initial begin
        
        registerFile[0] = 32'h00000000;

        for (i = 1; i < RFSIZE; i = i + 1) 
            registerFile[i] = 32'h00000000;
    end

    reg [4:0] readReg1_addr, readReg2_addr;

    always@(posedge clk or posedge reset) begin
        
        //updating the sources
        readReg1_addr <= readReg1;
        readReg2_addr <= readReg2;

        if (reset) begin
            for(i = 1; i < ADDRSIZE; i = i + 1) 
                registerFile[i] <= 32'h00000000;
        end

        else if (regWrite==1 & writeReg!=5'h00) 
            registerFile[writeReg] <= writeData;
        
    end
    always @(*) begin

        readData1 = registerFile[readReg1_addr];
        readData2 = registerFile[readReg2_addr];
    end 
    
endmodule