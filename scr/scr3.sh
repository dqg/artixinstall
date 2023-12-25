#!/bin/sh

echo "
[extra]
Include = /etc/pacman.d/mirrorlist-arch

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" >>/etc/pacman.conf

ln -s /etc/runit/sv/NetworkManager /etc/runit/runsvdir/default
mv /var/cache/pacman/*.hook /usr/share/libalpm/hooks

ln -s /usr/share/zoneinfo/Asia/Colombo /etc/localtime
hwclock -w

sed -i "/^#en_US/s/#//" /etc/locale.gen
printf 'export %s\n' 'LANG="en_US.UTF-8"' 'LC_COLLATE="C"' >/etc/locale.conf
locale-gen

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg

echo "art" >/etc/hostname
printf "%b\n" "127.0.0.1\tlocalhost
::1\t\tlocalhost
127.0.1.1\tart.localdomain\tart" >/etc/hosts

passwd -d root
swapoff -a
