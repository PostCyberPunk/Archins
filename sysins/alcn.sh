echo 'Adding community pkg to pacman'
cat >>/etc/pacman.conf <<EOF
[archlinuxcn]
SigLevel = Optional TrustAll
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch
EOF
pacman -Sy archlinuxcn-keyring
pacman -S yay ntfs-3g v2raya proxychains-ng
systemctl enable v2raya
date
