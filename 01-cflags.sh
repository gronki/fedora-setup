#!/bin/bash
set -ex

T=$(mktemp)
rpm --rcfile /usr/lib/rpm/rpmrc -E %optflags | tee $T
vim $T
CFLAGS=$(cat $T)

echo "export CFLAGS=\"$CFLAGS\""   | sudo tee    /etc/profile.d/cflags.sh
echo "export CXXFLAGS=\"$CFLAGS\"" | sudo tee -a /etc/profile.d/cflags.sh
echo "export FFLAGS=\"$CFLAGS\""   | sudo tee -a /etc/profile.d/cflags.sh
echo "export FCFLAGS=\"$CFLAGS\""  | sudo tee -a /etc/profile.d/cflags.sh
echo "export F95FLAGS=\"$CFLAGS\"" | sudo tee -a /etc/profile.d/cflags.sh
