#!/usr/bin/env bash

sudo dnf install -y cairo-dock

gsettings set org.mate.desktop.font-rendering antialiasing 'rgba'
gsettings set org.mate.desktop.font-rendering hinting 'slight'
gsettings set org.mate.desktop.font-rendering rgba-order 'rgb'

gsettings set org.mate.NotificationDaemon theme 'Slider'

gsettings set org.mate.screensaver idle-activation-enabled false
gsettings set org.mate.screensaver lock-enabled false

gsettings set org.mate.desktop.interface gtk-dialogs-use-header true
gsettings set org.mate.desktop.interface use-custom-font true
gsettings set org.mate.desktop.interface enable-animations true

gsettings set org.mate.desktop.interface font-name "Cantarell 11"
gsettings set org.mate.desktop.interface document-font-name "Noto Serif 11"
gsettings set org.mate.desktop.interface monospace-font-name "Fira Mono 14"
gsettings set org.mate.desktop.interface gtk-theme "Arc-Dark"
gsettings set org.mate.desktop.interface icon-theme "Numix Circle"

gsettings set org.mate.power-manager button-lid-ac 'nothing'
gsettings set org.mate.power-manager button-lid-battery 'suspend'
gsettings set org.mate.power-manager button-suspend 'nothing'
gsettings set org.mate.power-manager button-power 'interactive'

gsettings set org.mate.desktop.peripherals.touchpad natural-scroll true
gsettings set org.mate.desktop.peripherals.touchpad horizontal-two-finger-scrolling true
gsettings set org.mate.desktop.peripherals.touchpad horizontal-edge-scrolling false
gsettings set org.mate.desktop.peripherals.touchpad vertical-edge-scrolling false
gsettings set org.mate.desktop.peripherals.touchpad disable-while-typing true
gsettings set org.mate.desktop.peripherals.touchpad tap-to-click false

gsettings set org.mate.desktop.session.required-components windowmanager 'compiz'
gsettings set org.mate.desktop.session.required-components dock 'cairo-dock'

gsettings set org.mate.marco.general theme 'Arc-Dark'
