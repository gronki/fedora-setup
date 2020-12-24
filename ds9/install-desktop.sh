
prefix=/usr/local

sudo install -d "$prefix/share/applications"
sudo install -m 644 saods9.desktop "$prefix/share/applications"
sudo install -d "$prefix/share/icons"
sudo install -m 644 saods9.png "$prefix/share/icons"
