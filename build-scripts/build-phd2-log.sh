prefix=/opt/phd2log
version=0.6.2

if ! which wxformbuilder; then
	echo "wxformbuilder not installed!"
	echo "wget https://github.com/wxFormBuilder/wxFormBuilder/releases/download/v3.6.2/wxformbuilder.flatpak"
	echo "sudo flatpak install wxformbuilder.flatpak"
	exit
fi

cd $(mktemp -d)
curl -L https://github.com/agalasso/phdlogview/archive/v${version}.zip -o phd2log.zip
unzip phd2log.zip && cd phdlogview-${version}
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX="$prefix" ..
make
sudo make install

