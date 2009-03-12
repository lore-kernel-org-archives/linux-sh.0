From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 12 Mar 2009 14:45:33 +0000
Subject: [PATCH] sh: SuperH Mobile suspend support V2
Message-Id: <20090312144533.28453.15458.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20090309105143.23622.42915.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090309105143.23622.42915.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch contains CONFIG_SUSPEND support to the SuperH
architecture V2. If enabled, SuperH Mobile processors will
register their suspend callbacks during boot.

To suspend, use "echo mem > /sys/power/state". To allow
wakeup, make sure "/sys/device/platform/../power/wakeup"
contains "enabled". Additional per-device driver patches
are most likely needed.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V1:
 - fixed up issues pointed out by Paul
 - added more comments

 arch/sh/Kconfig                           |    1 
 arch/sh/include/asm/suspend.h             |    9 ++
 arch/sh/kernel/cpu/sh4a/Makefile          |    7 +
 arch/sh/kernel/cpu/sh4a/pm-sh_mobile.c    |   92 +++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/sleep-sh_mobile.S |  125 +++++++++++++++++++++++++++++
 5 files changed, 234 insertions(+)

--- 0005/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-03-12 23:13:25.000000000 +0900
@@ -181,6 +181,7 @@ config CPU_SHX3
 
 config ARCH_SHMOBILE
 	bool
+	select ARCH_SUSPEND_POSSIBLE
 
 choice
 	prompt "Processor sub-type selection"
--- 0001/arch/sh/include/asm/suspend.h
+++ work/arch/sh/include/asm/suspend.h	2009-03-12 23:16:59.000000000 +0900
@@ -1,6 +1,7 @@
 #ifndef _ASM_SH_SUSPEND_H
 #define _ASM_SH_SUSPEND_H
 
+#ifndef __ASSEMBLY__
 static inline int arch_prepare_suspend(void) { return 0; }
 
 #include <asm/ptrace.h>
@@ -9,5 +10,13 @@ struct swsusp_arch_regs {
 	struct pt_regs user_regs;
 	unsigned long bank1_regs[8];
 };
+#endif
+
+/* flags passed to assembly suspend code */
+#define SUSP_SH_SLEEP		(1 << 0) /* Regular sleep mode */
+#define SUSP_SH_STANDBY		(1 << 1) /* SH-Mobile Software standby mode */
+#define SUSP_SH_RSTANDBY	(1 << 2) /* SH-Mobile R-standby mode */
+#define SUSP_SH_USTANDBY	(1 << 3) /* SH-Mobile U-standby mode */
+#define SUSP_SH_SF		(1 << 4) /* Enable self-refresh */
 
 #endif /* _ASM_SH_SUSPEND_H */
--- 0001/arch/sh/kernel/cpu/sh4a/Makefile
+++ work/arch/sh/kernel/cpu/sh4a/Makefile	2009-03-12 22:15:16.000000000 +0900
@@ -35,6 +35,13 @@ pinmux-$(CONFIG_CPU_SUBTYPE_SH7723)	:= p
 pinmux-$(CONFIG_CPU_SUBTYPE_SH7785)	:= pinmux-sh7785.o
 pinmux-$(CONFIG_CPU_SUBTYPE_SH7786)	:= pinmux-sh7786.o
 
+# Power Mangement & Sleep mode
+pm-$(CONFIG_CPU_SUBTYPE_SH7343)		:= pm-sh_mobile.o sleep-sh_mobile.o
+pm-$(CONFIG_CPU_SUBTYPE_SH7366)		:= pm-sh_mobile.o sleep-sh_mobile.o
+pm-$(CONFIG_CPU_SUBTYPE_SH7722)		:= pm-sh_mobile.o sleep-sh_mobile.o
+pm-$(CONFIG_CPU_SUBTYPE_SH7723)		:= pm-sh_mobile.o sleep-sh_mobile.o
+
 obj-y			+= $(clock-y)
 obj-$(CONFIG_SMP)	+= $(smp-y)
 obj-$(CONFIG_GENERIC_GPIO)	+= $(pinmux-y)
+obj-$(CONFIG_PM)	+= $(pm-y)
--- /dev/null
+++ work/arch/sh/kernel/cpu/sh4a/pm-sh_mobile.c	2009-03-12 23:37:17.000000000 +0900
@@ -0,0 +1,92 @@
+/*
+ * arch/sh/kernel/cpu/sh4a/pm-sh_mobile.c
+ *
+ * Power management support code for SuperH Mobile
+ *
+ *  Copyright (C) 2009 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/suspend.h>
+#include <asm/suspend.h>
+#include <asm/uaccess.h>
+
+/*
+ * Sleep modes available on SuperH Mobile:
+ *
+ * Sleep mode is just plain "sleep" instruction
+ * Sleep Self-Refresh mode is above plus RAM put in Self-Refresh
+ * Standby Self-Refresh mode is above plus stopped clocks
+ */
+#define SUSP_MODE_SLEEP		(SUSP_SH_SLEEP)
+#define SUSP_MODE_SLEEP_SF	(SUSP_SH_SLEEP | SUSP_SH_SF)
+#define SUSP_MODE_STANDBY_SF	(SUSP_SH_STANDBY | SUSP_SH_SF)
+
+/*
+ * The following modes are not there yet:
+ *
+ * R-standby mode is unsupported, but will be added in the future
+ * U-standby mode is low priority since it needs bootloader hacks
+ *
+ * All modes should be tied in with cpuidle. But before that can
+ * happen we need to keep track of enabled hardware blocks so we
+ * can avoid entering sleep modes that stop clocks to hardware
+ * blocks that are in use even though the cpu core is idle.
+ */
+
+extern const unsigned char sh_mobile_standby[];
+extern const unsigned int sh_mobile_standby_size;
+
+static void sh_mobile_call_standby(unsigned long mode)
+{
+	extern void *vbr_base;
+	void *onchip_mem = (void *)0xe520000; /* ILRAM */
+	void (*standby_onchip_mem)(unsigned long) = onchip_mem;
+
+	/* Note: Wake up from sleep may generate exceptions!
+	 * Setup VBR to point to on-chip ram if self-refresh is
+	 * going to be used.
+	 */
+	if (mode & SUSP_SH_SF)
+		asm volatile("ldc %0, vbr" : : "r" (onchip_mem) : "memory");
+
+	/* Copy the assembly snippet to the otherwise ununsed ILRAM */
+	memcpy(onchip_mem, sh_mobile_standby, sh_mobile_standby_size);
+	wmb();
+	ctrl_barrier();
+
+	/* Let assembly snippet in on-chip memory handle the rest */
+	standby_onchip_mem(mode);
+
+	/* Put VBR back in System RAM again */
+	if (mode & SUSP_SH_SF)
+		asm volatile("ldc %0, vbr" : : "r" (&vbr_base) : "memory");
+}
+
+static int sh_pm_enter(suspend_state_t state)
+{
+	local_irq_disable();
+	set_bl_bit();
+	sh_mobile_call_standby(SUSP_MODE_STANDBY_SF);
+	local_irq_disable();
+	clear_bl_bit();
+	return 0;
+}
+
+static struct platform_suspend_ops sh_pm_ops = {
+	.enter          = sh_pm_enter,
+	.valid          = suspend_valid_only_mem,
+};
+
+static int __init sh_pm_init(void)
+{
+	suspend_set_ops(&sh_pm_ops);
+	return 0;
+}
+
+late_initcall(sh_pm_init);
--- /dev/null
+++ work/arch/sh/kernel/cpu/sh4a/sleep-sh_mobile.S	2009-03-12 23:31:02.000000000 +0900
@@ -0,0 +1,125 @@
+/*
+ * arch/sh/kernel/cpu/sh4a/sleep-sh_mobile.S
+ *
+ * Sleep mode and Standby modes support for SuperH Mobile
+ *
+ *  Copyright (C) 2009 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/sys.h>
+#include <linux/errno.h>
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/suspend.h>
+
+/* manage self-refresh and enter standby mode.
+ * this code will be copied to on-chip memory and executed from there.
+ */
+
+	.balign 	4096,0,4096
+ENTRY(sh_mobile_standby)
+	mov	r4, r0
+
+	tst	#SUSP_SH_SF, r0
+	bt	skip_set_sf
+
+	/* SDRAM: disable power down and put in self-refresh mode */
+	mov.l	1f, r4
+	mov.l	2f, r1
+	mov.l	@r4, r2
+	or	r1, r2
+	mov.l   3f, r3
+	and	r3, r2
+	mov.l	r2, @r4
+
+skip_set_sf:
+	tst	#SUSP_SH_SLEEP, r0
+	bt	test_standby
+
+	/* set mode to "sleep mode" */
+	bra	do_sleep
+	 mov	#0x00, r1
+
+test_standby:
+	tst	#SUSP_SH_STANDBY, r0
+	bt	test_rstandby
+
+	/* set mode to "software standby mode" */
+	bra	do_sleep
+	 mov	#0x80, r1
+
+test_rstandby:
+	tst	#SUSP_SH_RSTANDBY, r0
+	bt	test_ustandby
+
+	/* set mode to "r-standby mode" */
+	bra	do_sleep
+	 mov	#0x20, r1
+
+test_ustandby:
+	tst	#SUSP_SH_USTANDBY, r0
+	bt	done_sleep
+
+	/* set mode to "u-standby mode" */
+	mov	#0x10, r1
+
+	/* fall-through */
+
+do_sleep:
+	/* setup and enter selected standby mode */
+	mov.l	5f, r4
+	mov.l	r1, @r4
+	sleep
+
+done_sleep:
+	/* reset standby mode to sleep mode */
+	mov.l	5f, r4
+	mov	#0x00, r1
+	mov.l	r1, @r4
+
+	tst	#SUSP_SH_SF, r0
+	bt	skip_restore_sf
+
+	/* SDRAM: set auto-refresh mode */
+	mov.l	1f, r4
+	mov.l	@r4, r2
+	mov.l   4f, r3
+	and	r3, r2
+	mov.l	r2, @r4
+	mov.l	6f, r4
+	mov.l	7f, r1
+	mov.l	8f, r2
+	mov.l	@r4, r3
+	mov	#-1, r4
+	add	r4, r3
+	or	r2, r3
+	mov.l	r3, @r1
+skip_restore_sf:
+	rts
+	 nop
+
+	.balign 4
+1:	.long	0xfe400008 /* SDCR0 */
+2:	.long	0x00000400
+3:	.long	0xffff7fff
+4:	.long	0xfffffbff
+5:	.long	0xa4150020 /* STBCR */
+6:	.long   0xfe40001c /* RTCOR */
+7:	.long   0xfe400018 /* RTCNT */
+8:	.long   0xa55a0000
+
+/* interrupt vector @ 0x600 */
+	.balign 	0x400,0,0x400
+	.long	0xdeadbeef
+	.balign 	0x200,0,0x200
+	/* sh7722 will end up here in sleep mode */
+	rte
+	 nop
+sh_mobile_standby_end:
+
+ENTRY(sh_mobile_standby_size)
+	.long sh_mobile_standby_end - sh_mobile_standby
