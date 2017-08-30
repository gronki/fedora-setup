#!/bin/bash
set -ex

sudo dnf install @c-development cmake pkgconfig gcc-c++ \
    {wxGTK3,libindi,libnova,zlib,libusb}{,-devel} libindi-static

. /etc/profile.d/cflags.sh

OPENPHD_VER=2.6.3dev4

cd $(mktemp -d)
curl -L https://github.com/OpenPHDGuiding/phd2/archive/v${OPENPHD_VER}.tar.gz -o phd2.tar.gz
tar xzf phd2.tar.gz

cd phd2-${OPENPHD_VER}
mkdir -p tmp
cd tmp

cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
make
sudo make install

sudo dnf remove wxGTK3-devel {libindi,libnova,zlib,libusb}-devel libindi-static || echo nope
