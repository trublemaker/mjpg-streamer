#!/bin/sh

export LD_LIBRARY_PATH="$(pwd)"

## The input_file.so plugin watches a folder for new files, it does not matter where
## the JPEG files orginate from. For instance it is possible to grab the desktop and 
## store the files to a folder:

mkdir -p /tmp/input

rm /tmp/input/*.jpg

#while true; do xwd -root | convert - -scale 640 /tmp/input/bla.jpg; sleep 0.5; done &

str=""

cmd='./a.out'

count=0

while :
do
	count=$(( $count+1 ))
	str=`date "+%Y-%m-%d_%H:%M:%S.%N"`
	#str=`date "+%S.%N"`
	#echo "    $str"
	convert -fill red -pointsize 80 -draw "text 10,350 \"$count\"" /tmp/mem/file.jpg /tmp/mem/input/$str.jpg
	#convert -fill red -pointsize 240 -draw "text 10,350 \"$count\"" file.jpg /tmp/input/$count.jpg
	echo  $cmd "text 10,20 \"$str:$count\""
	#sleep 1.0
done	

## Then the files can be read from the folder "/tmp/input" and served via HTTP
./mjpg_streamer -i "input_file.so -f /tmp/input -r" -o "output_http.so --port 8123 -w www"

#http://www.sysware.cc:8123/?action=stream
