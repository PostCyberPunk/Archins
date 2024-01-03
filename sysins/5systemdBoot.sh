bootctl install && echo '!!!Systemd boot installed'
cp ./arch.conf /boot/loader/entries/ && echo 'copy entry conf'
cat >>/boot/loader/loader.config <<EOF
default arch
timeout 3
EOF
nvim -o /etc/fstab /boot/loader/entries/arch.conf

date
