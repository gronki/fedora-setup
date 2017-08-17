#!/bin/bash
set -ex

sudo yum install -y openssh-server
sudo systemctl enable sshd
