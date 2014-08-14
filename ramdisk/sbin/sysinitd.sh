#!/sbin/busybox sh

while ! /sbin/busybox pgrep android.process.acore ; do
  /sbin/busybox sleep 1
done

## Set optimum permissions for init.d scripts
/sbin/busybox sh /sbin/sysrw
/sbin/busybox sh /sbin/rootrw

/sbin/busybox chmod -R 777 /system/etc/init.d

/sbin/busybox sh /sbin/frandom.sh

/sbin/busybox sh /sbin/sysro
/sbin/busybox sh /sbin/rootro

# Execute files in init.d folder
export PATH=/sbin:/system/sbin:/system/bin:/system/xbin
/sbin/busybox run-parts /system/etc/init.d

