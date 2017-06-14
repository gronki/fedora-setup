#!/bin/bash
set -ex

sudo dnf copr enable -y region51/chrome-gnome-shell

sudo dnf install \
nextcloud-client{,-nautilus} nautilus-extensions \
dconf-editor yumex-dnf chrome-gnome-shell
