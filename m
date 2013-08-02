From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Aug 2013 06:39:34 +0000
Subject: [PATCH 2/4] ARM: shmobile: marzen: Use DT for GIC
Message-Id: <87fvus8ul9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current Marzen is using DT booting,
and r8a7779.dtsi already has GIC settings.

So, we can remove the C version of the GIC setup code,
instead rely on GIC information provided by DT.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-marzen.c         |    3 +--
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    1 -
 arch/arm/mach-shmobile/intc-r8a7779.c         |   22 ++++------------------
 3 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 2bf86c4..3551b54 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -266,8 +266,7 @@ DT_MACHINE_START(MARZEN, "marzen")
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_add_early_devices,
-	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= r8a7779_init_irq,
+	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= marzen_init,
 	.init_late	= r8a7779_init_late,
 	.dt_compat	= marzen_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index f10727f7..f08d6ec 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -24,7 +24,6 @@ static inline struct r8a7779_pm_ch *to_r8a7779_ch(struct generic_pm_domain *d)
 }
 
 extern void r8a7779_init_delay(void);
-extern void r8a7779_init_irq(void);
 extern void r8a7779_init_irq_extpin(int irlm);
 extern void r8a7779_init_irq_dt(void);
 extern void r8a7779_map_io(void);
diff --git a/arch/arm/mach-shmobile/intc-r8a7779.c b/arch/arm/mach-shmobile/intc-r8a7779.c
index 5f9e5dc..e992a68 100644
--- a/arch/arm/mach-shmobile/intc-r8a7779.c
+++ b/arch/arm/mach-shmobile/intc-r8a7779.c
@@ -89,15 +89,18 @@ void __init r8a7779_init_irq_extpin(int irlm)
 		pr_warn("r8a7779: unable to setup external irq pin mode\n");
 }
 
+#ifdef CONFIG_OF
 static int r8a7779_set_wake(struct irq_data *data, unsigned int on)
 {
 	return 0; /* always allow wakeup */
 }
 
-static void __init r8a7779_init_irq_common(void)
+void __init r8a7779_init_irq_dt(void)
 {
 	gic_arch_extn.irq_set_wake = r8a7779_set_wake;
 
+	irqchip_init();
+
 	/* route all interrupts to ARM */
 	__raw_writel(0xffffffff, INT2NTSR0);
 	__raw_writel(0x3fffffff, INT2NTSR1);
@@ -108,23 +111,6 @@ static void __init r8a7779_init_irq_common(void)
 	__raw_writel(0xfffbffdf, INT2SMSKCR2);
 	__raw_writel(0xbffffffc, INT2SMSKCR3);
 	__raw_writel(0x003fee3f, INT2SMSKCR4);
-}
-
-void __init r8a7779_init_irq(void)
-{
-	void __iomem *gic_dist_base = IOMEM(0xf0001000);
-	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
 
-	/* use GIC to handle interrupts */
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-
-	r8a7779_init_irq_common();
-}
-
-#ifdef CONFIG_OF
-void __init r8a7779_init_irq_dt(void)
-{
-	irqchip_init();
-	r8a7779_init_irq_common();
 }
 #endif
-- 
1.7.9.5

