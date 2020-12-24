#!/bin/bash
set -ex

sudo dnf install -y @c-development cmake pkgconfig gcc-c++ \
    {wxGTK3,libnova,zlib,libusb}{,-devel}

OPENPHD_VER=2.6.5
prefix=/opt/phd2

cd $(mktemp -d)
curl -L https://github.com/OpenPHDGuiding/phd2/archive/v${OPENPHD_VER}.tar.gz -o phd2.tar.gz
tar xzf phd2.tar.gz

cd phd2-${OPENPHD_VER}
mkdir -p tmp && cd tmp

cmake -DCMAKE_INSTALL_PREFIX="$prefix" ..
# do not add -j4 here -- may cause compilation conflicts
make
read -p 'press ENTER to install PHD2'
sudo make install

sudo dnf remove {wxGTK3,libnova,zlib,libusb}-devel || echo nope
