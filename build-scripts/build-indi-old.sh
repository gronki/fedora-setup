#!/usr/bin/env bash
# coding: utf-8
set -e

prefix=/opt/indi

sudo dnf install -y cmake {libnova,cfitsio,libusb,zlib,gsl,libjpeg,libcurl,libtheora,fftw3}{,-devel}

pushd $(mktemp -d) && pwd

indiversion=1.8.1
# 1.7.5 and later not working with ASI120MM-S
# 1.8.1 is the last version this script works with
curl -L https://github.com/indilib/indi/archive/v${indiversion}.tar.gz -o indi.tar.gz
tar xzf indi.tar.gz && cd indi-${indiversion}

mkdir build && cd build

mkdir libindi && cd libindi
cmake -DCMAKE_INSTALL_PREFIX=$prefix ../../libindi
make
read -p 'press ENTER to install libindi'
sudo make install
cd ..

pwd

libdir=$(rpm --define "_prefix $prefix" -E %_libdir)
sudo tee /etc/profile.d/indi.sh <<EOF
export PATH="$prefix/bin:\$PATH"
export LIBRARY_PATH="$libdir:\$LIBRARY_PATH"
export LD_LIBRARY_PATH="$libdir:\$LD_LIBRARY_PATH"
export CPATH="$prefix/include/libindi:\$CPATH"
EOF

. /etc/profile.d/indi.sh
echo "$libdir" | sudo tee /etc/ld.so.conf.d/indi.conf
sudo ldconfig -v

export prefix

mk3rdparty() {
	mkdir $1 && cd $1
	cmake -DCMAKE_INSTALL_PREFIX=$prefix ../../3rdparty/$1
	make
	read -p "press ENTER to install $1"
	sudo make install
	cd ..; pwd
}

mk3rdparty indi-eqmod
mk3rdparty indi-asi
sudo cp ../3rdparty/asi-common/99-asi.rules /etc/udev/rules.d/
# mk3rdparty libatik
# mk3rdparty indi-atik

sudo dnf remove {libnova,cfitsio,libusb,zlib,gsl,libjpeg,libcurl,libtheora,fftw3}-devel || echo nope

popd
