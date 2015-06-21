#!/bin/sh

exec >/var/log/setup_boot_from_hdd.log 2>&1
set -o xtrace

zfs create zones/smartos
cd /zones/smartos
mount -F hsfs /dev/dsk/c0t1d0p0 /mnt
rsync -av /mnt/ .
umount /mnt

cp -r /zones/smartos/boot /zones/boot
cd /zones/boot/grub
installgrub -m -f stage1 stage2 /dev/rdsk/c0d0s0


