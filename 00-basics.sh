#!/bin/bash
set -ex

sudo -b updatedb
sudo systemctl enable sshd

echo 'export EDITOR=nano' | sudo tee -a /etc/profile.d/editor.sh

CFLAGS="-g -Wall -O3 -mieee-fp -march=native"
FFLAGS="$CFLAGS -Wpedantic -Wintrinsics-std -Warray-temporaries \
-Wsurprising -Waliasing -Wno-unused-dummy-argument"

echo "export CFLAGS=\"$CFLAGS\"
export FFLAGS=\"$FFLAGS\"
export FCFLAGS=\"$FFLAGS\"
export F95FLAGS=\"$FFLAGS\"
export CXXFLAGS=\"$CFLAGS\"" | sudo tee -a /etc/profile.d/cflags.sh

. /etc/profile.d/cflags.sh
