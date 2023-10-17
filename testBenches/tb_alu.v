`timescale 1ns / 1ps
`include "alu.v"
`define WORDSIZE 32

module tb_alu;
   reg [`WORDSIZE -1:0] a, b;
   reg [3:0] cntrl;
   wire [`WORDSIZE -1:0] res; 
   wire z;
   reg [`WORDSIZE -1:0] expected_res;

   alu #((`WORDSIZE)) uut(
       .in1(a),
       .in2(b),
       .ctl(cntrl),
       .result(res),
       .zero(z)
   );

   // Test cases: Initialize inputs, control signals, and expected results
   initial begin
       #10 repeat (20) begin
           a = $random;
           b = $random;
           cntrl = $random & 4'b0110; // Restrict cntrl to 0000, 0001, 0010, and 0110
           
           // Calculate expected result based on control signal
           case (cntrl)
               4'b0000: expected_res = a & b;
               4'b0001: expected_res = a | b;
               4'b0010: expected_res = a + b;
               4'b0110: expected_res = a - b;
               default: expected_res = 0; // Default value for other control signals
           endcase
           
           #5; // Provide some delay before the next test case
       end
   end

   // Monitor the simulation and compare the result with the expected result
   initial begin
       $display("TIME   A   B   CTL   Result   Expected   ZERO");
       $monitor("%2d %h %h %b %h %h %b", $time, a, b, cntrl, res, expected_res, z);
   end

   // Finish the simulation after a certain duration
   initial #200 $finish;

endmodule
