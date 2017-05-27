#!/bin/bash
set -ex

sudo dnf install -y nextcloud-client{,-nautilus} nautilus-extensions

sudo dnf copr enable -y region51/chrome-gnome-shell
sudo dnf install -y chrome-gnome-shell
