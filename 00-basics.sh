#!/bin/bash
set -ex

sudo yum install vim-enhanced
echo export EDITOR=vim | sudo tee -a /etc/profile.d/editor.sh

echo alias wifi=\'nmcli device wifi\' | sudo tee -a /etc/profile.d/aliases.sh
