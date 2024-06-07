Buildroot utility for Beaglebone Black Board


<img src="https://upload.wikimedia.org/wikipedia/commons/6/6c/Angry_Penguin.svg" width="300" height="200">

This is a bash script that runs all code to boot custom kernel to beaglebone black board via microSD card.  This is assuming that buildroot was successfully downloaded, and all ``make`` steps were done, and custom kernel was successfully cross compiled and ready to be mounted to microSD card.  This employs the common practice of partinioning the microSD card into a BOOT partition (FAT16 or 32), and a ROOTFS partition (EXT4).  In my opinion, using ``gparted`` is easiest to do that, and this is what I've done.  But we'll do it the long way.  

After ```configure.sh``` is run, simply run ```sudo minicom -s```, and make sure serial port set up parameters look exactly like this:
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
Then save and exit, and power off and power on the Beaglebone, and make sure to interrupt the bootloader around 1 or 2 seconds after you see the boot messages start to pop up.
Then, we need to instruct bootloader to boot the linux kernel from microSD card, and not eMMC, and that is by explicitly telling it where to find the linux image, and .dtb file, and also by precisely telling it where to load from in the memory frame.
```
fatload mmc 0:1 0x82000000 zImage 
fatload mmc 0:1 0x88000000 am335x-boneblack.dtb 
setenv bootargs console=ttyS0,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait

bootz 0x82000000 - 0x88000000
```
Then we're done, we should see a welcome message from buildroot. 



