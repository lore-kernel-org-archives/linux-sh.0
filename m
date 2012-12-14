From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Dec 2012 03:43:12 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 external IRQ wake update
Message-Id: <20121214034312.20055.61728.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use sh73a0_set_wake() for external IRQ signals on sh73a0.

The sh73a0 IRQ hardware for external IRQ pins consists of
the INTCA interrupt controller and the GIC together doing
their best to limp along. These external IRQ pins are
treated as a special case where interrupts need to be
managed in both interrupt controllers in parallel.

The ->irq_set_wake() callback for the external IRQ pins
can be dealt with in the same way as INTCA-only without
involving the GIC. So this patch updates the external
IRQ pin code for sh73a0 to no longer involve the GIC.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/intc-sh73a0.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/intc-sh73a0.c
+++ work/arch/arm/mach-shmobile/intc-sh73a0.c	2012-12-14 12:29:17.000000000 +0900
@@ -315,11 +315,6 @@ static int intca_gic_set_type(struct irq
 	return irq_cbp(irq_set_type, to_intca_reloc_irq(data), type);
 }
 
-static int intca_gic_set_wake(struct irq_data *data, unsigned int on)
-{
-	return irq_cbp(irq_set_wake, to_intca_reloc_irq(data), on);
-}
-
 #ifdef CONFIG_SMP
 static int intca_gic_set_affinity(struct irq_data *data,
 				  const struct cpumask *cpumask,
@@ -339,7 +334,7 @@ struct irq_chip intca_gic_irq_chip = {
 	.irq_disable		= intca_gic_disable,
 	.irq_shutdown		= intca_gic_disable,
 	.irq_set_type		= intca_gic_set_type,
-	.irq_set_wake		= intca_gic_set_wake,
+	.irq_set_wake		= sh73a0_set_wake,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= intca_gic_set_affinity,
 #endif
