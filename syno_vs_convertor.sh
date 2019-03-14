#!/bin/bash
for i in /volume2/Videos/*.mkv;
do
	/usr/local/ffmpeg/bin/ffmpeg -i "$i" -map 0:v -map 0:a -map 0:s -c:v copy -c:a aac -af aformat=channel_layouts= "7.1|5.1|stereo" -c:s mov_text "$i x264 AAC.mp4"
done
