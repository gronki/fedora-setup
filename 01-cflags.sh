#!/bin/bash
set -ex

CFLAGS="-g -Wall -O3 -march=native"

echo export CFLAGS=\"$CFLAGS\" | sudo tee /etc/profile.d/cflags.sh
echo export CXXFLAGS=\"$CFLAGS\" | sudo tee -a /etc/profile.d/cflags.sh
echo export FFLAGS=\"$CFLAGS\" | sudo tee -a /etc/profile.d/cflags.sh
echo export FCFLAGS=\"$CFLAGS\" | sudo tee -a /etc/profile.d/cflags.sh
echo export FCFLAGS=\"$CFLAGS\" | sudo tee -a /etc/profile.d/cflags.sh
