#!/bin/bash
set -ex

sudo -b updatedb
sudo systemctl enable sshd

echo 'export EDITOR=nano' | sudo tee -a /etc/profile.d/editor.sh

CFLAGS="$(rpm -E %optflags) -O3 -march=native -mieee-fp"
FFLAGS_EXTRA="-Wstandard -Warray-temporaries -Wno-unused-dummy-argument \
-Waliasing -Wampersand -Wdeprecated -Wtarget-lifetime -Wsurprising"

echo "export CFLAGS=\"$CFLAGS\"
export FFLAGS=\"$CFLAGS $FFLAGS_EXTRA\"
export FCFLAGS=\"$CFLAGS $FFLAGS_EXTRA\"
export F95FLAGS=\"$CFLAGS $FFLAGS_EXTRA\"
export CXXFLAGS=\"$CFLAGS\" " | sudo tee -a /etc/profile.d/cflags.sh

. /etc/profile.d/cflags.sh
