module dataMemory(
    input memRead, memWrite, clk, reset,
    input [4:0] address,
    input [31:0] writeData,
    output reg [31:0] readData
);

    reg [31:0] memory [0:1023]; //(4KB)
    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the memory to an initial state (all zeros in this case)
            for (i = 0; i < 1024; i = i + 1) begin
                memory[i] <= 32'h0;
            end
        end else begin
            if (memRead)
                readData <= memory[address];
            if (memWrite)
                memory[address] <= writeData;
        end
    end

endmodule
