#!/bin/bash

# set default path
KERNEL_PATH=$PWD

# Set toolchain path
if [ "$(whoami)" == "ztotherad" ]; then
	#TOOLCHAIN_PATH="/home/ztotherad/toolchains/arm-eabi-4.8/bin"
	TOOLCHAIN_PATH="/home/ztotherad/toolchains/arm-eabi-4.9/bin"
	#TOOLCHAIN_PATH="/home/ztotherad/toolchains/arm-eabi-4.10/bin"
	#TOOLCHAIN_PATH="/home/ztotherad/toolchains/linaro-4.7.4/bin"
elif [ "$(whoami)" == "rollus" ]; then
	TOOLCHAIN_PATH="/home/rollus/toolchains/arm-eabi-4.4.3/bin"

fi

TOOLCHAIN="$TOOLCHAIN_PATH/arm-eabi-"
#TOOLCHAIN="$TOOLCHAIN_PATH/arm-gnueabi-"
#TOOLCHAIN="$TOOLCHAIN_PATH/arm-linux-androideabi-"
MODULES="$KERNEL_PATH/ramdisk/lib/modules"
ROOTFS_PATH="$KERNEL_PATH/ramdisk"


defconfig=t0_04_defconfig

export LOCALVERSION="$displayversion"
export KERNELDIR=$KERNEL_PATH
export CROSS_COMPILE=$TOOLCHAIN
export ARCH=arm


displayversion=energySTOCK

version=$displayversion-$(date +%Y%m%d)

# removing old kernel and module files
find -name '*.ko' -exec rm -rf {} $MODULES/* \;
rm -rf $KERNEL_PATH/arch/arm/boot/zImage
rm -rf $KERNEL_PATH/release

# Making the config
make $defconfig

make -j`grep 'processor' /proc/cpuinfo | wc -l` || exit -1

# Copying and stripping kernel modules
echo 'moving modules'
find -name '*.ko' -exec cp -av {} $MODULES \;
	"$TOOLCHAIN"strip --strip-unneeded $MODULES/*

echo 'move zImage'
cp -f arch/arm/boot/zImage .

# create ramdisk.cpio archive
cd $ROOTFS_PATH
find . | cpio -o -H newc | gzip > $KERNEL_PATH/ramdisk.cpio.gz
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
rm -rf $KERNEL_PATH/ramdisk.cpio.gz
rm -rf $KERNEL_PATH/boot.img
chmod 777 clean.sh
./clean.sh
