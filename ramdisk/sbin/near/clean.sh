#!/sbin/busybox sh
# Doing some cleanup
# by Simone201
# adapted by ztotherad

/sbin/busybox mount -o remount,rw /system

if [ -e /system/etc/init.d/s78enable_touchscreen_1 ]; then
	/sbin/busybox rm /system/etc/init.d/s78enable_touchscreen_1
fi;

# Creating init.d folder if it doesn't exist
if [ ! -d /system/etc/init.d ]; then
	/sbin/busybox mkdir /system/etc/init.d
fi;

# Setting the right script permissions
/sbin/busybox chmod 755 /system/etc/init.d/*

/sbin/busybox mount -o remount,ro /system
