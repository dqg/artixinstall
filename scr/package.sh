#!/bin/sh

sed -i "s/Required DatabaseOptional/Never/; /^#Color$/s/#//; /^# Misc options$/a ILoveCandy" /etc/pacman.conf
if [ -f "$(echo pkg1-*.txz)" ]; then
	mkdir -p /mnt/var/cache/pacman/pkg
	tar -Jxvf pkg1-*.txz -C /mnt/var/cache/pacman/pkg
	basestrap -U /mnt /mnt/var/cache/pacman/pkg/*
else
	sed -i "/--noconfirm/s/(/(--disable-download-timeout /" /bin/basestrap
	basestrap /mnt base artix-archlinux-support linux linux-firmware runit elogind-runit grub efibootmgr dash networkmanager-runit || exit 1
	x="$PWD"
	(cd /mnt/var/cache/pacman/pkg && tar -Jcvf $x/pkg1-$(date "+%Y%m%d").txz *.pkg.tar.zst)
fi

sed -i "s/Required DatabaseOptional/Never/; /^#Color$/s/#//; /^# Misc options$/a ILoveCandy" /mnt/etc/pacman.conf
fstabgen -U /mnt >/mnt/etc/fstab
ln -sf dash /mnt/bin/sh

cp -v /bin/neofetch /bin/vi /mnt/usr/local/bin
cp scr/chroot.sh /mnt
