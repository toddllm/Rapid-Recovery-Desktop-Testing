#!/bin/bash
platform=linux-base
to=linux-base
num_trials=3
results_dir='/home/deshantm/Rapid-Recovery-Desktop-Testing/results'
max_file_size=8g
iozone_dir=/home/deshantm/iozone3_347/src/current
cd $iozone_dir

num=1
while [ $num -le $num_trials ]; do
  (time ./iozone -i0 -i1 -a -g $max_file_size > ${results_dir}/iozone-${platform}-to-${to}-trial_${num}.out) 2>> ${results_dir}/iozone-${platform}-to-$to-timelog.out
  num=$(( $num + 1 ))
done

