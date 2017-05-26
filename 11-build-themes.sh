#!/bin/bash

set -ex

prefix=/usr
numix_frost_version=3.6.6
pop_gtk_version=1.2.2

# dependencies for POP & Numix Frost Theme
sudo dnf install -y glib2-devel gdk-pixbuf2-devel

# numix frost
pushd $(mktemp -d)
curl -L https://github.com/Antergos/Numix-Frost/archive/$numix_frost_version.zip -o Numix-Frost.zip
unzip Numix-Frost.zip
cd Numix-Frost-$numix_frost_version
make
sudo make install prefix="$prefix"
popd

# dependencies for POP theme
sudo dnf install -y librsvg2-devel parallel sassc

# POP theme
pushd $(mktemp -d)
curl -L https://github.com/system76/pop-gtk-theme/archive/v$pop_gtk_version.zip -o pop-gtk-theme.zip
unzip pop-gtk-theme.zip
cd pop-gtk-theme-$pop_gtk_version
./autogen.sh --prefix="$prefix"
make
sudo make install
popd

sudo dnf remove -y glib2-devel gdk-pixbuf2-devel librsvg2-devel
sudo dnf remove parallel sassc
