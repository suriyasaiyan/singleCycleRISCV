`include"registerFile.v"

module testbench_registerFile;
    reg clk;
    reg regWrite;
    reg reset;
    reg [4:0] readReg1;
    reg [4:0] readReg2;
    reg [4:0] writeReg;
    reg [31:0] writeData;
    wire [31:0] readData1;
    wire [31:0] readData2;

    // Instantiate the module under test
    registerFile #(
        .ADDRSIZE(5),
        .WORDSIZE(32)
    ) uut (
        .clk(clk),
        .regWrite(regWrite),
        .reset(reset),
        .readReg1(readReg1),
        .readReg2(readReg2),
        .writeReg(writeReg),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2)
    );

    always begin
        #5 clk = ~clk; 
    end

    initial begin

        clk = 0;
        reset = 1;
        regWrite = 0;
        readReg1 = 0;
        readReg2 = 0;
        writeReg = 0;
        writeData = 0;

        #5 reset = 0;

        // Test case 1: Write to register 1 and read from it
        regWrite = 1;
        writeReg = 1;
        writeData = 32'h12345678;
        #10;
        regWrite = 0;
        readReg1 = 1;
        #10;

        // Test case 2: Write to register 2 and read from it
        regWrite = 1;
        writeReg = 2;
        writeData = 32'h9ABCDEF1;
        #10;
        regWrite = 0;
        readReg2 = 2;
    end

    initial #16 $display("Time = %0t: readData1 = %h", $time, readData1);
    initial #36 $display("Time = %0t: readData2 = %h", $time, readData2);
  
    
    initial #70 $finish;
endmodule
