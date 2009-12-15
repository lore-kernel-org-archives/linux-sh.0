From: Roel Kluin <roel.kluin@gmail.com>
Date: Tue, 15 Dec 2009 16:36:34 +0000
Subject: [PATCH] sh: Fix test of unsigned in se7722_irq_demux()
Message-Id: <4B27BB12.1050008@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

se7722_fpga_irq[] is unsigned so the test does not work.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found using coccinelle: http://coccinelle.lip6.fr/

diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index 4eb31ac..b221b68 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -57,15 +57,16 @@ static void se7722_irq_demux(unsigned int irq, struct irq_desc *desc)
  */
 void __init init_se7722_IRQ(void)
 {
-	int i;
+	int i, irq;
 
 	ctrl_outw(0, IRQ01_MASK);       /* disable all irqs */
 	ctrl_outw(0x2000, 0xb03fffec);  /* mrshpc irq enable */
 
 	for (i = 0; i < SE7722_FPGA_IRQ_NR; i++) {
-		se7722_fpga_irq[i] = create_irq();
-		if (se7722_fpga_irq[i] < 0)
+		irq = create_irq();
+		if (irq < 0)
 			return;
+		se7722_fpga_irq[i] = irq;
 
 		set_irq_chip_and_handler_name(se7722_fpga_irq[i],
 					      &se7722_irq_chip,
