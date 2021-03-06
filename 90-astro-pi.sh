#!/usr/bin/env bash
set +e
set -x

bash 00-basics.sh
bash 01-cflags.sh
bash 20-vnc-desktop.sh

sudo dnf install -y kstars phd2 fpack

bash build-tools.sh

sudo dnf install -y {cfitsio,fftw3}{,-devel}

bash 60-telescope.sh

echo 'remember to install or build astrometry, indi and ds9'
