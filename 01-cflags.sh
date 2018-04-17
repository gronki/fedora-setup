#!/bin/bash
set -ex

sudo tee /etc/profile.d/cflags.sh <<EOF
ARCH_FLAGS="-march=native"
OPTFLAGS="-O2 -ftree-vectorize \$ARCH_FLAGS"

# for rpi3
# ARCH_FLAGS="-mcpu=cortex-a53 -mfpu=neon-fp-armv8 -mfloat-abi=hard"
# OPTFLAGS="-O2 -ftree-vectorize -pipe \$ARCH_FLAGS"

export CFLAGS="\$OPTFLAGS"
export CXXFLAGS="\$OPTFLAGS"
export FFLAGS="\$OPTFLAGS"
export ARCH_FLAGS
EOF

sudo vim /etc/profile.d/cflags.sh
