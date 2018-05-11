#!/bin/bash
set -ex

# TheImagingSource

sudo curl -L \
    https://raw.githubusercontent.com/TheImagingSource/tiscamera/master/data/udev/80-theimagingsource-cameras.rules \
    -o /etc/udev/rules.d/80-theimagingsource.rules

# ATIK

sudo dnf install -y libnova
sudo ln -sf $(rpm -E %_libdir)/libnova-0.15.so.0 \
	$(rpm -E %_libdir)/libnova-0.14.so.0

cd $(mktemp -d)
if test $(arch) == armv7l
then
	sudo dnf install -y alien
	wget http://download.cloudmakers.eu/atikccd-1.23-armhf.deb
	sudo alien -t atikccd-1.23-armhf.deb
	tar xzf atikccd-1.23.tgz
	cd usr
	sudo cp -r * /usr/local/
	sudo dnf remove alien
else
	wget http://download.cloudmakers.eu/atikccd-1.23-amd64.rpm
	sudo rpm -ivh --nodeps --force *.rpm
fi
