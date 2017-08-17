#!/bin/bash
set -ex

sudo dnf install -y @c-development @development-tools @rpm-development-tools fedpkg rpmdevtools copr-cli

sudo dnf install -y gists gcc-gfortran coffee-script
