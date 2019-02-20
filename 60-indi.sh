#!/usr/bin/env bash
# coding: utf-8
set -e

prefix=/usr/local

sudo dnf install -y @c-development cmake {libnova,cfitsio,libusb,zlib,gsl,libjpeg,libcurl,libtheora}{,-devel}

pushd $(mktemp -d) && pwd

indiversion=1.7.5
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

if [ $prefix != '/usr/local' ]; then
	
	libdir=$(rpm --define "_prefix $prefix" -E %_libdir)

	sudo tee /etc/profile.d/indi.sh <<EOF
	export PATH="$prefix/bin:\$PATH"
	export LIBRARY_PATH="$libdir:\$LIBRARY_PATH"
	export LD_LIBRARY_PATH="$libdir:\$LD_LIBRARY_PATH"
	export CPATH="$prefix/include/libindi:\$CPATH"
EOF

	. /etc/profile.d/indi.sh
	echo $libdir | sudo tee /etc/ld.so.conf.d/indi.conf
	sudo ldconfig -v
fi

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
# mk3rdparty libatik
# mk3rdparty indi-atik

sudo dnf remove {libnova,cfitsio,libusb,zlib,gsl,libjpeg,libcurl,libtheora}-devel || echo nope

popd
