#!/usr/bin/env bash
set -ex

export prefix=/opt/indi

sudo dnf install -y {libnova,cfitsio,libusb,zlib,gsl,libjpeg,libcurl,libtheora,fftw3}{,-devel}

cd $(mktemp -d) && pwd

indiversion=1.8.4
curl -L https://github.com/indilib/indi/archive/v${indiversion}.tar.gz | tar xzf -	
curl -L https://github.com/indilib/indi-3rdparty/archive/v${indiversion}.tar.gz | tar xzf -

# build INDI base

mkdir -p indi-${indiversion}/build
pushd    indi-${indiversion}/build

cmake -DCMAKE_INSTALL_PREFIX=$prefix .. && make \
	&& read -p 'press ENTER to install libindi' \
	&& sudo make install

popd

# ld config

libdir=$(rpm --define "_prefix $prefix" -E %_libdir)

sudo tee /etc/profile.d/indi.sh <<EOF
export PATH="$prefix/bin:\$PATH"
export LIBRARY_PATH="$libdir:\$LIBRARY_PATH"
export LD_LIBRARY_PATH="$libdir:\$LD_LIBRARY_PATH"
export CPATH="$prefix/include/libindi:\$CPATH"
EOF

source /etc/profile.d/indi.sh
echo "$libdir" | sudo tee /etc/ld.so.conf.d/indi.conf
sudo ldconfig -v

# build 3rd party drivers

mkdir -p indi-3rdparty-${indiversion}/build
pushd    indi-3rdparty-${indiversion}/build

mk3rdparty() {
	driver="$1"
	test -d "../$driver"
	mkdir -p $driver; pushd $driver
	cmake -DCMAKE_INSTALL_PREFIX=$prefix "../../$driver" && make \
		&& read -p "press ENTER to install $driver" \
		&& sudo make install
	popd
}

mk3rdparty indi-eqmod

mk3rdparty libasi
sudo cp ../libasi/99-asi.rules /etc/udev/rules.d/
mk3rdparty indi-asi

# mk3rdparty libatik
# mk3rdparty indi-atik

popd

# cleanup

sudo dnf remove {libnova,cfitsio,libusb,zlib,gsl,libjpeg,libcurl,libtheora,fftw3}-devel || echo nope

