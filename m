From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jul 2012 08:29:37 +0000
Subject: [PATCH 12/12 v2] ARM: shmobile: sh7372: completely switch over to using pm-rmobile API
Message-Id: <87obnupq4y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now, all sh7372 platforms are switched over to use pm-rmobile base PM domain,
and no one is using original sh7372_pm_domain APIs.
We can remove these, switching has been fully completed.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - based on pm-rmobile

 arch/arm/mach-shmobile/include/mach/sh7372.h |   36 ----
 arch/arm/mach-shmobile/pm-sh7372.c           |  221 --------------------------
 arch/arm/mach-shmobile/setup-sh7372.c        |   41 -----
 3 files changed, 0 insertions(+), 298 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index a7620c1..b59048e 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -478,22 +478,6 @@ extern struct clk sh7372_fsibck_clk;
 extern struct clk sh7372_fsidiva_clk;
 extern struct clk sh7372_fsidivb_clk;
 
-struct platform_device;
-
-struct sh7372_pm_domain {
-	struct generic_pm_domain genpd;
-	struct dev_power_governor *gov;
-	int (*suspend)(void);
-	void (*resume)(void);
-	unsigned int bit_shift;
-	bool no_debug;
-};
-
-static inline struct sh7372_pm_domain *to_sh7372_pd(struct generic_pm_domain *d)
-{
-	return container_of(d, struct sh7372_pm_domain, genpd);
-}
-
 #ifdef CONFIG_PM
 extern struct rmobile_pm_domain sh7372_pd_a4lc;
 extern struct rmobile_pm_domain sh7372_pd_a4mp;
@@ -504,26 +488,6 @@ extern struct rmobile_pm_domain sh7372_pd_a3ri;
 extern struct rmobile_pm_domain sh7372_pd_a4s;
 extern struct rmobile_pm_domain sh7372_pd_a3sp;
 extern struct rmobile_pm_domain sh7372_pd_a3sg;
-
-extern struct sh7372_pm_domain sh7372_a4lc;
-extern struct sh7372_pm_domain sh7372_a4mp;
-extern struct sh7372_pm_domain sh7372_d4;
-extern struct sh7372_pm_domain sh7372_a4r;
-extern struct sh7372_pm_domain sh7372_a3rv;
-extern struct sh7372_pm_domain sh7372_a3ri;
-extern struct sh7372_pm_domain sh7372_a4s;
-extern struct sh7372_pm_domain sh7372_a3sp;
-extern struct sh7372_pm_domain sh7372_a3sg;
-
-extern void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd);
-extern void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
-					struct platform_device *pdev);
-extern void sh7372_pm_add_subdomain(struct sh7372_pm_domain *sh7372_pd,
-				    struct sh7372_pm_domain *sh7372_sd);
-#else
-#define sh7372_init_pm_domain(pd) do { } while(0)
-#define sh7372_add_device_to_domain(pd, pdev) do { } while(0)
-#define sh7372_pm_add_subdomain(pd, sd) do { } while(0)
 #endif /* CONFIG_PM */
 
 extern void sh7372_intcs_suspend(void);
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index 5175336..e5290b56 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -42,13 +42,10 @@
 #define PLLC01STPCR 0xe61500c8
 
 /* SYSC */
-#define SPDCR 0xe6180008
-#define SWUCR 0xe6180014
 #define SBAR 0xe6180020
 #define WUPRMSK 0xe6180028
 #define WUPSMSK 0xe618002c
 #define WUPSMSK2 0xe6180048
-#define PSTR 0xe6180080
 #define WUPSFAC 0xe6180098
 #define IRQCR 0xe618022c
 #define IRQCR2 0xe6180238
@@ -72,226 +69,8 @@
 /* AP-System Core */
 #define APARMBAREA 0xe6f10020
 
-#define PSTR_RETRIES 100
-#define PSTR_DELAY_US 10
-
 #ifdef CONFIG_PM
 
-static int pd_power_down(struct generic_pm_domain *genpd)
-{
-	struct sh7372_pm_domain *sh7372_pd = to_sh7372_pd(genpd);
-	unsigned int mask = 1 << sh7372_pd->bit_shift;
-
-	if (sh7372_pd->suspend) {
-		int ret = sh7372_pd->suspend();
-
-		if (ret)
-			return ret;
-	}
-
-	if (__raw_readl(PSTR) & mask) {
-		unsigned int retry_count;
-
-		__raw_writel(mask, SPDCR);
-
-		for (retry_count = PSTR_RETRIES; retry_count; retry_count--) {
-			if (!(__raw_readl(SPDCR) & mask))
-				break;
-			cpu_relax();
-		}
-	}
-
-	if (!sh7372_pd->no_debug)
-		pr_debug("%s: Power off, 0x%08x -> PSTR = 0x%08x\n",
-			 genpd->name, mask, __raw_readl(PSTR));
-
-	return 0;
-}
-
-static int __pd_power_up(struct sh7372_pm_domain *sh7372_pd, bool do_resume)
-{
-	unsigned int mask = 1 << sh7372_pd->bit_shift;
-	unsigned int retry_count;
-	int ret = 0;
-
-	if (__raw_readl(PSTR) & mask)
-		goto out;
-
-	__raw_writel(mask, SWUCR);
-
-	for (retry_count = 2 * PSTR_RETRIES; retry_count; retry_count--) {
-		if (!(__raw_readl(SWUCR) & mask))
-			break;
-		if (retry_count > PSTR_RETRIES)
-			udelay(PSTR_DELAY_US);
-		else
-			cpu_relax();
-	}
-	if (!retry_count)
-		ret = -EIO;
-
-	if (!sh7372_pd->no_debug)
-		pr_debug("%s: Power on, 0x%08x -> PSTR = 0x%08x\n",
-			 sh7372_pd->genpd.name, mask, __raw_readl(PSTR));
-
- out:
-	if (ret = 0 && sh7372_pd->resume && do_resume)
-		sh7372_pd->resume();
-
-	return ret;
-}
-
-static int pd_power_up(struct generic_pm_domain *genpd)
-{
-	 return __pd_power_up(to_sh7372_pd(genpd), true);
-}
-
-static int sh7372_a4r_suspend(void)
-{
-	sh7372_intcs_suspend();
-	__raw_writel(0x300fffff, WUPRMSK); /* avoid wakeup */
-	return 0;
-}
-
-static bool pd_active_wakeup(struct device *dev)
-{
-	bool (*active_wakeup)(struct device *dev);
-
-	active_wakeup = dev_gpd_data(dev)->ops.active_wakeup;
-	return active_wakeup ? active_wakeup(dev) : true;
-}
-
-static int sh7372_stop_dev(struct device *dev)
-{
-	int (*stop)(struct device *dev);
-
-	stop = dev_gpd_data(dev)->ops.stop;
-	if (stop) {
-		int ret = stop(dev);
-		if (ret)
-			return ret;
-	}
-	return pm_clk_suspend(dev);
-}
-
-static int sh7372_start_dev(struct device *dev)
-{
-	int (*start)(struct device *dev);
-	int ret;
-
-	ret = pm_clk_resume(dev);
-	if (ret)
-		return ret;
-
-	start = dev_gpd_data(dev)->ops.start;
-	if (start)
-		ret = start(dev);
-
-	return ret;
-}
-
-void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd)
-{
-	struct generic_pm_domain *genpd = &sh7372_pd->genpd;
-	struct dev_power_governor *gov = sh7372_pd->gov;
-
-	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
-	genpd->dev_ops.stop = sh7372_stop_dev;
-	genpd->dev_ops.start = sh7372_start_dev;
-	genpd->dev_ops.active_wakeup = pd_active_wakeup;
-	genpd->dev_irq_safe = true;
-	genpd->power_off = pd_power_down;
-	genpd->power_on = pd_power_up;
-	__pd_power_up(sh7372_pd, false);
-}
-
-void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
-				 struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-
-	pm_genpd_add_device(&sh7372_pd->genpd, dev);
-	if (pm_clk_no_clocks(dev))
-		pm_clk_add(dev, NULL);
-}
-
-void sh7372_pm_add_subdomain(struct sh7372_pm_domain *sh7372_pd,
-			     struct sh7372_pm_domain *sh7372_sd)
-{
-	pm_genpd_add_subdomain(&sh7372_pd->genpd, &sh7372_sd->genpd);
-}
-
-struct sh7372_pm_domain sh7372_a4lc = {
-	.genpd.name = "A4LC",
-	.bit_shift = 1,
-};
-
-struct sh7372_pm_domain sh7372_a4mp = {
-	.genpd.name = "A4MP",
-	.bit_shift = 2,
-};
-
-struct sh7372_pm_domain sh7372_d4 = {
-	.genpd.name = "D4",
-	.bit_shift = 3,
-};
-
-struct sh7372_pm_domain sh7372_a4r = {
-	.genpd.name = "A4R",
-	.bit_shift = 5,
-	.suspend = sh7372_a4r_suspend,
-	.resume = sh7372_intcs_resume,
-};
-
-struct sh7372_pm_domain sh7372_a3rv = {
-	.genpd.name = "A3RV",
-	.bit_shift = 6,
-};
-
-struct sh7372_pm_domain sh7372_a3ri = {
-	.genpd.name = "A3RI",
-	.bit_shift = 8,
-};
-
-static int sh7372_a4s_suspend(void)
-{
-	/*
-	 * The A4S domain contains the CPU core and therefore it should
-	 * only be turned off if the CPU is in use.
-	 */
-	return -EBUSY;
-}
-
-struct sh7372_pm_domain sh7372_a4s = {
-	.genpd.name = "A4S",
-	.bit_shift = 10,
-	.gov = &pm_domain_always_on_gov,
-	.no_debug = true,
-	.suspend = sh7372_a4s_suspend,
-};
-
-static int sh7372_a3sp_suspend(void)
-{
-	/*
-	 * Serial consoles make use of SCIF hardware located in A3SP,
-	 * keep such power domain on if "no_console_suspend" is set.
-	 */
-	return console_suspend_enabled ? 0 : -EBUSY;
-}
-
-struct sh7372_pm_domain sh7372_a3sp = {
-	.genpd.name = "A3SP",
-	.bit_shift = 11,
-	.gov = &pm_domain_always_on_gov,
-	.no_debug = true,
-	.suspend = sh7372_a3sp_suspend,
-};
-
-struct sh7372_pm_domain sh7372_a3sg = {
-	.genpd.name = "A3SG",
-	.bit_shift = 13,
-};
-
 struct rmobile_pm_domain sh7372_pd_a4lc = {
 	.genpd.name = "A4LC",
 	.bit_shift = 1,
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 4b5f202..838a87b 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1001,22 +1001,6 @@ static struct platform_device *sh7372_late_devices[] __initdata = {
 
 void __init sh7372_add_standard_devices(void)
 {
-	sh7372_init_pm_domain(&sh7372_a4lc);
-	sh7372_init_pm_domain(&sh7372_a4mp);
-	sh7372_init_pm_domain(&sh7372_d4);
-	sh7372_init_pm_domain(&sh7372_a4r);
-	sh7372_init_pm_domain(&sh7372_a3rv);
-	sh7372_init_pm_domain(&sh7372_a3ri);
-	sh7372_init_pm_domain(&sh7372_a4s);
-	sh7372_init_pm_domain(&sh7372_a3sp);
-	sh7372_init_pm_domain(&sh7372_a3sg);
-
-	sh7372_pm_add_subdomain(&sh7372_a4lc, &sh7372_a3rv);
-	sh7372_pm_add_subdomain(&sh7372_a4r, &sh7372_a4lc);
-
-	sh7372_pm_add_subdomain(&sh7372_a4s, &sh7372_a3sg);
-	sh7372_pm_add_subdomain(&sh7372_a4s, &sh7372_a3sp);
-
 	rmobile_init_pm_domain(&sh7372_pd_a4lc);
 	rmobile_init_pm_domain(&sh7372_pd_a4mp);
 	rmobile_init_pm_domain(&sh7372_pd_d4);
@@ -1039,31 +1023,6 @@ void __init sh7372_add_standard_devices(void)
 	platform_add_devices(sh7372_late_devices,
 			    ARRAY_SIZE(sh7372_late_devices));
 
-	sh7372_add_device_to_domain(&sh7372_a3rv, &vpu_device);
-	sh7372_add_device_to_domain(&sh7372_a4mp, &spu0_device);
-	sh7372_add_device_to_domain(&sh7372_a4mp, &spu1_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &scif0_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &scif1_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &scif2_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &scif3_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &scif4_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &scif5_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &scif6_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &iic1_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &dma0_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &dma1_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &dma2_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &usb_dma0_device);
-	sh7372_add_device_to_domain(&sh7372_a3sp, &usb_dma1_device);
-	sh7372_add_device_to_domain(&sh7372_a4r, &iic0_device);
-	sh7372_add_device_to_domain(&sh7372_a4r, &veu0_device);
-	sh7372_add_device_to_domain(&sh7372_a4r, &veu1_device);
-	sh7372_add_device_to_domain(&sh7372_a4r, &veu2_device);
-	sh7372_add_device_to_domain(&sh7372_a4r, &veu3_device);
-	sh7372_add_device_to_domain(&sh7372_a4r, &jpu_device);
-	sh7372_add_device_to_domain(&sh7372_a4r, &tmu00_device);
-	sh7372_add_device_to_domain(&sh7372_a4r, &tmu01_device);
-
 	rmobile_add_device_to_domain(&sh7372_pd_a3rv, &vpu_device);
 	rmobile_add_device_to_domain(&sh7372_pd_a4mp, &spu0_device);
 	rmobile_add_device_to_domain(&sh7372_pd_a4mp, &spu1_device);
-- 
1.7.5.4

