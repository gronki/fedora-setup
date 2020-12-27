#!/usr/bin/env bash
set +e
set -x

sudo dnf install \
	openbox obconf rofi tint2 tigervnc-server \
	rxvt-unicode pcmanfm xdg-utils usbutils \
	neovim htop ImageMagick
sudo dnf install kstars phd2 libnova fpack
sudo dnf install siril

sudo dnf install gcc{,-c++,-gfortran} make autoconf cmake git \
	{cfitsio,fftw3}{,-devel}
