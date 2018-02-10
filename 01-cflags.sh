#!/bin/bash
set -ex

sudo dnf install @c-development gcc-{c++,gfortran} redhat-rpm-config

cat | sudo tee /etc/profile.d/cflags.sh <<EOF
OPTFLAGS="-g -Wall -O2 -march=native"

# rpm flags
# OPTFLAGS="$(rpm --define '__global_compiler_flags -g -Wall -O2' -E %optflags)"

# rpm flags -- full (without hardening)
# OPTFLAGS="$(rpm --undefine _hardened_build -E %optflags)"

# for rpi3
# OPTFLAGS="-g -O3 -Wall -mcpu=cortex-a53 -mfpu=neon-fp-armv8 -mfloat-abi=hard"

export CFLAGS="\$OPTFLAGS"
export CXXLAGS="\$OPTFLAGS"
export FFLAGS="\$OPTFLAGS"
EOF

