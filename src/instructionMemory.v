module instructionMemory 
#( 
    parameter ADDRSIZE = 5, 
    WORDSIZE = 32   
)(
    input [5:0] readAddress, 
    output [WORDSIZE -1:0] instruction  
    );

    localparam MEMSIZE = 1 << ADDRSIZE;
    reg [WORDSIZE - 1:0] instructionMemory [0:MEMSIZE - 1];
    
    initial $readmemh("imem.mem", instructionMemory); 

    assign instruction = instructionMemory[readAddress]; 
    
endmodule