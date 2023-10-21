// if we write at 1 to 0, we have read it at 1 to 0 at the same cycle #10

module dataMemory
#(
    parameter ADDRSIZE = 5, 
    WORDSIZE = 32 
)(
    input memRead, memWrite, clk,
    input [WORDSIZE -1:0] address,
    input [WORDSIZE -1:0] writeData,
    output reg [WORDSIZE -1:0] readData
);
    localparam MEMSIZE = 1 << ADDRSIZE; 
    reg [WORDSIZE - 1:0] memory [0:MEMSIZE - 1];

    initial $readmemh("dmem.mem", memory); 

    always @(*) begin readData <= memory[address]; end

    always @(posedge clk) begin

        if (memRead)
            readData <= memory[address];
        if (memWrite)
            memory[address] <= writeData;   
    end
endmodule
