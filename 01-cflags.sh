#!/bin/bash
set -e

OPTFLAGS="-g -Wall -O2"
ARCH_FLAGS="-march=native"

if cat /proc/cpuinfo | grep BCM2835; then
	ARCH_FLAGS="-mcpu=cortex-a53 -mfpu=neon-fp-armv8 -mfloat-abi=hard"
	OPTFLAGS="$OPTFLAGS -pipe"
fi

sudo tee /etc/profile.d/cflags.sh <<EOF
export ARCH_FLAGS="$ARCH_FLAGS"
OPTFLAGS="$OPTFLAGS"

export   CFLAGS="\$OPTFLAGS \$ARCH_FLAGS"
export CXXFLAGS="\$OPTFLAGS \$ARCH_FLAGS"
export   FFLAGS="\$OPTFLAGS \$ARCH_FLAGS"
EOF

sudo vim /etc/profile.d/cflags.sh
