#!/bin/bash
source ./lib/utils.sh

boot_fix() {
	mkdir /usr/lib/systemd/system-generators-backup
	mv /usr/lib/systemd/system-generators/systemd-gpt-auto-generator /usr/lib/systemd/system-generators-backup/systemd-gpt-auto-generator.bak
}

step_boot() {
	bootctl install
	check_last_cmd "Systemd boot installed"
	cp ./lib/arch.conf /boot/loader/entries/
	check_last_cmd "Boot entry conf copied"
	cat >>/boot/loader/loader.config <<EOF
default arch
timeout 3
EOF
	mblue "Loader Setup"
	if need_confirm "Setup bootloader with neovim? "; then
		nvim -o /etc/fstab /boot/loader/entries/arch.conf
	fi
	mgreen "Done:bootloader"
	if need_confirm "Do you want fix systemd boot hang for 1m30s? "; then
		boot_fix && mgreen "Fixed"
	fi
	print_time
}

if [[ ! $1 = "" ]]; then
	"$1"
else
	step_boot
fi
