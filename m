From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 05 Apr 2011 11:24:01 +0000
Subject: [PATCH/RFC] ARM: mach-shmobile: sh7372 Core Standby CPUIdle prototype
Message-Id: <20110405112401.564.97749.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds sh7372 Core Standby CPUIdle support,
most parts nicked from the OMAP2 implementation.

About 55 mW seems to be saved compared to simple WFI.
The latency information needs more work.

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile         |    5 
 arch/arm/mach-shmobile/cpuidle-sh7372.c |  136 +++++++++++++++++
 arch/arm/mach-shmobile/sleep-sh7372.S   |  244 +++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2011-04-05 20:20:11.000000000 +0900
@@ -30,6 +30,10 @@ obj-$(CONFIG_ARCH_SH7377)	+= entry-intc.
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
 obj-$(CONFIG_ARCH_SH73A0)	+= entry-gic.o
 
+# CPUIdle
+cpuidle-y			:+cpuidle-$(CONFIG_ARCH_SH7372)	+= cpuidle-sh7372.o sleep-sh7372.o
+
 # Board objects
 obj-$(CONFIG_MACH_G3EVM)	+= board-g3evm.o
 obj-$(CONFIG_MACH_G4EVM)	+= board-g4evm.o
@@ -40,3 +44,4 @@ obj-$(CONFIG_MACH_MACKEREL)	+= board-mac
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
 obj-$(CONFIG_GENERIC_GPIO)	+= $(pfc-y)
+obj-$(CONFIG_CPU_IDLE)		+= ${cpuidle-y}
--- /dev/null
+++ work/arch/arm/mach-shmobile/cpuidle-sh7372.c	2011-04-05 20:20:13.000000000 +0900
@@ -0,0 +1,136 @@
+/*
+ * sh7372 cpuidle support
+ *
+ * Copyright (C) 2011 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/suspend.h>
+#include <linux/cpuidle.h>
+#include <mach/sh7372.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/tlbflush.h>
+
+static void sh7372_wfi(void)
+{
+	cpu_do_idle();
+}
+
+#define SMFRAM 0xe6a70000
+#define SBAR 0xe6180020
+#define APARMBAREA 0xe6f10020
+#define SYSTBCR 0xe6150024
+
+extern void sh7372_cpu_suspend(void);
+extern void sh7372_cpu_resume(void);
+
+static void sh7372_core_standby(void)
+{
+	void __iomem *smfram = (void __iomem *)SMFRAM;
+
+	__raw_writel(0, APARMBAREA); /* translate 4k */
+	__raw_writel(__pa(sh7372_cpu_resume), SBAR); /* set reset vector */
+	__raw_writel(0x10, SYSTBCR); /* enable core standby */
+
+	sh7372_cpu_suspend();
+	cpu_init();
+
+	/* restore page table */
+	 __raw_writel(__raw_readl(smfram + 0x40),
+		     __va(__raw_readl(smfram + 0x3c)));
+
+	flush_tlb_all();
+	/* setup cache */
+	set_cr(__raw_readl(smfram + 0x38));
+
+	__raw_writel(0, SYSTBCR); /* disable core standby */
+	__raw_writel(0, SBAR); /* disable reset vector translation */
+}
+
+static void (*enter_cpuidle[])(void) = {
+	sh7372_wfi, /* regular sleep mode */
+	sh7372_core_standby,
+};
+
+static int cpuidle_sleep_enter(struct cpuidle_device *dev,
+			       struct cpuidle_state *state)
+{
+	ktime_t before, after;
+	int requested_state = state - &dev->states[0];
+
+	dev->last_state = &dev->states[requested_state];
+	before = ktime_get();
+
+	local_irq_disable();
+	local_fiq_disable();
+
+	enter_cpuidle[requested_state]();
+
+	local_irq_enable();
+	local_fiq_enable();
+
+	after = ktime_get();
+	return ktime_to_ns(ktime_sub(after, before)) >> 10;
+}
+
+static struct cpuidle_device cpuidle_dev;
+static struct cpuidle_driver cpuidle_driver = {
+	.name =		"sh7372_idle",
+	.owner =	THIS_MODULE,
+};
+
+void sh7372_cpuidle_init(void)
+{
+	struct cpuidle_device *dev = &cpuidle_dev;
+	struct cpuidle_state *state;
+	int i;
+
+	cpuidle_register_driver(&cpuidle_driver);
+
+	for (i = 0; i < CPUIDLE_STATE_MAX; i++) {
+		dev->states[i].name[0] = '\0';
+		dev->states[i].desc[0] = '\0';
+	}
+
+	i = CPUIDLE_DRIVER_STATE_START;
+
+	state = &dev->states[i++];
+	snprintf(state->name, CPUIDLE_NAME_LEN, "C1");
+	strncpy(state->desc, "WFI", CPUIDLE_DESC_LEN);
+	state->exit_latency = 1;
+	state->target_residency = 1 * 2;
+	state->power_usage = 3;
+	state->flags = 0;
+	state->flags |= CPUIDLE_FLAG_TIME_VALID;
+	state->enter = cpuidle_sleep_enter;
+
+	dev->safe_state = state;
+
+	state = &dev->states[i++];
+	snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
+	strncpy(state->desc, "Core Standby Mode", CPUIDLE_DESC_LEN);
+	state->exit_latency = 100;
+	state->target_residency = 1 * 2;
+	state->power_usage = 1;
+	state->flags = 0;
+	state->flags |= CPUIDLE_FLAG_TIME_VALID;
+	state->enter = cpuidle_sleep_enter;
+
+	dev->state_count = i;
+
+	cpuidle_register_device(dev);
+}
+
+static int __init sh_pm_init(void)
+{
+	sh7372_cpuidle_init();
+	return 0;
+}
+
+late_initcall(sh_pm_init);
--- /dev/null
+++ work/arch/arm/mach-shmobile/sleep-sh7372.S	2011-04-05 20:20:22.000000000 +0900
@@ -0,0 +1,244 @@
+/*
+ * sh7372 lowlevel sleep code for "Core Standby Mode"
+ *
+ * Copyright (C) 2011 Magnus Damm
+ *
+ * In "Core Standby Mode" the ARM core is off, but L2 cache is still on
+ *
+ * Based on mach-omap2/sleep34xx.S
+ *
+ * (C) Copyright 2007 Texas Instruments
+ * Karthik Dasu <karthik-dp@ti.com>
+ *
+ * (C) Copyright 2004 Texas Instruments, <www.ti.com>
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+#define SMFRAM 0xe6a70000
+
+	.align
+kernel_flush:
+	.word	v7_flush_dcache_all
+
+	.align	3
+ENTRY(sh7372_cpu_suspend)
+	stmfd	sp!, {r0-r12, lr}	@ save registers on stack
+
+	ldr	r8, =SMFRAM
+
+	mov	r4, sp			@ Store sp
+	mrs	r5, spsr		@ Store spsr
+	mov	r6, lr			@ Store lr
+	stmia	r8!, {r4-r6}
+
+	mrc	p15, 0, r4, c1, c0, 2	@ Coprocessor access control register
+	mrc	p15, 0, r5, c2, c0, 0	@ TTBR0
+	mrc	p15, 0, r6, c2, c0, 1	@ TTBR1
+	mrc	p15, 0, r7, c2, c0, 2	@ TTBCR
+	stmia	r8!, {r4-r7}
+
+	mrc	p15, 0, r4, c3, c0, 0	@ Domain access Control Register
+	mrc	p15, 0, r5, c10, c2, 0	@ PRRR
+	mrc	p15, 0, r6, c10, c2, 1	@ NMRR
+	stmia	r8!,{r4-r6}
+
+	mrc	p15, 0, r4, c13, c0, 1	@ Context ID
+	mrc	p15, 0, r5, c13, c0, 2	@ User r/w thread and process ID
+	mrc	p15, 0, r6, c12, c0, 0	@ Secure or NS vector base address
+	mrs	r7, cpsr		@ Store current cpsr
+	stmia	r8!, {r4-r7}
+
+	mrc	p15, 0, r4, c1, c0, 0	@ save control register
+	stmia	r8!, {r4}
+
+	/*
+	 * jump out to kernel flush routine
+	 *  - reuse that code is better
+	 *  - it executes in a cached space so is faster than refetch per-block
+	 *  - should be faster and will change with kernel
+	 *  - 'might' have to copy address, load and jump to it
+	 * Flush all data from the L1 data cache before disabling
+	 * SCTLR.C bit.
+	 */
+	ldr	r1, kernel_flush
+	mov	lr, pc
+	bx	r1
+
+	/*
+	 * Clear the SCTLR.C bit to prevent further data cache
+	 * allocation. Clearing SCTLR.C would make all the data accesses
+	 * strongly ordered and would not hit the cache.
+	 */
+	mrc	p15, 0, r0, c1, c0, 0
+	bic	r0, r0, #(1 << 2)	@ Disable the C bit
+	mcr	p15, 0, r0, c1, c0, 0
+	isb
+
+	/*
+	 * Invalidate L1 data cache. Even though only invalidate is
+	 * necessary exported flush API is used here. Doing clean
+	 * on already clean cache would be almost NOP.
+	 */
+	ldr	r1, kernel_flush
+	blx	r1
+	/*
+	 * The kernel doesn't interwork: v7_flush_dcache_all in particluar will
+	 * always return in Thumb state when CONFIG_THUMB2_KERNEL is enabled.
+	 * This sequence switches back to ARM.  Note that .align may insert a
+	 * nop: bx pc needs to be word-aligned in order to work.
+	 */
+ THUMB(	.thumb		)
+ THUMB(	.align		)
+ THUMB(	bx	pc	)
+ THUMB(	nop		)
+	.arm
+
+	/* Data memory barrier and Data sync barrier */
+	dsb
+	dmb
+
+/*
+ * =================+ * = WFI instruction => Enter idle =
+ * =================+ */
+sleep_again:
+	wfi				@ wait for interrupt
+	b	sleep_again
+
+	.pool
+
+	.align	12
+	.text
+	.global	sh7372_cpu_resume
+sh7372_cpu_resume:
+
+	mov	r1, #0
+	/*
+	 * Invalidate all instruction caches to PoU
+	 * and flush branch target cache
+	 */
+	mcr	p15, 0, r1, c7, c5, 0
+
+	ldr	r3, =SMFRAM
+
+	ldmia	r3!, {r4-r6}
+	mov	sp, r4			@ Restore sp
+	msr	spsr_cxsf, r5		@ Restore spsr
+	mov	lr, r6			@ Restore lr
+
+	ldmia	r3!, {r4-r7}
+	mcr	p15, 0, r4, c1, c0, 2	@ Coprocessor access Control Register
+	mcr	p15, 0, r5, c2, c0, 0	@ TTBR0
+	mcr	p15, 0, r6, c2, c0, 1	@ TTBR1
+	mcr	p15, 0, r7, c2, c0, 2	@ TTBCR
+
+	ldmia	r3!,{r4-r6}
+	mcr	p15, 0, r4, c3, c0, 0	@ Domain access Control Register
+	mcr	p15, 0, r5, c10, c2, 0	@ PRRR
+	mcr	p15, 0, r6, c10, c2, 1	@ NMRR
+
+	ldmia	r3!,{r4-r7}
+	mcr	p15, 0, r4, c13, c0, 1	@ Context ID
+	mcr	p15, 0, r5, c13, c0, 2	@ User r/w thread and process ID
+	mrc	p15, 0, r6, c12, c0, 0	@ Secure or NS vector base address
+	msr	cpsr, r7		@ store cpsr
+
+	/* Starting to enable MMU here */
+	mrc	p15, 0, r7, c2, c0, 2 	@ Read TTBRControl
+	/* Extract N (0:2) bits and decide whether to use TTBR0 or TTBR1 */
+	and	r7, #0x7
+	cmp	r7, #0x0
+	beq	usettbr0
+ttbr_error:
+	/*
+	 * More work needs to be done to support N[0:2] value other than 0
+	 * So looping here so that the error can be detected
+	 */
+	b	ttbr_error
+
+	.align
+cache_pred_disable_mask:
+	.word	0xFFFFE7FB
+ttbrbit_mask:
+	.word	0xFFFFC000
+table_index_mask:
+	.word	0xFFF00000
+table_entry:
+	.word	0x00000C02
+usettbr0:
+
+	mrc	p15, 0, r2, c2, c0, 0
+	ldr	r5, ttbrbit_mask
+	and	r2, r5
+	mov	r4, pc
+	ldr	r5, table_index_mask
+	and	r4, r5			@ r4 = 31 to 20 bits of pc
+	/* Extract the value to be written to table entry */
+	ldr	r6, table_entry
+	/* r6 has the value to be written to table entry */
+	add	r6, r6, r4
+	/* Getting the address of table entry to modify */
+	lsr	r4, #18
+	/* r2 has the location which needs to be modified */
+	add	r2, r4
+	ldr	r4, [r2]
+	str	r6, [r2] /* modify the table entry */
+
+	mov	r7, r6
+	mov	r5, r2
+	mov	r6, r4
+	/* r5 = original page table address */
+	/* r6 = original page table data */
+
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 4	@ Flush prefetch buffer
+	mcr	p15, 0, r0, c7, c5, 6	@ Invalidate branch predictor array
+	mcr	p15, 0, r0, c8, c5, 0	@ Invalidate instruction TLB
+	mcr	p15, 0, r0, c8, c6, 0	@ Invalidate data TLB
+
+	/*
+	 * Restore control register. This enables the MMU.
+	 * The caches and prediction are not enabled here, they
+	 * will be enabled after restoring the MMU table entry.
+	 */
+	ldmia	r3!, {r4}
+	stmia	r3!, {r5} /* save original page table address */
+	stmia	r3!, {r6} /* save original page table data */
+	stmia	r3!, {r7} /* save modified page table data */
+
+	ldr	r2, cache_pred_disable_mask
+	and	r4, r2
+	mcr	p15, 0, r4, c1, c0, 0
+	dsb
+	isb
+
+	ldr     r0, =restoremmu_on
+	bx      r0
+
+/*
+ * ===============
+ * = Exit point from OFF mode =
+ * ===============
+ */
+restoremmu_on:
+
+	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
