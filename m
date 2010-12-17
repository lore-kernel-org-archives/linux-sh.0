From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 17 Dec 2010 06:15:48 +0000
Subject: [PATCH] ARM: mach-shmobile: INTC interrupt priority level demux fix
Message-Id: <20101217061548.26708.13030.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix interrupt priority level handling on SH-Mobile ARM.

SH-Mobile ARM platforms using multiple interrupt priority
levels need this patch to fix a potential dead lock that
may occur if multiple interrupts with different levels
are pending simultaneously.

The default INTC configuration is to use the same priority
level for all interrupts, so this issue does not trigger by
default. It is however common for board code to override the
interrupt priority for certain interrupt sources depending
on the application. Without this fix such boards may lock up.

In detail, this patch updates the INTC code in entry-macro.S
to make sure that the INTLVLA register gets set as expected.

To trigger this bug modify the board specific code to adjust
the interrupt priority level for the ethernet chip. After
changing the priority level simply use flood ping to drown
the board with interrupts.

This patch applies to INTCA-based processors such as sh7372,
sh7377 and sh7372. GIC-based processors are not affected.

Suitable for v2.6.37-rc and stable from v2.6.34 to v2.6.36.

Cc: stable@kernel.org
Signed-off-by: Magnus Damm <damm@opensource.se>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---

 arch/arm/mach-shmobile/include/mach/entry-macro.S |   30 ++++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ work/arch/arm/mach-shmobile/include/mach/entry-macro.S	2010-12-17 13:33:58.000000000 +0900
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2010 Magnus Damm
  * Copyright (C) 2008 Renesas Solutions Corp.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -14,24 +15,45 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 
+#define INTCA_BASE	0xe6980000
+#define INTFLGA_OFFS	0x00000018 /* accept pending interrupt */
+#define INTEVTA_OFFS	0x00000020 /* vector number of accepted interrupt */
+#define INTLVLA_OFFS	0x00000030 /* priority level of accepted interrupt */
+#define INTLVLB_OFFS	0x00000034 /* previous priority level */
+
 	.macro  disable_fiq
 	.endm
 
 	.macro  get_irqnr_preamble, base, tmp
-	ldr     \base, =INTFLGA
+	ldr     \base, =INTCA_BASE
 	.endm
 
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
 
 	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr     \irqnr, [\base]
+	/* The single INTFLGA read access below results in the following:
+	 *
+	 * 1. INTLVLB is updated with old priority value from INTLVLA
+	 * 2. Highest priority interrupt is accepted
+	 * 3. INTLVLA is updated to contain priority of accepted interrupt
+	 * 4. Accepted interrupt vector is stored in INTFLGA and INTEVTA
+	 */
+	ldr     \irqnr, [\base, #INTFLGA_OFFS]
+
+	/* Restore INTLVLA with the value saved in INTLVLB.
+	 * This is required to support interrupt priorities properly.
+	 */
+	ldrb	\tmp, [\base, #INTLVLB_OFFS]
+	strb    \tmp, [\base, #INTLVLA_OFFS]
+
+	/* Handle invalid vector number case */
 	cmp	\irqnr, #0
 	beq	1000f
-	/* intevt to irq number */
+
+	/* Convert vector to irq number, same as the evt2irq() macro */
 	lsr	\irqnr, \irqnr, #0x5
 	subs	\irqnr, \irqnr, #16
 
