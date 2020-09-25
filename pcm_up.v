
// upconvert 44.1/88.2/176.4 pcm to 352.8
// source_type: 00->44.1 01->88.2  10->176.4 11->352.8

`timescale 1ps/1ps

module pcm_up(
input mclk,      //45.1584MHz clock
input reset_n,
input start,

//rom interface
output [9:0] tap_addr,
input signed [31:0] tap,

input [1:0] source_type,  
input signed [31:0]xl,             //input sample
input signed [31:0]xr,             //input sample
output started,
output reg signed [31:0] yl,
output reg signed [31:0] yr
);

parameter PCM441 = 2'b00;
parameter PCM882 = 2'b01;
parameter PCM176 = 2'b10;
parameter PCM352 = 2'b11;


parameter FIR1_000 = 1'b0,
          FIR1_100 = 1'b1;

wire rst_n = start ? reset_n : 1'b0;


reg state, n_state;
reg [6:0] j, n_j;
reg [2:0] k, n_k;
reg work, n_work;
assign started = work;

wire [6:0] jj = 7'd127 - j;

assign tap_addr = (PCM441 == source_type) ? {jj[6:0],k[2:0]} :
                  (PCM882 == source_type) ? {1'b0, jj[6:0],k[1:0]} :
                  (PCM176 == source_type) ? {2'b00, jj[6:0],k[0]} : {3'b000, j[6:0]};

wire [2:0] last_k;
assign last_k = (PCM441 == source_type) ? 3'd7 :
                (PCM882 == source_type) ? 3'd3 :
                (PCM176 == source_type) ? 3'd1 : 3'd0;

reg signed [31:0] n_yl, n_yr;
reg signed [59:0] sum_0, n_sum_0;
reg signed [59:0] sum_1, n_sum_1;

wire signed [59:0] mul_fir0_tap;
wire signed [59:0] mul_fir1_tap;

wire signed [31:0] TAP_AT_tap_pos = tap;


//////2p ram//////////////////////
reg wen, n_wen;
reg [6:0] waddr, n_waddr, raddr, n_raddr, ram_addr, n_ram_addr;
wire [31:0] dout_0, dout_1;
fir_ram #(.ADDR_W(7), .DATA_W(32)) UR0(.clk(mclk), .reset_n(rst_n), .we(wen), .waddr(waddr), .di(xl), .raddr(raddr), .dout(dout_0));
fir_ram #(.ADDR_W(7), .DATA_W(32)) UR1(.clk(mclk), .reset_n(rst_n), .we(wen), .waddr(waddr), .di(xr), .raddr(raddr), .dout(dout_1));
mult28x32 UM1 (.clk(mclk), .reset_n(rst_n), .a(dout_0[31:4]), .b(TAP_AT_tap_pos), .y(mul_fir0_tap));
mult28x32 UM2 (.clk(mclk), .reset_n(rst_n), .a(dout_1[31:4]), .b(TAP_AT_tap_pos), .y(mul_fir1_tap));
//////2p ram//////////////////////

always @(posedge mclk or negedge rst_n)
    if (rst_n == 0) begin
        j <= 0;
        k <= 0;
        sum_0 <= 0;
        yl <= 0;
        sum_1 <= 0;
        yr <= 0;
        state <= 0;
        work <= 0;
        
        wen <= 0; 
        waddr <= 0;
        raddr <= 0;
        ram_addr <= 0;

        end
    else begin
        j <= n_j;
        k <= n_k;
        sum_0 <= n_sum_0;
        yl <= n_yl;
        sum_1 <= n_sum_1;
        yr <= n_yr;
        state <= n_state;
        work <= n_work;

        wen <= n_wen;
        waddr <= n_waddr;
        raddr <= n_raddr;
        ram_addr <=n_ram_addr;

        end

//FSM body
always @* begin
    n_j = j;
    n_k = k;
    n_sum_0 = sum_0;
    n_yl = yl;
    n_sum_1 = sum_1;
    n_yr = yr;
    n_state = state;
    n_work = work;

    n_wen = wen;
    n_waddr = waddr;
    n_raddr = raddr;
    n_ram_addr = ram_addr;


    case(state)

FIR1_000: begin
    n_work = 0;
    n_sum_0 = 0;
    n_sum_1 = 0;
    n_k = 0;
    n_j = 0;
    if (start == 0) n_state = FIR1_000;
    else begin
         n_state = FIR1_100;
         end
    end

//// Big loop for polyphase interpolation FIR  /////
//// first, we start with
//// fir[0] * C0 + fir [1] * c8 + fir[2] * c16 ... ==> out0
//// then 
//// fir[0] * C1 + fir [1] * c9 + fir[2] * c17 ... ==> out1
//// ...
//// until 
//// fir[0] * C7 + fir [1] * c15 + fir[2] * c23 ... ==> out7
//// then
//// read new input x, shift fir[], redo the loop
// BIG LOOP, for example, 8x oversampling will loop 8 times
// 4x oversampling will loop 4 times
// BIG Loop's counter is k;
// each polyphase sub tap's length should < 126 because
// output rate is 352800 and our clock is 45.1584MHz, which is 
// 128x of 352800, need to finish calculating polyphase in 128 cycles
// polyphase loop counter is j

FIR1_100: begin     // inner loop, calculate filter result: sum
                    // go through poly phase sub filter (max 126!)
                    // for 8x filter, it will go through 8x128 ops
                    // at the end of 8x128 ops, read a new x in, shift fir[]
                    // at the end of each 128 ops, output a y
                    // 
                    // for 4x filter, it will go through 4x128 ops
                    // at the end of 4x128 ops, read a new x in, shift fir[]
                    // at the end of each 128 ops, output a y
#1       n_state = FIR1_100; //default is inner loop

#1       if (j==127) begin   //end of inner loop (polyphase) 
             #1 if (k==last_k) begin  //end of big loop!
             n_waddr = ram_addr;
             n_wen = 1'b1;
             n_ram_addr = ram_addr + 7'd1;
             n_raddr = ram_addr + 7'd1;
             n_k = 0;
             end
          else begin
             n_k = k+1;
             n_wen = 1'b0;
             n_raddr = ram_addr;
             end

          n_j = 0;
          n_sum_0 = 0;
          n_sum_1 = 0;
          n_state = FIR1_100;
          //#10 if (work) $display("@@@@=%d", fir_out_1);   //must delay to allow logic settle
          end

       else begin
           #1 n_sum_0 = sum_0 + mul_fir0_tap;
           #1 n_sum_1 = sum_1 + mul_fir1_tap;
           #1 n_j = j+1;
           n_raddr = raddr + 7'd1;
           end

       //output result
       if (j==127) begin
            #1 n_yl = sum_0[58:27];
            #1 n_yr = sum_1[58:27];
            n_work = 1;
            end

       end
   endcase
   end
endmodule




