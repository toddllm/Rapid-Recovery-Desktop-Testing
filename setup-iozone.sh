#!/bin/bash

#rename to iozone.sh???

#deps
sudo yum install gcc gnuplot

#comment during testing
#wget http://www.iozone.org/src/current/iozone3_347.tar

tar xf iozone3_347.tar
cd iozone3_347/src/current
make linux-AMD64
echo 'running iozone, this may take awhile'
date >> $output_file
./iozone -a -i 0 -i 1 >> $output_file
date >> $output_file
