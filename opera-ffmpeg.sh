#!/usr/bin/env bash
set -e

[ $(arch) != x86_64 ] && exit -1
if [ "$USER" == root ]; then
	echo 'do not run this as root'
	exit -1
fi

ffmpeg_version=0.31.4
wget "https://github.com/iteufel/nwjs-ffmpeg-prebuilt/releases/download/$ffmpeg_version/$ffmpeg_version-linux-x64.zip" -O ffmpeg.zip || exit -1
unzip ffmpeg.zip

sudo install -d /usr/lib64/ffmpeg-stolen
sudo install libffmpeg.so /usr/lib64/ffmpeg-stolen/
sudo ldconfig /usr/lib64/ffmpeg-stolen

rm -f ffmpeg.zip libffmpeg.so

json_config_file=/usr/lib64/opera/resources/ffmpeg_preload_config.json
if ! cat $json_config_file | grep ffmpeg-stolen; then
cat $json_config_file \
	| sed 's/\[/[\n  "\/usr\/lib64\/ffmpeg-stolen\/libffmpeg.so",/' \
	| sudo tee $json_config_file
fi

opera --new-window 'youtube.com/html5' 'html5test.com'
