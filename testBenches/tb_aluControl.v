// `include "defines.vh"
// `include "aluControl.v"

// module aluControl_tb;
//   reg [3:0] instruction;
//   reg [1:0] aluOp;
//   wire [3:0] aluCtl;
//   reg [3:0] expectedAluCtl;
//   reg [3:0] pattern [0:5];

//   aluControl aluControl_inst (
//     .instruction(instruction),
//     .aluOp(aluOp),
//     .aluCtl(aluCtl)
//   );

//   initial begin
//         pattern[0] = 4'b0000;
//         pattern[1] = 4'b1000;
//         pattern[2] = 4'b0111;
//         pattern[3] = 4'b0110;
//   end

//   initial begin
//     #10repeat(20) begin
//       instruction = pattern [$random & 2'b11];
//       aluOp = $random & 2'b11;
//       case (aluOp)
//         2'b00: expectedAluCtl = `ADD; 
//         2'b01: expectedAluCtl = `SUB; 
//         default:
//           case (instruction)
//             4'b0000: expectedAluCtl = `ADD;
//             4'b1000: expectedAluCtl = `SUB; 
//             4'b0111: expectedAluCtl = `AND; 
//             4'b0110: expectedAluCtl = `OR; 
//             default: expectedAluCtl = `ADD; 
//           endcase
//       endcase
//       #5; 
//     end
//   end 

//     initial begin
//         $monitor("time= %2d, aluOp= %b, instruction= %b, aluCtl= %b, Expected= %b" ,$time, aluOp, instruction, aluCtl, expectedAluCtl);
//     end

//     initial #200 $finish;

// endmodule



`timescale 1ns / 1ps
`include "defines.vh" 
module tb_aluControl;

  reg [3:0] instruction;
  reg [1:0] aluOp;
  wire [3:0] aluCtl;
  integer i;

  aluControl uut (
    .instruction(instruction),
    .aluOp(aluOp),
    .aluCtl(aluCtl)
  );

  initial begin
        for (i = 0; i < 10; i = i + 1) begin
          instruction = $random & 4'b1111;
          aluOp = $random & 2'b11;
          #10;
          $display("instr= %b, aluOp = %b, aluCtl = %b", instruction, aluOp, aluCtl);
        end
    $finish;
  end

endmodule

