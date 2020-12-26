#!/usr/bin/env bash
set -e

OPTFLAGS="-O3 -funsafe-math-optimizations"
ARCHFLAGS="-march=native"

# RPi 3B
if cat /proc/cpuinfo | grep BCM2835; then
	ARCHFLAGS="-mcpu=cortex-a53 -mfpu=neon-fp-armv8 -mfloat-abi=hard"
fi

sudo tee /etc/profile.d/cflags.sh <<EOF
export ARCHFLAGS="$ARCHFLAGS"
export OPTFLAGS="$OPTFLAGS \$ARCHFLAGS"

export   CFLAGS="\$OPTFLAGS"
export CXXFLAGS="\$OPTFLAGS"
export   FFLAGS="\$OPTFLAGS"
export  FCFLAGS="\$OPTFLAGS"
EOF

sudo vi /etc/profile.d/cflags.sh
