#!/bin/bash

# set default path
KERNEL_PATH=$PWD

TOOLCHAIN="/home/ztotherad/toolchains/arm-eabi-4.9/bin/arm-eabi-"

if [ -e boot.img ]; then
	rm boot.img
fi

if [ -e compile.log ]; then
	rm compile.log
fi

if [ -e ramdisk.cpio ]; then
	rm ramdisk.cpio
fi

echo "Cleaning latest build"
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN -j`grep 'processor' /proc/cpuinfo | wc -l` mrproper
