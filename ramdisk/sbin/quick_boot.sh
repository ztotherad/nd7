#!/sbin/busybox sh

#Exynos 4412 Default scaling-frequency(N710x)
echo "1600000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo "100000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

