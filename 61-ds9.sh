#!/usr/bin/env bash

set -e

version=7.6b4

prefix=/usr/local
bindir=$prefix/bin
libdir=$prefix/lib
libexecdir=$prefix/libexec
datadir=$prefix/share
docdir=$datadir/doc

sudo dnf install -y {libX11,zlib,libxml2,libxslt,libXft,fontconfig}-devel
sudo dnf install -y --allowerasing compat-openssl10-devel
sudo dnf install -y gcc-{c++,gfortran} libX11 zlib libxml2 libxslt fontconfig libXft tcl

builddir=$(mktemp -d)
cp ds9/saods9.{png,desktop} $builddir
cd $builddir

curl -L http://ds9.si.edu/download/source/ds9.${version}.tar.gz -o saods9.tar.gz
# curl -L https://github.com/wjoye/tkblt/archive/v${tkblt_version}.tar.gz -o tkblt.tar.gz

tar xzfv saods9.tar.gz && rm -fv saods9.tar.gz
cd SAOImageDS9 

unix/configure --prefix $prefix \
        --exec-prefix   $prefix \
        --libdir        $libdir/saods9 \
        --libexecdir    $libexecdir \
        --docdir        $docdir/saods9 \
        --datadir       $datadir
make 

sudo install -d ${bindir}
sudo install -d ${datadir}/{icons,applications}
sudo install -d ${docdir}/saods9

sudo install bin/ds9 ${bindir}
sudo cp -rv ds9/doc/* ${docdir}/saods9/

cd ..
sudo install -m 644 saods9.png ${datadir}/icons/
sudo install -m 644 saods9.desktop ${datadir}/applications/
rm -rfv saods9

sudo dnf remove {libX11,zlib,openssl,libxml2,libxslt,libXft,fontconfig}-devel
sudo dnf remove compat-openssl10-devel
