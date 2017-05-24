#!/bin/bash
set -ex

sudo flatpak install -y https://s3.amazonaws.com/alexlarsson/spotify-repo/spotify.flatpakref
sudo flatpak install -y https://s3.amazonaws.com/alexlarsson/skype-repo/skype.flatpakref
sudo flatpak install -y https://dl.tingping.se/flatpak/gnome-twitch.flatpakref
sudo flatpak install -y http://flatpak.uploadedlobster.com/peek-stable.flatpakref
