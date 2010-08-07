#!/bin/bash

usage="$0 <options>"

platform=win7-base
to=win7-base
num_trials=5
results_dir='/home/COSIAdmin/Rapid-Recovery-Desktop-Testing/results/netpipe'
netpipe_dir=/home/COSIAdmin/NetPIPE-3.7.1
my_ip='10.0.0.100'
client_IP='10.0.0.101'

cd $netpipe_dir


num=1
while [ $num -le $num_trials ]; do
 
  #start server locally
  ${netpipe_dir}/NPtcp &
  
  #sleeping 60 seconds is overly conservative here
  sleep 60
 
  #connect to client over ssh and run client netpipe
  ssh ${client_IP} "${netpipe_dir}/NPtcp -h ${my_ip} -o ${netpipe_dir}/np.out"
  sleep 5

  #save output file
  scp ${client_IP}:${netpipe_dir}/np.out ${results_dir}/netpipe-${platform}-${to}_trial_${num}.out
  ssh ${client_IP} "rm ${netpipe_dir}/np.out"

  num=$(( $num + 1 ))
  
  #sleepiog 60 seconds is probably overly conservative here
  sleep 60
done
