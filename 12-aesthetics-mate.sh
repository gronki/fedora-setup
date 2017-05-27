#!/usr/bin/env bash

sudo dnf install -y plank compiz {simple-,}ccsm

gsettings set org.mate.font-rendering antialiasing 'rgba'
gsettings set org.mate.font-rendering hinting 'slight'
gsettings set org.mate.font-rendering rgba-order 'rgb'

gsettings set org.mate.NotificationDaemon theme 'Slider'

gsettings set org.mate.screensaver idle-activation-enabled false
gsettings set org.mate.screensaver lock-enabled false

gsettings set org.mate.interface gtk-dialogs-use-header true
gsettings set org.mate.interface use-custom-font true
gsettings set org.mate.interface enable-animations true

gsettings set org.mate.interface font-name "Cantarell 11"
gsettings set org.mate.interface document-font-name "Noto Serif 11"
gsettings set org.mate.interface monospace-font-name "Fira Mono 14"
gsettings set org.mate.interface gtk-theme "Arc-Darker"
gsettings set org.mate.Marco.general theme 'Arc-Darker'
gsettings set org.mate.interface icon-theme "Numix-Circle"

gsettings set org.mate.power-manager button-lid-ac 'nothing'
gsettings set org.mate.power-manager button-lid-battery 'suspend'
gsettings set org.mate.power-manager button-suspend 'nothing'
gsettings set org.mate.power-manager button-power 'interactive'

gsettings set org.mate.peripherals-touchpad natural-scroll true
gsettings set org.mate.peripherals-touchpad horizontal-two-finger-scrolling true
gsettings set org.mate.peripherals-touchpad horizontal-edge-scrolling false
gsettings set org.mate.peripherals-touchpad vertical-edge-scrolling false
gsettings set org.mate.peripherals-touchpad disable-while-typing true
gsettings set org.mate.peripherals-touchpad tap-to-click false

gsettings set org.mate.peripherals-mouse cursor-size 24
gsettings set org.mate.peripherals-mouse cursor-theme 'Adwaita'

gsettings set org.mate.session.required-components windowmanager 'compiz'
gsettings set org.mate.session.required-components dock 'plank'
gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ theme 'Arc'

sudo cp compizconfig.Default.ini /etc/compizconfig/Default.ini
