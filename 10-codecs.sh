#!/bin/bash
set -ex

sudo dnf install -y libva{,-utils}
sudo dnf install libva-intel-driver || echo show goes on
sudo dnf install libva-vdpau-driver vdpauinfo mesa-vdpau-drivers || echo show goes on

sudo dnf install -y gstreamer1-{libav,vaapi} gstreamer1-plugins{-base,-good{,-extras},-bad{-free{,-extras},-freeworld,-nonfree}}
sudo dnf install -y gstreamer1-plugin-mpg123 mpg123-libs
sudo dnf install -y mpv
sudo dnf install -y gstreamer-{ffmpeg,plugins-good}

sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264 xpra-codecs-freeworld

sudo dnf install -y libde265
