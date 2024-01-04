#!/bin/bash
source ./lib/utils.sh

config_pacman() {
	target_file="/etc/pacman.conf"

	sed -i '/\[options\]/a \
### Setting\
Color\
CheckSpace\
VerbosePkgLists\
ParallelDownloads = 5\
ILoveCandy
' $target_file
	tee -a >>/etc/pacman.conf <<EOF
[archlinuxcn]
SigLevel = Optional TrustAll
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch
EOF
}

step_extra_source() {
	config_pacman && mgreen 'Adding community pkg to pacman.conf'
	pacman -Sy archlinuxcn-keyring && mgreen "Synced: archlinuxcn-keyring"
	pacman -S --needed yay ntfs-3g v2raya proxychains-ng && mgreen "Synced: yay and proxy"
	systemctl enable v2raya && mteal "v2raya enabled"
	date
}

if [[ $1 = "" ]]; then
	step_extra_source
else
	"$1"
fi
