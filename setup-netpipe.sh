#!/bin/bash

wget http://www.scl.ameslab.gov/netpipe/code/NetPIPE-3.7.1.tar.gz
tar xf NetPIPE-3.7.1.tar.gz
cd NetPIPE-3.7.1
make
echo 'now you can run the NPtcp binary inside of the NetPIPE-3.7.1 directory' 
