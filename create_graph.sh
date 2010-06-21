#!/bin/bash

#create_graph

usage="$0 read|write iozone.outfile1 iozone.outfile2 gnuplot.in [output.ps]"

if [ -z $4 ]; then
  echo $usage
  exit 1
fi

type=$1
iozone_file1=$2
iozone_file2=$3
gnuplot_in=$4

file1=$(basename $iozone_file1)
file2=$(basename $iozone_file2)


if [ $type == "read" ]; then
  awk '$1 ~ /^[0-9]+/ { print  $1 " " $2 " " $5  }' $iozone_file1 > /tmp/read-${file1}
  awk '$1 ~ /^[0-9]+/ { print  $1 " " $2 " " $5  }' $iozone_file2 > /tmp/read-${file2}
elif [ $type == "write" ]; then
  awk '$1 ~ /^[0-9]+/ { print  $1 " " $2 " " $3  }' $iozone_file1 > /tmp/write-${file1}
  awk '$1 ~ /^[0-9]+/ { print  $1 " " $2 " " $3  }' $iozone_file2 > /tmp/write-${file2}
else
  echo "error unknown type: $type"
fi

if [ -z $5 ]; then
  echo 'set terminal x11' > /tmp/${file1}-${file2}-gnuplot.out
else
  echo 'set terminal postscript enhanced color' > /tmp/${file1}-${file2}-gnuplot.out
  #echo 'set terminal png enhanced' > /tmp/${file1}-${file2}-gnuplot.out
fi

plot_cmd="splot '/tmp/${type}-${file1}' using 1:2:3 title 'input1 $type performance'  , '/tmp/${type}-${file2}' using 1:2:3 title 'input2 $type performance' with lines"
cat gnuplot.in >> /tmp/${file1}-${file2}-gnuplot.out


#optional output file
if [ ! -z $5 ]; then
  echo "set output \"$5\"" >> /tmp/${file1}-${file2}-gnuplot.out
fi

echo $plot_cmd >> /tmp/${file1}-${file2}-gnuplot.out



echo "wrote temporary gnuplot file /tmp/${file1}-${file2}-gnuplot.out"
echo 'pause -1 "Hit return to quit"' >>  /tmp/${file1}-${file2}-gnuplot.out
gnuplot /tmp/${file1}-${file2}-gnuplot.out

#cleanup temp files

if [ $type == "read" ]; then
  rm /tmp/read-${file1}
  rm /tmp/read-${file2}
elif [ $type == "write" ]; then
  rm /tmp/write-${file1}
  rm /tmp/write-${file2}
else
  echo -n ""
fi

rm /tmp/${file1}-${file2}-gnuplot.out
