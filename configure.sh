#!/bin/bash

## Firt check where your microSD card is mounted when you insert it to a PC
lsblk | grep -i sd*
# For me it was /dev/sdc, for you it could be /dev/sdb

sudo dd if=/dev/zero of=/dev/sdc bs=1M count=16
sudo  cfdisk /dev/sdc
cat /proc/partitions | grep sdc
sudo mkfs.vfat -F 32 -n BOOT /dev/sdc1
sudo mkfs.ext4 -L rootfs -E nodiscard  /dev/sdc2
cp MLO /media/$USER/BOOT/
cp u-boot.img /media/$USER/BOOT/
cp zImage /media/$USER/BOOT/
cp am335x-boneblack.dtb /media/$USER/BOOT/
sudo tar -C /media/$USER/ROOTFS/ -xf rootfs.tar .



