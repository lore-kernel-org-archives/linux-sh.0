From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 07 Mar 2013 19:00:31 +0000
Subject: [no-PATCH 1/3] ARM: shmobile: add INTC interrupt controllers on sh73a0 in the DT case
Message-Id: <Pine.LNX.4.64.1303071954420.16065@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Not-Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 +-
 arch/arm/mach-shmobile/include/mach/common.h   |    1 +
 arch/arm/mach-shmobile/intc-sh73a0.c           |   26 ++++++++++++++++++-----
 arch/arm/mach-shmobile/setup-sh73a0.c          |    8 +++---
 4 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 63992a2..fbbaa55 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -98,7 +98,7 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= irqchip_init,
+	.init_irq	= sh73a0_init_irq_intc_dt,
 	.init_machine	= kzm_init,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= kzm9g_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 03f73de..074832b 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -37,6 +37,7 @@ extern struct clk sh7372_extal2_clk;
 extern void sh73a0_init_delay(void);
 extern void sh73a0_init_irq(void);
 extern void sh73a0_init_irq_dt(void);
+void sh73a0_init_irq_intc_dt(void);
 extern void sh73a0_map_io(void);
 extern void sh73a0_earlytimer_init(void);
 extern void sh73a0_add_early_devices(void);
diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index 19a26f4..cc1ff9f 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -315,15 +315,10 @@ static irqreturn_t sh73a0_pint1_demux(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-void __init sh73a0_init_irq(void)
+static void __init __sh73a0_init_irq(void)
 {
-	void __iomem *gic_dist_base = IOMEM(0xf0001000);
-	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
 	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
 
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
-
 	register_intc_controller(&intcs_desc);
 	register_intc_controller(&intc_pint0_desc);
 	register_intc_controller(&intc_pint1_desc);
@@ -343,3 +338,22 @@ void __init sh73a0_init_irq(void)
 	sh73a0_pint1_cascade.handler = sh73a0_pint1_demux;
 	setup_irq(gic_spi(34), &sh73a0_pint1_cascade);
 }
+
+void __init sh73a0_init_irq(void)
+{
+	void __iomem *gic_dist_base = IOMEM(0xf0001000);
+	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
+
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
+
+	__sh73a0_init_irq();
+}
+
+#ifdef CONFIG_OF
+void __init sh73a0_init_irq_intc_dt(void)
+{
+	irqchip_init();
+	__sh73a0_init_irq();
+}
+#endif
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 95a75af..470b890 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -914,6 +914,10 @@ static struct platform_device *sh73a0_devices_dt[] __initdata = {
 	&scif7_device,
 	&scif8_device,
 	&cmt10_device,
+	&irqpin0_device,
+	&irqpin1_device,
+	&irqpin2_device,
+	&irqpin3_device,
 };
 
 static struct platform_device *sh73a0_early_devices[] __initdata = {
@@ -930,10 +934,6 @@ static struct platform_device *sh73a0_late_devices[] __initdata = {
 	&dma0_device,
 	&mpdma0_device,
 	&pmu_device,
-	&irqpin0_device,
-	&irqpin1_device,
-	&irqpin2_device,
-	&irqpin3_device,
 };
 
 #define SRCR2          IOMEM(0xe61580b0)
-- 
1.7.2.5

