#!/usr/bin/env bash
set -e

if [ $(arch) != x86_64 ]; then
	exit -1
fi

ffmpeg_version=0.32.1
wget "https://github.com/iteufel/nwjs-ffmpeg-prebuilt/releases/download/$ffmpeg_version/$ffmpeg_version-linux-x64.zip" -O ffmpeg.zip; unzip ffmpeg.zip
sudo install -d /usr/lib64/ffmpeg-stolen
sudo install libffmpeg.so /usr/lib64/ffmpeg-stolen/
sudo ldconfig /usr/lib64/ffmpeg-stolen

rm -f ffmpeg.zip libffmpeg.so

json_config_file=/usr/lib64/opera/resources/ffmpeg_preload_config.json
cat $json_config_file | sed 's/\[/[\n  "\/usr\/lib64\/ffmpeg-stolen\/libffmpeg.so",/' | sudo tee $json_config_file
