From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Jan 2012 11:10:49 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 IRQ sparse alloc fix
Message-Id: <20120117111049.5442.27930.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix the sh73a0 external IRQ pin code to properly support
CONFIG_SPARSE_IRQ=y by allocating IRQ descriptors for the
cascaded IRQs associated with external IRQ pins.

Without this fix it is impossible to request IRQ0->IRQ31
on the Kota2 board when sparse IRQs are enabled. 

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/intc-sh73a0.c |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/arch/arm/mach-shmobile/intc-sh73a0.c
+++ work/arch/arm/mach-shmobile/intc-sh73a0.c	2012-01-17 19:59:22.000000000 +0900
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/sh_intc.h>
@@ -445,6 +446,7 @@ void __init sh73a0_init_irq(void)
 		setup_irq(gic_spi(1 + k), &sh73a0_irq_pin_cascade[k]);
 
 		n = intcs_evt2irq(to_intc_vect(gic_spi(1 + k)));
+		WARN_ON(irq_alloc_desc_at(n, numa_node_id()) != n);
 		irq_set_chip_and_handler_name(n, &intca_gic_irq_chip,
 					      handle_level_irq, "level");
 		set_irq_flags(n, IRQF_VALID); /* yuck */
