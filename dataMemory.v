module dataMemory
#(
    parameter ADDRSIZE = 32, // Number of Locations
    WORDSIZE = 32 // Size of each location
)
(
    input memRead, memWrite, clk, reset,
    input [4:0] address,
    input [31:0] writeData,
    output reg [31:0] readData
);

    reg [WORDSIZE - 1:0] memory [0:ADDRSIZE - 1];
    integer i;

    initial begin
        
        for (i = 1; i < ADDRSIZE; i = i + 1)
            memory[i] = 32'h00000000;
    end

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            for (i = 1; i < ADDRSIZE; i = i + 1)
                memory[i] <= 32'h00000000;
        end
        else
        begin
            if (memRead)
                readData <= memory[address];
            if (memWrite)
                memory[address] <= writeData;
        end
    end

endmodule
