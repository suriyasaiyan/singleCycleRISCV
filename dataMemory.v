module dataMemory
#(
    parameter ADDRSIZE = 5, // Number of Locations
    WORDSIZE = 32 // Size of each location
)
(
    input memRead, memWrite, clk, reset,
    input [4:0] address,
    input [WORDSIZE -1:0] writeData,
    output reg [WORDSIZE -1:0] readData
);
    localparam MEMSIZE = 1 << ADDRSIZE; // 2^ ADDRSIZE; memorySize
    reg [WORDSIZE - 1:0] memory [0:MEMSIZE - 1];
    integer i;

    initial begin
        
        for (i = 0; i < MEMSIZE; i = i + 1)
            memory[i] = 32'h00000000;
    end

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            for (i = 0; i < MEMSIZE; i = i + 1)
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
