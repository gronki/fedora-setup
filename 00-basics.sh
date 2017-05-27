#!/bin/bash
set -ex

sudo dnf install -y dconf-editor yumex-dnf
sudo -b updatedb
sudo systemctl enable sshd

cat - > /tmp/editor.sh <<EOF
export EDITOR=nano
EOF
sudo mv /tmp/editor.sh /etc/profile.d/editor.sh

cat - > /tmp/cflags.sh <<EOF
export CFLAGS="-O3 -march=native -ffast-math"
export FFLAGS="-O3 -march=native -ffast-math"
export CXXFLAGS="-O3 -march=native -ffast-math"
EOF
sudo mv /tmp/cflags.sh /etc/profile.d/cflags.sh
