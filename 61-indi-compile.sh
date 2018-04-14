#!/bin/bash
# coding: utf-8
set -ex

sudo dnf install @development-tools cmake
sudo dnf install libnova-devel cfitsio-devel libusb-devel zlib-devel gsl-devel libjpeg-devel libcurl-devel

cd $(mktemp -d) && pwd

curl -L https://github.com/indilib/indi/archive/master.zip -o indi.zip
unzip indi.zip 
cd indi-master

mkdir build && cd build

mkdir libindi && cd libindi
cmake -DCMAKE_INSTALL_PREFIX=/opt/indi ../../libindi
make
sudo make install
cd ..

sudo tee /etc/profile.d/indi.sh <<EOF
export LD_LIBRARY_PATH="/opt/indi/lib64:\$LD_LIBRARY_PATH"
export PATH="/opt/indi/bin:\$PATH"
EOF

. /etc/profile.d/indi.sh
export LIBRARY_PATH=/opt/indi/lib64
export CPATH=/opt/indi/include/libindi

mkdir indi-eqmod && cd indi-eqmod
cmake -DCMAKE_INSTALL_PREFIX=/opt/indi ../../3rdparty/indi-eqmod
make
sudo make install
cd ..

mkdir indi-asi && cd indi-asi
cmake -DCMAKE_INSTALL_PREFIX=/opt/indi ../../3rdparty/indi-asi
make
sudo make install
cd ..

