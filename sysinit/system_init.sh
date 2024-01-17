#!/bin/bash
source ./lib/utils.sh

if need_confirm "Initialize enviroment(time locale user)"; then
	./1env.sh
fi

if need_confirm "Install Packages?"; then
	./2PKG.sh
fi

if need_confirm "Install systemdBoot?"; then
	./3systemdBoot.sh
fi

if need_confirm "Install SSH?"; then
  pacman -S --noconfirm openssh&&systemctl enable sshd
fi
