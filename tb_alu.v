module tb_alu();
parameter WORDSIZE = 64;
reg [WORDSIZE -1: 0] in1,in2;
reg [3:0] ctl;
wire [WORDSIZE -1: 0] result;
wire zero;
integer i;

alu #(REGSIZE) uut (
    .in1(in1), 
    .in2(in2),
    .ctl(ctl),
    .result(result),
    .zero(zero)
)
initial begin
    for(i = 0; i < 10; i += 1)
        in1 = $random;
        in2 = $random;
        ctl = 
endmodule