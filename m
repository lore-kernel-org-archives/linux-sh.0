From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 18 Dec 2011 16:59:20 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 A4S support
Message-Id: <20111218165920.20402.41644.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add support for the sh7372 A4S power domain / sleep mode.

The sh7372 contains a power domain named A4S which in turn
contains power domains for both I/O Devices and CPU cores.

At this point only System wide Suspend-to-RAM is supported,
but the the hardware can also support CPUIdle. With more
efforts in the future CPUIdle can work with bot A4S and A3SM.

Tested on the sh7372 Mackerel board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    4 -
 arch/arm/mach-shmobile/include/mach/sh7372.h |    3 +
 arch/arm/mach-shmobile/intc-sh7372.c         |   49 ++++++++++++++++++++
 arch/arm/mach-shmobile/pm-sh7372.c           |   63 ++++++++++++++++++----=
----
 arch/arm/mach-shmobile/setup-sh7372.c        |    6 ++
 arch/arm/mach-shmobile/sleep-sh7372.S        |   21 ++++----
 6 files changed, 116 insertions(+), 30 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2011-12-19 01:35:31.0=
00000000 +0900
@@ -35,8 +35,8 @@ extern void sh7372_add_standard_devices(
 extern void sh7372_clock_init(void);
 extern void sh7372_pinmux_init(void);
 extern void sh7372_pm_init(void);
-extern void sh7372_resume_core_standby_a3sm(void);
-extern int sh7372_do_idle_a3sm(unsigned long unused);
+extern void sh7372_resume_core_standby_sysc(void);
+extern int sh7372_do_idle_sysc(unsigned long sleep_mode);
 extern struct clk sh7372_extal1_clk;
 extern struct clk sh7372_extal2_clk;
=20
--- 0001/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2011-12-19 01:35:31.0=
00000000 +0900
@@ -499,6 +499,7 @@ extern struct sh7372_pm_domain sh7372_d4
 extern struct sh7372_pm_domain sh7372_a4r;
 extern struct sh7372_pm_domain sh7372_a3rv;
 extern struct sh7372_pm_domain sh7372_a3ri;
+extern struct sh7372_pm_domain sh7372_a4s;
 extern struct sh7372_pm_domain sh7372_a3sp;
 extern struct sh7372_pm_domain sh7372_a3sg;
=20
@@ -515,5 +516,7 @@ extern void sh7372_pm_add_subdomain(stru
=20
 extern void sh7372_intcs_suspend(void);
 extern void sh7372_intcs_resume(void);
+extern void sh7372_intca_suspend(void);
+extern void sh7372_intca_resume(void);
=20
 #endif /* __ASM_SH7372_H__ */
--- 0001/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2011-12-19 01:35:31.000000000=
 +0900
@@ -611,3 +611,52 @@ void sh7372_intcs_resume(void)
 	for (k =3D 0x80; k <=3D 0x9c; k +=3D 4)
 		__raw_writeb(ffd5[k], intcs_ffd5 + k);
 }
+
+static unsigned short e694[0x200];
+static unsigned short e695[0x200];
+
+void sh7372_intca_suspend(void)
+{
+	int k;
+
+	for (k =3D 0x00; k <=3D 0x38; k +=3D 4)
+		e694[k] =3D __raw_readw(0xe6940000 + k);
+
+	for (k =3D 0x80; k <=3D 0xb4; k +=3D 4)
+		e694[k] =3D __raw_readb(0xe6940000 + k);
+
+	for (k =3D 0x180; k <=3D 0x1b4; k +=3D 4)
+		e694[k] =3D __raw_readb(0xe6940000 + k);
+
+	for (k =3D 0x00; k <=3D 0x50; k +=3D 4)
+		e695[k] =3D __raw_readw(0xe6950000 + k);
+
+	for (k =3D 0x80; k <=3D 0xa8; k +=3D 4)
+		e695[k] =3D __raw_readb(0xe6950000 + k);
+
+	for (k =3D 0x180; k <=3D 0x1a8; k +=3D 4)
+		e695[k] =3D __raw_readb(0xe6950000 + k);
+}
+
+void sh7372_intca_resume(void)
+{
+	int k;
+
+	for (k =3D 0x00; k <=3D 0x38; k +=3D 4)
+		__raw_writew(e694[k], 0xe6940000 + k);
+
+	for (k =3D 0x80; k <=3D 0xb4; k +=3D 4)
+		__raw_writeb(e694[k], 0xe6940000 + k);
+
+	for (k =3D 0x180; k <=3D 0x1b4; k +=3D 4)
+		__raw_writeb(e694[k], 0xe6940000 + k);
+
+	for (k =3D 0x00; k <=3D 0x50; k +=3D 4)
+		__raw_writew(e695[k], 0xe6950000 + k);
+
+	for (k =3D 0x80; k <=3D 0xa8; k +=3D 4)
+		__raw_writeb(e695[k], 0xe6950000 + k);
+
+	for (k =3D 0x180; k <=3D 0x1a8; k +=3D 4)
+		__raw_writeb(e695[k], 0xe6950000 + k);
+}
--- 0001/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-12-19 01:48:09.000000000 +=
0900
@@ -226,6 +226,13 @@ struct sh7372_pm_domain sh7372_a3ri =3D {
 	.bit_shift =3D 8,
 };
=20
+struct sh7372_pm_domain sh7372_a4s =3D {
+	.bit_shift =3D 10,
+	.gov =3D &sh7372_always_on_gov,
+	.no_debug =3D true,
+	.stay_on =3D true,
+};
+
 struct sh7372_pm_domain sh7372_a3sp =3D {
 	.bit_shift =3D 11,
 	.gov =3D &sh7372_always_on_gov,
@@ -257,11 +264,16 @@ static int sh7372_do_idle_core_standby(u
 	return 0;
 }
=20
-static void sh7372_enter_core_standby(void)
+static void sh7372_set_reset_vector(unsigned long address)
 {
 	/* set reset vector, translate 4k */
-	__raw_writel(__pa(sh7372_resume_core_standby_a3sm), SBAR);
+	__raw_writel(address, SBAR);
 	__raw_writel(0, APARMBAREA);
+}
+
+static void sh7372_enter_core_standby(void)
+{
+	sh7372_set_reset_vector(__pa(sh7372_resume_core_standby_sysc));
=20
 	/* enter sleep mode with SYSTBCR to 0x10 */
 	__raw_writel(0x10, SYSTBCR);
@@ -274,27 +286,22 @@ static void sh7372_enter_core_standby(vo
 #endif
=20
 #ifdef CONFIG_SUSPEND
-static void sh7372_enter_a3sm_common(int pllc0_on)
+static void sh7372_enter_sysc(int pllc0_on, unsigned long sleep_mode)
 {
-	/* set reset vector, translate 4k */
-	__raw_writel(__pa(sh7372_resume_core_standby_a3sm), SBAR);
-	__raw_writel(0, APARMBAREA);
-
 	if (pllc0_on)
 		__raw_writel(0, PLLC01STPCR);
 	else
 		__raw_writel(1 << 28, PLLC01STPCR);
=20
-	__raw_writel(0, PDNSEL); /* power-down A3SM only, not A4S */
 	__raw_readl(WUPSFAC); /* read wakeup int. factor before sleep */
-	cpu_suspend(0, sh7372_do_idle_a3sm);
+	cpu_suspend(sleep_mode, sh7372_do_idle_sysc);
 	__raw_readl(WUPSFAC); /* read wakeup int. factor after wakeup */
=20
 	 /* disable reset vector translation */
 	__raw_writel(0, SBAR);
 }
=20
-static int sh7372_a3sm_valid(unsigned long *mskp, unsigned long *msk2p)
+static int sh7372_sysc_valid(unsigned long *mskp, unsigned long *msk2p)
 {
 	unsigned long mstpsr0, mstpsr1, mstpsr2, mstpsr3, mstpsr4;
 	unsigned long msk, msk2;
@@ -382,7 +389,7 @@ static void sh7372_icr_to_irqcr(unsigned
 	*irqcr2p =3D irqcr2;
 }
=20
-static void sh7372_setup_a3sm(unsigned long msk, unsigned long msk2)
+static void sh7372_setup_sysc(unsigned long msk, unsigned long msk2)
 {
 	u16 irqcrx_low, irqcrx_high, irqcry_low, irqcry_high;
 	unsigned long tmp;
@@ -415,6 +422,22 @@ static void sh7372_setup_a3sm(unsigned l
 	__raw_writel((irqcrx_high << 16) | irqcrx_low, IRQCR3);
 	__raw_writel((irqcry_high << 16) | irqcry_low, IRQCR4);
 }
+
+static void sh7372_enter_a3sm_common(int pllc0_on)
+{
+	sh7372_set_reset_vector(__pa(sh7372_resume_core_standby_sysc));
+	sh7372_enter_sysc(pllc0_on, 1 << 12);
+}
+
+static void sh7372_enter_a4s_common(int pllc0_on)
+{
+	sh7372_intca_suspend();
+	memcpy((void *)SMFRAM, sh7372_resume_core_standby_sysc, 0x100);
+	sh7372_set_reset_vector(SMFRAM);
+	sh7372_enter_sysc(pllc0_on, 1 << 10);
+	sh7372_intca_resume();
+}
+
 #endif
=20
 #ifdef CONFIG_CPU_IDLE
@@ -448,14 +471,20 @@ static int sh7372_enter_suspend(suspend_
 	unsigned long msk, msk2;
=20
 	/* check active clocks to determine potential wakeup sources */
-	if (sh7372_a3sm_valid(&msk, &msk2)) {
-
+	if (sh7372_sysc_valid(&msk, &msk2)) {
 		/* convert INTC mask and sense to SYSC mask and sense */
-		sh7372_setup_a3sm(msk, msk2);
+		sh7372_setup_sysc(msk, msk2);
=20
-		/* enter A3SM sleep with PLLC0 off */
-		pr_debug("entering A3SM\n");
-		sh7372_enter_a3sm_common(0);
+		if (!sh7372_a3sp.stay_on &&
+		    sh7372_a4s.genpd.status =3D GPD_STATE_POWER_OFF) {
+			/* enter A4S sleep with PLLC0 off */
+			pr_debug("entering A4S\n");
+			sh7372_enter_a4s_common(0);
+		} else {
+			/* enter A3SM sleep with PLLC0 off */
+			pr_debug("entering A3SM\n");
+			sh7372_enter_a3sm_common(0);
+		}
 	} else {
 		/* default to Core Standby that supports all wakeup sources */
 		pr_debug("entering Core Standby\n");
--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-12-19 01:35:31.00000000=
0 +0900
@@ -994,12 +994,16 @@ void __init sh7372_add_standard_devices(
 	sh7372_init_pm_domain(&sh7372_a4r);
 	sh7372_init_pm_domain(&sh7372_a3rv);
 	sh7372_init_pm_domain(&sh7372_a3ri);
-	sh7372_init_pm_domain(&sh7372_a3sg);
+	sh7372_init_pm_domain(&sh7372_a4s);
 	sh7372_init_pm_domain(&sh7372_a3sp);
+	sh7372_init_pm_domain(&sh7372_a3sg);
=20
 	sh7372_pm_add_subdomain(&sh7372_a4lc, &sh7372_a3rv);
 	sh7372_pm_add_subdomain(&sh7372_a4r, &sh7372_a4lc);
=20
+	sh7372_pm_add_subdomain(&sh7372_a4s, &sh7372_a3sg);
+	sh7372_pm_add_subdomain(&sh7372_a4s, &sh7372_a3sp);
+
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
=20
--- 0001/arch/arm/mach-shmobile/sleep-sh7372.S
+++ work/arch/arm/mach-shmobile/sleep-sh7372.S	2011-12-19 01:47:37.00000000=
0 +0900
@@ -37,13 +37,18 @@
 #if defined(CONFIG_SUSPEND) || defined(CONFIG_CPU_IDLE)
 	.align	12
 	.text
-	.global sh7372_resume_core_standby_a3sm
-sh7372_resume_core_standby_a3sm:
+	.global sh7372_resume_core_standby_sysc
+sh7372_resume_core_standby_sysc:
 	ldr     pc, 1f
 1:	.long   cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
=20
-	.global	sh7372_do_idle_a3sm
-sh7372_do_idle_a3sm:
+#define SPDCR 0xe6180008
+
+	/* A3SM & A4S power down */
+	.global	sh7372_do_idle_sysc
+sh7372_do_idle_sysc:
+	mov	r8, r0 /* sleep mode passed in r0 */
+
 	/*
 	 * Clear the SCTLR.C bit to prevent further data cache
 	 * allocation. Clearing SCTLR.C would make all the data accesses
@@ -80,13 +85,9 @@ sh7372_do_idle_a3sm:
 	dsb
 	dmb
=20
-#define SPDCR 0xe6180008
-#define A3SM (1 << 12)
-
-	/* A3SM power down */
+	/* SYSC power down */
 	ldr     r0, =3DSPDCR
-	ldr     r1, =A3SM
-	str     r1, [r0]
+	str     r8, [r0]
 1:
 	b      1b
=20
