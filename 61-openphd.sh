#!/bin/bash
set -ex

sudo dnf install -y @c-development cmake pkgconfig \
    {wxGTK3,libindi,libnova,zlib,libusb}{,-devel}

{wxGTK3,libindi,libnova,zlib,libusb}{,-devel}

export CFLAGS="-O3 -march=native -ffast-math"
export FFLAGS="-O3 -march=native -ffast-math"
export CXXFLAGS="-O3 -march=native -ffast-math"

OPENPHD_VER=2.6.3dev4
pushd $(mktemp -d)
curl -L https://github.com/OpenPHDGuiding/phd2/archive/v${OPENPHD_VER}.zip -o phd2.zip
unzip phd2.zip
cd phd2-${OPENPHD_VER}
mkdir -p tmp
cd tmp
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
make -j $(nproc)
sudo make install

popd

sudo dnf remove wxGTK3-devel {libindi,libnova,zlib,libusb}-devel || echo nope
