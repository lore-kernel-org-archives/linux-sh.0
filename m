From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Mar 2012 10:23:11 +0000
Subject: [PATCH 06/06] ARM: mach-shmobile: Rework sh7372 INTCS demuxer V2
Message-Id: <20120328102311.18870.79756.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20120328064105.28557.57736.sendpatchset@w520>
In-Reply-To: <20120328064105.28557.57736.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch is the sh7372 INTC demux rework V2.

Updates the sh7372 INTCS demuxer to not hook into
the INTCA interrupt controller. The mask register
for the chained INTCS interrupt source happens
to be located in the INTCS register range instead of
the INTCA as expected. To allow each INTCA and INTCS
interrupt controller to work in their own IRQ range
this patch moves the INTCS vector away.

Needed for future IRQ domain support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - Use dummy_irq_chip, thanks Paul!

 arch/arm/mach-shmobile/intc-sh7372.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- 0006/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2012-03-28 17:09:01.000000000 +0900
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/sh_intc.h>
@@ -314,8 +315,6 @@ enum {
 	UNUSED_INTCS = 0,
 	ENABLED_INTCS,
 
-	INTCS,
-
 	/* interrupt sources INTCS */
 
 	/* IRQ0S - IRQ31S */
@@ -429,8 +428,6 @@ static struct intc_vect intcs_vectors[]
 	INTCS_VECT(CPORTS2R, 0x1a20),
 	/* CEC */
 	INTCS_VECT(JPU6E, 0x1a80),
-
-	INTC_VECT(INTCS, 0xf80),
 };
 
 static struct intc_group intcs_groups[] __initdata = {
@@ -493,9 +490,6 @@ static struct intc_mask_reg intcs_mask_r
 	{ 0xffd5019c, 0xffd501dc, 8, /* IMR7SA3 / IMCR7SA3 */
 	  { MFIS2_INTCS, CPORTS2R, 0, 0,
 	    JPU6E, 0, 0, 0 } },
-	{ 0xffd20104, 0, 16, /* INTAMASK */
-	  { 0, 0, 0, 0, 0, 0, 0, 0,
-	    0, 0, 0, 0, 0, 0, 0, INTCS } },
 };
 
 /* Priority is needed for INTCA to receive the INTCS interrupt */
@@ -560,6 +554,7 @@ static void __iomem *intcs_ffd5;
 void __init sh7372_init_irq(void)
 {
 	void __iomem *intevtsa;
+	int n;
 
 	intcs_ffd2 = ioremap_nocache(0xffd20000, PAGE_SIZE);
 	intevtsa = intcs_ffd2 + 0x100;
@@ -570,9 +565,19 @@ void __init sh7372_init_irq(void)
 	register_intc_controller(&intca_irq_pins_hi_desc);
 	register_intc_controller(&intcs_desc);
 
+	/* setup dummy cascade chip for INTCS */
+	n = evt2irq(0xf80);
+	irq_alloc_desc_at(n, numa_node_id());
+	irq_set_chip_and_handler_name(n, &dummy_irq_chip,
+				      handle_level_irq, "level");
+	set_irq_flags(n, IRQF_VALID); /* yuck */
+
 	/* demux using INTEVTSA */
-	irq_set_handler_data(evt2irq(0xf80), (void *)intevtsa);
-	irq_set_chained_handler(evt2irq(0xf80), intcs_demux);
+	irq_set_handler_data(n, (void *)intevtsa);
+	irq_set_chained_handler(n, intcs_demux);
+
+	/* unmask INTCS in INTAMASK */
+	iowrite16(0, intcs_ffd2 + 0x104);
 }
 
 static unsigned short ffd2[0x200];
