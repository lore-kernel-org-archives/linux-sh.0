From: Matt Fleming <mjf@gentoo.org>
Date: Sun, 14 Dec 2008 12:02:27 +0000
Subject: [PATCH 4/5] sh: Convert Cayman boards from hw_interrupt_type to irq_chip
Message-Id: <ff11b9a9b797db1bf120396fa0039c3f99ee4a0a.1229255348.git.mjf@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I've been unable to even compile-test this change because I don't have
an sh5 toolchain. All uses of hw_interrupt_type for SuperH boards have
now been converted to use irq_chip.

Signed-off-by: Matt Fleming <mjf@gentoo.org>
---
 arch/sh/boards/mach-cayman/irq.c |   35 ++++++++---------------------------
 1 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/arch/sh/boards/mach-cayman/irq.c b/arch/sh/boards/mach-cayman/irq.c
index ceb37ae..da62ad5 100644
--- a/arch/sh/boards/mach-cayman/irq.c
+++ b/arch/sh/boards/mach-cayman/irq.c
@@ -94,31 +94,11 @@ static void ack_cayman_irq(unsigned int irq)
 	disable_cayman_irq(irq);
 }
 
-static void end_cayman_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-		enable_cayman_irq(irq);
-}
-
-static unsigned int startup_cayman_irq(unsigned int irq)
-{
-	enable_cayman_irq(irq);
-	return 0; /* never anything pending */
-}
-
-static void shutdown_cayman_irq(unsigned int irq)
-{
-	disable_cayman_irq(irq);
-}
-
-struct hw_interrupt_type cayman_irq_type = {
-	.typename	= "Cayman-IRQ",
-	.startup	= startup_cayman_irq,
-	.shutdown	= shutdown_cayman_irq,
-	.enable		= enable_cayman_irq,
-	.disable	= disable_cayman_irq,
-	.ack		= ack_cayman_irq,
-	.end		= end_cayman_irq,
+struct irq_chip cayman_irq_type = {
+	.name		= "Cayman-IRQ",
+	.unmask 	= enable_cayman_irq,
+	.mask		= disable_cayman_irq,
+	.mask_ack	= ack_cayman_irq,
 };
 
 int cayman_irq_demux(int evt)
@@ -187,8 +167,9 @@ void init_cayman_irq(void)
 		return;
 	}
 
-	for (i=0; i<NR_EXT_IRQS; i++) {
-		irq_desc[START_EXT_IRQS + i].chip = &cayman_irq_type;
+	for (i = 0; i < NR_EXT_IRQS; i++) {
+		set_irq_chip_and_handler(START_EXT_IRQS + i, &cayman_irq_type,
+					 handle_level_irq);
 	}
 
 	/* Setup the SMSC interrupt */
-- 
1.5.6.4

