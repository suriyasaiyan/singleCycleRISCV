`include "defines.vh"
`include "dataMemory.v"

module tb_dataMemory;
    reg memRead, memWrite, clk;
    reg [4:0] address;
    reg [31:0] writeData;
    wire [31:0] readData;

    dataMemory #(5, 32) uut (
        .memRead(memRead),
        .memWrite(memWrite),
        .clk(clk),
        .address(address),
        .writeData(writeData),
        .readData(readData)
    );

    always #5 clk = ~ clk;
    
    initial begin
        clk =0;
        memRead =0;
        memWrite = 0;
        address = 5'd0;
        writeData = 32'h00000000;
     
        #5 memWrite = 1; // 0 to 1
        address = $random & 5'b11111;
        writeData = $random & 32'hFFFFFFFF;
        #5 memWrite = 0; // 1 to 0

        #5 memRead = 1; // 0 to 1
        if (readData != writeData) $display("%h != %h", readData, writeData);
        else $display("PASSED");
    end

    initial begin

    end

    
    initial #20 $finish;

    
endmodule
