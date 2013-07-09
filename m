From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Jul 2013 08:48:34 +0000
Subject: [PATCH] ARM: shmobile: r8a7778: remove r8a7778_init_irq()
Message-Id: <8738rot8yp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch removes r8a7778_init_irq(), since no-one is using it.
And now, there is no reason to have r8a7778_init_irq_common().
r8a7778_init_irq_dt() includes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Simon

This patch is based on renesas-next-20130704v2 tag

 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7778.c        |   37 ++++++-------------------
 2 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 2e36264..5d0e120 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -33,7 +33,6 @@ extern void r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info);
 extern void r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
 extern void r8a7778_init_late(void);
 extern void r8a7778_init_delay(void);
-extern void r8a7778_init_irq(void);
 extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 2a101eb..a3a2e37 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -408,17 +408,25 @@ void __init r8a7778_init_irq_extpin(int irlm)
 			&irqpin_platform_data, sizeof(irqpin_platform_data));
 }
 
+void __init r8a7778_init_delay(void)
+{
+	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
+}
+
+#ifdef CONFIG_USE_OF
 #define INT2SMSKCR0	0x82288 /* 0xfe782288 */
 #define INT2SMSKCR1	0x8228c /* 0xfe78228c */
 
 #define INT2NTSR0	0x00018 /* 0xfe700018 */
 #define INT2NTSR1	0x0002c /* 0xfe70002c */
-static void __init r8a7778_init_irq_common(void)
+void __init r8a7778_init_irq_dt(void)
 {
 	void __iomem *base = ioremap_nocache(0xfe700000, 0x00100000);
 
 	BUG_ON(!base);
 
+	irqchip_init();
+
 	/* route all interrupts to ARM */
 	__raw_writel(0x73ffffff, base + INT2NTSR0);
 	__raw_writel(0xffffffff, base + INT2NTSR1);
@@ -430,33 +438,6 @@ static void __init r8a7778_init_irq_common(void)
 	iounmap(base);
 }
 
-void __init r8a7778_init_irq(void)
-{
-	void __iomem *gic_dist_base;
-	void __iomem *gic_cpu_base;
-
-	gic_dist_base = ioremap_nocache(0xfe438000, PAGE_SIZE);
-	gic_cpu_base  = ioremap_nocache(0xfe430000, PAGE_SIZE);
-	BUG_ON(!gic_dist_base || !gic_cpu_base);
-
-	/* use GIC to handle interrupts */
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-
-	r8a7778_init_irq_common();
-}
-
-void __init r8a7778_init_delay(void)
-{
-	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
-}
-
-#ifdef CONFIG_USE_OF
-void __init r8a7778_init_irq_dt(void)
-{
-	irqchip_init();
-	r8a7778_init_irq_common();
-}
-
 static const char *r8a7778_compat_dt[] __initdata = {
 	"renesas,r8a7778",
 	NULL,
-- 
1.7.9.5

