#!/bin/bash
set -ex

sudo dnf install -y dconf-editor yumex-dnf
sudo -b updatedb
sudo systemctl enable sshd

echo 'export EDITOR=nano' | sudo tee -a /etc/profile.d/editor.sh

OPT_FLAGS="-g -Wall -O3 -march=native -mieee-fp"
FFLAGS_EXTRA="-Wstandard -Warray-temporaries -Wno-unused-dummy-argument
-Waliasing -Wampersand -Wdeprecated -Wtarget-lifetime -Wsurprising"
cat - > /tmp/cflags.sh <<EOF
export CFLAGS="$OPT_FLAGS"
export FFLAGS="$OPT_FLAGS $FFLAGS_EXTRA"
export FCFLAGS="$OPT_FLAGS $FFLAGS_EXTRA"
export F95FLAGS="$OPT_FLAGS $FFLAGS_EXTRA"
export CXXFLAGS="$OPT_FLAGS"
EOF
sudo mv /tmp/cflags.sh /etc/profile.d/cflags.sh
