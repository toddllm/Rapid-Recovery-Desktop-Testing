#!/bin/bash

cat > /tmp/gnuplot-lin-net.in <<EOT
set term postscript enhanced color
set output "network-linux.ps"
set logscale x
set key left top
set ylabel "Throughput (Mb/s)"
set xlabel "Packet size (bytes)"
plot "netpipe-fedora-base-fedora-base_trial_1.out" title "Linux base" with lines, "netpipe-ubuntu32-guest-ubuntu32-guest_trial_1.out" title "Linux guest" with lines
EOT

gnuplot /tmp/gnuplot-lin-net.in
evince network-linux.ps &
rm /tmp/gnuplot-lin-net.in
