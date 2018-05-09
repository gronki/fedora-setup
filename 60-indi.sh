#!/bin/bash
# coding: utf-8
set -ex

prefix=/usr/local

sudo dnf install -y @c-development cmake {libnova,cfitsio,libusb,zlib,gsl,libjpeg,libcurl,libtheora}{,-devel}

cd $(mktemp -d) && pwd

curl -L https://github.com/indilib/indi/archive/master.zip -o indi.zip
unzip indi.zip 
cd indi-master

mkdir build && cd build

mkdir libindi && cd libindi
cmake -DCMAKE_INSTALL_PREFIX=$prefix ../../libindi
make -j4
read -p 'press ENTER to install libindi'
sudo make install
cd ..

pwd


if [ $prefix != '/usr/local' ]; then
	
	if [ $(arch) == x86_64 ]; then
		libdir="$prefix/lib64"
	else
		libdir="$prefix/lib"
	fi

	sudo tee /etc/profile.d/indi.sh <<EOF
	export PATH="$prefix/bin:\$PATH"
	export LIBRARY_PATH="$libdir:\$LIBRARY_PATH"
	# export LD_LIBRARY_PATH="$libdir:\$LD_LIBRARY_PATH"
	export CPATH="$prefix/include/libindi:\$CPATH"
EOF

	. /etc/profile.d/indi.sh
	echo $libdir | sudo tee /etc/ld.so.conf.d/indi.conf
	sudo ldconfig -v
fi

mkdir indi-eqmod && cd indi-eqmod
cmake -DCMAKE_INSTALL_PREFIX=$prefix ../../3rdparty/indi-eqmod
make -j4
read -p 'press ENTER to install indi-eqmod'
sudo make install
cd ..

pwd

mkdir indi-asi && cd indi-asi
cmake -DCMAKE_INSTALL_PREFIX=$prefix ../../3rdparty/indi-asi
make -j4
read -p 'press ENTER to install indi-asi'
sudo make install
cd ..

pwd

sudo dnf remove {libnova,cfitsio,libusb,zlib,gsl,libjpeg,libcurl,libtheora}-devel || echo nope
