`timescale 1ps/1ps
module tb();

reg preset_n; initial begin preset_n = 1; #10000 preset_n = 0; #100000 preset_n = 1; end
reg pclk; initial begin pclk = 0; #313333 pclk = 0; forever #11072.1 pclk = ~pclk; end//45.1584MHZ   11072.1  49.152mhz 10172.5
reg sdclk; initial begin sdclk = 0; #313333 sdclk = 0; forever #800000 sdclk = ~sdclk; end

reg start;
wire signed [31:0] pcm;
wire signed [31:0] angle;
wire started;
reg cmdin;
wire cmdout;
wire  cmd;
reg en;
//assign angle = 'b00100000000000000000000000000000;
assign angle = 12173944;       //1KHz @ 352.8KHz @45MHz Mclk
//assign angle = 3043486;        //250Hz @ 352.8KHz
//assign angle = 97391549;       //1KHz @ 44.1KHz
initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0,tb);
end


initial begin
    start = 0;
	en =0;
    #800000 start = 1;
	en =1;
	#3200000 en = 0;
    end

initial begin
    cmdin = 0;
    #800000 cmdin = 1;
	#800000 cmdin = 1;
	#800000 cmdin = 0;
	#800000 cmdin = 0;
	#800000 cmdin = 1;
	#800000 cmdin = 0;
	#800000 cmdin = 1;
	#800000 cmdin = 0;
	#800000 cmdin = 1;
    end
	
assign cmdout = cmd;

assign cmd = en?cmdin:1'bz;
parameter LEVEL_0dB =  40'd1304065748 * 256;
parameter LEVEL_N12dB = 40'd1304065748 * 64;
parameter LEVEL_N60dB = 40'd1304065748 / 4; 
parameter LEVEL_MUTE = 40'd0;

wire signed [39:0] level;  // amplitude of wavegen
assign level = LEVEL_0dB;


wavegen U100(.pclk(pclk), .preset_n(preset_n), .start(start),
     .level(level),
     .angle(angle), .started(started), .pcm_out(pcm));
	 

		
// to PCM352
parameter PCM441=2'b00;
parameter PCM882=2'b01;
parameter PCM176=2'b10;
parameter PCM352=2'b11;

wire [1:0] ctrl = PCM176;

reg [19:0] j;

integer fs,fr;
	 
// generate slow pcm
//reg [9:0] i;   //44.1K
//reg [8:0] i;   //88.2K
//reg [7:0] i;   //176.4K
reg [6:0] i;    //352.8k
reg signed [31:0] pcmslow;
reg [1:0] filter_types;
reg clk_d2;
always @(posedge pclk or preset_n)
	begin
	if(preset_n == 0||pcmslow == 32'd0)
		clk_d2 <= 1'b0;
	else clk_d2 <= ~clk_d2;
	end
reg wlrck;
always @(posedge pclk or preset_n)
	begin
	if(preset_n==0||pcmslow == 32'd0)
		wlrck <= 1'b0;
	else if(num == 127||num == 255)
		wlrck <= ~wlrck;
	else
		wlrck <= wlrck;
	end
reg [15:0]num;
always @(posedge pclk or preset_n)
	begin
	if(preset_n==0||pcmslow == 32'd0)
		num <= 15'd0;
	else if(num == 255)
		num <= 15'd0;
	else
		num <= num + 15'd1;
	end
always @(posedge pclk or negedge preset_n) 
    if (0==preset_n) begin
        i<=0;  
		pcmslow <= 0;
		filter_types <= 2'b00;
	    j <= 0;
	   // fs = $fopen("77.txt");
		//fr = $fopen("44.txt");
        end
    else begin
        i <= i+1;
        if (i==0) begin
            pcmslow <= pcm; 
            
//        #10 $display("@@@@=%d",  pcmslow);   //must delay to allow logic settle
            end
		if(i == 1) begin
		   //$fdisplay(fs,"@@@@=%d",pcm);
		   //$fdisplay(fr,"@@@@=%d",yr);
		   j <= j + 1;
		   if(j == 2048) filter_types <= 2'b01;
		   if(j == 4096) filter_types <= 2'b10;
		   if(j == 6144) filter_types <= 2'b11;
		   if(j == 8192) begin
		     //$fclose(fs);
			 //$fclose(fr);
			 $finish;
		   end
        end
end

// up convert


//rom
wire [1:0] ov = (ctrl==PCM352) ? 2'd0 :
                (ctrl==PCM176) ? 2'd1 :
                (ctrl==PCM882) ? 2'd2 : 2'd3;
				
wire signed [31:0] up_pcm_l, up_pcm_r;
//pcm up
// pcm_up_convert U_pcm_up_convert(
//                .mclk(pclk),//45.1584MHZ
//                .reset_n(preset_n),
//                .start(start),
//                .ctrl(ctrl),
//               // .filter_types(filter_types),
//                .xl(pcmslow),
//                .xr(pcmslow),
//                .yl(up_pcm_l),
//                .yr(up_pcm_r),
//                .started()
//        );
//down
down176 u_down176(
.pclk(pclk),
.reset_n(preset_n),
.ibick(clk_d2),
.ldata(pcmslow),
.rdata(pcmslow),
.ilrck(wlrck),
.obick(),
.olrck(),
.down_ldata(),
.down_rdata()

);


/*
test u_test(
.reset_n(preset_n),

.mclk(pclk),
.source_left(pcmslow),
.source_right(pcmslow),
.sdclk(),
.cmd(),
.sd_d0(),
.sd_d1(),
.sd_d2(),
.sd_d3(),

.dsd_lp0(),
.dsd_lp1(),
.dsd_lp2(),
.dsd_lp3(),
.dsd_lp4(),
.dsd_lp5(),
.dsd_lp6(),
.dsd_lp7(),
.dsd_ln0(),
.dsd_ln1(),
.dsd_ln2(),
.dsd_ln3(),
.dsd_ln4(),
.dsd_ln5(),
.dsd_ln6(),
.dsd_ln7(),
.dsd_rp0(),
.dsd_rp1(),
.dsd_rp2(),
.dsd_rp3(),
.dsd_rp4(),
.dsd_rp5(),
.dsd_rp6(),
.dsd_rp7(),
.dsd_rn0(),
.dsd_rn1(),
.dsd_rn2(),
.dsd_rn3(),
.dsd_rn4(),
.dsd_rn5(),
.dsd_rn6(),
.dsd_rn7()


);
*/
/*
reg [6:0] k;    //352.8k
reg [19:0] m;

always @(posedge pclk or negedge preset_n) begin
    if (0==preset_n) begin
      k <= 0;
	  m <= 0;
	  fr = $fopen("352.txt");
	end
	else begin
	  k <= k +1;
	  if(k ==  1) begin
	     $fdisplay(fr,"@@@@=%d",pcmslow);
		m <= m + 1;
		if(m == 65600) $fclose(fr);
	  end
	end
end
*/
endmodule
