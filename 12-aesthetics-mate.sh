#!/usr/bin/env bash

gsettings set org.mate.font-rendering antialiasing 'rgba'
gsettings set org.mate.font-rendering hinting 'slight'
gsettings set org.mate.font-rendering rgba-order 'rgb'

gsettings set org.mate.NotificationDaemon theme 'Slider'

gsettings set org.mate.screensaver idle-activation-enabled false
gsettings set org.mate.screensaver lock-enabled false

gsettings set org.mate.interface font-name "Cantarell 11"
gsettings set org.mate.interface document-font-name "Noto Serif 11"
gsettings set org.mate.interface monospace-font-name "Fira Mono 14"
gsettings set org.mate.interface gtk-theme "Adwaita"
gsettings set org.mate.interface icon-theme "Numix Circle"
