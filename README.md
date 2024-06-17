Buildroot utility for Beaglebone Black Board


<img src="https://upload.wikimedia.org/wikipedia/commons/6/6c/Angry_Penguin.svg" width="300" height="200">

This is a bash script that runs all code to boot custom kernel to beaglebone black board via microSD card.  This is assuming that buildroot was successfully downloaded, and all ``make`` steps were done, and custom kernel was successfully cross compiled and ready to be mounted to microSD card.  This employs the common practice of partinioning the microSD card into a BOOT partition (FAT16 or 32), and a ROOTFS partition (EXT4).  In my opinion, using ``gparted`` is easiest to do that, and this is what I've done.

After ```configure.sh``` is run, all image-related files that are contained in ``~/buildroot/output/images/`` are successfully copied to the ``ROOTFS`` and ``BOOT`` partitions successfully.  

Navigate next to the ``~/buildroot/output/images/`` and specifically the ``uEnv.txt`` file, and make sure it contains the following, which instructs the bootloader to load kernel from SD card:

``` bootpart=0:1
    devtype=mmc
    bootdir=
    bootfile=zImage
    bootpartition=mmcblk0p2
    set_mmc1=if test $board_name = A33515BB; then setenv bootpartition mmcblk1p2; fi
    set_bootargs=setenv bootargs console=ttyO0,115200n8 root=/dev/${bootpartition} rw rootfstype=ext4 rootwait
    uenvcmd=run set_mmc1; run set_bootargs;run loadimage;run loadfdt;printenv bootargs;bootz ${loadaddr} - ${fdtaddr} 
```

simply run ```sudo minicom -s```, and make sure serial port set up parameters look exactly like this:
```
    +-----------------------------------------------------------------------+
    | A -    Serial Device      : /dev/ttyUSB0                              |
    | B - Lockfile Location     : /var/lock                                 |
    | C -   Callin Program      :                                           |
    | D -  Callout Program      :                                           |
    | E -    Bps/Par/Bits       : 115200 8N1                                |
    | F - Hardware Flow Control : No                                        |
    | G - Software Flow Control : No                                        |
    | H -     RS485 Enable      : No                                        |
    | I -   RS485 Rts On Send   : No                                        |
    | J -  RS485 Rts After Send : No                                        |
    | K -  RS485 Rx During Tx   : No                                        |
    | L -  RS485 Terminate Bus  : No                                        |
    | M - RS485 Delay Rts Before: 0                                         |
    | N - RS485 Delay Rts After : 0                                         |
    |                                                                       |
    |    Change which setting?                                              |
    +-----------------------------------------------------------------------+
```
Then save and exit, and power off and power on the Beaglebone, and we're done, we should see a welcome message from buildroot upon powering up the BBB.
In the case where the commands from the custom ``uEnv.txt`` do not work and BBB doesnt boot from SD card, the command below is a more guaranteed command that you can use. Its a ``uboot`` command that you should invoke upon interrupting the bootloader 1-2 seconds after connecting to the console:

```
setenv bootcmd 'fatload mmc 0:1 ${loadaddr} zImage; fatload mmc 0:1 ${fdtaddr} am335x-boneblack.dtb; bootz ${loadaddr} - ${fdtaddr}
```

This should work now without requiring you to interrupt bootloader or anything.



