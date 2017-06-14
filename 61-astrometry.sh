#!/usr/bin/env bash

sudo dnf install -y {freetype,zlib,libpng,cairo,libjpeg-turbo,libimagequant}-devel \
    swig redhat-rpm-config netpbm-progs

. /etc/profile.d/cflags.sh

cd $(mktemp -d)
ASTROMETRY_VERSION=0.70
curl -L \
    https://github.com/dstndstn/astrometry.net/archive/${ASTROMETRY_VERSION}.tar.gz \
    -o astrometry.net.tar.gz
tar xzf astrometry.net.tar.gz
cd astrometry.net-${ASTROMETRY_VERSION}
./configure --prefix=/opt
make -j $(nproc) all
sudo make install

cat - > /tmp/astrometry-path.sh <<EOF
export PATH="\$PATH:/opt/astrometry/bin"
EOF

sudo mv /tmp/astrometry-path.sh /etc/profile.d/

cd /opt/astrometry/data
sudo wget --continue http://broiler.astrometry.net/~dstn/4200/index-{4219,4218,4217,4216,4215,4214,4213,4212,4211,4210,4209,4208,{4207,4206,4205}-{00,01,02,03,04,05,06,07,08,07,10,11}}.fits

sudo dnf remove swig {freetype,zlib,libpng,cairo,libjpeg-turbo,libimagequant}-devel \
        || echo nope
