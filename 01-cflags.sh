#!/usr/bin/env bash
set -e

OPTFLAGS="-O2"
ARCHFLAGS="-march=native"
OPTFLAGS_RPM=$(rpm -E %optflags)

# RPi 3B
if cat /proc/cpuinfo | grep BCM2835; then
	ARCHFLAGS="-mcpu=cortex-a53 -mfpu=neon-fp-armv8 -mfloat-abi=hard"
fi

sudo tee /etc/profile.d/cflags.sh <<EOF
export ARCHFLAGS="$ARCHFLAGS"
export OPTFLAGS="$OPTFLAGS \$ARCHFLAGS"

# these are the flags from RPM build
# export OPTFLAGS="$OPTFLAGS_RPM"

export   CFLAGS="\$OPTFLAGS"
export CXXFLAGS="\$OPTFLAGS"
export   FFLAGS="\$OPTFLAGS"
export  FCFLAGS="\$OPTFLAGS"
EOF

sudo vi /etc/profile.d/cflags.sh
