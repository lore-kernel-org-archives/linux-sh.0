From: Matt Fleming <mjf@gentoo.org>
Date: Fri, 28 Nov 2008 08:58:30 +0000
Subject: [PATCH] sh: Switch HD64461 from hw_interrupt_type to irq_chip
Message-Id: <1227862710-11696-1-git-send-email-mjf@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use struct irq_chip for the interrupt handler for the HD64461. Also
convert some in{b,w} and out{b,w} calls to the equivalent __raw_* calls.
Include <linux/io.h> and not <asm/io.h> to stop checkpatch.pl
complaining.

This change should now allow machines with HD64461 to define
GENERIC_HARDIRQS_NO__DO_IRQ.

Acked-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
Signed-off-by: Matt Fleming <mjf@gentoo.org>
---
 arch/sh/cchips/hd6446x/hd64461.c |  115 ++++++++-----------------------------
 1 files changed, 25 insertions(+), 90 deletions(-)

diff --git a/arch/sh/cchips/hd6446x/hd64461.c b/arch/sh/cchips/hd6446x/hd64461.c
index f1a4a07..27ceeb9 100644
--- a/arch/sh/cchips/hd6446x/hd64461.c
+++ b/arch/sh/cchips/hd6446x/hd64461.c
@@ -10,99 +10,49 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/irq.h>
 #include <asm/hd64461.h>
 
 /* This belongs in cpu specific */
 #define INTC_ICR1 0xA4140010UL
 
-static void disable_hd64461_irq(unsigned int irq)
+static void hd64461_mask_irq(unsigned int irq)
 {
 	unsigned short nimr;
 	unsigned short mask = 1 << (irq - HD64461_IRQBASE);
 
-	nimr = inw(HD64461_NIMR);
+	nimr = __raw_readw(HD64461_NIMR);
 	nimr |= mask;
-	outw(nimr, HD64461_NIMR);
+	__raw_writew(nimr, HD64461_NIMR);
 }
 
-static void enable_hd64461_irq(unsigned int irq)
+static void hd64461_unmask_irq(unsigned int irq)
 {
 	unsigned short nimr;
 	unsigned short mask = 1 << (irq - HD64461_IRQBASE);
 
-	nimr = inw(HD64461_NIMR);
+	nimr = __raw_readw(HD64461_NIMR);
 	nimr &= ~mask;
-	outw(nimr, HD64461_NIMR);
+	__raw_writew(nimr, HD64461_NIMR);
 }
 
-static void mask_and_ack_hd64461(unsigned int irq)
+static void hd64461_mask_and_ack_irq(unsigned int irq)
 {
-	disable_hd64461_irq(irq);
+	hd64461_mask_irq(irq);
 #ifdef CONFIG_HD64461_ENABLER
 	if (irq = HD64461_IRQBASE + 13)
-		outb(0x00, HD64461_PCC1CSCR);
+		__raw_writeb(0x00, HD64461_PCC1CSCR);
 #endif
 }
 
-static void end_hd64461_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_hd64461_irq(irq);
-}
-
-static unsigned int startup_hd64461_irq(unsigned int irq)
-{
-	enable_hd64461_irq(irq);
-	return 0;
-}
-
-static void shutdown_hd64461_irq(unsigned int irq)
-{
-	disable_hd64461_irq(irq);
-}
-
-static struct hw_interrupt_type hd64461_irq_type = {
-	.typename	= "HD64461-IRQ",
-	.startup	= startup_hd64461_irq,
-	.shutdown	= shutdown_hd64461_irq,
-	.enable		= enable_hd64461_irq,
-	.disable	= disable_hd64461_irq,
-	.ack		= mask_and_ack_hd64461,
-	.end		= end_hd64461_irq,
+static struct irq_chip hd64461_irq_chip = {
+	.name		= "HD64461-IRQ",
+	.mask		= hd64461_mask_irq,
+	.mask_ack	= hd64461_mask_and_ack_irq,
+	.unmask		= hd64461_unmask_irq,
 };
 
-static irqreturn_t hd64461_interrupt(int irq, void *dev_id)
-{
-	printk(KERN_INFO
-	       "HD64461: spurious interrupt, nirr: 0x%x nimr: 0x%x\n",
-	       inw(HD64461_NIRR), inw(HD64461_NIMR));
-
-	return IRQ_NONE;
-}
-
-static struct {
-	int (*func) (int, void *);
-	void *dev;
-} hd64461_demux[HD64461_IRQ_NUM];
-
-void hd64461_register_irq_demux(int irq,
-				int (*demux) (int irq, void *dev), void *dev)
-{
-	hd64461_demux[irq - HD64461_IRQBASE].func = demux;
-	hd64461_demux[irq - HD64461_IRQBASE].dev = dev;
-}
-
-EXPORT_SYMBOL(hd64461_register_irq_demux);
-
-void hd64461_unregister_irq_demux(int irq)
-{
-	hd64461_demux[irq - HD64461_IRQBASE].func = 0;
-}
-
-EXPORT_SYMBOL(hd64461_unregister_irq_demux);
-
 int hd64461_irq_demux(int irq)
 {
 	if (irq = CONFIG_HD64461_IRQ) {
@@ -115,25 +65,11 @@ int hd64461_irq_demux(int irq)
 		for (bit = 1, i = 0; i < 16; bit <<= 1, i++)
 			if (nirr & bit)
 				break;
-		if (i = 16)
-			irq = CONFIG_HD64461_IRQ;
-		else {
-			irq = HD64461_IRQBASE + i;
-			if (hd64461_demux[i].func != 0) {
-				irq = hd64461_demux[i].func(irq, hd64461_demux[i].dev);
-			}
-		}
+		irq = HD64461_IRQBASE + i;
 	}
 	return irq;
 }
 
-static struct irqaction irq0 = {
-	.handler = hd64461_interrupt,
-	.flags = IRQF_DISABLED,
-	.mask = CPU_MASK_NONE,
-	.name = "HD64461",
-};
-
 int __init setup_hd64461(void)
 {
 	int i;
@@ -146,22 +82,21 @@ int __init setup_hd64461(void)
 	       CONFIG_HD64461_IOBASE, CONFIG_HD64461_IRQ, HD64461_IRQBASE,
 	       HD64461_IRQBASE + 15);
 
-#if defined(CONFIG_CPU_SUBTYPE_SH7709)	/* Should be at processor specific part.. */
-	outw(0x2240, INTC_ICR1);
+/* Should be at processor specific part.. */
+#if defined(CONFIG_CPU_SUBTYPE_SH7709)
+	__raw_writew(0x2240, INTC_ICR1);
 #endif
-	outw(0xffff, HD64461_NIMR);
+	__raw_writew(0xffff, HD64461_NIMR);
 
 	/*  IRQ 80 -> 95 belongs to HD64461  */
-	for (i = HD64461_IRQBASE; i < HD64461_IRQBASE + 16; i++) {
-		irq_desc[i].chip = &hd64461_irq_type;
-	}
-
-	setup_irq(CONFIG_HD64461_IRQ, &irq0);
+	for (i = HD64461_IRQBASE; i < HD64461_IRQBASE + 16; i++)
+		set_irq_chip_and_handler(i, &hd64461_irq_chip,
+					 handle_level_irq);
 
 #ifdef CONFIG_HD64461_ENABLER
 	printk(KERN_INFO "HD64461: enabling PCMCIA devices\n");
-	outb(0x4c, HD64461_PCC1CSCIER);
-	outb(0x00, HD64461_PCC1CSCR);
+	__raw_writeb(0x4c, HD64461_PCC1CSCIER);
+	__raw_writeb(0x00, HD64461_PCC1CSCR);
 #endif
 
 	return 0;
-- 
1.5.6.4

