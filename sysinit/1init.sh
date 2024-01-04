#!/bin/bash
source ./lib/utils.sh

set_time() {

	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	hwclock --systohc && echo 'SyncClock'
	mgreen "Time setting done"
  now_time=$(date)
	mgreen "Completed time: $now_time"
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
	chsh -s /usr/bin/fish $hname
	# echo '!!!!!!Dont forget to chang your password!!!'
	echo password for Root
	passwd
	echo password for $uname
	passwd $uname
	date
}

step_init_system() {
	read -p "HostName: " hname
	read -p "UserName: " uname

	set_time && mgreen "Initialized:Time"
	gen_locale && mgreen "Initialized:Locale"
	set_usernpass && mgreen "Initialized:User and password"

	systemctl enable NetworkManager && mgreen "NetworkManager enabled"
}

if [[ $1 = "" ]]; then
	step_init_system
else
	"$1"
fi
