#!/bin/bash
set -ex

# telescope control
sudo dnf install -y libindi indi-eqmod indi-gphoto
sudo dnf install kstars ccdciel

# TheImagingSource

sudo curl -L \
    https://raw.githubusercontent.com/TheImagingSource/tiscamera/master/data/udev/80-theimagingsource-cameras.rules \
    -o /etc/udev/rules.d/80-theimagingsource.rules

# ATIK

sudo dnf install -y libnova
cd /usr/lib64
sudo ln -sf libnova-0.15.so.0 libnova-0.14.so.0

cd $(mktemp -d)
if test $(arch) == armv7l
then
sudo dnf install -y alien
wget http://download.cloudmakers.eu/atikccd-1.23-armhf.deb
alien -r atikccd-1.23-armhf.deb
else
wget http://download.cloudmakers.eu/atikccd-1.23-amd64.rpm
fi
sudo rpm -ivh --nodeps --force *.rpm
