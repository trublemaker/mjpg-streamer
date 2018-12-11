#!/bin/sh

export LD_LIBRARY_PATH="$(pwd)"

## The input_file.so plugin watches a folder for new files, it does not matter where
## the JPEG files orginate from. For instance it is possible to grab the desktop and 
## store the files to a folder:

mkdir -p /tmp/input

#while true; do xwd -root | convert - -scale 640 /tmp/input/bla.jpg; sleep 0.5; done &

str=`date "+%Y-%m-%d %H:%M:%S.%N"`

while :
do
		str=`date "+%Y-%m-%d_%H:%M:%S.%N"`
		#echo ./a.out "text 10,20  \"$str\""
		echo "    $str"
		convert  -fill red -pointsize 180 -draw "text 10,350 \"$str\"" file.jpg /tmp/input/$str.jpg
		sleep 1.5 
done	

## Then the files can be read from the folder "/tmp/input" and served via HTTP
./mjpg_streamer -i "input_file.so -f /tmp/input -r" -o "output_http.so --port 8123 -w www"

#http://www.sysware.cc:8123/?action=stream
