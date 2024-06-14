Buildroot utility for Beaglebone Black Board


<img src="https://upload.wikimedia.org/wikipedia/commons/6/6c/Angry_Penguin.svg" width="300" height="200">

This is a bash script that runs all code to boot custom kernel to beaglebone black board via microSD card.  This is assuming that buildroot was successfully downloaded, and all ``make`` steps were done, and custom kernel was successfully cross compiled and ready to be mounted to microSD card.  This employs the common practice of partinioning the microSD card into a BOOT partition (FAT16 or 32), and a ROOTFS partition (EXT4).  In my opinion, using ``gparted`` is easiest to do that, and this is what I've done.

After ```configure.sh``` is run, all image-related files that are contained in ``~/buildroot/output/images/`` are successfully copied to the ``ROOTFS`` and ``BOOT`` partitions successfully.  

Navigate next to the ``~/buildroot/output/images/`` and specifically the ``uEnc.txt`` file, and make sure it contains the following, which instructs the bootloader to load kernel from SD card:


```    fdtfile=am335x-boneblack.dtb
    fdtaddr=0x88000000
    bootfile=zImage
    loadaddr=0x82000000
    console=ttyO0,115200n8
    serverip=192.168.0.104
    ipaddr=192.168.0.105
    rootpath=/rootfs
    netloadfdt=tftp ${fdtaddr} ${fdtfile}
    netloadimage=tftp ${loadaddr} ${bootfile}
    netargs=setenv bootargs console=${console} ${optargs} root=/dev/nfs nfsroot=${serverip}:${rootpath},nolock,nfsvers=3 rw rootwait ip=${ipaddr}
    netboot=echo Booting from network ...; setenv autoload no; run netloadimage; run netloadfdt; run netargs; bootz ${loadaddr} - ${fdtaddr}
    uenvcmd=run netboot
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
Then save and exit, and power off and power on the Beaglebone, and we're done, we should see a welcome message from buildroot. 


