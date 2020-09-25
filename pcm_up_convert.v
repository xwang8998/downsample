`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 19:14:03
// Design Name: 
// Module Name: pcm_up_convert
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pcm_up_convert(
       input mclk,//45.1584MHZ
       input reset_n,
       input start,
       input [1:0] ctrl,
       input [31:0] xl,
       input [31:0] xr,
       output [31:0] yl,
       output [31:0] yr,
       output started
       );
parameter PCM441=2'b00;
parameter PCM882=2'b01;
parameter PCM176=2'b10;
parameter PCM352=2'b11;       
//rom
//wire [1:0] ctrl;
wire [1:0] ov = (ctrl==PCM352) ? 2'd0 :
                (ctrl==PCM176) ? 2'd1 :
                (ctrl==PCM882) ? 2'd2 : 2'd3;
                       
wire [9:0] tap_addr;
wire signed [31:0] tap;

tap_rom U_ROM(
        .oversampling_x(ov), 
        .address(tap_addr), 
        .output_tap(tap)
        );
          
    // up convert
pcm_up U_UP(
       .mclk(mclk), 
       .reset_n(reset_n), 
       .start(start), 
       .tap_addr(tap_addr), 
       .tap(tap),
       .source_type(ctrl), 
       .xl(xl), 
       .xr(xr), 
       .started(started), 
       .yl(yl), 
       .yr(yr)
       );
           
endmodule
