#!/usr/bin/env bash
set -ex

version=8.2

prefix=/usr/local
bindir=$prefix/bin
libdir=$prefix/lib
libexecdir=$prefix/libexec
datadir=$prefix/share
docdir=$datadir/doc

sudo dnf install -y {libX11,zlib,libxml2,libxslt,libXft,fontconfig}{,-devel} \
        tcl perl-File-Compare
sudo dnf install -y --allowerasing compat-openssl10-devel

builddir=$(mktemp -d)
cp ../ds9/saods9.{png,desktop} $builddir
cd $builddir

#curl -L http://ds9.si.edu/download/source/ds9.${version}.tar.gz | tar xzf -
tar xzf $HOME/ds9.${version}.tar.gz -C $builddir

cd SAOImageDS9 

# unset CFLAGS FFLAGS CXXFLAGS OPTFLAGS

export OPTFLAGS="-O2 $ARCHFLAGS"
export CFLAGS="$OPTFLAGS"
export CXXFLAGS="$OPTFLAGS"
export FFLAGS="$OPTFLAGS"

# fix error with va_list
sed -i -E 's/va_list[A-Za-z\ ]*/.../' tcl8.6/generic/tclDecls.h

unix/configure --prefix $prefix \
        --exec-prefix   $prefix \
        --libdir        $libdir/saods9 \
        --libexecdir    $libexecdir \
        --docdir        $docdir/saods9 \
        --datadir       $datadir
make 

read -p 'press ENTER to install SAODS9'
sudo install -d ${bindir}
sudo install -d ${datadir}/{icons,applications}
sudo install -d ${docdir}/saods9

sudo install bin/ds9 ${bindir}
sudo install -m 644 ds9/doc/* ${docdir}/saods9/

cd ..
sudo install -m 644 saods9.png ${datadir}/icons/
sudo install -m 644 saods9.desktop ${datadir}/applications/

sudo dnf remove {libX11,zlib,openssl,libxml2,libxslt,libXft,fontconfig}-devel
sudo dnf remove compat-openssl10-devel
