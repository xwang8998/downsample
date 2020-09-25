module down176(
input pclk,
input reset_n,
input ibick,
input [31:0]ldata,
input [31:0]rdata,
input ilrck,
output reg obick,
output reg olrck,
output [31:0]down_ldata,
output [31:0]down_rdata
);
assign down_ldata = y0;
assign down_rdata = y1;
reg [6:0]i;
reg [31:0]y0,y1;
always @(posedge ibick or negedge reset_n)
	begin
	if(reset_n ==0)
		obick <= 1'b0;
	else
		obick <= ~obick;
	end
always @(posedge ilrck or negedge reset_n)
	begin
	if(reset_n == 0)
		olrck <= 1'b0;
	else
	 	olrck <= ~olrck;
	end	
always @(posedge ibick or negedge reset_n)
	begin
		if(reset_n == 1'b0)begin
			i<=0;
			y0<=32'd0;
			y1<=32'd0;

		end
		else begin
		i <= i+1;
		if(i==127)
			begin
			y0 <= ldata;
			y1 <= rdata;
			end
		end	

	end
wire [31:0]pcm705;
rompcm705 u_pcm705(
.clk(pclk),
.reset_n(reset_n),
.addrout(pcm705)
);
wire [31:0]pcm_out;
cic
#(.ILEN(6))//9-441  8-882  7-176.4  6-352.8
 u_cic(
.mclk(pclk),//45.1584MHZ
.reset_n(reset_n),
.pcm_in(pcm705),//352.8khz 
.pcm_out(pcm_out) //44.1khz
);

wire [31:0]topdata;
down768_384 u_down768_384(
.addr(i),
.topdata(topdata)
);

wire [31:0]topdata1;
down768_384_n u_down768_384_n(
.addr(i),
.topdata(topdata1)
);
endmodule
