#!/bin/sh

./qemu_bridge_setup.sh restart
#qemu-system-arm -M versatilepb -kernel buildroot-2018.08/output/images/zImage -dtb buildroot-2018.08/output/images/versatile-pb.dtb -drive file=buildroot-2018.08/output/images/rootfs.ext2,if=scsi -append "root=/dev/sda console=ttyAMA0,115200" -netdev tap,id=n1,ifname=tap0,script=no,downscript=no -device e1000,netdev=n1
#qemu-img resize -f raw buildroot/output/images/sdcard.img 256M
qemu-system-aarch64 -M raspi3b -m 1024 \
    -kernel buildroot/output/images/Image \
    -dtb buildroot/output/images/bcm2710-rpi-3-b.dtb \
    -drive if=sd,driver=raw,file=buildroot/output/images/sdcard.img \
    -append "console=ttyAMA0 root=/dev/mmcblk0p2 rw rootwait rootfstype=ext4" \
    -device usb-net,netdev=net0 \
    -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
    #-serial stdio \
    #-netdev tap,id=n1,ifname=tap0,script=no,downscript=no -device e1000,netdev=n1

exit $?
