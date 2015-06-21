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

cat >/zones/boot/grub/menu.lst <<EOFMENULST
findroot (pool_zones,0)
default=0
timeout=10
min_mem64 1024
serial --speed=115200 --unit=1,0,2,3 --word=8 --parity=no --stop=1
terminal composite
variable os_console vga

title SmartOS
   bootfs zones/smartos
   kernel$ /platform/i86pc/kernel/amd64/unix -B console=\${os_console},\${os_console}-mode="115200,8,n,1,-",root_shadow='$5$2HOHRnK3$NvLlm.1KQBbB0WjoP7xcIwGnllhzp2HnT.mDO7DpxYA',smartos=true
   module /platform/i86pc/amd64/boot_archive

title SmartOS noinstall/recovery (login/pw: root/root)
   bootfs zones/smartos
   kernel$ /platform/i86pc/kernel/amd64/unix -B console=\${os_console},\${os_console}-mode="115200,8,n,1,-",root_shadow='$5$2HOHRnK3$NvLlm.1KQBbB0WjoP7xcIwGnllhzp2HnT.mDO7DpxYA',standalone=true,noimport=true
   module /platform/i86pc/amd64/boot_archive

title SmartOS +kmdb
   bootfs zones/smartos
   kernel$ /platform/i86pc/kernel/amd64/unix -kd -B console=\${os_console},\${os_console}-mode="115200,8,n,1,-",root_shadow='$5$2HOHRnK3$NvLlm.1KQBbB0WjoP7xcIwGnllhzp2HnT.mDO7DpxYA',smartos=true
   module /platform/i86pc/amd64/boot_archive
EOFMENULST
