#!/bin/sh

export LD_LIBRARY_PATH="$(pwd)"

## The input_file.so plugin watches a folder for new files, it does not matter where
## the JPEG files orginate from. For instance it is possible to grab the desktop and 
## store the files to a folder:

mkdir -p /tmp/input

#while true; do xwd -root | convert - -scale 640 /tmp/input/bla.jpg; sleep 0.5; done &

## Then the files can be read from the folder "/tmp/input" and served via HTTP
#./mjpg_streamer -i "input_file.so -f /tmp/mem/input -r" -o "output_http.so --port 8123 -w www"

./mjpg_streamer -i "input_file.so -f /tmp/mem/input -d 0.01 -s /tmp/mem/file.jpg" -o "output_http.so --port 8123 -w www"

#http://www.xxxx:8123/?action=stream
