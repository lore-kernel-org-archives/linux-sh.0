From: Rafael Ignacio Zurita <rizurita@yahoo.com>
Date: Fri, 20 Mar 2009 02:08:22 +0000
Subject: [PATCH] sh: fix the HD64461 level-triggered interrupts handling
Message-Id: <20090320020822.GA17555@rafazurita.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Rework the hd64461 demuxer code to fix the HD64461 level-triggered
interrupts handling, using handle_level_irq() as needed.

Signed-off-by: Rafael Ignacio Zurita <rizurita@yahoo.com>
---
 arch/sh/boards/mach-hp6xx/setup.c |    1 -
 arch/sh/cchips/hd6446x/hd64461.c  |   30 +++++++++++++++++-------------
 arch/sh/include/asm/hd64461.h     |    1 -
 3 files changed, 17 insertions(+), 15 deletions(-)

--- a/arch/sh/boards/mach-hp6xx/setup.c
+++ b/arch/sh/boards/mach-hp6xx/setup.c
@@ -115,7 +115,6 @@ static struct sh_machine_vector mv_hp6xx __initmv = {
 	.mv_setup = hp6xx_setup,
 	/* IRQ's : CPU(64) + CCHIP(16) + FREE_TO_USE(6) */
 	.mv_nr_irqs = HD64461_IRQBASE + HD64461_IRQ_NUM + 6,
-	.mv_irq_demux = hd64461_irq_demux,
 	/* Enable IRQ0 -> IRQ3 in IRQ_MODE */
 	.mv_init_irq = hp6xx_init_irq,
 };
--- a/arch/sh/cchips/hd6446x/hd64461.c
+++ b/arch/sh/cchips/hd6446x/hd64461.c
@@ -53,21 +53,22 @@ static struct irq_chip hd64461_irq_chip = {
 	.unmask		= hd64461_unmask_irq,
 };
 
-int hd64461_irq_demux(int irq)
+static void hd64461_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
-	if (irq = CONFIG_HD64461_IRQ) {
-		unsigned short bit;
-		unsigned short nirr = inw(HD64461_NIRR);
-		unsigned short nimr = inw(HD64461_NIMR);
-		int i;
-
-		nirr &= ~nimr;
-		for (bit = 1, i = 0; i < 16; bit <<= 1, i++)
-			if (nirr & bit)
-				break;
-		irq = HD64461_IRQBASE + i;
+	unsigned short intv = ctrl_inw(HD64461_NIRR);
+	struct irq_desc *ext_desc;
+	unsigned int ext_irq = HD64461_IRQBASE;
+
+	intv &= (1 << HD64461_IRQ_NUM) - 1;
+
+	while (intv) {
+		if (intv & 1) {
+			ext_desc = irq_desc + ext_irq;
+			handle_level_irq(ext_irq, ext_desc);
+		}
+		intv >>= 1;
+		ext_irq++;
 	}
-	return irq;
 }
 
 int __init setup_hd64461(void)
@@ -93,6 +94,9 @@ int __init setup_hd64461(void)
 		set_irq_chip_and_handler(i, &hd64461_irq_chip,
 					 handle_level_irq);
 
+	set_irq_chained_handler(CONFIG_HD64461_IRQ, hd64461_irq_demux);
+	set_irq_type(CONFIG_HD64461_IRQ, IRQ_TYPE_LEVEL_LOW);
+
 #ifdef CONFIG_HD64461_ENABLER
 	printk(KERN_INFO "HD64461: enabling PCMCIA devices\n");
 	__raw_writeb(0x4c, HD64461_PCC1CSCIER);
--- a/arch/sh/include/asm/hd64461.h
+++ b/arch/sh/include/asm/hd64461.h
@@ -242,7 +242,6 @@
 #include <asm/io_generic.h>
 
 /* arch/sh/cchips/hd6446x/hd64461/setup.c */
-int hd64461_irq_demux(int irq);
 void hd64461_register_irq_demux(int irq,
 				int (*demux) (int irq, void *dev), void *dev);
 void hd64461_unregister_irq_demux(int irq);
-- 
