#!/usr/bin/env bash
set -e

sudo dnf install -y curl tar libnova bzip2-libs

# TheImagingSource

sudo curl -L \
    https://raw.githubusercontent.com/TheImagingSource/tiscamera/master/data/udev/80-theimagingsource-cameras.rules \
    -o /etc/udev/rules.d/80-theimagingsource.rules

# ATIK

sudo ln -sfv $(rpm -E %_libdir)/libnova-0.15.so.0 \
	$(rpm -E %_libdir)/libnova-0.16.so.0
sudo ln -sfv $(rpm -E %_libdir)/libbz2.so.1.0.* \
	$(rpm -E %_libdir)/libbz2.so.1.0

atikccd_ver=1.30

pushd $(mktemp -d)

if [[ $(arch) == x86_64 ]]
then
	curl -L http://download.cloudmakers.eu/atikccd-${atikccd_ver}-amd64.rpm -o atik64.rpm
	sudo rpm -ivh ./atik64.rpm --nodeps --force
elif [[ $(arch) == arm* ]]
then
	curl -L http://download.cloudmakers.eu/atikccd-${atikccd_ver}-armhf.deb -o atikarm.deb
	ar -x atikarm.deb
	tar xaf data.tar.??
	sudo cp -rv usr/local/* /usr/local/
	sudo cp -v lib/udev/rules.d/99-atik.rules /usr/lib/udev/rules.d/
else
	echo "nieznana architektura"; exit -1
fi

popd
