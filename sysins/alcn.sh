echo 'Adding community pkg to pacman'
cat >>/etc/pacman.conf <<EOF
[archlinuxcn]
SigLevel = Optional TrustAll
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
EOF
pacman -Sy archlinuxcn-keyring
date
