read -p "HostName: " hname
read -p "UserName: " uname

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc && echo 'SyncClock'
cat >>/etc/locale.gen <<EOF
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
EOF
locale-gen
echo 'LANG=en_US.UTF-8' >>/etc/locale.conf

echo $hname >>/etc/hostname
useradd -m -G wheel $uname
systemctl enable NetworkManager
cat >>/etc/sudoers <<EOF
%wheel ALL=(ALL:ALL) ALL
%wheel ALL=(ALL:ALL) NOPASSWD: ALL
EOF
echo 'Dont forget to chang your password!!!'
date
