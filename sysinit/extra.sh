#!/bin/bash
source ./lib/utils.sh

if [[ $1 = "" ]]; then
  step_extra_source
else
	"$1"
fi

step_extra_source
{
  config_pacman&&mgreen 'Adding community pkg to pacman'
	pacman -Sy archlinuxcn-keyring
	pacman -S --needed yay ntfs-3g v2raya proxychains-ng
	systemctl enable v2raya && mteal "v2raya enabled"
	date
}
config_pacman(){
	tee -a >>/etc/pacman.conf <<EOF
### Setting
Color
CheckSpace
VerbosePkgLists
ParallelDownloads = 5
ILoveCandy

[archlinuxcn]
SigLevel = Optional TrustAll
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch

EOF
}
