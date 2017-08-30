#!/bin/bash
set -ex

sudo dnf install -y \
	@c-development @development-tools @rpm-development-tools \
	fedpkg rpmdevtools copr-cli gists \
	gcc-gfortran coffee-script
