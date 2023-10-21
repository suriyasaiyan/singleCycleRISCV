start
clk high

pc goes to the instructionMemory.readAddress[0];
assign controlUnit.instruction = [6:0]instructionMemory.instruction;
set the control signals based on the instruction 
read the flags,


