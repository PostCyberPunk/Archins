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
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch
EOF
}

step_extra_source() {
	config_pacman && mgreen 'Adding community pkg to pacman.conf'

  ############## 2023 12 patch ################
	sudo pacman-key --lsign-key "farseerfc@archlinux.org"
	
	redo_failed_cmd "Synced: archlinuxcn-keyring" "pacman -Sy --noconfirm archlinuxcn-keyring"

	redo_failed_cmd "Synced: yay and proxy" "pacman -S --noconfirm --needed yay ntfs-3g v2raya proxychains-ng"

	redo_failed_cmd "v2raya enabled" "systemctl enable v2raya"
	date
}

if [[ $1 = "" ]]; then
	step_extra_source
else
	"$1"
fi
