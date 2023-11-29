#!/bin/sh

chmod -R 777 scr
scr/disk.sh
scr/package.sh || exit 1
artix-chroot /mnt /chroot.sh
rm /mnt/chroot.sh
