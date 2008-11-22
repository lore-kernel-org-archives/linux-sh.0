From: Matt Fleming <mjf@gentoo.org>
Date: Sat, 22 Nov 2008 16:49:52 +0000
Subject: Re: HP Jornada 600-series bisected
Message-Id: <20081122164952.GC821@console-pimps.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
List-Id: <linux-sh.vger.kernel.org>
References: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
In-Reply-To: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
To: linux-sh@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 21, 2008 at 04:34:45PM +0900, Paul Mundt wrote:
> 
> So, pending a rewrite of hd64461, we should probably just leave the
> __do_IRQ() dispatch as an option there, until someone gets around to
> rewriting that mess. I will conditionalize it on !HD64461 for now.

Kristoffer can you try the attached patch, please? It compiles OK but I
haven't had chance to test it on actual hardware.


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-sh-Switch-HD64461-from-hw_interrupt_type-to-irq_chi.patch"

From 7258c0f9c1a2cf01a87d67d6221daf6dd79fa3e8 Mon Sep 17 00:00:00 2001
From: Matt Fleming <mjf@gentoo.org>
Date: Sat, 22 Nov 2008 16:24:35 +0000
Subject: [PATCH] sh: Switch HD64461 from hw_interrupt_type to irq_chip

Use struct irq_chip for the interrupt handler for the HD64461. Also
convert some in{b,w} and out{b,w} calls to the equivalent __raw_* calls.

This is the first step to allow machines with HD64461 to define
GENERIC_HARDIRQS_NO__DO_IRQ.

Signed-off-by: Matt Fleming <mjf@gentoo.org>
---
 arch/sh/cchips/hd6446x/hd64461.c |  111 ++++++++-----------------------------
 1 files changed, 24 insertions(+), 87 deletions(-)

diff --git a/arch/sh/cchips/hd6446x/hd64461.c b/arch/sh/cchips/hd6446x/hd64461.c
index f1a4a07..a550833 100644
--- a/arch/sh/cchips/hd6446x/hd64461.c
+++ b/arch/sh/cchips/hd6446x/hd64461.c
@@ -17,90 +17,42 @@
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
 	if (irq == HD64461_IRQBASE + 13)
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
 EXPORT_SYMBOL(hd64461_unregister_irq_demux);
 
 int hd64461_irq_demux(int irq)
@@ -115,25 +67,11 @@ int hd64461_irq_demux(int irq)
 		for (bit = 1, i = 0; i < 16; bit <<= 1, i++)
 			if (nirr & bit)
 				break;
-		if (i == 16)
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
@@ -146,22 +84,21 @@ int __init setup_hd64461(void)
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


--oyUTqETQ0mS9luUI--
