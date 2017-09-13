#!/bin/bash
set -ex

sudo dnf install @c-development gcc-{c++,gfortran} redhat-rpm-config

cat | sudo tee /etc/profile.d/cflags.sh <<EOF
OPTFLAGS="$(rpm --define '__global_compiler_flags -g -Wall -O2' -E %optflags)"

# for rpi3
# OPTFLAGS="-O2 -g -mcpu=cortex-a53 -mfloat-abi=hard -mfpu=neon-fp-armv8 -ffast-math"

export CFLAGS="\$OPTFLAGS"
export CXXLAGS="\$OPTFLAGS"
export FFLAGS="\$OPTFLAGS -I $(rpm -E %_fmoddir)"
export FCFLAGS="\$OPTFLAGS -I $(rpm -E %_fmoddir)"
EOF

