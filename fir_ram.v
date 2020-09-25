
// FIR filter delay ram
// dual port syn rom, wclk === rclk === clk

module fir_ram #(
    parameter ADDR_W=7, 
    parameter DATA_W=32
)(
input clk,
input reset_n,
input we,
input [ADDR_W-1:0] waddr,
input [DATA_W-1:0] di,

input [ADDR_W-1:0] raddr,
output [DATA_W-1:0] dout
);

localparam MEM_LEN = {ADDR_W{1'b1}};

reg [DATA_W-1:0] mem [0:MEM_LEN];
reg [DATA_W-1:0] rdata;

assign dout = rdata;
integer n;
always @ (posedge clk or negedge reset_n)
   if (1'b0 == reset_n) begin
       for (n = 0; n <= MEM_LEN; n = n +1)   mem[n] <= 0;
       rdata <= 0;
       end
   else begin
       if (we) mem[waddr] <= di;
       rdata <= mem[raddr];
       end

endmodule

