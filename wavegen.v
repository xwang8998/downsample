// generate sine wave for testing
// this version will generate 1KHz @ 352.8KHz sample rate,  under 45.1584MHz clock

module wavegen(
input pclk,
input preset_n,
input start,
input signed [39:0] level,    //amplitude
input signed [31:0] angle,
output started,
output signed [31:0] pcm_out
);

reg reset_n;
always @* if (start == 0) reset_n = 0; else reset_n = preset_n;

reg pclk_div2;
always @(posedge pclk or negedge reset_n) 
    if (1'b0 == reset_n) pclk_div2 <= 0;
    else pclk_div2 <= ~pclk_div2;

parameter WG_000 = 3'h0,
          WG_100 = 3'h1,
          WG_200 = 3'h2,
          WG_300 = 3'h3,
          WG_400 = 3'h4,
          WG_500 = 3'h5,
          WG_600 = 3'h6,
          WG_700 = 3'h7;

wire signed [31:0] SCALE_1;
assign SCALE_1 = 32'd1304065748;//0.607252935
//assign SCALE_1 = 34'd5216262993;
//assign SCALE_1 = 32'd6072;


reg signed [39:0] xstart, ystart, n_xstart, n_ystart;
reg signed [71:0] AX, n_AX, BX, n_BX;
reg [9:0] i, n_i;
reg [2:0] state, n_state;
wire signed [39:0] cos, sin;
reg signed [31:0] waveout, n_waveout;
reg working, n_working;

assign started = working;

assign pcm_out = waveout;


cordic UCORD(.clk(pclk_div2), .preset_n(preset_n), .start(start),
.xi(xstart), .yi(ystart), .angle(angle), .cos(cos), .sin(sin));

always @(posedge pclk_div2 or negedge reset_n) 
    if (reset_n == 0) begin
        AX <= 0; BX <= 0;
        xstart <= 0;
        ystart <= 0;
        i <= 0;
        waveout <= 0;
        state <= 0;
        working <= 0;
        end
    else begin
        AX <= n_AX;  BX <= n_BX;
        xstart <= n_xstart;
        ystart <= n_ystart;
        i <= n_i;
        waveout <= n_waveout;
        state <= n_state;
        working <= n_working;
        end


always @* begin
    n_AX = AX; n_BX = BX;
    n_xstart = xstart;
    n_ystart = ystart;
    n_i = i;
    n_waveout = waveout;
    n_state = state;
    n_working = working;
    case(state)

WG_000: begin
        n_working = 0;
        n_AX = 0; n_BX = 0;
        //n_xstart = SCALE_1*256;          // 0 degree, cos = 1, sin = 0;
        //n_xstart = SCALE_1*128;          // 0 degree, cos = 1, sin = 0;
        //n_xstart = SCALE_1*64;           // 0 degree, cos = 1, sin = 0; //-12dB
        //n_xstart = SCALE_1/4;            // 0 degree, cos = 1, sin = 0; //-60dB
        n_xstart = level; 
        
        n_ystart = 0;
        n_i = 0;
        if (start == 1) n_state = WG_100;
        end

WG_100: begin
        if (i == 57) n_state = WG_200;  // CORDIC calc , 128 cycle loop, sample rate 352.8k
        //if (i == 121) n_state = WG_200;  // CORDIC calc , 128 cycle loop, sample rate 352.8k
        //if (i == 121+1024-128) n_state = WG_200;  // 1024 cycle loop, sample rate 44.1k
        n_i = i+1;
        end

WG_200: begin
        n_xstart = cos;       //result
        n_ystart = sin;       //result
        n_i = 0;
        n_state = WG_300; 
        end

WG_300: begin
        n_AX = xstart * SCALE_1;
        n_BX = ystart * SCALE_1;
        n_state = WG_400;
        end
WG_400: begin
        n_state = WG_500;
        end
WG_500: begin
        n_state = WG_600;
        end
WG_600: begin
        n_state = WG_700;
        end
WG_700: begin
        n_waveout = ystart[39:8];
        //#10 $display("@@@@=%d",  n_waveout);   //must delay to allow logic settle
        n_xstart = AX[70:31];
        n_ystart = BX[70:31];
        n_state = WG_100;
        n_working = 1;
        end
    endcase
    end

endmodule

