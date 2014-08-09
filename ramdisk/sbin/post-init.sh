#!/sbin/busybox sh
# thanks to hardcore and nexxx
# thanks to knzo, gokhanmoral, pikachu01
# thanks to dorimanx
# modded by simone201 for NEAK Kernel

MMC=`ls -d /sys/block/mmc*`;

/sbin/busybox cp /data/user.log /data/user.log.bak
/sbin/busybox rm /data/user.log
exec >>/data/user.log
exec 2>&1

echo $(date) START of post-init.sh

##### Early-init phase #####

# IPv6 privacy tweak
  echo "2" > /proc/sys/net/ipv6/conf/all/use_tempaddr

# Remount all partitions with noatime
  for k in $(/sbin/busybox mount | /sbin/busybox grep relatime | /sbin/busybox cut -d " " -f3)
  do
        sync
        /sbin/busybox mount -o remount,noatime $k
  done

# Remount ext4 partitions with optimizations
  for k in $(/sbin/busybox mount | /sbin/busybox grep ext4 | /sbin/busybox cut -d " " -f3)
  do
        sync
        /sbin/busybox mount -o remount,commit=15 $k
  done
  
# VM Tweaks (thx to dorimanx)
  /sbin/busybox sysctl -w vm.vfs_cache_pressure=70
  echo "12288" > /proc/sys/vm/min_free_kbytes;
  echo "1500" > /proc/sys/vm/dirty_writeback_centisecs;
  echo "200" > /proc/sys/vm/dirty_expire_centisecs;
  echo "70" > /proc/sys/vm/dirty_background_ratio;
  echo "90" > /proc/sys/vm/dirty_ratio;
  echo "4" > /proc/sys/vm/min_free_order_shift;
  echo "1" > /proc/sys/vm/overcommit_memory;
  echo "50" > /proc/sys/vm/overcommit_ratio;
  echo "128 128" > /proc/sys/vm/lowmem_reserve_ratio;
  echo "3" > /proc/sys/vm/page-cluster;
  echo "4096" > /proc/sys/vm/min_free_kbytes;
  echo "0" > /proc/sys/vm/swappiness;

# Zzmoove CPU hotplug tweaks - thx to hardcore
echo "Setting up ZZMove tunables ..."
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/disable_hotplug
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/disable_hotplug_sleep
echo "55" > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold
echo "50" > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug1
echo "40" > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug2
echo "30" > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug3
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug_freq1
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug_freq2
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_hotplug_freq3
echo "44" > /sys/devices/system/cpu/cpufreq/zzmoove/down_threshold_sleep
echo "1" > /sys/devices/system/cpu/cpufreq/zzmoove/early_demand
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/fast_scaling
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/fast_scaling_sleep
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/freq_limit
echo "600000" > /sys/devices/system/cpu/cpufreq/zzmoove/freq_limit_sleep
echo "1" > /sys/devices/system/cpu/cpufreq/zzmoove/freq_step
echo "5" > /sys/devices/system/cpu/cpufreq/zzmoove/freq_step_sleep
echo "25" > /sys/devices/system/cpu/cpufreq/zzmoove/grad_up_threshold
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/hotplug_block_cycles
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/hotplug_idle_threshold
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/hotplug_sleep
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/ignore_nice_load
echo "1" > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_down_factor
echo "0" > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_down_max_momentum
echo "100000" > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_rate
echo "30000" > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_rate_min
echo "2" > /sys/devices/system/cpu/cpufreq/zzmoove/sampling_rate_sleep_multiplier
echo "75" > /sys/devices/system/cpu/cpufreq/zzmoove/smooth_up
echo "100" > /sys/devices/system/cpu/cpufreq/zzmoove/smooth_up_sleep
echo "80" > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold
echo "86" > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug1
echo "75" > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug2
echo "85" > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug3
echo "1100000" > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug_freq1
echo "1400000" > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug_freq2
echo "1600000" > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_hotplug_freq3
echo "90" > /sys/devices/system/cpu/cpufreq/zzmoove/up_threshold_sleep
echo "7"  > /sys/devices/system/cpu/cpufreq/zzmoove/profile_number
echo "zzmod" > /sys/devices/system/cpu/cpufreq/zzmoove/profile

# SD cards (mmcblk) read ahead tweaks
  echo "1024" > /sys/devices/virtual/bdi/179:0/read_ahead_kb
  echo "1024" > /sys/devices/virtual/bdi/179:16/read_ahead_kb
  echo "512" > /sys/devices/virtual/bdi/default/read_ahead_kb
  echo "256" > /sys/block/mmcblk0/bdi/read_ahead_kb
  echo "256" > /sys/block/mmcblk1/bdi/read_ahead_kb

# TCP tweaks (thx to dorimanx)
  echo "0" > /proc/sys/net/ipv4/tcp_timestamps;
  echo "1" > /proc/sys/net/ipv4/tcp_tw_reuse;
  echo "1" > /proc/sys/net/ipv4/tcp_sack;
  echo "1" > /proc/sys/net/ipv4/tcp_tw_recycle;
  echo "1" > /proc/sys/net/ipv4/tcp_window_scaling;
  echo "1" > /proc/sys/net/ipv4/tcp_moderate_rcvbuf;
  echo "1" > /proc/sys/net/ipv4/route/flush;
  echo "2" > /proc/sys/net/ipv4/tcp_syn_retries;
  echo "2" > /proc/sys/net/ipv4/tcp_synack_retries;
  echo "10" > /proc/sys/net/ipv4/tcp_fin_timeout;
  echo "0" > /proc/sys/net/ipv4/tcp_ecn;
  echo "524288" > /proc/sys/net/core/wmem_max;
  echo "524288" > /proc/sys/net/core/rmem_max;
  echo "262144" > /proc/sys/net/core/rmem_default;
  echo "262144" > /proc/sys/net/core/wmem_default;
  echo "20480" > /proc/sys/net/core/optmem_max;
  echo "6144 87380 524288" > /proc/sys/net/ipv4/tcp_wmem;
  echo "6144 87380 524288" > /proc/sys/net/ipv4/tcp_rmem;
  echo "4096" > /proc/sys/net/ipv4/udp_rmem_min;
  echo "4096" > /proc/sys/net/ipv4/udp_wmem_min;

# Increase wifi scan interval to save some more battery
  setprop wifi.supplicant_scan_interval 120;

# New scheduler tweaks + readahead tweaks (thx to Pikachu01 && dorimanx)
for i in $MMC;
do
	if [ -e $i/queue/rotational ]; then
		echo "0" > $i/queue/rotational; 
	fi;
	if [ -e $i/queue/nr_requests ]; then
		echo "8192" > $i/queue/nr_requests;
	fi;
	if [ -e $i/queue/iostats ]; then
		echo "0" > $i/queue/iostats;
	fi;
	if [ -e $i/queue/iosched/back_seek_penalty ]; then
		echo "1" > $i/queue/iosched/back_seek_penalty;
	fi;
	if [ -e $i/queue/iosched/slice_idle ]; then
		echo "2" > $i/queue/iosched/slice_idle;
	fi;
done;

# Misc IO Tweaks (thx to dorimanx)
  echo "524288" > /proc/sys/fs/file-max;
  echo "1048576" > /proc/sys/fs/nr_open;
  echo "32000" > /proc/sys/fs/inotify/max_queued_events;
  echo "256" > /proc/sys/fs/inotify/max_user_instances;
  echo "10240" > /proc/sys/fs/inotify/max_user_watches;

# Misc Kernel Tweaks (thx to dorimanx)
  echo "2048" > /proc/sys/kernel/msgmni;
  echo "65536" > /proc/sys/kernel/msgmax;
  echo "10" > /proc/sys/fs/lease-break-time;
  echo "128" > /proc/sys/kernel/random/read_wakeup_threshold;
  echo "256" > /proc/sys/kernel/random/write_wakeup_threshold;
  echo "500 512000 64 2048" > /proc/sys/kernel/sem;
  echo "2097152" > /proc/sys/kernel/shmall;
  echo "268435456" > /proc/sys/kernel/shmmax;
  echo "524288" > /proc/sys/kernel/threads-max;

# Turn off debugging for certain modules
  echo "0" > /sys/module/wakelock/parameters/debug_mask
  echo "0" > /sys/module/userwakelock/parameters/debug_mask
  echo "0" > /sys/module/earlysuspend/parameters/debug_mask
  echo "0" > /sys/module/alarm/parameters/debug_mask
  echo "0" > /sys/module/alarm_dev/parameters/debug_mask
  echo "0" > /sys/module/binder/parameters/debug_mask
  echo "0" > /sys/module/lowmemorykiller/parameters/debug_level

# Doing some cleanup before init.d support & neak options
    /sbin/busybox sh /sbin/near/cleanup.sh
	
# energySTOCK options
	/sbin/busybox sh /sbin/near/energy-options.sh

# Set VR as default scheduler - workaround
echo "sio" > /sys/block/mmcblk0/queue/scheduler
echo "sio" > /sys/block/mmcblk1/queue/scheduler

echo $(date) PRE-INIT DONE of post-init.sh

##### Post-init phase #####

sleep 10

# init.d support
echo $(date) USER INIT START from /system/etc/init.d
if cd /system/etc/init.d >/dev/null 2>&1 ; then
    for file in * ; do
        if ! ls "$file" >/dev/null 2>&1 ; then continue ; fi
        echo "START '$file'"
        /system/bin/sh "$file"
        echo "EXIT '$file' ($?)"
    done
fi
echo $(date) USER INIT DONE from /system/etc/init.d

echo $(date) USER INIT START from /data/init.d
if cd /data/init.d >/dev/null 2>&1 ; then
    for file in * ; do
        if ! ls "$file" >/dev/null 2>&1 ; then continue ; fi
        echo "START '$file'"
        /system/bin/sh "$file"
        echo "EXIT '$file' ($?)"
    done
fi
echo $(date) USER INIT DONE from /data/init.d

echo $(date) END of post-init.sh