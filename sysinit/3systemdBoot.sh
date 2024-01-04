#!/bin/bash
source ./lib/utils.sh

boot_fix() {
	mkdir /usr/lib/systemd/system-generators-backup
	mv /usr/lib/systemd/system-generators/systemd-gpt-auto-generator /usr/lib/systemd/system-generators-backup/systemd-gpt-auto-generator.bak
}

step_boot() {
	bootctl install
	check_last_cmd "Systemd boot installed"
	cp ./lib/arch.conf /boot/loader/entries/ && echo 'copy entry conf'
	cat >>/boot/loader/loader.config <<EOF
default arch
timeout 3
EOF
	mteal "Loader Setup"
	nvim -o /etc/fstab /boot/loader/entries/arch.conf
	mgreen "Done:bootloader"
	if need_confirm "Do you want fix systemd boot hang for 1m30s? "; then
		boot_fix && mgreen "Fixed"
	fi
  now_time=$(date)
	mgreen "Completed time: $now_time"
}

if [[ ! $1 = "" ]]; then
	"$1"
else
	step_boot
fi
