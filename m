From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 Apr 2008 12:30:09 +0000
Subject: [PATCH] sh: unify external irq pin code for sh3
Message-Id: <20080424123009.19634.73951.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch unifies the sh3 external irq pin code. It buys us some
savings with reduced code redundancy, but the main feature with
this change is irq sense selection support for all sh3 processors.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh3/Makefile       |    2 -
 arch/sh/kernel/cpu/sh3/setup-sh3.c    |   64 +++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh3/setup-sh7705.c |   20 +---------
 arch/sh/kernel/cpu/sh3/setup-sh770x.c |   32 ++--------------
 arch/sh/kernel/cpu/sh3/setup-sh7710.c |   20 +---------
 arch/sh/kernel/cpu/sh3/setup-sh7720.c |   31 +--------------
 include/asm-sh/hw_irq.h               |    3 +
 7 files changed, 78 insertions(+), 94 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh3/Makefile
+++ work/arch/sh/kernel/cpu/sh3/Makefile	2008-04-24 16:52:23.000000000 +0900
@@ -2,7 +2,7 @@
 # Makefile for the Linux/SuperH SH-3 backends.
 #
 
-obj-y	:= ex.o probe.o entry.o
+obj-y	:= ex.o probe.o entry.o setup-sh3.o
 
 # CPU subtype setup
 obj-$(CONFIG_CPU_SUBTYPE_SH7705)	+= setup-sh7705.o
--- /dev/null
+++ work/arch/sh/kernel/cpu/sh3/setup-sh3.c	2008-04-24 17:18:55.000000000 +0900
@@ -0,0 +1,64 @@
+/*
+ * Shared SH3 Setup code
+ *
+ *  Copyright (C) 2008  Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+/* All SH3 devices are equipped with IRQ0->5 (except sh7708) */
+
+enum {
+	UNUSED = 0,
+
+	/* interrupt sources */
+	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5,
+};
+
+static struct intc_vect vectors_irq0123[] __initdata = {
+	INTC_VECT(IRQ0, 0x600), INTC_VECT(IRQ1, 0x620),
+	INTC_VECT(IRQ2, 0x640), INTC_VECT(IRQ3, 0x660),
+};
+
+static struct intc_vect vectors_irq45[] __initdata = {
+	INTC_VECT(IRQ4, 0x680), INTC_VECT(IRQ5, 0x6a0),
+};
+
+static struct intc_prio_reg prio_registers[] __initdata = {
+	{ 0xa4000016, 0, 16, 4, /* IPRC */ { IRQ3, IRQ2, IRQ1, IRQ0 } },
+	{ 0xa4000018, 0, 16, 4, /* IPRD */ { 0, 0, IRQ5, IRQ4 } },
+};
+
+static struct intc_sense_reg sense_registers[] __initdata = {
+	{ 0xa4000010, 16, 2, { 0, 0, IRQ5, IRQ4, IRQ3, IRQ2, IRQ1, IRQ0 } },
+};
+
+static DECLARE_INTC_DESC(intc_desc_irq0123, "sh3-irq0123", vectors_irq0123,
+			 NULL, NULL, prio_registers, sense_registers);
+
+static DECLARE_INTC_DESC(intc_desc_irq45, "sh3-irq45", vectors_irq45,
+			 NULL, NULL, prio_registers, sense_registers);
+
+#define INTC_ICR1		0xa4000010UL
+#define INTC_ICR1_IRQLVL	(1<<14)
+
+void __init plat_irq_setup_pins(int mode)
+{
+	if (mode = IRQ_MODE_IRQ) {
+		ctrl_outw(ctrl_inw(INTC_ICR1) & ~INTC_ICR1_IRQLVL, INTC_ICR1);
+		register_intc_controller(&intc_desc_irq0123);
+		return;
+	}
+	BUG();
+}
+
+void __init plat_irq_setup_sh3(void)
+{
+	register_intc_controller(&intc_desc_irq45);
+}
--- 0004/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7705.c	2008-04-24 17:00:09.000000000 +0900
@@ -37,7 +37,7 @@ enum {
 };
 
 static struct intc_vect vectors[] __initdata = {
-	INTC_VECT(IRQ4, 0x680), INTC_VECT(IRQ5, 0x6a0),
+	/* IRQ0->5 are handled in setup-sh3.c */
 	INTC_VECT(PINT07, 0x700), INTC_VECT(PINT815, 0x720),
 	INTC_VECT(DMAC_DEI0, 0x800), INTC_VECT(DMAC_DEI1, 0x820),
 	INTC_VECT(DMAC_DEI2, 0x840), INTC_VECT(DMAC_DEI3, 0x860),
@@ -81,14 +81,6 @@ static struct intc_prio_reg prio_registe
 static DECLARE_INTC_DESC(intc_desc, "sh7705", vectors, groups,
 			 NULL, prio_registers, NULL);
 
-static struct intc_vect vectors_irq[] __initdata = {
-	INTC_VECT(IRQ0, 0x600), INTC_VECT(IRQ1, 0x620),
-	INTC_VECT(IRQ2, 0x640), INTC_VECT(IRQ3, 0x660),
-};
-
-static DECLARE_INTC_DESC(intc_desc_irq, "sh7705-irq", vectors_irq, NULL,
-			 NULL, prio_registers, NULL);
-
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xa4410000,
@@ -159,16 +151,8 @@ static int __init sh7705_devices_setup(v
 }
 __initcall(sh7705_devices_setup);
 
-void __init plat_irq_setup_pins(int mode)
-{
-	if (mode = IRQ_MODE_IRQ) {
-		register_intc_controller(&intc_desc_irq);
-		return;
-	}
-	BUG();
-}
-
 void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
+	plat_irq_setup_sh3();
 }
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh770x.c	2008-04-24 17:07:19.000000000 +0900
@@ -52,7 +52,7 @@ static struct intc_vect vectors[] __init
 #if defined(CONFIG_CPU_SUBTYPE_SH7706) || \
     defined(CONFIG_CPU_SUBTYPE_SH7707) || \
     defined(CONFIG_CPU_SUBTYPE_SH7709)
-	INTC_VECT(IRQ4, 0x680), INTC_VECT(IRQ5, 0x6a0),
+	/* IRQ0->5 are handled in setup-sh3.c */
 	INTC_VECT(DMAC_DEI0, 0x800), INTC_VECT(DMAC_DEI1, 0x820),
 	INTC_VECT(DMAC_DEI2, 0x840), INTC_VECT(DMAC_DEI3, 0x860),
 	INTC_VECT(ADC_ADI, 0x980),
@@ -104,18 +104,6 @@ static struct intc_prio_reg prio_registe
 static DECLARE_INTC_DESC(intc_desc, "sh770x", vectors, groups,
 			 NULL, prio_registers, NULL);
 
-#if defined(CONFIG_CPU_SUBTYPE_SH7706) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7707) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7709)
-static struct intc_vect vectors_irq[] __initdata = {
-	INTC_VECT(IRQ0, 0x600), INTC_VECT(IRQ1, 0x620),
-	INTC_VECT(IRQ2, 0x640), INTC_VECT(IRQ3, 0x660),
-};
-
-static DECLARE_INTC_DESC(intc_desc_irq, "sh770x-irq", vectors_irq, NULL,
-			 NULL, prio_registers, NULL);
-#endif
-
 static struct resource rtc_resources[] = {
 	[0] =	{
 		.start	= 0xfffffec0,
@@ -194,24 +182,12 @@ static int __init sh770x_devices_setup(v
 }
 __initcall(sh770x_devices_setup);
 
-#define INTC_ICR1		0xa4000010UL
-#define INTC_ICR1_IRQLVL	(1<<14)
-
-void __init plat_irq_setup_pins(int mode)
+void __init plat_irq_setup(void)
 {
-	if (mode = IRQ_MODE_IRQ) {
+	register_intc_controller(&intc_desc);
 #if defined(CONFIG_CPU_SUBTYPE_SH7706) || \
     defined(CONFIG_CPU_SUBTYPE_SH7707) || \
     defined(CONFIG_CPU_SUBTYPE_SH7709)
-		ctrl_outw(ctrl_inw(INTC_ICR1) & ~INTC_ICR1_IRQLVL, INTC_ICR1);
-		register_intc_controller(&intc_desc_irq);
-		return;
+	plat_irq_setup_sh3();
 #endif
-	}
-	BUG();
-}
-
-void __init plat_irq_setup(void)
-{
-	register_intc_controller(&intc_desc);
 }
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7710.c	2008-04-24 17:04:32.000000000 +0900
@@ -38,7 +38,7 @@ enum {
 };
 
 static struct intc_vect vectors[] __initdata = {
-	INTC_VECT(IRQ4, 0x680), INTC_VECT(IRQ5, 0x6a0),
+	/* IRQ0->5 are handled in setup-sh3.c */
 	INTC_VECT(DMAC_DEI0, 0x800), INTC_VECT(DMAC_DEI1, 0x820),
 	INTC_VECT(DMAC_DEI2, 0x840), INTC_VECT(DMAC_DEI3, 0x860),
 	INTC_VECT(SCIF0_ERI, 0x880), INTC_VECT(SCIF0_RXI, 0x8a0),
@@ -91,14 +91,6 @@ static struct intc_prio_reg prio_registe
 static DECLARE_INTC_DESC(intc_desc, "sh7710", vectors, groups,
 			 NULL, prio_registers, NULL);
 
-static struct intc_vect vectors_irq[] __initdata = {
-	INTC_VECT(IRQ0, 0x600), INTC_VECT(IRQ1, 0x620),
-	INTC_VECT(IRQ2, 0x640), INTC_VECT(IRQ3, 0x660),
-};
-
-static DECLARE_INTC_DESC(intc_desc_irq, "sh7710-irq", vectors_irq, NULL,
-			 NULL, prio_registers, NULL);
-
 static struct resource rtc_resources[] = {
 	[0] =	{
 		.start	= 0xa413fec0,
@@ -170,16 +162,8 @@ static int __init sh7710_devices_setup(v
 }
 __initcall(sh7710_devices_setup);
 
-void __init plat_irq_setup_pins(int mode)
-{
-	if (mode = IRQ_MODE_IRQ) {
-		register_intc_controller(&intc_desc_irq);
-		return;
-	}
-	BUG();
-}
-
 void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
+	plat_irq_setup_sh3();
 }
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7720.c	2008-04-24 17:08:14.000000000 +0900
@@ -19,10 +19,6 @@
 #include <linux/serial_sci.h>
 #include <asm/rtc.h>
 
-#define INTC_ICR1	0xA4140010UL
-#define INTC_ICR_IRLM   0x4000
-#define INTC_ICR_IRQ	(~INTC_ICR_IRLM)
-
 static struct resource rtc_resources[] = {
 	[0] = {
 		.start	= 0xa413fec0,
@@ -170,6 +166,7 @@ enum {
 };
 
 static struct intc_vect vectors[] __initdata = {
+	/* IRQ0->5 are handled in setup-sh3.c */
 	INTC_VECT(TMU0, 0x400),       INTC_VECT(TMU1, 0x420),
 	INTC_VECT(TMU2, 0x440),       INTC_VECT(RTC_ATI, 0x480),
 	INTC_VECT(RTC_PRI, 0x4a0),    INTC_VECT(RTC_CUI, 0x4c0),
@@ -229,32 +226,8 @@ static struct intc_prio_reg prio_registe
 static DECLARE_INTC_DESC(intc_desc, "sh7720", vectors, groups,
 		NULL, prio_registers, NULL);
 
-static struct intc_sense_reg sense_registers[] __initdata = {
-	{ INTC_ICR1, 16, 2, { 0, 0, IRQ5, IRQ4, IRQ3, IRQ2, IRQ1, IRQ0 } },
-};
-
-static struct intc_vect vectors_irq[] __initdata = {
-	INTC_VECT(IRQ0, 0x600), INTC_VECT(IRQ1, 0x620),
-	INTC_VECT(IRQ2, 0x640), INTC_VECT(IRQ3, 0x660),
-	INTC_VECT(IRQ4, 0x680), INTC_VECT(IRQ5, 0x6a0),
-};
-
-static DECLARE_INTC_DESC(intc_irq_desc, "sh7720-irq", vectors_irq,
-		NULL, NULL, prio_registers, sense_registers);
-
-void __init plat_irq_setup_pins(int mode)
-{
-	switch (mode) {
-	case IRQ_MODE_IRQ:
-		ctrl_outw(ctrl_inw(INTC_ICR1) & INTC_ICR_IRQ, INTC_ICR1);
-		register_intc_controller(&intc_irq_desc);
-		break;
-	default:
-		BUG();
-	}
-}
-
 void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
+	plat_irq_setup_sh3();
 }
--- 0001/include/asm-sh/hw_irq.h
+++ work/include/asm-sh/hw_irq.h	2008-04-24 17:19:33.000000000 +0900
@@ -95,6 +95,9 @@ void __init register_intc_controller(str
 int intc_set_priority(unsigned int irq, unsigned int prio);
 
 void __init plat_irq_setup(void);
+#ifdef CONFIG_CPU_SH3
+void __init plat_irq_setup_sh3(void);
+#endif
 
 enum { IRQ_MODE_IRQ, IRQ_MODE_IRQ7654, IRQ_MODE_IRQ3210,
        IRQ_MODE_IRL7654_MASK, IRQ_MODE_IRL3210_MASK,
