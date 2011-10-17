From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 17 Oct 2011 09:00:52 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 and AG5EVM PINT support
Message-Id: <20111017090052.21996.49291.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Support PINT on sh73a0 and AG5EVM using INTC PINT macros.

With this patch applied the AG5EVM ethernet is handled
through one of the chained sh73a0 PINT interrupt controllers.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on "[PATCH] ARM: mach-shmobile: Add support for PINT though macros"
 and on "[PATCH 00/07] ARM: mach-shmobile: External IRQ pin update"

 arch/arm/mach-shmobile/board-ag5evm.c        |   17 ------
 arch/arm/mach-shmobile/include/mach/sh73a0.h |    4 +
 arch/arm/mach-shmobile/intc-sh73a0.c         |   65 ++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 15 deletions(-)

--- 0014/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-10-14 18:50:07.000000000 +0900
@@ -58,7 +58,7 @@ static struct resource smsc9220_resource
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start		= gic_spi(33), /* PINT1 */
+		.start		= SH73A0_PINT0_IRQ(2), /* PINTA2 */
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -465,19 +465,6 @@ static void __init ag5evm_map_io(void)
 	shmobile_setup_console();
 }
 
-#define PINTC_ADDR	0xe6900000
-#define PINTER0A	(PINTC_ADDR + 0xa0)
-#define PINTCR0A	(PINTC_ADDR + 0xb0)
-
-void __init ag5evm_init_irq(void)
-{
-	sh73a0_init_irq();
-
-	/* setup PINT: enable PINTA2 as active low */
-	__raw_writel(__raw_readl(PINTER0A) | (1<<29), PINTER0A);
-	__raw_writew(__raw_readw(PINTCR0A) | (2<<10), PINTCR0A);
-}
-
 #define DSI0PHYCR	0xe615006c
 
 static void __init ag5evm_init(void)
@@ -611,7 +598,7 @@ struct sys_timer ag5evm_timer = {
 
 MACHINE_START(AG5EVM, "ag5evm")
 	.map_io		= ag5evm_map_io,
-	.init_irq	= ag5evm_init_irq,
+	.init_irq	= sh73a0_init_irq,
 	.handle_irq	= shmobile_handle_irq_gic,
 	.init_machine	= ag5evm_init,
 	.timer		= &ag5evm_timer,
--- 0002/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ work/arch/arm/mach-shmobile/include/mach/sh73a0.h	2011-10-14 18:50:07.000000000 +0900
@@ -507,4 +507,8 @@ enum {
 	SHDMA_SLAVE_MMCIF_RX,
 };
 
+/* PINT interrupts are located at Linux IRQ 768 and up */
+#define SH73A0_PINT0_IRQ(irq) ((irq) + 768)
+#define SH73A0_PINT1_IRQ(irq) ((irq) + 800)
+
 #endif /* __ASM_SH73A0_H__ */
--- 0013/arch/arm/mach-shmobile/intc-sh73a0.c
+++ work/arch/arm/mach-shmobile/intc-sh73a0.c	2011-10-17 16:52:48.000000000 +0900
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/sh_intc.h>
 #include <mach/intc.h>
+#include <mach/sh73a0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -363,6 +364,59 @@ static irqreturn_t sh73a0_irq_pin_demux(
 
 static struct irqaction sh73a0_irq_pin_cascade[32];
 
+#define PINTER0 0xe69000a0
+#define PINTER1 0xe69000a4
+#define PINTRR0 0xe69000d0
+#define PINTRR1 0xe69000d4
+
+#define PINT0A_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq))
+#define PINT0B_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq + 8))
+#define PINT0C_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq + 16))
+#define PINT0D_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq + 24))
+#define PINT1E_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT1_IRQ(irq))
+
+INTC_PINT(intc_pint0, PINTER0, 0xe69000b0, "sh73a0-pint0",		\
+  INTC_PINT_E(A), INTC_PINT_E(B), INTC_PINT_E(C), INTC_PINT_E(D),	\
+  INTC_PINT_V(A, PINT0A_IRQ), INTC_PINT_V(B, PINT0B_IRQ),		\
+  INTC_PINT_V(C, PINT0C_IRQ), INTC_PINT_V(D, PINT0D_IRQ),		\
+  INTC_PINT_E(A), INTC_PINT_E(B), INTC_PINT_E(C), INTC_PINT_E(D),	\
+  INTC_PINT_E(A), INTC_PINT_E(B), INTC_PINT_E(C), INTC_PINT_E(D));
+
+INTC_PINT(intc_pint1, PINTER1, 0xe69000c0, "sh73a0-pint1",		\
+  INTC_PINT_E(E), INTC_PINT_E_EMPTY, INTC_PINT_E_EMPTY, INTC_PINT_E_EMPTY, \
+  INTC_PINT_V(E, PINT1E_IRQ), INTC_PINT_V_NONE,				\
+  INTC_PINT_V_NONE, INTC_PINT_V_NONE,					\
+  INTC_PINT_E_NONE, INTC_PINT_E_NONE, INTC_PINT_E_NONE, INTC_PINT_E(E), \
+  INTC_PINT_E(E), INTC_PINT_E_NONE, INTC_PINT_E_NONE, INTC_PINT_E_NONE);
+
+static struct irqaction sh73a0_pint0_cascade;
+static struct irqaction sh73a0_pint1_cascade;
+
+static void pint_demux(unsigned long rr, unsigned long er, int base_irq)
+{
+	unsigned long value =  ioread32(rr) & ioread32(er);
+	int k;
+
+	for (k = 0; k < 32; k++) {
+		if (value & (1 << (31 - k))) {
+			generic_handle_irq(base_irq + k);
+			iowrite32(~(1 << (31 - k)), rr);
+		}
+	}
+}
+
+static irqreturn_t sh73a0_pint0_demux(int irq, void *dev_id)
+{
+	pint_demux(PINTRR0, PINTER0, SH73A0_PINT0_IRQ(0));
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t sh73a0_pint1_demux(int irq, void *dev_id)
+{
+	pint_demux(PINTRR1, PINTER1, SH73A0_PINT1_IRQ(0));
+	return IRQ_HANDLED;
+}
+
 void __init sh73a0_init_irq(void)
 {
 	void __iomem *gic_dist_base = __io(0xf0001000);
@@ -375,6 +429,8 @@ void __init sh73a0_init_irq(void)
 
 	register_intc_controller(&intcs_desc);
 	register_intc_controller(&intca_irq_pins_desc);
+	register_intc_controller(&intc_pint0_desc);
+	register_intc_controller(&intc_pint1_desc);
 
 	/* demux using INTEVTSA */
 	sh73a0_intcs_cascade.name = "INTCS cascade";
@@ -393,4 +449,13 @@ void __init sh73a0_init_irq(void)
 					      handle_level_irq, "level");
 		set_irq_flags(n, IRQF_VALID); /* yuck */
 	}
+
+	/* PINT pins are sanely tied to the GIC as SPI */
+	sh73a0_pint0_cascade.name = "PINT0 cascade";
+	sh73a0_pint0_cascade.handler = sh73a0_pint0_demux;
+	setup_irq(gic_spi(33), &sh73a0_pint0_cascade);
+
+	sh73a0_pint1_cascade.name = "PINT1 cascade";
+	sh73a0_pint1_cascade.handler = sh73a0_pint1_demux;
+	setup_irq(gic_spi(34), &sh73a0_pint1_cascade);
 }
