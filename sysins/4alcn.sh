echo 'Adding community pkg to pacman'
tee -a >>/etc/pacman.conf <<EOF
### Setting
Color
CheckSpace
VerbosePkgLists
ParallelDownloads = 5
ILoveCandy

[archlinuxcn]
SigLevel = Optional TrustAll
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch
EOF
pacman -Sy archlinuxcn-keyring
pacman -S --needed yay ntfs-3g v2raya proxychains-ng
systemctl enable v2raya
date
