`timescale 1ps/1ps
module cic(
       	input mclk,//45.1584MHZ
	input reset_n,
	input signed[31:0] pcm_in,//352.8khz 
	output signed[31:0] pcm_out //44.1khz
	   );
	   
localparam LAST_CYCLE = 128;
parameter ILEN = 9;
wire [3:0]XHDATA;
assign XHDATA = 2**(ILEN-6);
reg [ILEN:0]i;
reg signed [35:0] temp_pcm;
reg signed [35:0] dout_pcm;
assign pcm_out = dout_pcm[35:4];
always @(posedge mclk or negedge reset_n) begin
  if(reset_n == 1'b0) begin
    i <= 0;
	temp_pcm<=0;
	dout_pcm<=0;
  end
  else begin
    i<= i+1;
	if(i == (LAST_CYCLE-1) || i == (LAST_CYCLE*2-1) ||i == (LAST_CYCLE*3-1) || i == (LAST_CYCLE*4-1) || i == (LAST_CYCLE*5-1)||i == (LAST_CYCLE*6-1) ||i == (LAST_CYCLE*7-1)  ) temp_pcm <= temp_pcm + pcm_in;
	if(i == (LAST_CYCLE*XHDATA-1)) begin 
	  dout_pcm<= temp_pcm + pcm_in;
	  temp_pcm<=0;
	end
  end 
end
endmodule
