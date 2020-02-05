#!/bin/bash
set -ex

# interface fonts
sudo dnf install -y google-roboto-fonts \
    google-noto-{mono,sans,serif}-fonts \
    mozilla-fira-{sans,mono}-fonts \
    google-droid-{sans,sans-mono,serif}-fonts

# some pretty themes
sudo dnf install arc-theme numix-gtk-theme \
      numix-icon-theme{,-circle} greybird-gtk{2,3}-theme

