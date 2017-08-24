#!/bin/bash
set -ex

T=$(mktemp)
#rpm --undefine _hardened_build -E %optflags | tee $T
echo '-g -O2' | tee $T
vim $T
CFLAGS=$(cat $T)

echo "export CFLAGS=\"$CFLAGS\""   | sudo tee    /etc/profile.d/cflags.sh
echo "export CXXFLAGS=\"$CFLAGS\"" | sudo tee -a /etc/profile.d/cflags.sh
echo "export FFLAGS=\"$CFLAGS\""   | sudo tee -a /etc/profile.d/cflags.sh
echo "export FCFLAGS=\"$CFLAGS\""  | sudo tee -a /etc/profile.d/cflags.sh
echo "export F95FLAGS=\"$CFLAGS\"" | sudo tee -a /etc/profile.d/cflags.sh
