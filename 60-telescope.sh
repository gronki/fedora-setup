#!/bin/bash
set -ex

# telescope control
sudo dnf install -y indistarter libindi indi-eqmod indi-gphoto ccdciel
#sudo dnf install -y nightview

# TheImagingSource

sudo curl https://raw.githubusercontent.com/TheImagingSource/tiscamera/master/data/udev/80-theimagingsource-cameras.rules -o /etc/udev/rules.d/80-theimagingsource.rules

# ATIK

sudo dnf install -y libnova
cd /usr/lib64
sudo ln -sf libnova-0.15.so.0 libnova-0.14.so.0

curl http://download.cloudmakers.eu/atikccd-1.23-amd64.rpm -o /tmp/atik.rpm
sudo rpm -ivh --nodeps --force /tmp/atik.rpm
