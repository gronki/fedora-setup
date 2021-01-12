#!/usr/bin/env bash
set +e -x

sudo dnf install -y \
	openbox obconf rofi rxvt-unicode pcmanfm leafpad \
	tigervnc-server xdg-utils ImageMagick \
	google-droid-sans-mono-fonts abattis-cantarell-fonts
