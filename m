From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 09 Mar 2009 10:51:43 +0000
Subject: [PATCH] sh: SuperH Mobile suspend support
Message-Id: <20090309105143.23622.42915.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds CONFIG_SUSPEND support to the SuperH
architecture. If enabled, SuperH Mobile processors will
register their suspend callbacks during boot.

To suspend, use "echo mem > /sys/power/state". To allow
wakeup, make sure "/sys/device/platform/../power/wakeup"
contains "enabled". Additional per-device driver patches
are most likely needed.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                           |    1 
 arch/sh/include/asm/suspend.h             |   12 ++
 arch/sh/kernel/cpu/sh4a/Makefile          |    7 +
 arch/sh/kernel/cpu/sh4a/pm-sh_mobile.c    |   76 +++++++++++++++++
 arch/sh/kernel/cpu/sh4a/sleep-sh_mobile.S |  125 +++++++++++++++++++++++++++++
 5 files changed, 221 insertions(+)

--- 0004/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-03-09 19:36:29.000000000 +0900
@@ -159,6 +159,7 @@ config CPU_SH4
 	select CPU_HAS_SR_RB
 	select CPU_HAS_PTEA if !CPU_SH4A || CPU_SHX2
 	select CPU_HAS_FPU if !CPU_SH4AL_DSP
+	select ARCH_SUSPEND_POSSIBLE
 
 config CPU_SH4A
 	bool
--- 0005/arch/sh/include/asm/suspend.h
+++ work/arch/sh/include/asm/suspend.h	2009-03-09 19:36:29.000000000 +0900
@@ -1,6 +1,7 @@
 #ifndef _ASM_SH_SUSPEND_H
 #define _ASM_SH_SUSPEND_H
 
+#ifndef __ASSEMBLY__
 static inline int arch_prepare_suspend(void) { return 0; }
 
 #include <asm/ptrace.h>
@@ -9,5 +10,16 @@ struct swsusp_arch_regs {
 	struct pt_regs user_regs;
 	unsigned long bank1_regs[8];
 };
+#endif
+
+#define SUSP_SH_SLEEP		(1 << 0) /* Regular sleep mode */
+#define SUSP_SH_STANDBY		(1 << 1) /* Software standby mode */
+#define SUSP_SH_RSTANDBY	(1 << 2) /* R-standby mode */
+#define SUSP_SH_USTANDBY	(1 << 3) /* U-standby mode */
+#define SUSP_SH_SF		(1 << 4) /* Enable self-refresh */
+
+#define SUSP_MODE_SLEEP		(SUSP_SH_SLEEP)
+#define SUSP_MODE_SLEEP_SF	(SUSP_SH_SLEEP | SUSP_SH_SF)
+#define SUSP_MODE_STANDBY_SF	(SUSP_SH_STANDBY | SUSP_SH_SF)
 
 #endif /* _ASM_SH_SUSPEND_H */
--- 0001/arch/sh/kernel/cpu/sh4a/Makefile
+++ work/arch/sh/kernel/cpu/sh4a/Makefile	2009-03-09 19:36:29.000000000 +0900
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
+++ work/arch/sh/kernel/cpu/sh4a/pm-sh_mobile.c	2009-03-09 19:36:29.000000000 +0900
@@ -0,0 +1,76 @@
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
+extern const unsigned char do_standby[];
+extern const unsigned int do_standby_size;
+
+#define ILRAM_ADDR 0xe5200000
+
+static void set_vbr(void *base)
+{
+	asm volatile("ldc	%0, vbr"
+		     : /* no output */
+		     : "r" (base)
+		     : "memory");
+}
+
+static void sh_suspend_mode(unsigned long mode)
+{
+	extern void *vbr_base;
+	void *onchip_memory = (void *)ILRAM_ADDR;
+	void (*do_standby_ilram)(unsigned long) = onchip_memory;
+
+	/* wake up from sleep may generate exceptions
+	 * so setup temporary VBR to point to on-chip ram
+	 * if system ram will be put self-refresh during sleep.
+	 */
+
+	if (mode & SUSP_SH_SF)
+		set_vbr(onchip_memory);
+
+	memcpy(onchip_memory, do_standby, do_standby_size);
+	wmb();
+	ctrl_barrier();
+	do_standby_ilram(mode);
+
+	if (mode & SUSP_SH_SF)
+		set_vbr(&vbr_base);
+}
+
+static int sh_pm_enter(suspend_state_t state)
+{
+	local_irq_disable();
+	set_bl_bit();
+	sh_suspend_mode(SUSP_MODE_STANDBY_SF);
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
+++ work/arch/sh/kernel/cpu/sh4a/sleep-sh_mobile.S	2009-03-09 19:36:40.000000000 +0900
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
+ENTRY(do_standby)
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
+do_standby_end:
+
+ENTRY(do_standby_size)
+	.long do_standby_end - do_standby
