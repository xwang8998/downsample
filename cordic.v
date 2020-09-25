
// 
// xi's initial value is x=0.607252935009 * SCALE / level
// yi's initial value is 0
// angle = degree/360 * (2^32)
// NOTE!! cordic has gains, depends on how many iterations, need to reverse the gain upfront
// iter=16    0.607252935103
// iter=28+   0.607252935009
//
// input:
//   xi is the starting angle's cosine * 0.607252935009
//   yi is the starting angle's sine * 0.607252935009
//   output: cos is the cosine of current_angle + angle
//
//

module cordic(
input clk,
input preset_n,
input start,

input signed [39:0] xi,
input signed [39:0] yi,
input signed [31:0] angle,//12173944;
output signed [39:0] cos,
output signed [39:0] sin
);

reg reset_n;
always @* if (start == 0) reset_n = 0; else reset_n = preset_n;


wire signed [31:0] atan_table [0:30];

assign atan_table[00] = 'b0010_0000_0000_0000_0000_0000_0000_0000; // 45.000 degrees -> atan(2^0)
assign atan_table[01] = 'b00010010111001000000010100011101; // 26.565 degrees -> atan(2^-1)
assign atan_table[02] = 'b00001001111110110011100001011011; // 14.036 degrees -> atan(2^-2)
assign atan_table[03] = 'b00000101000100010001000111010100; // atan(2^-3)
assign atan_table[04] = 'b00000010100010110000110101000011;
assign atan_table[05] = 'b00000001010001011101011111100001;
assign atan_table[06] = 'b00000000101000101111011000011110;
assign atan_table[07] = 'b00000000010100010111110001010101;
assign atan_table[08] = 'b00000000001010001011111001010011;
assign atan_table[09] = 'b00000000000101000101111100101110;
assign atan_table[10] = 'b00000000000010100010111110011000;
assign atan_table[11] = 'b00000000000001010001011111001100;
assign atan_table[12] = 'b00000000000000101000101111100110;
assign atan_table[13] = 'b00000000000000010100010111110011;
assign atan_table[14] = 'b00000000000000001010001011111001;
assign atan_table[15] = 'b00000000000000000101000101111100;
assign atan_table[16] = 'b00000000000000000010100010111110;
assign atan_table[17] = 'b00000000000000000001010001011111;
assign atan_table[18] = 'b00000000000000000000101000101111;
assign atan_table[19] = 'b00000000000000000000010100010111;
assign atan_table[20] = 'b00000000000000000000001010001011;
assign atan_table[21] = 'b00000000000000000000000101000101;
assign atan_table[22] = 'b00000000000000000000000010100010;
assign atan_table[23] = 'b00000000000000000000000001010001;
assign atan_table[24] = 'b00000000000000000000000000101000;
assign atan_table[25] = 'b00000000000000000000000000010100;
assign atan_table[26] = 'b00000000000000000000000000001010;
assign atan_table[27] = 'b00000000000000000000000000000101;
assign atan_table[28] = 'b00000000000000000000000000000010;
assign atan_table[29] = 'b00000000000000000000000000000001;
assign atan_table[30] = 'b00000000000000000000000000000000;

reg signed [39:0] x [0:31];
reg signed [39:0] y [0:31];
reg signed [31:0] z [0:31];

always @(posedge clk or negedge reset_n)
    if (reset_n == 0) begin
        x[0] <= 0;
        y[0] <= 0;
        z[0] <= 0;
        end
    else begin
        if (angle[31] == angle[30]) begin//-pi/2 to pi/2
            x[0] <= xi;
            y[0] <= yi;
            z[0] <= angle;
            end
        else if (angle[30] == 0) begin
            x[0] <= yi;
            y[0] <= -xi;
            z[0] <= {2'b11,angle[29:0]};  // + pi/2 -- -pi/2
            end
        else begin
            x[0] <= -yi;
            y[0] <= xi;
            z[0] <= {2'b00,angle[29:0]};  // - pi/2 -- pi/2
            end
        end
    

integer i;
always @(posedge clk or negedge reset_n)
    if (reset_n == 0) begin
        for (i=1; i<32; i = i + 1) x[i] <= 0;
        for (i=1; i<32; i = i + 1) y[i] <= 0;
        for (i=1; i<32; i = i + 1) z[i] <= 0;
        end
    else begin
        for (i=1; i<32; i = i + 1) begin
            if (z[i-1][31] == 1) begin
                x[i] <= x[i-1] + (y[i-1] >>> (i-1));
                y[i] <= y[i-1] - (x[i-1] >>> (i-1));
                z[i] <= z[i-1] + atan_table[i-1];
                end
            else begin
                x[i] <= x[i-1] - (y[i-1] >>> (i-1));
                y[i] <= y[i-1] + (x[i-1] >>> (i-1));
                z[i] <= z[i-1] - atan_table[i-1];
                end
            end
        end

assign cos = x[31];
assign sin = y[31];

endmodule


