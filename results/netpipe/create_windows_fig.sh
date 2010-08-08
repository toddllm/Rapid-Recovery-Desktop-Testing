#!/bin/bash

cat > /tmp/gnuplot-win-net.in <<EOT
set term postscript enhanced color
set output "network-windows.ps"
set logscale x
set key left top
set ylabel "Throughput (Mb/s)"
set xlabel "Packet size (bytes)"
plot "netpipe-win7-base-win7-base_trial_1.out" title "Windows base" with lines, "netpipe-win7-guest-win7-guest_trial_1.out" title "Windows guest" with lines
EOT

gnuplot /tmp/gnuplot-win-net.in
evince network-linux.ps &
rm /tmp/gnuplot-win-net.in
