cmd_net/netfilter/interceptor/ip_selector_db.o := /home/ztotherad/toolchains/arm-eabi-4.9/bin/arm-eabi-gcc -Wp,-MD,net/netfilter/interceptor/.ip_selector_db.o.d  -nostdinc -isystem /home/ztotherad/toolchains/arm-eabi-4.9/bin/../lib/gcc/arm-eabi/4.9.1/include -I/home/ztotherad/kernels/nd7kk/arch/arm/include -Iarch/arm/include/generated -Iinclude  -include include/generated/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-exynos/include -Iarch/arm/plat-s5p/include -Iarch/arm/plat-samsung/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -marm -march=armv7-a -mcpu=cortex-a9 -mfpu=neon -mtune=cortex-a9 -fno-pic -munaligned-access -O3 -marm -fno-dwarf2-cfi-asm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO -DKERNEL -D_KERNEL -DWITH_IPV6    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(ip_selector_db)"  -D"KBUILD_MODNAME=KBUILD_STR(vpnclient)" -c -o net/netfilter/interceptor/.tmp_ip_selector_db.o net/netfilter/interceptor/ip_selector_db.c

source_net/netfilter/interceptor/ip_selector_db.o := net/netfilter/interceptor/ip_selector_db.c

deps_net/netfilter/interceptor/ip_selector_db.o := \
  net/netfilter/interceptor/implementation_defs.h \
  net/netfilter/interceptor/public_defs.h \
  include/linux/types.h \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
    $(wildcard include/config/64bit.h) \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/types.h \
  include/asm-generic/int-ll64.h \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/bitsperlong.h \
  include/asm-generic/bitsperlong.h \
  include/linux/posix_types.h \
  include/linux/stddef.h \
  include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
  include/linux/compiler-gcc4.h \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/posix_types.h \
  net/netfilter/interceptor/implementation_config.h \
    $(wildcard include/config/h.h) \
  net/netfilter/interceptor/kernelspd_defs.h \
  include/linux/string.h \
    $(wildcard include/config/binary/printf.h) \
  /home/ztotherad/toolchains/arm-eabi-4.9/lib/gcc/arm-eabi/4.9.1/include/stdarg.h \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/string.h \
  include/linux/kernel.h \
    $(wildcard include/config/preempt/voluntary.h) \
    $(wildcard include/config/debug/spinlock/sleep.h) \
    $(wildcard include/config/prove/locking.h) \
    $(wildcard include/config/ring/buffer.h) \
    $(wildcard include/config/tracing.h) \
    $(wildcard include/config/numa.h) \
    $(wildcard include/config/compaction.h) \
    $(wildcard include/config/ftrace/mcount/record.h) \
  include/linux/linkage.h \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/linkage.h \
  include/linux/bitops.h \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/bitops.h \
    $(wildcard include/config/smp.h) \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/system.h \
    $(wildcard include/config/function/graph/tracer.h) \
    $(wildcard include/config/cpu/32v6k.h) \
    $(wildcard include/config/cpu/xsc3.h) \
    $(wildcard include/config/cpu/fa526.h) \
    $(wildcard include/config/arch/has/barriers.h) \
    $(wildcard include/config/arm/dma/mem/bufferable.h) \
    $(wildcard include/config/cpu/sa1100.h) \
    $(wildcard include/config/cpu/sa110.h) \
    $(wildcard include/config/cpu/v6.h) \
  include/linux/irqflags.h \
    $(wildcard include/config/trace/irqflags.h) \
    $(wildcard include/config/irqsoff/tracer.h) \
    $(wildcard include/config/preempt/tracer.h) \
    $(wildcard include/config/trace/irqflags/support.h) \
  include/linux/typecheck.h \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/irqflags.h \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/ptrace.h \
    $(wildcard include/config/cpu/endian/be8.h) \
    $(wildcard include/config/arm/thumb.h) \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/hwcap.h \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/outercache.h \
    $(wildcard include/config/outer/cache/sync.h) \
    $(wildcard include/config/outer/cache.h) \
  include/asm-generic/cmpxchg-local.h \
  include/asm-generic/bitops/non-atomic.h \
  include/asm-generic/bitops/fls64.h \
  include/asm-generic/bitops/sched.h \
  include/asm-generic/bitops/hweight.h \
  include/asm-generic/bitops/arch_hweight.h \
  include/asm-generic/bitops/const_hweight.h \
  include/asm-generic/bitops/lock.h \
  include/asm-generic/bitops/le.h \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/byteorder.h \
  include/linux/byteorder/little_endian.h \
  include/linux/swab.h \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/swab.h \
  include/linux/byteorder/generic.h \
  include/linux/log2.h \
    $(wildcard include/config/arch/has/ilog2/u32.h) \
    $(wildcard include/config/arch/has/ilog2/u64.h) \
  include/linux/printk.h \
    $(wildcard include/config/printk.h) \
    $(wildcard include/config/dynamic/debug.h) \
  include/linux/init.h \
    $(wildcard include/config/fast/resume.h) \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/hotplug.h) \
  include/linux/dynamic_debug.h \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/bug.h \
    $(wildcard include/config/bug.h) \
    $(wildcard include/config/debug/bugverbose.h) \
  include/asm-generic/bug.h \
    $(wildcard include/config/generic/bug.h) \
    $(wildcard include/config/generic/bug/relative/pointers.h) \
  /home/ztotherad/kernels/nd7kk/arch/arm/include/asm/div64.h \
  net/netfilter/interceptor/debug_implementation.h \
  net/netfilter/interceptor/debug_strbuf.h \
  net/netfilter/interceptor/debug_outputf.h \
  net/netfilter/interceptor/ip_selector_db.h \
  net/netfilter/interceptor/ip_selector.h \
  net/netfilter/interceptor/ip_selector_match.h \

net/netfilter/interceptor/ip_selector_db.o: $(deps_net/netfilter/interceptor/ip_selector_db.o)

$(deps_net/netfilter/interceptor/ip_selector_db.o):
