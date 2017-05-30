#!/usr/bin/env bash

sudo dnf install -y swig {freetype,zlib,libpng,cairo,libjpeg-turbo,libimagequant}-devel

export CFLAGS="-O3 -march=native -ffast-math"
export FFLAGS="-O3 -march=native -ffast-math"
export CXXFLAGS="-O3 -march=native -ffast-math"

cd $(mktemp -d)
ASTROMETRY_VERSION=0.70
curl -L https://github.com/dstndstn/astrometry.net/archive/${ASTROMETRY_VERSION}.tar.gz -o astrometry.net.tar.gz
tar xzf astrometry.net.tar.gz
cd astrometry.net-${ASTROMETRY_VERSION}
./configure --prefix=/usr/local
make -j $(nproc) all
sudo make install

sudo dnf remove swig {freetype,zlib,libpng,cairo,libjpeg-turbo,libimagequant}-devel || echo nope
