#!/usr/bin/env bash
set -e

prefix=/usr/local

sudo dnf install -y \
    {freetype,zlib,libpng,cairo,cfitsio,libjpeg-turbo,libimagequant}-devel \
    swig redhat-rpm-config @c-development cfitsio sextractor \
    python2-{numpy,devel} gcc-c++ netpbm-{progs,devel}

cd $(mktemp -d)
ASTROMETRY_VERSION=0.74
curl -L \
    https://github.com/dstndstn/astrometry.net/archive/${ASTROMETRY_VERSION}.tar.gz \
    -o astrometry.net.tar.gz
tar xzf astrometry.net.tar.gz
cd astrometry.net-${ASTROMETRY_VERSION}

pwd

./configure && make -j4 
read -p 'press ENTER to install astrometry'
sudo make install INSTALL_DIR=${prefix}

pwd

if [ $prefix != '/usr/local' ]; then
	sudo tee /etc/profile.d/astrometry.sh <<EOF
	export PATH=\"${prefix}/bin:\$PATH\"
	export LIBRARY_PATH=\"${prefix}/lib:\$LIBRARY_PATH\"
	# export LD_LIBRARY_PATH=\"${prefix}/lib:\$LD_LIBRARY_PATH\"
EOF

	echo ${prefix}/lib | sudo tee /etc/ld.so.conf.d/astrometry.conf
	sudo ldconfig -v
fi

read -p 'Press ENTER to download data...'
sudo mkdir -p ${prefix}/data && cd ${prefix}/data

# sudo wget --continue http://broiler.astrometry.net/~dstn/4200/index-{4219,4218,4217,4216,4215,4214,4213,4212,4211,4210,4209,4208,{4207,4206,4205}-{00,01,02,03,04,05,06,07,08,07,10,11}}.fits
sudo wget --continue http://broiler.astrometry.net/~dstn/4200/index-{4211,4210,4209,4208}.fits

sudo dnf remove swig {freetype,zlib,netpbm,libpng,cairo,libjpeg-turbo,cfitsio,libimagequant}-devel  || echo nope
