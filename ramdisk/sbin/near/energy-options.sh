#!/sbin/busybox sh
# init.d script taken from neak kernel
# and implemented for the energySTOCK kernel

/sbin/busybox mount -o remount,rw /data

# SCHED_MC Feature
if [ -e /data/neak/schedmc ]; then
	echo "schedmc enabled"
	echo "1" > /sys/devices/system/cpu/sched_mc_power_savings
else
	echo "schedmc disabled"
	echo "0" > /sys/devices/system/cpu/sched_mc_power_savings
fi;

# AFTR Idle Mode
if [ -e /data/neak/aftridle ]; then
	echo "aftr+lpa idle mode enabled"
	echo "3" > /sys/module/cpuidle_exynos4/parameters/enable_mask
else
	echo "aftr+lpa idle mode disabled - using idle+lpa"
	echo "2" > /sys/module/cpuidle_exynos4/parameters/enable_mask
fi;

# EXT4 Speed Tweaks
if [ -e /data/neak/ext4boost ]; then
	echo "ext4 boost tweaks enabled"
	/sbin/busybox mount -o noatime,remount,rw,discard,barrier=0,commit=60,noauto_da_alloc,delalloc /cache /cache;
	/sbin/busybox mount -o noatime,remount,rw,discard,barrier=0,commit=60,noauto_da_alloc,delalloc /data /data;
fi;
