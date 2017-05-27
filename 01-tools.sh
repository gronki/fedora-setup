#!/bin/bash
set -ex

sudo dnf install -y git PackageKit-command-not-found
sudo dnf install -y dconf-editor yumex-dnf
