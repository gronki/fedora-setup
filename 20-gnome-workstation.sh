#!/bin/bash
set -ex

sudo dnf copr enable -y region51/chrome-gnome-shell
sudo dnf install -y chrome-gnome-shell

sudo dnf install owncloud-client{,-nautilus} nautilus-extensions dconf-editor tilix{,-nautilus} geary gnome-tweak-tool 

sudo dnf install gnome-shell-extension-{pomodoro,freon,apps-menu,places-menu,openweather,dash-to-dock,refresh-wifi,alternate-tab,topicons-plus,suspend-button,media-player-indicator}

sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
sudo dnf install spotify

curl -L 'http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm' -o /tmp/adobe.rpm
sudo dnf install /tmp/adobe.rpm
sudo dnf install flash-player-ppapi
