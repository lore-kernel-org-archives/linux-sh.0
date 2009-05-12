From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 May 2009 09:34:26 +0000
Subject: [PATCH] sh: add sh4-202 INTC tables
Message-Id: <20090512093426.25188.25549.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds INTC tables for sh4-202 with support
for HUDI, TMU0, TMU1, TMU2, RTC, SCIF and WDT.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   56 +++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

--- 0010/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh4-202.c	2009-05-12 17:00:17.000000000 +0900
@@ -2,6 +2,7 @@
  * SH4-202 Setup
  *
  *  Copyright (C) 2006  Paul Mundt
+ *  Copyright (C) 2009  Magnus Damm
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -12,6 +13,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
+#include <linux/io.h>
 
 static struct plat_sci_port sci_platform_data[] = {
 	{
@@ -150,7 +152,59 @@ void __init plat_early_device_setup(void
 				   ARRAY_SIZE(sh4202_early_devices));
 }
 
+enum {
+	UNUSED = 0,
+
+	/* interrupt sources */
+	IRL0, IRL1, IRL2, IRL3, /* only IRLM mode supported */
+	HUDI, TMU0, TMU1, TMU2, RTC, SCIF, WDT,
+};
+
+static struct intc_vect vectors[] __initdata = {
+	INTC_VECT(HUDI, 0x600),
+	INTC_VECT(TMU0, 0x400), INTC_VECT(TMU1, 0x420),
+	INTC_VECT(TMU2, 0x440), INTC_VECT(TMU2, 0x460),
+	INTC_VECT(RTC, 0x480), INTC_VECT(RTC, 0x4a0),
+	INTC_VECT(RTC, 0x4c0),
+	INTC_VECT(SCIF, 0x700), INTC_VECT(SCIF, 0x720),
+	INTC_VECT(SCIF, 0x740), INTC_VECT(SCIF, 0x760),
+	INTC_VECT(WDT, 0x560),
+};
+
+static struct intc_prio_reg prio_registers[] __initdata = {
+	{ 0xffd00004, 0, 16, 4, /* IPRA */ { TMU0, TMU1, TMU2, RTC } },
+	{ 0xffd00008, 0, 16, 4, /* IPRB */ { WDT, 0, 0, 0 } },
+	{ 0xffd0000c, 0, 16, 4, /* IPRC */ { 0, 0, SCIF, HUDI } },
+	{ 0xffd00010, 0, 16, 4, /* IPRD */ { IRL0, IRL1, IRL2, IRL3 } },
+};
+
+static DECLARE_INTC_DESC(intc_desc, "sh4-202", vectors, NULL,
+			 NULL, prio_registers, NULL);
+
+static struct intc_vect vectors_irlm[] __initdata = {
+	INTC_VECT(IRL0, 0x240), INTC_VECT(IRL1, 0x2a0),
+	INTC_VECT(IRL2, 0x300), INTC_VECT(IRL3, 0x360),
+};
+
+static DECLARE_INTC_DESC(intc_desc_irlm, "sh4-202_irlm", vectors_irlm, NULL,
+			 NULL, prio_registers, NULL);
+
 void __init plat_irq_setup(void)
 {
-	/* do nothing - all IRL interrupts are handled by the board code */
+	register_intc_controller(&intc_desc);
+}
+
+#define INTC_ICR	0xffd00000UL
+#define INTC_ICR_IRLM   (1<<7)
+
+void __init plat_irq_setup_pins(int mode)
+{
+	switch (mode) {
+	case IRQ_MODE_IRQ: /* individual interrupt mode for IRL3-0 */
+		ctrl_outw(ctrl_inw(INTC_ICR) | INTC_ICR_IRLM, INTC_ICR);
+		register_intc_controller(&intc_desc_irlm);
+		break;
+	default:
+		BUG();
+	}
 }
