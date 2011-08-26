From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 26 Aug 2011 06:43:25 +0000
Subject: [PATCH 01/03] ARM: mach-shmobile: sh7372 A3SM support
Message-Id: <20110826064325.373.35309.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds sh7372 A3SM power domain support.

The sh7372 A3SM hardware power domain contains the
ARM Cortex-A8 CPU Core including L2 cache. This
sleep mode can be seen as a one step deeper sleep
mode from the already existing Core Standby mode.

To wake up from A3SM sleep only a few wakeup sources
are supported - so the regular INTC controller will
not be able to help us unfortunately.

The code in this patch will enter A3SM sleep via the
regular Suspend-to-RAM interface in the case of only
wakeups supported by A3SM are enabled. If unsupported
wakeups are enabled then Core Standby will be used
instead.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 To be able to enter A3SM you need to apply MSTP patches
 for MSIOF, CMT and USB-DMAC. You may also have to
 disable the serial console on the kernel command line.

 arch/arm/mach-shmobile/include/mach/common.h |    3=20
 arch/arm/mach-shmobile/pm-sh7372.c           |  209 ++++++++++++++++++++++=
+++-
 arch/arm/mach-shmobile/sleep-sh7372.S        |   55 ++++++
 3 files changed, 256 insertions(+), 11 deletions(-)

--- 0002/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2011-08-26 13:02:46.0=
00000000 +0900
@@ -35,7 +35,8 @@ extern void sh7372_add_standard_devices(
 extern void sh7372_clock_init(void);
 extern void sh7372_pinmux_init(void);
 extern void sh7372_pm_init(void);
-extern void sh7372_resume_core_standby(void);
+extern void sh7372_resume_core_standby_a3sm(void);
+extern int sh7372_do_idle_a3sm(unsigned long unused);
 extern struct clk sh7372_extal1_clk;
 extern struct clk sh7372_extal2_clk;
=20
--- 0002/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-08-26 13:03:38.000000000 +=
0900
@@ -18,6 +18,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/bitrev.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
@@ -25,14 +27,48 @@
 #include <mach/common.h>
 #include <mach/sh7372.h>
=20
-#define SMFRAM 0xe6a70000
+/* DBG */
+#define DBGREG1 0xe6100020
+#define DBGREG9 0xe6100040
+
+/* CPGA */
 #define SYSTBCR 0xe6150024
-#define SBAR 0xe6180020
-#define APARMBAREA 0xe6f10020
+#define MSTPSR0 0xe6150030
+#define MSTPSR1 0xe6150038
+#define MSTPSR2 0xe6150040
+#define MSTPSR3 0xe6150048
+#define MSTPSR4 0xe615004c
+#define PLLC01STPCR 0xe61500c8
=20
+/* SYSC */
 #define SPDCR 0xe6180008
 #define SWUCR 0xe6180014
+#define SBAR 0xe6180020
+#define WUPSMSK 0xe618002c
+#define WUPSMSK2 0xe6180048
 #define PSTR 0xe6180080
+#define WUPSFAC 0xe6180098
+#define IRQCR 0xe618022c
+#define IRQCR2 0xe6180238
+#define IRQCR3 0xe6180244
+#define IRQCR4 0xe6180248
+#define PDNSEL 0xe6180254
+
+/* INTC */
+#define ICR1A 0xe6900000
+#define ICR2A 0xe6900004
+#define ICR3A 0xe6900008
+#define ICR4A 0xe690000c
+#define INTMSK00A 0xe6900040
+#define INTMSK10A 0xe6900044
+#define INTMSK20A 0xe6900048
+#define INTMSK30A 0xe690004c
+
+/* MFIS */
+#define SMFRAM 0xe6a70000
+
+/* AP-System Core */
+#define APARMBAREA 0xe6f10020
=20
 #define PSTR_RETRIES 100
 #define PSTR_DELAY_US 10
@@ -195,7 +231,7 @@ static int sh7372_do_idle_core_standby(u
 static void sh7372_enter_core_standby(void)
 {
 	/* set reset vector, translate 4k */
-	__raw_writel(__pa(sh7372_resume_core_standby), SBAR);
+	__raw_writel(__pa(sh7372_resume_core_standby_a3sm), SBAR);
 	__raw_writel(0, APARMBAREA);
=20
 	/* enter sleep mode with SYSTBCR to 0x10 */
@@ -207,7 +243,151 @@ static void sh7372_enter_core_standby(vo
 	__raw_writel(0, SBAR);
 }
=20
+static void sh7372_enter_a3sm_common(int pllc0_on)
+{
+	/* set reset vector, translate 4k */
+	__raw_writel(__pa(sh7372_resume_core_standby_a3sm), SBAR);
+	__raw_writel(0, APARMBAREA);
+
+	if (pllc0_on)
+		__raw_writel(0, PLLC01STPCR);
+	else
+		__raw_writel(1 << 28, PLLC01STPCR);
+
+	__raw_writel(0, PDNSEL); /* power-down A3SM only, not A4S */
+	__raw_readl(WUPSFAC); /* read wakeup int. factor before sleep */
+	cpu_suspend(0, sh7372_do_idle_a3sm);
+	__raw_readl(WUPSFAC); /* read wakeup int. factor after wakeup */
+
+	 /* disable reset vector translation */
+	__raw_writel(0, SBAR);
+}
+
+static int sh7372_a3sm_valid(unsigned long *mskp, unsigned long *msk2p)
+{
+	unsigned long mstpsr0, mstpsr1, mstpsr2, mstpsr3, mstpsr4;
+	unsigned long msk, msk2;
+
+	/* check active clocks to determine potential wakeup sources */
+
+	mstpsr0 =3D __raw_readl(MSTPSR0);
+	if ((mstpsr0 & 0x00000003) !=3D 0x00000003) {
+		pr_debug("sh7372 mstpsr0 0x%08lx\n", mstpsr0);
+		return 0;
+	}
+
+	mstpsr1 =3D __raw_readl(MSTPSR1);
+	if ((mstpsr1 & 0xff079b7f) !=3D 0xff079b7f) {
+		pr_debug("sh7372 mstpsr1 0x%08lx\n", mstpsr1);
+		return 0;
+	}
+
+	mstpsr2 =3D __raw_readl(MSTPSR2);
+	if ((mstpsr2 & 0x000741ff) !=3D 0x000741ff) {
+		pr_debug("sh7372 mstpsr2 0x%08lx\n", mstpsr2);
+		return 0;
+	}
+
+	mstpsr3 =3D __raw_readl(MSTPSR3);
+	if ((mstpsr3 & 0x1a60f010) !=3D 0x1a60f010) {
+		pr_debug("sh7372 mstpsr3 0x%08lx\n", mstpsr3);
+		return 0;
+	}
+
+	mstpsr4 =3D __raw_readl(MSTPSR4);
+	if ((mstpsr4 & 0x00008cf0) !=3D 0x00008cf0) {
+		pr_debug("sh7372 mstpsr4 0x%08lx\n", mstpsr4);
+		return 0;
+	}
+
+	msk =3D 0;
+	msk2 =3D 0;
+
+	/* make bitmaps of limited number of wakeup sources */
+
+	if ((mstpsr2 & (1 << 23)) =3D 0) /* SPU2 */
+		msk |=3D 1 << 31;
+
+	if ((mstpsr2 & (1 << 12)) =3D 0) /* MFI_MFIM */
+		msk |=3D 1 << 21;
+
+	if ((mstpsr4 & (1 << 3)) =3D 0) /* KEYSC */
+		msk |=3D 1 << 2;
+
+	if ((mstpsr1 & (1 << 24)) =3D 0) /* CMT0 */
+		msk |=3D 1 << 1;
+
+	if ((mstpsr3 & (1 << 29)) =3D 0) /* CMT1 */
+		msk |=3D 1 << 1;
+
+	if ((mstpsr4 & (1 << 0)) =3D 0) /* CMT2 */
+		msk |=3D 1 << 1;
+
+	if ((mstpsr2 & (1 << 13)) =3D 0) /* MFI_MFIS */
+		msk2 |=3D 1 << 17;
+
+	*mskp =3D msk;
+	*msk2p =3D msk2;
+
+	return 1;
+}
+
+static void sh7372_icr_to_irqcr(unsigned long icr, u16 *irqcr1p, u16 *irqc=
r2p)
+{
+	u16 tmp, irqcr1, irqcr2;
+	int k;
+
+	irqcr1 =3D 0;
+	irqcr2 =3D 0;
+
+	/* convert INTCA ICR register layout to SYSC IRQCR+IRQCR2 */
+	for (k =3D 0; k <=3D 7; k++) {
+		tmp =3D (icr >> ((7 - k) * 4)) & 0xf;
+		irqcr1 |=3D (tmp & 0x03) << (k * 2);
+		irqcr2 |=3D (tmp >> 2) << (k * 2);
+	}
+
+	*irqcr1p =3D irqcr1;
+	*irqcr2p =3D irqcr2;
+}
+
+static void sh7372_setup_a3sm(unsigned long msk, unsigned long msk2)
+{
+	u16 irqcrx_low, irqcrx_high, irqcry_low, irqcry_high;
+	unsigned long tmp;
+
+	/* read IRQ0A -> IRQ15A mask */
+	tmp =3D bitrev8(__raw_readb(INTMSK00A));
+	tmp |=3D bitrev8(__raw_readb(INTMSK10A)) << 8;
+
+	/* setup WUPSMSK from clocks and external IRQ mask */
+	msk =3D (~msk & 0xc030000f) | (tmp << 4);
+	__raw_writel(msk, WUPSMSK);
+
+	/* propage level/edge trigger for external IRQ 0->15 */
+	sh7372_icr_to_irqcr(__raw_readl(ICR1A), &irqcrx_low, &irqcry_low);
+	sh7372_icr_to_irqcr(__raw_readl(ICR2A), &irqcrx_high, &irqcry_high);
+	__raw_writel((irqcrx_high << 16) | irqcrx_low, IRQCR);
+	__raw_writel((irqcry_high << 16) | irqcry_low, IRQCR2);
+
+	/* read IRQ16A -> IRQ31A mask */
+	tmp =3D bitrev8(__raw_readb(INTMSK20A));
+	tmp |=3D bitrev8(__raw_readb(INTMSK30A)) << 8;
+
+	/* setup WUPSMSK2 from clocks and external IRQ mask */
+	msk2 =3D (~msk2 & 0x00030000) | tmp;
+	__raw_writel(msk2, WUPSMSK2);
+
+	/* propage level/edge trigger for external IRQ 16->31 */
+	sh7372_icr_to_irqcr(__raw_readl(ICR3A), &irqcrx_low, &irqcry_low);
+	sh7372_icr_to_irqcr(__raw_readl(ICR4A), &irqcrx_high, &irqcry_high);
+	__raw_writel((irqcrx_high << 16) | irqcrx_low, IRQCR3);
+	__raw_writel((irqcry_high << 16) | irqcry_low, IRQCR4);
+}
+
+
 #ifdef CONFIG_CPU_IDLE
+
 static void sh7372_cpuidle_setup(struct cpuidle_device *dev)
 {
 	struct cpuidle_state *state;
@@ -235,9 +415,25 @@ static void sh7372_cpuidle_init(void) {}
 #endif
=20
 #ifdef CONFIG_SUSPEND
+
 static int sh7372_enter_suspend(suspend_state_t suspend_state)
 {
-	sh7372_enter_core_standby();
+	unsigned long msk, msk2;
+
+	/* check active clocks to determine potential wakeup sources */
+	if (sh7372_a3sm_valid(&msk, &msk2)) {
+
+		/* convert INTC mask and sense to SYSC mask and sense */
+		sh7372_setup_a3sm(msk, msk2);
+
+		/* enter A3SM sleep with PLLC0 off */
+		pr_debug("entering A3SM\n");
+		sh7372_enter_a3sm_common(0);
+	} else {
+		/* default to Core Standby that supports all wakeup sources */
+		pr_debug("entering Core Standby\n");
+		sh7372_enter_core_standby();
+	}
 	return 0;
 }
=20
@@ -249,9 +445,6 @@ static void sh7372_suspend_init(void)
 static void sh7372_suspend_init(void) {}
 #endif
=20
-#define DBGREG1 0xe6100020
-#define DBGREG9 0xe6100040
-
 void __init sh7372_pm_init(void)
 {
 	/* enable DBG hardware block to kick SYSC */
--- 0002/arch/arm/mach-shmobile/sleep-sh7372.S
+++ work/arch/arm/mach-shmobile/sleep-sh7372.S	2011-08-26 13:19:38.00000000=
0 +0900
@@ -36,7 +36,58 @@
=20
 	.align	12
 	.text
-	.global sh7372_resume_core_standby
-sh7372_resume_core_standby:
+	.global sh7372_resume_core_standby_a3sm
+sh7372_resume_core_standby_a3sm:
 	ldr     pc, 1f
 1:	.long   cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
+
+	.global	sh7372_do_idle_a3sm
+sh7372_do_idle_a3sm:
+	/*
+ 	 * Clear the SCTLR.C bit to prevent further data cache
+	 * allocation. Clearing SCTLR.C would make all the data accesses
+	 * strongly ordered and would not hit the cache.
+	 */
+	mrc	p15, 0, r0, c1, c0, 0
+	bic	r0, r0, #(1 << 2)	@ Disable the C bit
+	mcr	p15, 0, r0, c1, c0, 0
+	isb
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
+1:
+	b      1b
+
+kernel_flush:
+	.word v7_flush_dcache_all
