#!/usr/bin/env bash
set -ex

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

select hinting in slight medium full none
do
	if [ -n "$hinting" ]; then
		sudo rm -fv "${confd}"/10-hinting-*.conf
		sudo ln -s "${availd}/10-hinting-${hinting}.conf" "${confd}/10-hinting-${hinting}.conf"
		setXres Xft hintstyle "hint${hinting}"
		which xfconf-query && xfconf-query -c xsettings -p /Xft/HintStyle -s "hint${hinting}"
		echo "hinting set to $hinting"
		break
	fi
done

select filter in default light legacy
do
	if [ -n "$filter" ]; then
		sudo rm -fv "${confd}"/11-lcdfilter-*.conf
		sudo ln -s "${availd}/11-lcdfilter-${filter}.conf" "${confd}/11-lcdfilter-${filter}.conf"
		setXres Xft lcdfilter "lcd${filter}"
		echo "lcdfilter set to $filter"
		break
	fi
done

fc-cache -r &
