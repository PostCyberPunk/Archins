#!/bin/bash
source ./lib/utils.sh

init_install() {
	systemctl stop reflector && myellow "Stop Reflector"
	timedatectl set-timezone Asia/Shanghai && mgreen "Setup timezone"
	print_time

	sed -i '1 i Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist && mgreen "Tsinghua mirrors added"
	# pacman -S archlinux-keyring && mgreen "Synced:archlinux-keyring"
	pacman -Syy && mgreen "PKG source updated"
}

### 2 partition
write_disk() {
	lsblk
	mgreen "######################"
	myellow "!!!!!Carefull or you may lost data!!!!"
	mgreen "######################"
	read -p "Disk id(/dev/): " _disk_id
	if [[ -z $_disk_id ]]; then
		mred "Disk id cant be empty"
		return 1
	fi
	cfdisk /dev/$_disk_id
	if [[ $? -eq 0 ]]; then
		fdisk -l /dev/$_disk_id && myellow "Are you sure?"
	else
		mred "Wrong disk id!" && return 1
	fi
	# cfdisk /dev/$_disk_id && $(fdisk -l /dev/$_disk_id && myellow "Are you sure?") || $(mred "Wrong disk id!" && return 0)
	if need_confirm "continue? "; then
		mgreen "Ok partition ready"
		return 0
	else
		myellow "Restart cfdisk"
		return 1
	fi
}
step_partition() {
	while ! write_disk; do
		myellow "Start Over"
	done
}

###### formant and core installing #######
step_info_fc() {
	if [[ -z $_disk_id ]]; then
		lsblk
		read -p "Disk id(/dev/): " _disk_id
	fi
	mteal "Input the partition index(1-9):"
	read -p "EFI index(/dev/$_disk_id)" efipart
	read -p "Main index(/dev/$_disk_id)" mainpart
	efipart=/dev/$_disk_id$efipart
	mainpart=/dev/$_disk_id$mainpart
}
step_format() {
	__partition_format() {
		mkfs.ext4 $mainpart && mgreen "Main formation succced" || return 1
		mkfs.fat -F 32 $efipart && mgreen "EFI formation suddced" || return 1
		return 0
	}
	__partition_format
	check_last_cmd "Partition Formating"
}
step_core() {
	mount $mainpart /mnt
	mount --mkdir $efipart /mnt/boot
	myellow "Installing core!"
	pacstrap /mnt base base-devel linux linux-firmware linux-headers
	if need_confirm "Do you want to install Extra ?"; then
		pacstrap /mnt man-db man-pages networkmanager grub efibootmgr intel-ucode \
			fish git neovim lf bottom noto-fonts-cjk \
			tmux wget curl which lvm2
	fi
	check_last_cmd "Core installation"
	genfstab -U /mnt >>/mnt/etc/fstab
	check_last_cmd "Generation fstab"
}

pre-chroot() {
	cp -r "./sysinit" "/mnt/home/"
	cp -r "./lib" "/mnt/home/sysinit/"
	mblue "Script located at:/home/sysinit"
}
chroot() {
	arch-chroot /mnt /bin/bash -c '
  cd /home/sysinit/
  chmod +x ./*.sh
  ./system_init.sh
  '
}

main() {
	mgreen "######################"
	mgreen "PCP Arch Installation"
	mgreen "######################"
	if need_confirm "Init ArchISO ?"; then
		init_install
	fi

	if need_confirm "Disk partition?"; then
		step_partition
	fi

	if need_confirm "Formation and Installing core?"; then
		step_info_fc
		while ! need_confirm "Are You Sure? \
      EFI:$efipart \
      MainFileSystem:$mainpart \
       "; do
			step_info_fc
		done
		if need_confirm "Format partition?"; then
			step_format
		fi
		if need_confirm "Install Core?"; then
			step_core
		fi
	fi
	###########Chroot
	if need_confirm "Arch-chroot? "; then
		if need_confirm "Prepare for chroot? "; then
			pre-chroot
		fi
		chroot
	else
		mblue "Tips Make sure only system partition mounted"
		mblue "You can run pre-chroot to copy all files first"
	fi
}

######################
# Get the directory of the script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Check if the current working directory is the same as the script directory
if [ ! "$PWD" = "$DIR" ]; then
	echo "The script is not being executed in the same directory where it is located."
	exit 1
fi

if [[ $1 = "" ]]; then
	main
else
	"$1"
fi
exit 0
