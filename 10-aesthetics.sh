#!/bin/bash
set -ex

# subpixel rendering
sudo dnf install -y freetype-freeworld

# font configuration
cd /etc/fonts/conf.d/
sudo rm -f 10-hinting-*.conf
sudo rm -f 10*sub-pixel*.conf
sudo rm -f 11-lcdfilter-*.conf
sudo ln -sf /usr/share/fontconfig/conf.avail/10-hinting-slight.conf
sudo ln -sf /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf
sudo ln -sf /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf

# gnome fine tuning
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-date true

# interface fonts
sudo dnf install -y google-roboto-fonts \
    google-noto-{mono,sans,serif}-fonts \
    mozilla-fira-{sans,mono}-fonts \
    google-droid-{sans,sans-mono,serif}-fonts

# some pretty themes
sudo dnf install -y arc-theme numix-gtk-theme \
      numix-icon-theme{,-circle} greybird-gtk{2,3}-theme

# hekoaida and Adapta themes
sudo dnf copr enable -y heikoada/gtk-themes
sudo dnf install -y gnome-shell-theme-adapta adapta-gtk-theme-{gtk2,gtk3,chrome,gedit}

# dependencies for POP & Numix Frost Theme
sudo dnf install -y glib2-devel gdk-pixbuf2-devel

# numix frost
pushd $(mktemp -d)
curl -L https://github.com/Antergos/Numix-Frost/archive/master.zip -o Numix-Frost.zip
unzip Numix-Frost.zip
cd Numix-Frost-master
make
sudo make install prefix=/usr/local
popd

# dependencies for POP theme
sudo dnf install -y librsvg2-devel parallel sassc

# POP theme
pushd $(mktemp -d)
curl -L https://github.com/system76/pop-gtk-theme/archive/master.zip -o pop-gtk-theme.zip
unzip pop-gtk-theme.zip
cd pop-gtk-theme-master
./autogen.sh --prefix=/usr/local
make
sudo make install
popd

sudo dnf remove -y glib2-devel gdk-pixbuf2-devel librsvg2-devel
sudo dnf remove parallel
sudo dnf remove sassc
