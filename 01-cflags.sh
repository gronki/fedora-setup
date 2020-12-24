#!/bin/bash
set -e

OPTFLAGS="-O3 -pipe -g1 -Wall"
ARCHFLAGS="-march=native"

if cat /proc/cpuinfo | grep BCM2835; then
	OPTFLAGS="$OPTFLAGS -funsafe-math-optimizations"
	ARCHFLAGS="-mcpu=cortex-a53 -mfpu=neon-fp-armv8 -mfloat-abi=hard"
fi

sudo tee /etc/profile.d/cflags.sh <<EOF
export ARCHFLAGS="$ARCHFLAGS"
OPTFLAGS="$OPTFLAGS"

export   CFLAGS="\$OPTFLAGS \$ARCHFLAGS"
export CXXFLAGS="\$OPTFLAGS \$ARCHFLAGS"
export   FFLAGS="\$OPTFLAGS \$ARCHFLAGS"
export  FCFLAGS="\$OPTFLAGS \$ARCHFLAGS"
EOF

sudo vi /etc/profile.d/cflags.sh
