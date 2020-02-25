#!/usr/bin/env bash

set -e

if [ ! -f "$1" ]; then 
	echo usage: install_discord.sh discord.tar.gz
	exit -1
fi

rm -rf Discord
tar xzfv "$1"

sudo mkdir -p /opt/discord
sudo cp -rv Discord/* /opt/discord/

cd /opt/discord
sudo chmod +x Discord
sudo ln -sf $PWD/Discord /usr/local/bin/Discord
cat discord.desktop | sed 's/\/usr\/share/\/opt/' | sudo tee /usr/local/share/applications/discord.desktop
sudo ln -sf $PWD/discord.png /usr/local/share/icons/discord.png

bash postinst.sh
