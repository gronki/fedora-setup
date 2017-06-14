#!/bin/bash
set -ex

sudo dnf install mpv \
libva{,-utils} vdpauinfo ffmpeg-libs \
gstreamer1-vaapi gstreamer1-plugins{-base,-good{,-extras},-bad{-free{,-extras},-freeworld,-nonfree}} \
gstreamer1-plugin-mpg123 mpg123-libs \
gstreamer-{ffmpeg,plugins-good} \
libde265

echo 'hwdec=yes' | sudo tee -a /etc/mpv/mpv.conf

sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264

if glxinfo | grep Device | grep Intel
then
    # intel graphics
    sudo dnf install libva-intel-driver libvdpau-va-gl
    echo 'export VDPAU_DRIVER=va_gl' | sudo tee -a /etc/environment
else
    # nvidia graphics
    sudo dnf install libva-vdpau-driver mesa-vdpau-drivers
fi

sudo mkdir -p /etc/adobe
echo "EnableLinuxHWVideoDecode=1" | sudo tee -a /etc/adobe/mms.cfg
echo "OverrideGPUValidation=1" | sudo tee -a /etc/adobe/mms.cfg
