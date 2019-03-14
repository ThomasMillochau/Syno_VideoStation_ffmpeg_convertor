# Syno_VideoStation_ffmpeg_convertor
Convert all your video files the correct format to avoid transcoding by Synology Video Station (performance gain)

This script makes a loop to put in input of the following ffmpeg command all the .mkv or .avi files of the directory in question


#### [ffmpeg Documentation](https://www.ffmpeg.org/ffmpeg.html "ffmpeg Documentation")

#### ffmpeg parameters description

- -i

    input file

- -map 0:v -map 0:a -map 0:s

Forces the inclusion of video + audio + subtitle streams in the output file 
(by default it is the automatic mode that determines which streams will be in the output file)

[ffmpeg manual stream selection](https://www.ffmpeg.org/ffmpeg.html#toc-Manual-stream-selection "ffmpeg Manual stream selection")
```html
When -map is used, only user-mapped streams are included in that output file... 
```


- -c:v copy

The video stream is not modified it's simply copied into the output mp4 container.

- -c:a aac -af aformat=channel_layouts="7.1|5.1|stereo"

The aac parameter is used to convert all audio streams to aac format (by default here aac_lc)
The aformat parameter forces the number of channels to its initial value (if 7.1 in input, then 7.1 in output, if stereo in input, then stereo in output) without modifying the audio bitrate of each stream.

The main objective here is to fix a default value of the parameter aac of ffmepg when converting a 5.1 audio stream: by default the output stream will be 5.1 (side)
```html
5.1 = FL+FR+FC+LFE+BL+BR
5.1(side) = FL+FR+FC+LFE+SL+SR 
```
But Videostation does not recognize the 5.1 (side) so you have to force the audio stream to stay in 5.1


- -c:s mov_text

VideoStation only reads subtitle files in text format so we convert the files to text without modifying the content (position relative to audio tracks).

- "$i x264 AAC.mp4"

The video, audio, subtitle streams are written after conversion in a container mp4.
