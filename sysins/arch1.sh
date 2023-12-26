echo "first install"
systemctl stop reflector
sed -i '1 i Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch ' /etc/pacman.d/mirrorlist
timedatectl set-timezone Asia/Shanghai
pacman -Syy
pacman -S archlinux-keyring
date
