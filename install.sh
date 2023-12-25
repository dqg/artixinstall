#!/bin/bash

. scr/scr1.sh
. scr/scr2.sh
artix-chroot /mnt /scr3.sh
rm /mnt/scr3.sh
