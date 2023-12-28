read -p "efi " efipart
read -p "ext4 " mainpart

mkfs.ext4 $mainpart
mkfs.fat -F 32 $efipart
mount $mainpart /mnt
mount --mkdir $efipart /mnt/boot
pacstrap /mnt base base-devel linux linux-firmware linux-headers fish git neovim lf bottom man-db man-pages networkmanager grub efibootmgr intel-ucode noto-fonts-cjk which lvm2 tumx
genfstab -U /mnt >>/mnt/etc/fstab && echo 'generated fstab'
date
