#!/bin/bash

set -ex

prefix=/usr

# dependencies for POP & Numix Frost Theme
sudo dnf install -y glib2-devel gdk-pixbuf2-devel rubygem-sass

# NUMIX FROST THEME

cd $(mktemp -d)
curl -L https://github.com/Antergos/Numix-Frost/archive/master.zip -o Numix-Frost.zip
unzip Numix-Frost.zip && cd Numix-Frost-master
make
sudo make install prefix="$prefix"

# dependencies for POP theme
sudo dnf install -y librsvg2-devel parallel sassc

# ADAPTA THEME

cd $(mktemp -d)
curl -L https://github.com/adapta-project/adapta-gtk-theme/archive/master.tar.gz -o adapta.tar.gz
tar xzf adapta.tar.gz && cd adapta-gtk-theme-master
./autogen.sh --prefix="$prefix"
make
sudo make install

# POP THEME

cd $(mktemp -d)
curl -L https://github.com/system76/pop-gtk-theme/archive/master.zip -o pop-gtk-theme.zip
unzip pop-gtk-theme.zip && cd pop-gtk-theme-master
./autogen.sh --prefix="$prefix"
make
sudo make install

sudo dnf remove -y glib2-devel gdk-pixbuf2-devel librsvg2-devel parallel
