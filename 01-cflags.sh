#!/bin/bash
set -ex

sudo dnf install @c-development gcc-{c++,gfortran} redhat-rpm-config

cat | sudo tee /etc/profile.d/cflags.sh <<EOF
OPTFLAGS="-O2 -ftree-vectorize -march=native"

# rpm flags
# OPTFLAGS="$(rpm --define '__global_compiler_flags -O2' -E %optflags)"

# rpm flags -- full (without hardening)
# OPTFLAGS="$(rpm --undefine _hardened_build -E %optflags)"

# for rpi3
# OPTFLAGS="-O2 -ftree-vectorize -pipe -mcpu=cortex-a53 -mfpu=neon-fp-armv8 -mfloat-abi=hard"

export CFLAGS="\$OPTFLAGS"
export CXXLAGS="\$OPTFLAGS"
export FFLAGS="\$OPTFLAGS"
EOF

