#!/bin/bash
source ./lib/utils.sh

set_time() {

	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	hwclock --systohc && echo 'SyncClock'
	mgreen "Time setting done"

	print_time
}

gen_locale() {
	cat >>/etc/locale.gen <<EOF
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
EOF
	locale-gen
	echo 'LANG=en_US.UTF-8' >>/etc/locale.conf
}

set_usernpass() {

	echo $hname >>/etc/hostname
	useradd -m -G wheel $uname

	cat >>/etc/sudoers <<EOF
%wheel ALL=(ALL:ALL) ALL
%wheel ALL=(ALL:ALL) NOPASSWD: ALL
EOF
	chsh -s /usr/bin/fish
	check_last_cmd "Change shell to fish for root"
	chsh -s /usr/bin/fish $uname
	check_last_cmd "Change shell to fish for $uname"

	mteal "Change password for Root:"

	redo_failed_cmd "Change password for Root" "passwd root"
	mteal "Change password for $uname:"

	redo_failed_cmd "Change password for $uname" "passwd $uname"
}

step_init_system() {

	mgreen "Done:arch-chroot"
	mblue "######################"
	mblue "Initialzing system!"
	mblue "######################"

	read -p "HostName: " hname
	read -p "UserName: " uname

	set_time && mgreen "Initialized:Time"
	gen_locale && mgreen "Initialized:Locale"
	set_usernpass && mgreen "Initialized:User and password"

	systemctl enable NetworkManager && mgreen "NetworkManager enabled"
}

help() {
  declare -F
}

if [[ $1 = "" ]]; then
	step_init_system
else
	"$1"
fi
