//
// 1 stage pipeline, consider using it in ASIC designs since it uses less registers.
//
`timescale 1ps/1ps

module mult28x32(
input clk,
input reset_n,
input signed [27:0] a,
input signed [31:0] b,
output reg signed [59:0] y
);

//reg signed [59:0] res;
//assign y =  res;
always @(posedge clk or negedge reset_n)
    if (reset_n == 0) begin
         y <= 0;
         end
    else begin
         y <= #1 a*b;
         end

endmodule





