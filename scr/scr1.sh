#!/bin/bash

swapoff -a
umount -Rq /mnt

f() {
	until [ "$x" = "0" ]; do
		echo "[1;32m${1%\$*}[0m"
		var=$(echo "$1" | sed -E 's/.*\$(\S*).*/\1/')
		read $var
		[ -n "${!var}" ] && eval "$1"
		x="$?"
	done; unset x
}

lsblk -d
f "cfdisk /dev/\$disk"
lsblk /dev/$disk
lsblk /dev/$disk
printf "\033[3J\033[H"
lsblk /dev/$disk
f "mkfs.fat -F 32 /dev/$disk\$boot >/dev/null"
f "mkswap -q /dev/$disk\$swap >/dev/null"
f "mkfs.ext4 -Fq /dev/$disk\$root >/dev/null"

mount /dev/$disk$root /mnt
mkdir /mnt/{a,b,c,boot}
mount /dev/$disk$boot /mnt/boot
swapon /dev/$disk$swap
