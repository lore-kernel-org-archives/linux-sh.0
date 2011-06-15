From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Jun 2011 13:26:40 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 A3SM sleep prototype
Message-Id: <20110615132640.8310.73352.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This prototype adds A3SM sleep mode support for Suspend-to-RAM
on the sh7372 SoC and boards such as Mackerel and AP4EVB.

A3SM sleep is similar to ARM Core Standby on sh7372, but instead
of only powering down the ARM core including L1 cache A3SM also
shuts down the L2 cache. PLLC0 can also be turned off. The down
side is the limited amount of wakeup sources available for A3SM.

In theory we can also add limited CPUIdle support, but it is not
yet clear how to determine which wakeup sources that are active
during normal operation on a running system. Creating a special
case is easy, but to support something in a generic way requires
more information from various parts of the kernel.

The goal with this prototype is to highlight the need for this
extra information. I suspect that we can get this from Runtime PM.

One solution is export information from the SoC specific Runtime
PM code so we can determine the current state of each device. We
can then use the per-device state together with the interrupt status
to determine potential wakeup sources and from that select the most
suitable sleep mode.

In other words, in the solution proposal above we assume that devices
that are Runtime PM idle (clocked stopped and maybe powered down)
will not generate wakeups. Since the device is idle can we treat
the associated interrupt as disabled even though it happens to be
enabled through request_irq().

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    2=20
 arch/arm/mach-shmobile/pm-sh7372.c           |  134 ++++++++++++++++++++++=
+++-
 arch/arm/mach-shmobile/sleep-sh7372.S        |   84 ++++++++++++++++
 3 files changed, 218 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2011-06-15 21:54:42.0=
00000000 +0900
@@ -35,7 +35,7 @@ extern void sh7372_add_standard_devices(
 extern void sh7372_clock_init(void);
 extern void sh7372_pinmux_init(void);
 extern void sh7372_pm_init(void);
-extern void sh7372_cpu_suspend(void);
+extern void sh7372_cpu_suspend(int do_a3sm);
 extern void sh7372_cpu_resume(void);
 extern struct clk sh7372_extal1_clk;
 extern struct clk sh7372_extal2_clk;
--- 0001/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-06-15 22:02:15.000000000 +=
0900
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
@@ -22,7 +23,12 @@
=20
 #define SMFRAM 0xe6a70000
 #define SYSTBCR 0xe6150024
+#define PLLC01STPCR 0xe61500c8
 #define SBAR 0xe6180020
+#define WUPSMSK 0xe618002c
+#define WUPSMSK2 0xe6180048
+#define WUPSFAC 0xe6180098
+#define PDNSEL 0xe6180254
 #define APARMBAREA 0xe6f10020
=20
 static void sh7372_enter_core_standby(void)
@@ -35,7 +41,7 @@ static void sh7372_enter_core_standby(vo
=20
 	__raw_writel(0, smfram + 0x3c); /* clear page table address */
=20
-	sh7372_cpu_suspend();
+	sh7372_cpu_suspend(0);
 	cpu_init();
=20
 	/* if page table address is non-NULL then we have been powered down */
@@ -51,6 +57,38 @@ static void sh7372_enter_core_standby(vo
 	__raw_writel(0, SBAR); /* disable reset vector translation */
 }
=20
+static void sh7372_enter_a3sm(void)
+{
+	void __iomem *smfram =3D (void __iomem *)SMFRAM;
+
+	pr_info("entering a3sm sleep mode!\n");
+
+	__raw_writel(0, APARMBAREA); /* translate 4k */
+	__raw_writel(__pa(sh7372_cpu_resume), SBAR); /* set reset vector */
+
+	__raw_writel(0, smfram + 0x3c); /* clear page table address */
+
+	__raw_writel(0, PDNSEL); /* power-down A3SM only, not A4S */
+
+	__raw_readl(WUPSFAC); /* read wakeup int. factor before sleep */
+
+	sh7372_cpu_suspend(1);
+	cpu_init();
+
+	/* if page table address is non-NULL then we have been powered down */
+	if (__raw_readl(smfram + 0x3c)) {
+		__raw_writel(__raw_readl(smfram + 0x40),
+			     __va(__raw_readl(smfram + 0x3c)));
+
+		flush_tlb_all();
+		set_cr(__raw_readl(smfram + 0x38));
+
+		__raw_readl(WUPSFAC); /* read wakeup int. factor after wakeup */
+	}
+
+	__raw_writel(0, SBAR); /* disable reset vector translation */
+}
+
 #ifdef CONFIG_CPU_IDLE
 static void sh7372_cpuidle_setup(struct cpuidle_device *dev)
 {
@@ -79,8 +117,102 @@ static void sh7372_cpuidle_init(void) {}
 #endif
=20
 #ifdef CONFIG_SUSPEND
+
+#define WUPSMSK_BIT(n) ((n) + 1)
+#define WUPSMSK2_BIT(n) ((n) + 1 + 32)
+
+static unsigned char irq2msk[NR_IRQS] =3D {
+	[evt2irq(0x1800)] =3D WUPSMSK_BIT(31), /* SPU2_SPU0 */
+	[evt2irq(0x1820)] =3D WUPSMSK_BIT(31), /* SPU2_SPU1 */
+	[intcs_evt2irq(0x5a0)] =3D WUPSMSK_BIT(30), /* LCRC */
+	[evt2irq(0x0900)] =3D WUPSMSK_BIT(21), /* MFI_MFIM */
+	[evt2irq(0x03e0)] =3D WUPSMSK_BIT(19), /* IRQ15A */
+	[evt2irq(0x03c0)] =3D WUPSMSK_BIT(18), /* IRQ14A */
+	[evt2irq(0x03a0)] =3D WUPSMSK_BIT(17), /* IRQ13A */
+	[evt2irq(0x0380)] =3D WUPSMSK_BIT(16), /* IRQ12A */
+	[evt2irq(0x0360)] =3D WUPSMSK_BIT(15), /* IRQ11A */
+	[evt2irq(0x0340)] =3D WUPSMSK_BIT(14), /* IRQ10A */
+	[evt2irq(0x0320)] =3D WUPSMSK_BIT(13), /* IRQ9A */
+	[evt2irq(0x0300)] =3D WUPSMSK_BIT(12), /* IRQ8A */
+	[evt2irq(0x02e0)] =3D WUPSMSK_BIT(11), /* IRQ7A */
+	[evt2irq(0x02c0)] =3D WUPSMSK_BIT(10), /* IRQ6A */
+	[evt2irq(0x02a0)] =3D WUPSMSK_BIT(9), /* IRQ5A */
+	[evt2irq(0x0280)] =3D WUPSMSK_BIT(8), /* IRQ4A */
+	[evt2irq(0x0260)] =3D WUPSMSK_BIT(7), /* IRQ3A */
+	[evt2irq(0x0240)] =3D WUPSMSK_BIT(6), /* IRQ2A */
+	[evt2irq(0x0220)] =3D WUPSMSK_BIT(5), /* IRQ1A */
+	[evt2irq(0x0200)] =3D WUPSMSK_BIT(4), /* IRQ0A */
+	[evt2irq(0x0be0)] =3D WUPSMSK_BIT(2), /* KEYSC_KEY */
+	[evt2irq(0x0b00)] =3D WUPSMSK_BIT(1), /* CMT1_CMT10 */
+	[evt2irq(0x0b20)] =3D WUPSMSK_BIT(1), /* CMT1_CMT11 */
+	[evt2irq(0x0b40)] =3D WUPSMSK_BIT(1), /* CMT1_CMT12 */
+	[evt2irq(0x0b60)] =3D WUPSMSK_BIT(1), /* CMT1_CMT13 */
+	[evt2irq(0x0b80)] =3D WUPSMSK_BIT(1), /* CMT2 */
+	[evt2irq(0x0ba0)] =3D WUPSMSK_BIT(1), /* CMT3 */
+	[evt2irq(0x0920)] =3D WUPSMSK2_BIT(17), /* MFI_MFIS */
+	[evt2irq(0x33e0)] =3D WUPSMSK2_BIT(15), /* IRQ31A */
+	[evt2irq(0x33c0)] =3D WUPSMSK2_BIT(14), /* IRQ30A */
+	[evt2irq(0x33a0)] =3D WUPSMSK2_BIT(13), /* IRQ29A */
+	[evt2irq(0x3380)] =3D WUPSMSK2_BIT(12), /* IRQ28A */
+	[evt2irq(0x3360)] =3D WUPSMSK2_BIT(11), /* IRQ27A */
+	[evt2irq(0x3340)] =3D WUPSMSK2_BIT(10), /* IRQ26A */
+	[evt2irq(0x3320)] =3D WUPSMSK2_BIT(9), /* IRQ25A */
+	[evt2irq(0x3300)] =3D WUPSMSK2_BIT(8), /* IRQ24A */
+	[evt2irq(0x32e0)] =3D WUPSMSK2_BIT(7), /* IRQ23A */
+	[evt2irq(0x32c0)] =3D WUPSMSK2_BIT(6), /* IRQ22A */
+	[evt2irq(0x32a0)] =3D WUPSMSK2_BIT(5), /* IRQ21A */
+	[evt2irq(0x3280)] =3D WUPSMSK2_BIT(4), /* IRQ20A */
+	[evt2irq(0x3260)] =3D WUPSMSK2_BIT(3), /* IRQ19A */
+	[evt2irq(0x3240)] =3D WUPSMSK2_BIT(2), /* IRQ18A */
+	[evt2irq(0x3220)] =3D WUPSMSK2_BIT(1), /* IRQ17A */
+	[evt2irq(0x3200)] =3D WUPSMSK2_BIT(0), /* IRQ16A */
+};
+
 static int sh7372_enter_suspend(suspend_state_t suspend_state)
 {
+	int irq;
+	unsigned long msk, msk2, tmp;
+	int a3sm_supported =3D 1;
+
+	msk =3D 0;
+	msk2 =3D 0;
+
+	/* check active wakeup sources to determine allowed sleep mode */
+	for_each_active_irq(irq) {
+		struct irq_data *data =3D irq_get_irq_data(irq);
+
+		if (!irqd_is_wakeup_set(data))
+			continue;
+
+		tmp =3D irq2msk[irq];
+		if (!tmp) {
+			a3sm_supported =3D 0;
+			break;
+		}
+
+		tmp--;
+		if (tmp >=3D 32)
+			msk2 |=3D 1 << (tmp - 32);
+		else
+			msk |=3D 1 << tmp;
+	}
+
+	if (a3sm_supported) {
+		/* setup wakeup sources in SYSC */
+		__raw_writel(~msk, WUPSMSK);
+		__raw_writel(~msk2, WUPSMSK2);
+
+		/* turn off PLLC0 when entering A3SM */
+		__raw_writel(1 << 28, PLLC01STPCR);
+
+		/* TODO: propagate edge/level trigger config to SYSC */
+
+		/* enter A3SM sleep */
+		sh7372_enter_a3sm();
+		return 0;
+	}
+
+	/* default to ARM Core Standby since it supports all wakeup sources */
 	sh7372_enter_core_standby();
 	return 0;
 }
--- 0001/arch/arm/mach-shmobile/sleep-sh7372.S
+++ work/arch/arm/mach-shmobile/sleep-sh7372.S	2011-06-15 22:02:00.00000000=
0 +0900
@@ -42,6 +42,7 @@ kernel_flush:
 ENTRY(sh7372_cpu_suspend)
 	stmfd	sp!, {r0-r12, lr}	@ save registers on stack
=20
+	mov	r9, r0
 	ldr	r8, =3DSMFRAM
=20
 	mov	r4, sp			@ Store sp
@@ -69,6 +70,89 @@ ENTRY(sh7372_cpu_suspend)
 	mrc	p15, 0, r4, c1, c0, 0	@ save control register
 	stmia	r8!, {r4}
=20
+	cmp	r9, #0x0
+	beq	core_standby
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
+	/* disable L2 cache in the aux control register */
+	mrc     p15, 0, r10, c1, c0, 1
+	bic     r10, r10, #2
+	mcr     p15, 0, r10, c1, c0, 1
+
+	/*
+	 * Invalidate data cache again.
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
+#define SPDCR 0xe6180008
+#define A3SM (1 << 12)
+
+	/* A3SM power down */
+	ldr     r0, =3DSPDCR
+	ldr     r1, =A3SM
+	str     r1, [r0]
+
+busy_loop:
+	b       busy_loop
+
+core_standby:
 	/*
 	 * jump out to kernel flush routine
 	 *  - reuse that code is better
