#!/system/bin/sh

/sbin/busybox mount -t rootfs -o remount,rw rootfs

# Disable knox
pm disable com.sec.knox.seandroid
setenforce 0
setprop ro.securestorage.support false

sync
/system/xbin/daemonsu --auto-daemon &

# kernel custom test

if [ -e /data/Kerneltest.log ]; then
rm /data/Kerneltest.log
fi

echo  Kernel script is working !!! >> /data/Kerneltest.log
echo "excecuted on $(date +"%d-%m-%Y %r" )" >> /data/Kerneltest.log

# Init.d
busybox run-parts /system/etc/init.d

/sbin/busybox mount -t rootfs -o remount,ro rootfs
/sbin/busybox mount -o remount,rw /data

# CPU freq min and max

#CPU
chmod 755 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 755 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo "100000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "1600000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 755 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 755 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

#GPU Voltages 160, 266, 350, 533, 640
echo "160 266 350 533 640" > /sys/class/misc/gpu_control/gpu_clock_control
# UV GPU by -10
echo "865000 89000 940000 1015000 1065000" >> /sys/class/misc/gpu_control/gpu_voltage_control

# Multicore power saving
echo 2 > /sys/devices/system/cpu/sched_mc_power_savings

# CPU idle mode
echo 3 > /sys/module/cpuidle_exynos4/parameters/enable_mask

# Dynamic FSync (Default On)
echo "1" > /sys/kernel/dyn_fsync/Dyn_fsync_active

# Logger Mode
echo 0 > /sys/kernel/logger_mode/logger_mode

# Swappiness
echo "90" > /proc/sys/vm/swappiness

#Zram0
swapoff /dev/block/zram0
echo 1 > /sys/block/zram0/reset
echo 524288000 > /sys/block/zram0/disksize
echo 1 > /sys/block/zram0/initstate
mkswap /dev/block/zram0
swapon -p 2 /dev/block/zram0

#Internet speed tweaks
echo "0" > /proc/sys/net/ipv4/tcp_timestamps;
echo "1" > /proc/sys/net/ipv4/tcp_tw_reuse;
echo "1" > /proc/sys/net/ipv4/tcp_sack;
echo "1" > /proc/sys/net/ipv4/tcp_tw_recycle;
echo "1" > /proc/sys/net/ipv4/tcp_window_scaling;
echo "5" > /proc/sys/net/ipv4/tcp_keepalive_probes;
echo "30" > /proc/sys/net/ipv4/tcp_keepalive_intvl;
echo "15" > /proc/sys/net/ipv4/tcp_fin_timeout;
echo "404480" > /proc/sys/net/core/wmem_max;
echo "404480" > /proc/sys/net/core/rmem_max;
echo "256960" > /proc/sys/net/core/rmem_default;
echo "256960" > /proc/sys/net/core/wmem_default;
echo "4096 16384 404480" > /proc/sys/net/ipv4/tcp_wmem;
echo "4096 87380 404480" > /proc/sys/net/ipv4/tcp_rmem;

# CPU governor zzmoove-zzopt
echo "zzmoove" >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
/sbin/busybox sleep 2

echo 6 > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
echo 80 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold
echo 65 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold
echo 40 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug1
echo 400000 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug_freq1
echo 20 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug1
echo 0 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug_freq1
echo 65 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug2
echo 1200000 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug_freq2
echo 50 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug2
echo 0 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug_freq2
echo 90 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug3
echo 1600000 > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug_freq3
echo 70 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug3
echo 0 > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug_freq3

# i/o schedulers
echo sio > /sys/block/mmcblk0/queue/scheduler
echo sio > /sys/block/mmcblk1/queue/scheduler

# Internal and External SD read_ahead_kb
echo 256 > /sys/block/mmcblk0/bdi/read_ahead_kb
echo 512 > /sys/block/mmcblk1/bdi/read_ahead_kb

# TouchWake (Default disable)
# echo "1" > /sys/devices/virtual/misc/touchwake/enabled
# echo "5" > /sys/devices/virtual/misc/touchwake/delay
# Touchwake [KNOCKON]
# echo "1" > /sys/class/misc/touchwake/knockon
# echo "1" > /sys/class/misc/touchwake/keypower_mode

# LMK minfree (AGGRESSIVE)
echo "2048,4096,8192,16384,24576,32768" > /sys/module/lowmemorykiller/parameters/minfree
