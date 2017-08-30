#!/bin/bash
set -ex

sudo dnf install @c-development cmake pkgconfig \
    {wxGTK3,libindi,libnova,zlib,libusb}{,-devel} libindi-static

. /etc/profile.d/cflags.sh

OPENPHD_VER=2.6.3dev5

cd $(mktemp -d)
curl -L https://github.com/OpenPHDGuiding/phd2/archive/v${OPENPHD_VER}.zip -o phd2.zip
unzip phd2.zip

cd phd2-${OPENPHD_VER}
mkdir -p tmp
cd tmp

cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
make -j $(nproc)
sudo make install

sudo dnf remove wxGTK3-devel {libindi,libnova,zlib,libusb}-devel libindi-static || echo nope
