#!/bin/bash

# set default path
KERNEL_PATH=$PWD
defconfig=t0_04_defconfig

# set toolchain path and root filesystem path
TOOLCHAIN="/home/ztotherad/toolchains/arm-eabi-4.9/bin/arm-eabi-"
ROOTFS_PATH="$KERNEL_PATH/ramdisk"

# exports
export LOCALVERSION="$displayversion"
export KERNELDIR=$KERNEL_PATH
export CROSS_COMPILE=$TOOLCHAIN
export ARCH=arm
export USE_SEC_FIPS_MODE=true


displayversion=energySTOCK

version=$displayversion-$(date +%Y%m%d)

# removing module files
find -name '*.ko' -exec rm -rf {} $ROOTFS_PATH/lib/modules/* \;

# Making the config
make $defconfig

make -j`grep 'processor' /proc/cpuinfo | wc -l` ARCH=arm CROSS_COMPILE=$TOOLCHAIN >> compile.log 2>&1 || exit -1

# Copying and stripping kernel modules
echo 'moving modules'
find -name '*.ko' -exec cp -av {} $ROOTFS_PATH/lib/modules/ \;
		"$TOOLCHAIN"strip --strip-unneeded $ROOTFS_PATH/lib/modules/*

# copy kernel image
rm -rf $KERNEL_PATH/release/$version.zip
echo 'move zImage'
cp -f arch/arm/boot/zImage .

# create ramdisk.cpio archive
cd $ROOTFS_PATH
find . | cpio -o -H newc  > $KERNEL_PATH/ramdisk.cpio.gz
cd $KERNEL_PATH

# make boot.img
./mkbootimg --kernel zImage --ramdisk ramdisk.cpio.gz -o $KERNEL_PATH/boot.img

# copy boot.img
cp -f boot.img $KERNEL_PATH/releasetools/zip/

# creating flashable zip
cd $KERNEL_PATH
cd releasetools/zip
zip -0 -r $version.zip *
mkdir -p $KERNEL_PATH/release
mv *.zip $KERNEL_PATH/release
cd ..

# cleanup
echo 'clean up, clean up, everybody clean up..'
rm $KERNEL_PATH/releasetools/zip/boot.img
rm $KERNEL_PATH/zImage
rm -rf $KERNEL_PATH/ramdisk.cpio
rm -rf $KERNEL_PATH/boot.img
cd $KERNEL_PATH/release && mv $version.zip $HOME
cd .. && rm -rf release
