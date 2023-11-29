#!/bin/sh

swapoff -a
umount -Rq /mnt

part() {
	until [ "$x" = "0" ]; do
		echo "[1;32m${1%\$*}[0m"
		: "${1% >/dev/null}"
		read ${_#*\$}
		eval "$1"
		x="$?"
	done; unset x
}

lsblk -d
part "cfdisk /dev/\$disk"
lsblk /dev/$disk
lsblk /dev/$disk
printf "\033[3J\033[H"
lsblk /dev/$disk
part "mkfs.fat -F 32 /dev/$disk\$boot >/dev/null"
part "mkswap -q /dev/$disk\$swap >/dev/null"
part "mkfs.ext4 -Fq /dev/$disk\$root >/dev/null"

mount /dev/$disk$root /mnt
mkdir /mnt/a /mnt/b /mnt/c /mnt/boot
mount /dev/$disk$boot /mnt/boot
swapon /dev/$disk$swap
