#!/bin/bash
set -ex

sudo dnf install -y i3 rxvt-unicode mozilla-fira-{mono,sans}-fonts google-roboto-fonts caja midori
sudo dnf install openbox obconf lxpanel lxmenu-data

cat | sudo tee -a /etc/X11/Xresources <<EOF
# general font rendering options
Xft.hinting: 1
Xft.autohint: 0
Xft.hintstyle: hintslight
Xft.antialias: 1

# uncomment this if not used by VNC
# Xft.lcdfilter: lcddefault
# Xft.rgba: rgb

# RXVT settings
URxvt.scrollBar: false
URxvt.background: #181818
URxvt.foreground: #F0F0F0
URxvt.letterSpacing: -2
URxvt.font: xft:Fira Mono:size=12
URxvt.url-launcher: midori
EOF

