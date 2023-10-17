` include "instructionMemory.v"
module tb_instructionMemory();

    reg [5:0] readAddress; 
    wire [31:0] instruction;  
    integer i;

    instructionMemory #(5,32) uut (

        .readAddress (readAddress), 
        .instruction (instruction)
    ); 

    initial begin

        for (i = 0; i < 32; i = i + 1) begin
            readAddress = i;
            #5;
        end

        $finish;
    end

    initial begin
        $monitor("inst=%h, addr=%d", instruction, readAddress);
    end

endmodule
