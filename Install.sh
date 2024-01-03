source ./lib/confirm.sh
source ./lib/message.sh

mgreen "PCP Arch Installation"
systemctl stop reflector && myellow "stop reflector"
sed -i '1 i Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist && myellow "add tsinghua mirrors"
timedatectl set-timezone Asia/Shanghai && myellow "Setup timezone"
mgreen "Current time:"
date
pacman -Syy && mgreen "PKG source updated"
pacman -S archlinux-keyring && mgreen "archlinux-keyring installed"

### 2 partition
__write_disk() {
	lsblk
	myellow "!!!!!Carefull or you may lost data!!!!"
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
	if needConfirm "continue? "; then
		mgreen "Ok partition ready"
		return 0
	else
		myellow "Restart cfdisk"
		return 1
	fi
}
step_partition() {
	while ! __write_disk; do
		myellow "Start Over"
	done
}
mteal "Input the partition id:"
