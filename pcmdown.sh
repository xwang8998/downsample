#!/bin/sh
echo "1>"
iverilog -o out -y ./ cordic.v tb.v  wavegen.v down176.v top4rom.v top5rom.v cic.v pcm_up_convert.v pcm_up.v tap_rom.v fir_ram.v mult28x32.v rompcm705_v3.v rompcm44.v 
echo "2>"
vvp -n out -lxt2
echo "3>"
cp wave.vcd wave.lxt
echo "4>"
gtkwave wave.vcd
