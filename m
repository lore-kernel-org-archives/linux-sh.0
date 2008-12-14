From: Matt Fleming <mjf@gentoo.org>
Date: Sun, 14 Dec 2008 12:02:24 +0000
Subject: [PATCH 1/5] sh: Convert Microdev boards from hw_interrupt_type to irq_chip
Message-Id: <006313f0e180a1cd3dec11f09f4d406b556500f8.1229255348.git.mjf@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is part of the SH move to irq_chip.

Signed-off-by: Matt Fleming <mjf@gentoo.org>
---
 arch/sh/boards/mach-microdev/irq.c |   36 +++++++-----------------------------
 1 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/arch/sh/boards/mach-microdev/irq.c b/arch/sh/boards/mach-microdev/irq.c
index 702753c..b551963 100644
--- a/arch/sh/boards/mach-microdev/irq.c
+++ b/arch/sh/boards/mach-microdev/irq.c
@@ -67,27 +67,13 @@ static const struct {
 
 static void enable_microdev_irq(unsigned int irq);
 static void disable_microdev_irq(unsigned int irq);
-
-	/* shutdown is same as "disable" */
-#define shutdown_microdev_irq disable_microdev_irq
-
 static void mask_and_ack_microdev(unsigned int);
-static void end_microdev_irq(unsigned int irq);
-
-static unsigned int startup_microdev_irq(unsigned int irq)
-{
-	enable_microdev_irq(irq);
-	return 0;		/* never anything pending */
-}
 
-static struct hw_interrupt_type microdev_irq_type = {
-	.typename = "MicroDev-IRQ",
-	.startup = startup_microdev_irq,
-	.shutdown = shutdown_microdev_irq,
-	.enable = enable_microdev_irq,
-	.disable = disable_microdev_irq,
+static struct irq_chip microdev_irq_type = {
+	.name = "MicroDev-IRQ",
+	.unmask = enable_microdev_irq,
+	.mask = disable_microdev_irq,
 	.ack = mask_and_ack_microdev,
-	.end = end_microdev_irq
 };
 
 static void disable_microdev_irq(unsigned int irq)
@@ -130,11 +116,11 @@ static void enable_microdev_irq(unsigned int irq)
 	ctrl_outl(MICRODEV_FPGA_INTC_MASK(fpgaIrq), MICRODEV_FPGA_INTENB_REG);
 }
 
-	/* This functions sets the desired irq handler to be a MicroDev type */
+/* This function sets the desired irq handler to be a MicroDev type */
 static void __init make_microdev_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-	irq_desc[irq].chip = &microdev_irq_type;
+	set_irq_chip_and_handler(irq, &microdev_irq_type, handle_level_irq);
 	disable_microdev_irq(irq);
 }
 
@@ -143,17 +129,11 @@ static void mask_and_ack_microdev(unsigned int irq)
 	disable_microdev_irq(irq);
 }
 
-static void end_microdev_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_microdev_irq(irq);
-}
-
 extern void __init init_microdev_irq(void)
 {
 	int i;
 
-		/* disable interrupts on the FPGA INTC register */
+	/* disable interrupts on the FPGA INTC register */
 	ctrl_outl(~0ul, MICRODEV_FPGA_INTDSB_REG);
 
 	for (i = 0; i < NUM_EXTERNAL_IRQS; i++)
@@ -179,5 +159,3 @@ extern void microdev_print_fpga_intc_status(void)
 	printk("FPGA_INTPRI[3..0] = %08x:%08x:%08x:%08x\n", *intprid, *intpric, *intprib, *intpria);
 	printk("-------------------------------------------------------------------------------\n");
 }
-
-
-- 
1.5.6.4

