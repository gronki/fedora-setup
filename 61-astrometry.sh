#!/usr/bin/env bash
set -e

sudo dnf install -y \
    {freetype,zlib,libpng,cairo,cfitsio,libjpeg-turbo,libimagequant}-devel \
    swig redhat-rpm-config netpbm-progs @c-development cfitsio \
    python2-{numpy,devel}

. /etc/profile.d/cflags.sh

cd $(mktemp -d)
ASTROMETRY_VERSION=0.72
curl -L \
    https://github.com/dstndstn/astrometry.net/archive/${ASTROMETRY_VERSION}.tar.gz \
    -o astrometry.net.tar.gz
tar xzf astrometry.net.tar.gz
cd astrometry.net-${ASTROMETRY_VERSION}
./configure && make -j $(nproc)
sudo make install INSTALL_DIR=/opt/astrometry

cat - > /tmp/astrometry-path.sh <<EOF
export PATH="\$PATH:/opt/astrometry/bin"
EOF

sudo mv /tmp/astrometry-path.sh /etc/profile.d/

mkdir -p /opt/astrometry/data && cd /opt/astrometry/data

sudo wget --continue http://broiler.astrometry.net/~dstn/4200/index-{4219,4218,4217,4216,4215,4214,4213,4212,4211,4210,4209,4208,{4207,4206}-{00,01,02,03,04,05,06,07,08,07,10,11}}.fits

sudo dnf remove swig {freetype,zlib,libpng,cairo,libjpeg-turbo,cfitsio,libimagequant}-devel \
        || echo nope
