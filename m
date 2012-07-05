From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jul 2012 08:28:32 +0000
Subject: [PATCH 09/12 v2] ARM: shmobile: sh7372: add pm-rmobile domain support
Message-Id: <87sjd6pq6q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds pm-rmobile common API base PM domain.
sh7372 CPU/platform will switch to using it from
original implementation

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - based on pm-rmobile

 arch/arm/mach-shmobile/include/mach/sh7372.h |   11 ++++
 arch/arm/mach-shmobile/pm-sh7372.c           |   84 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/setup-sh7372.c        |   41 +++++++++++++
 3 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 915d009..a7620c1 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -13,6 +13,7 @@
 
 #include <linux/sh_clk.h>
 #include <linux/pm_domain.h>
+#include <mach/pm-rmobile.h>
 
 /*
  * Pin Function Controller:
@@ -494,6 +495,16 @@ static inline struct sh7372_pm_domain *to_sh7372_pd(struct generic_pm_domain *d)
 }
 
 #ifdef CONFIG_PM
+extern struct rmobile_pm_domain sh7372_pd_a4lc;
+extern struct rmobile_pm_domain sh7372_pd_a4mp;
+extern struct rmobile_pm_domain sh7372_pd_d4;
+extern struct rmobile_pm_domain sh7372_pd_a4r;
+extern struct rmobile_pm_domain sh7372_pd_a3rv;
+extern struct rmobile_pm_domain sh7372_pd_a3ri;
+extern struct rmobile_pm_domain sh7372_pd_a4s;
+extern struct rmobile_pm_domain sh7372_pd_a3sp;
+extern struct rmobile_pm_domain sh7372_pd_a3sg;
+
 extern struct sh7372_pm_domain sh7372_a4lc;
 extern struct sh7372_pm_domain sh7372_a4mp;
 extern struct sh7372_pm_domain sh7372_d4;
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index 44daaee..5175336 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -26,6 +26,7 @@
 #include <asm/suspend.h>
 #include <mach/common.h>
 #include <mach/sh7372.h>
+#include <mach/pm-rmobile.h>
 
 /* DBG */
 #define DBGREG1 0xe6100020
@@ -290,6 +291,85 @@ struct sh7372_pm_domain sh7372_a3sg = {
 	.genpd.name = "A3SG",
 	.bit_shift = 13,
 };
+
+struct rmobile_pm_domain sh7372_pd_a4lc = {
+	.genpd.name = "A4LC",
+	.bit_shift = 1,
+};
+
+struct rmobile_pm_domain sh7372_pd_a4mp = {
+	.genpd.name = "A4MP",
+	.bit_shift = 2,
+};
+
+struct rmobile_pm_domain sh7372_pd_d4 = {
+	.genpd.name = "D4",
+	.bit_shift = 3,
+};
+
+static int sh7372_a4r_pd_suspend(void)
+{
+	sh7372_intcs_suspend();
+	__raw_writel(0x300fffff, WUPRMSK); /* avoid wakeup */
+	return 0;
+}
+
+struct rmobile_pm_domain sh7372_pd_a4r = {
+	.genpd.name = "A4R",
+	.bit_shift = 5,
+	.suspend = sh7372_a4r_pd_suspend,
+	.resume = sh7372_intcs_resume,
+};
+
+struct rmobile_pm_domain sh7372_pd_a3rv = {
+	.genpd.name = "A3RV",
+	.bit_shift = 6,
+};
+
+struct rmobile_pm_domain sh7372_pd_a3ri = {
+	.genpd.name = "A3RI",
+	.bit_shift = 8,
+};
+
+static int sh7372_pd_a4s_suspend(void)
+{
+	/*
+	 * The A4S domain contains the CPU core and therefore it should
+	 * only be turned off if the CPU is in use.
+	 */
+	return -EBUSY;
+}
+
+struct rmobile_pm_domain sh7372_pd_a4s = {
+	.genpd.name = "A4S",
+	.bit_shift = 10,
+	.gov = &pm_domain_always_on_gov,
+	.no_debug = true,
+	.suspend = sh7372_pd_a4s_suspend,
+};
+
+static int sh7372_a3sp_pd_suspend(void)
+{
+	/*
+	 * Serial consoles make use of SCIF hardware located in A3SP,
+	 * keep such power domain on if "no_console_suspend" is set.
+	 */
+	return console_suspend_enabled ? 0 : -EBUSY;
+}
+
+struct rmobile_pm_domain sh7372_pd_a3sp = {
+	.genpd.name = "A3SP",
+	.bit_shift = 11,
+	.gov = &pm_domain_always_on_gov,
+	.no_debug = true,
+	.suspend = sh7372_a3sp_pd_suspend,
+};
+
+struct rmobile_pm_domain sh7372_pd_a3sg = {
+	.genpd.name = "A3SG",
+	.bit_shift = 13,
+};
+
 #endif /* CONFIG_PM */
 
 #if defined(CONFIG_SUSPEND) || defined(CONFIG_CPU_IDLE)
@@ -511,7 +591,7 @@ static int sh7372_enter_suspend(suspend_state_t suspend_state)
 		sh7372_setup_sysc(msk, msk2);
 
 		if (!console_suspend_enabled &&
-		    sh7372_a4s.genpd.status = GPD_STATE_POWER_OFF) {
+		    sh7372_pd_a4s.genpd.status = GPD_STATE_POWER_OFF) {
 			/* enter A4S sleep with PLLC0 off */
 			pr_debug("entering A4S\n");
 			sh7372_enter_a4s_common(0);
@@ -545,7 +625,7 @@ static int sh7372_pm_notifier_fn(struct notifier_block *notifier,
 		 * executed during system suspend and resume, respectively, so
 		 * that those functions don't crash while accessing the INTCS.
 		 */
-		pm_genpd_poweron(&sh7372_a4r.genpd);
+		pm_genpd_poweron(&sh7372_pd_a4r.genpd);
 		break;
 	case PM_POST_SUSPEND:
 		pm_genpd_poweroff_unused();
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 7873159..4b5f202 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1017,6 +1017,22 @@ void __init sh7372_add_standard_devices(void)
 	sh7372_pm_add_subdomain(&sh7372_a4s, &sh7372_a3sg);
 	sh7372_pm_add_subdomain(&sh7372_a4s, &sh7372_a3sp);
 
+	rmobile_init_pm_domain(&sh7372_pd_a4lc);
+	rmobile_init_pm_domain(&sh7372_pd_a4mp);
+	rmobile_init_pm_domain(&sh7372_pd_d4);
+	rmobile_init_pm_domain(&sh7372_pd_a4r);
+	rmobile_init_pm_domain(&sh7372_pd_a3rv);
+	rmobile_init_pm_domain(&sh7372_pd_a3ri);
+	rmobile_init_pm_domain(&sh7372_pd_a4s);
+	rmobile_init_pm_domain(&sh7372_pd_a3sp);
+	rmobile_init_pm_domain(&sh7372_pd_a3sg);
+
+	rmobile_pm_add_subdomain(&sh7372_pd_a4lc, &sh7372_pd_a3rv);
+	rmobile_pm_add_subdomain(&sh7372_pd_a4r, &sh7372_pd_a4lc);
+
+	rmobile_pm_add_subdomain(&sh7372_pd_a4s, &sh7372_pd_a3sg);
+	rmobile_pm_add_subdomain(&sh7372_pd_a4s, &sh7372_pd_a3sp);
+
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
@@ -1047,6 +1063,31 @@ void __init sh7372_add_standard_devices(void)
 	sh7372_add_device_to_domain(&sh7372_a4r, &jpu_device);
 	sh7372_add_device_to_domain(&sh7372_a4r, &tmu00_device);
 	sh7372_add_device_to_domain(&sh7372_a4r, &tmu01_device);
+
+	rmobile_add_device_to_domain(&sh7372_pd_a3rv, &vpu_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4mp, &spu0_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4mp, &spu1_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &scif0_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &scif1_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &scif2_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &scif3_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &scif4_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &scif5_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &scif6_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &iic1_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &dma0_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &dma1_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &dma2_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &usb_dma0_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a3sp, &usb_dma1_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4r, &iic0_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4r, &veu0_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4r, &veu1_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4r, &veu2_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4r, &veu3_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4r, &jpu_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4r, &tmu00_device);
+	rmobile_add_device_to_domain(&sh7372_pd_a4r, &tmu01_device);
 }
 
 static void __init sh7372_earlytimer_init(void)
-- 
1.7.5.4

