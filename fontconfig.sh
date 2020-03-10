#!/usr/bin/env bash
set -e

#-----------------------------------------------------------------------------#

confd=/etc/fonts/conf.d
availd=/usr/share/fontconfig/conf.avail
Xres=/etc/X11/Xresources

setXres() {
	if grep "${1}[.*]${2}" "${Xres}"; then
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
	else
		setXres Xft hinting "true"
	fi

	setXres Xft antialias "true"
	setXres Xft autohint "false"

	sudo rm -fv "${confd}"/10-hinting-*.conf
	sudo ln -s "${availd}/10-hinting-${hinting}.conf" "${confd}/10-hinting-${hinting}.conf"
	
	setXres Xft hintstyle "hint${hinting}"
	
	xfconf-query -c xsettings -p /Xft/HintStyle -s "hint${hinting}" || echo xfconf fail
	gsettings set org.gnome.settings-daemon.plugins.xsettings hinting ${hinting} || echo gsettings fail
	
	echo
	echo -e "hinting set to \033[1m$hinting\033[0m"
	echo
}

setLcdFilter() {
	filter="$1"
	
	sudo rm -fv "${confd}"/11-lcdfilter-*.conf
	sudo ln -s "${availd}/11-lcdfilter-${filter}.conf" "${confd}/11-lcdfilter-${filter}.conf"
	setXres Xft lcdfilter "lcd${filter}"
	
	echo
	echo -e "lcdfilter set to \033[1m$filter\033[0m"
	echo
}

#-----------------------------------------------------------------------------#

sudo pwd; echo

echo select hinting
select hinting in slight full none
do
	if [ -n "$hinting" ]; then
		setHinting "$hinting"
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

#-----------------------------------------------------------------------------#

fc-cache -r &

#-----------------------------------------------------------------------------#

# rgb bgr vbgr vrgb
# /org/gnome/settings-daemon/plugins/xsettings/
# xfconf-query -c xsettings -l -v
