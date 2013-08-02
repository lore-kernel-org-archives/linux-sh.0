From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Aug 2013 06:39:13 +0000
Subject: [PATCH 1/4] ARM: shmobile: armadillo800eva: Use DT for GIC
Message-Id: <87haf88ult.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d58226a21a7b84a3f82265821f24ce2aad267f1c.1374624997.git.horms+renesas@verge.net.au>
In-Reply-To: <d58226a21a7b84a3f82265821f24ce2aad267f1c.1374624997.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current Armadillo800eva is using DT booting,
and r8a7740.dtsi already has GIC settings.

So, we can remove the C version of the GIC setup code,
instead rely on GIC information provided by DT.

This patch removes r8a7740_init_irq() which has
no user any more

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h  |    1 -
 arch/arm/mach-shmobile/intc-r8a7740.c          |   20 +++-----------------
 3 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 4cfcbbe..da58332 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1314,7 +1314,7 @@ static const char *eva_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
 	.map_io		= r8a7740_map_io,
 	.init_early	= eva_add_early_devices,
-	.init_irq	= r8a7740_init_irq,
+	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= eva_init,
 	.init_late	= shmobile_init_late,
 	.init_time	= eva_earlytimer_init,
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 56f3750..d07932f 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -48,7 +48,6 @@ enum {
 
 extern void r8a7740_meram_workaround(void);
 extern void r8a7740_init_delay(void);
-extern void r8a7740_init_irq(void);
 extern void r8a7740_init_irq_of(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
index 8871f77..7519353 100644
--- a/arch/arm/mach-shmobile/intc-r8a7740.c
+++ b/arch/arm/mach-shmobile/intc-r8a7740.c
@@ -23,12 +23,14 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
 
-static void __init r8a7740_init_irq_common(void)
+void __init r8a7740_init_irq_of(void)
 {
 	void __iomem *intc_prio_base = ioremap_nocache(0xe6900010, 0x10);
 	void __iomem *intc_msk_base = ioremap_nocache(0xe6900040, 0x10);
 	void __iomem *pfc_inta_ctrl = ioremap_nocache(0xe605807c, 0x4);
 
+	irqchip_init();
+
 	/* route signals to GIC */
 	iowrite32(0x0, pfc_inta_ctrl);
 
@@ -50,19 +52,3 @@ static void __init r8a7740_init_irq_common(void)
 	iounmap(intc_msk_base);
 	iounmap(pfc_inta_ctrl);
 }
-
-void __init r8a7740_init_irq_of(void)
-{
-	irqchip_init();
-	r8a7740_init_irq_common();
-}
-
-void __init r8a7740_init_irq(void)
-{
-	void __iomem *gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
-	void __iomem *gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
-
-	/* initialize the Generic Interrupt Controller PL390 r0p0 */
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-	r8a7740_init_irq_common();
-}
-- 
1.7.9.5

