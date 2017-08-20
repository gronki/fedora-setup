#!/usr/bin/env bash

sudo dnf install -y tcsh ncurses libXmu ncurses-compat-libs xpa xorg-x11-fonts-misc

IRAFBASE=/opt/iraf

sudo rm -rfv $IRAFBASE
sudo mkdir -p $IRAFBASE
cd $IRAFBASE

sudo curl -L ftp://iraf.noao.edu/iraf/v216/PCIX/iraf.lnux.x86_64.tar.gz -o irpk.tar.gz
sudo tar xfz irpk.tar.gz
sudo rm irpk.tar.gz

sudo ./install --system --verbose \
    --term      xgterm \
    --root      $IRAFBASE \
    --bindir    /usr/local/bin \
    --cache     /tmp \
    --imdir     /tmp

sudo ln -s $IRAFBASE/vendor/x11iraf/bin.linux/xgterm /usr/local/bin/

cd && mkiraf

echo alias iraf=\'xgterm -bg \\\#1E2022 -fg \\\#d0d0d0 -cr \\\#e0e0e0 -title IRAF -fn 12x24 -e cl\' | sudo tee /etc/profile.d/run-iraf.sh
