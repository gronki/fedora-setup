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

# interface fonts
sudo dnf install -y google-roboto-fonts \
    google-noto-{mono,sans,serif}-fonts \
    mozilla-fira-{sans,mono}-fonts \
    google-droid-{sans,sans-mono,serif}-fonts

# some pretty themes
sudo dnf install arc-theme numix-gtk-theme \
      numix-icon-theme{,-circle} greybird-gtk{2,3}-theme

# hekoaida and Adapta themes
# sudo dnf copr enable -y heikoada/gtk-themes
# sudo dnf install -y adapta-gtk-theme-{gtk2,gtk3,chrome,gedit}
# sudo dnf install gnome-shell-theme-adapta || echo OK

sudo mkdir -p /usr/local/share/wallpapers

sudo curl -L http://rigel.astronet.pl/~gronki/wallpapers/001.jpg -o /usr/local/share/wallpapers/001.jpg
sudo curl -L http://rigel.astronet.pl/~gronki/wallpapers/002.jpg -o /usr/local/share/wallpapers/002.jpg
sudo curl -L http://rigel.astronet.pl/~gronki/wallpapers/003.jpg -o /usr/local/share/wallpapers/003.jpg
sudo curl -L http://rigel.astronet.pl/~gronki/wallpapers/004.jpg -o /usr/local/share/wallpapers/004.jpg
sudo curl -L http://rigel.astronet.pl/~gronki/wallpapers/010.jpg -o /usr/local/share/wallpapers/010.jpg

sudo chmod +r /usr/local/share/wallpapers/*.jpg
