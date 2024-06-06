Buildroot utility for Beaglebone Black Board


<img src="https://upload.wikimedia.org/wikipedia/commons/6/6c/Angry_Penguin.svg" width="300" height="200">

This is a bash script that runs all code to boot custom kernel to beaglebone black board via microSD card.  This is assuming that buildroot was successfully downloaded, and all ''make'' steps were done, and custom kernel was successfully cross compiled and ready to be mounted to microSD card.  This employs the common practice of partinioning the microSD card into a BOOT partition (FAT16 or 32), and a ROOTFS partition (EXT4).  In my opinion, using ''gparted'' is easiest to do that, and this is what I've done.  But we'll do it the long way.  
