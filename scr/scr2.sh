#!/bin/bash

var="s/Required DatabaseOptional/Never/
s/^#(ParallelDownloads).*/\1 = 3/
/^#Color$/s/#//
/^# Misc options$/a ILoveCandy"
sed -Ei "$var" /etc/pacman.conf

[ -f pkg1-*.txz ] || {
until [ "$x" = "0" ]; do
	basestrap /mnt $(grep -v "^http" list)
	x="$?"
done
curl -LOO --output-dir /mnt/var/cache/pacman $(grep "^http" list) || exit 1
mv /mnt/var/cache/pacman/{*.zst,pkg}
tar -Jvcf pkg1-$(date "+%Y%m%d").txz -C /mnt/var/cache pacman
exit
}

mkdir -p /mnt/var/cache
tar -Jvxf pkg1-*.txz -C /mnt/var/cache
basestrap -U /mnt /mnt/var/cache/pacman/pkg/*

sed -Ei "$var" /mnt/etc/pacman.conf
fstabgen -U /mnt >/mnt/etc/fstab
ln -sf dash /mnt/bin/sh
cp scr/scr3.sh /mnt
