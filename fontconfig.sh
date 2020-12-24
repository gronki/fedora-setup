#!/usr/bin/env bash

#-----------------------------------------------------------------------------#

confd=/etc/fonts/conf.d
availd=/usr/share/fontconfig/conf.avail
Xres=/etc/X11/Xresources

setXres() {
	if grep -q "${1}[.*]${2}" "${Xres}"; then
		sudo sed -i "s/${1}[.*]${2}.*$/${1}.${2}: ${3}/" "${Xres}"
	else
		echo "${1}.${2}: ${3}" | sudo tee -a "${Xres}"
	fi
	echo "${1}.${2}: ${3}" | xrdb -merge
}


setHinting() {
	hinting="$1"
	
	if [ $hinting == none ]; then
		setXres Xft hinting "false"
		sudo ln -sv "${availd}/10-unhinted.conf" "${confd}/10-unhinted.conf"
	else
		setXres Xft hinting "true"
		sudo rm -fv "${confd}"/10-unhinted.conf
	fi

	sudo rm -fv "${confd}"/10-hinting-*.conf
	sudo ln -sv "${availd}/10-hinting-${hinting}.conf" "${confd}/10-hinting-${hinting}.conf"
	
	setXres Xft hintstyle "hint${hinting}"
	
	xfconf-query -c xsettings -p /Xft/HintStyle -s "hint${hinting}"
	gsettings set org.gnome.settings-daemon.plugins.xsettings hinting ${hinting}
	
	echo -e "\nhinting set to \033[1m$hinting\033[0m\n"
}

setLcdFilter() {
	filter="$1"
	
	sudo rm -fv "${confd}"/11-lcdfilter-*.conf
	sudo ln -sv "${availd}/11-lcdfilter-${filter}.conf" "${confd}/11-lcdfilter-${filter}.conf"
	setXres Xft lcdfilter "lcd${filter}"
	
	echo -e "\nlcdfilter set to \033[1m$filter\033[0m\n"
}

setSubpixel() {
	rgb="$1"
	setXres Xft rgba "$rgb"
	sudo rm -fv "${confd}/10-sub-pixel-"* 
	if [ "$rgb" == none ]; then
		sudo ln -sfv "${availd}/10-no-sub-pixel.conf" "${confd}/10-no-sub-pixel.conf"
		gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing "grayscale"
	else
		sudo rm -fv "${confd}/10-no-sub-pixel.conf"
		sudo ln -sv "${availd}/10-sub-pixel-$rgb.conf" "${confd}/10-sub-pixel-$rgb.conf"
		gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing "rgba"
		gsettings set org.gnome.settings-daemon.plugins.xsettings rgba-order "$rgb"
	fi
	xfconf-query -c xsettings -p /Xft/RGBA -s "$rgb"
	echo -e "\nsubpixel rendering set to \033[1m$rgb\033[0m\n"
}

setAutohint() {
	if [ -z $1 -o $1 == 0 ]; then
		setXres Xft autohint 0
		sudo rm -fv "$confd/10-autohint.conf"
		echo -e "\nautohint \033[1moff\033[0m\n"
	else
		setXres Xft autohint 1
		sudo ln -sfv "$availd/10-autohint.conf" "$confd/10-autohint.conf"
		echo -e "\n\033[1mautohint enabled\033[0m\n"
	fi
}

#-----------------------------------------------------------------------------#

sudo pwd; echo

setXres Xft antialias 1

echo select hinting
select hinting in full slight none
do
	if [ -n "$hinting" ]; then
		setHinting "$hinting"
		break
	fi
done

echo autohint?
select ah in no yes
do
	if [ -n "$ah" ]; then
		[ "$ah" == yes ] && setAutohint 1
		[ "$ah" == no  ] && setAutohint 0
		break
	fi
done

echo select filter
select filter in default light legacy
do
	if [ -n "$filter" ]; then
		setLcdFilter "$filter"
		break
	fi
done

echo select subpixel order
select rgb in rgb bgr vrgb vbgr none
do
	if [ -n "$rgb" ]; then
		setSubpixel "$rgb"
		break
	fi
done


#-----------------------------------------------------------------------------#

fc-cache -r &

#-----------------------------------------------------------------------------#

# rgb bgr vbgr vrgb
# /org/gnome/settings-daemon/plugins/xsettings/
# xfconf-query -c xsettings -l -v
