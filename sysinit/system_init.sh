#!/bin/bash
source ./lib/utils.sh

if need_confirm "Initialize enviroment(time locale user)"; then
	./1env.sh
fi

if need_confirm "Setup AUR?"; then
	./2AUR.sh
fi

if need_confirm "Install systemdBoot?"; then
	./3systemdBoot.sh
fi

if need_confirm "Install SSH?"; then
  pacman -S openssh&&systemctl enable sshd
fi
