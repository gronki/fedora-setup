#!/bin/bash
set -ex

echo export CFLAGS=\"$(rpm -E %optflags)\" | sudo tee -a /etc/profile.d/cflags.sh
echo export CXXFLAGS=\"$(rpm -E %optflags)\" | sudo tee -a /etc/profile.d/cflags.sh
echo export FFLAGS=\"$(rpm -E %optflags)\" | sudo tee -a /etc/profile.d/cflags.sh
echo export FCFLAGS=\"$(rpm -E %optflags)\" | sudo tee -a /etc/profile.d/cflags.sh
echo export FCFLAGS=\"$(rpm -E %optflags)\" | sudo tee -a /etc/profile.d/cflags.sh

sudo dnf install git @c-development
