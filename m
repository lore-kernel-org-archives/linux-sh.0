From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Feb 2013 02:55:38 +0000
Subject: [PATCH 03/03] ARM: shmobile: INTC External IRQ pin driver on r8a7779
Message-Id: <20130226030118.9682.13020.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the r8a7779 IRQ code to make use of the
INTC External IRQ pin driver for external
interrupt pins IRQ0 -> IRQ3.

The r8a7779 SoC can like older SH SoCs configure
to use the IRQ0 -> IRQ3 signals as individual
interrupts or a combined IRL mode.

Without this patch the r8a7779 SoC code does
not fully support external IRQ pins in individual
IRQ mode. The r8a7779 PFC code does not yet have
gpio_to_irq() support so no need to update such
code.

At this point the DT reference implementations
are not covered. In the future such code shall
tie in the INTC External IRQ pin driver via
DT, so this kind of verbose code is not needed
for the long term DT case.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Tested on r8a7779 Marzen.

 Depends on:
 [PATCH] irqchip: Renesas INTC External IRQ pin driver
 [PATCH 01/03] ARM: shmobile: irq_pin() for static IRQ pin assignment

 arch/arm/mach-shmobile/Kconfig               |    1 
 arch/arm/mach-shmobile/board-marzen.c        |    3 -
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/intc-r8a7779.c        |   53 +++++++++++++++++++++++++-
 4 files changed, 56 insertions(+), 2 deletions(-)

--- 0012/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-02-18 18:57:09.000000000 +0900
@@ -32,6 +32,7 @@ config ARCH_R8A7779
 	select SH_CLK_CPG
 	select USB_ARCH_HAS_EHCI
 	select USB_ARCH_HAS_OHCI
+	select RENESAS_INTC_IRQPIN
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
--- 0001/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2013-02-18 20:50:12.000000000 +0900
@@ -67,7 +67,7 @@ static struct resource smsc911x_resource
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start		= gic_spi(28), /* IRQ 1 */
+		.start		= irq_pin(1), /* IRQ1 */
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -335,6 +335,7 @@ static void __init marzen_init(void)
 				ARRAY_SIZE(dummy_supplies));
 
 	r8a7779_pinmux_init();
+	r8a7779_init_irq_extpin(1); /* IRQ1 as individual interrupt */
 
 	/* SCIF2 (CN18: DEBUG0) */
 	gpio_request(GPIO_FN_TX2_C, NULL);
--- 0009/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-02-18 20:47:52.000000000 +0900
@@ -59,6 +59,7 @@ extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
 
 extern void r8a7779_init_irq(void);
+extern void r8a7779_init_irq_extpin(int irlm);
 extern void r8a7779_init_irq_dt(void);
 extern void r8a7779_map_io(void);
 extern void r8a7779_earlytimer_init(void);
--- 0001/arch/arm/mach-shmobile/intc-r8a7779.c
+++ work/arch/arm/mach-shmobile/intc-r8a7779.c	2013-02-18 21:01:14.000000000 +0900
@@ -19,13 +19,16 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/irqchip/arm-gic.h>
-#include <mach/common.h>
+#include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/irqchip.h>
+#include <mach/common.h>
 #include <mach/intc.h>
+#include <mach/irqs.h>
 #include <mach/r8a7779.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +42,54 @@
 #define INT2NTSR0 IOMEM(0xfe700060)
 #define INT2NTSR1 IOMEM(0xfe700064)
 
+struct renesas_intc_irqpin_config irqpin0_platform_data = {
+	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
+	.sense_bitfield_width = 2,
+};
+
+static struct resource irqpin0_resources[] = {
+	DEFINE_RES_MEM(0xfe78001c, 4), /* ICR1 */
+	DEFINE_RES_MEM(0xfe780010, 4), /* INTPRI */
+	DEFINE_RES_MEM(0xfe780024, 4), /* INTREQ */
+	DEFINE_RES_MEM(0xfe780044, 4), /* INTMSK0 */
+	DEFINE_RES_MEM(0xfe780064, 4), /* INTMSKCLR0 */
+	DEFINE_RES_IRQ(gic_spi(27)), /* IRQ0 */
+	DEFINE_RES_IRQ(gic_spi(28)), /* IRQ1 */
+	DEFINE_RES_IRQ(gic_spi(29)), /* IRQ2 */
+	DEFINE_RES_IRQ(gic_spi(30)), /* IRQ3 */
+};
+
+static struct platform_device irqpin0_device = {
+	.name		= "renesas_intc_irqpin",
+	.id		= 0,
+	.resource	= irqpin0_resources,
+	.num_resources	= ARRAY_SIZE(irqpin0_resources),
+	.dev		= {
+		.platform_data	= &irqpin0_platform_data,
+	},
+};
+
+void __init r8a7779_init_irq_extpin(int irlm)
+{
+	void __iomem *icr0 = ioremap_nocache(0xfe780000, PAGE_SIZE);
+	unsigned long tmp;
+
+	if (icr0) {
+		tmp = ioread32(icr0);
+		if (irlm)
+			tmp |= 1 << 23; /* IRQ0 -> IRQ3 as individual pins */
+		else
+			tmp &= ~(1 << 23); /* IRL mode - not supported */
+		tmp |= (1 << 21); /* LVLMODE = 1 */
+		iowrite32(tmp, icr0);
+		iounmap(icr0);
+
+		if (irlm)
+			platform_device_register(&irqpin0_device);
+	} else
+		pr_warn("r8a7779: unable to setup external irq pin mode\n");
+}
+
 static int r8a7779_set_wake(struct irq_data *data, unsigned int on)
 {
 	return 0; /* always allow wakeup */
