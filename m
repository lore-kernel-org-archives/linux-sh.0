From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:31:05 +0000
Subject: [PATCH][RFC] ARM: shmobile: r8a7740: basic PM domain support
Message-Id: <87ehp3lm3e.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

PM domain specification between sh7372 and r8a7740 was very similar.
This patch adds PM domain support for r8a7740 based on sh7372.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Makefile               |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7740.h |   35 +++++
 arch/arm/mach-shmobile/pm-r8a7740.c           |  200 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c        |   20 +++
 4 files changed, 256 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/pm-r8a7740.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 8aa1962..4919d73 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_ARCH_R8A7740)	+= entry-intc.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
+obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 
 # Board objects
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 6468fcc..0dd6361 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -19,6 +19,8 @@
 #ifndef __ASM_R8A7740_H__
 #define __ASM_R8A7740_H__
 
+#include <linux/pm_domain.h>
+
 /*
  * MD_CKx pin
  */
@@ -588,4 +590,37 @@ enum {
 	GPIO_FN_TRACEAUD_FROM_MEMC,
 };
 
+struct platform_device;
+
+struct r8a7740_pm_domain {
+	struct generic_pm_domain genpd;
+	struct dev_power_governor *gov;
+	int (*suspend)(void);
+	void (*resume)(void);
+	unsigned int bit_shift;
+	bool no_debug;
+};
+
+static inline
+struct r8a7740_pm_domain *to_r8a7740_pd(struct generic_pm_domain *d)
+{
+	return container_of(d, struct r8a7740_pm_domain, genpd);
+}
+
+#ifdef CONFIG_PM
+extern struct r8a7740_pm_domain r8a7740_a4s;
+extern struct r8a7740_pm_domain r8a7740_a3sp;
+
+extern void r8a7740_init_pm_domain(struct r8a7740_pm_domain *r8a7740_pd);
+extern void r8a7740_add_device_to_domain(struct r8a7740_pm_domain *r8a7740_pd,
+					struct platform_device *pdev);
+extern void r8a7740_pm_add_subdomain(struct r8a7740_pm_domain *r8a7740_pd,
+				    struct r8a7740_pm_domain *r8a7740_sd);
+#else
+#define r8a7740_init_pm_domain(pd) do { } while (0)
+#define r8a7740_add_device_to_domain(pd, pdev) do { } while (0)
+#define r8a7740_pm_add_subdomain(pd, sd) do { } while (0)
+#endif /* CONFIG_PM */
+
+
 #endif /* __ASM_R8A7740_H__ */
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
new file mode 100644
index 0000000..faa0254
--- /dev/null
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -0,0 +1,200 @@
+/*
+ * r8a7740 power management support
+ *
+ * Copyright (C) 2012  Renesas Solutions Corp.
+ * Copyright (C) 2012  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * based on pm-sh7372.c
+ *  Copyright (C) 2011 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_clock.h>
+#include <asm/io.h>
+#include <mach/r8a7740.h>
+
+/* SYSC */
+#define SPDCR		0xe6180008
+#define SWUCR		0xe6180014
+#define PSTR		0xe6180080
+
+#define PSTR_RETRIES	100
+#define PSTR_DELAY_US	10
+
+#ifdef CONFIG_PM
+static int pd_power_down(struct generic_pm_domain *genpd)
+{
+	struct r8a7740_pm_domain *r8a7740_pd = to_r8a7740_pd(genpd);
+	unsigned int mask = 1 << r8a7740_pd->bit_shift;
+
+	if (r8a7740_pd->suspend) {
+		int ret = r8a7740_pd->suspend();
+
+		if (ret)
+			return ret;
+	}
+
+	if (__raw_readl(PSTR) & mask) {
+		unsigned int retry_count;
+		__raw_writel(mask, SPDCR);
+
+		for (retry_count = PSTR_RETRIES; retry_count; retry_count--) {
+			if (!(__raw_readl(SPDCR) & mask))
+				break;
+			cpu_relax();
+		}
+	}
+
+	if (!r8a7740_pd->no_debug)
+		pr_debug("%s: Power off, 0x%08x -> PSTR = 0x%08x\n",
+			 genpd->name, mask, __raw_readl(PSTR));
+
+	return 0;
+}
+
+static int __pd_power_up(struct r8a7740_pm_domain *r8a7740_pd, bool do_resume)
+{
+	unsigned int mask = 1 << r8a7740_pd->bit_shift;
+	unsigned int retry_count;
+	int ret = 0;
+
+	if (__raw_readl(PSTR) & mask)
+		goto out;
+
+	__raw_writel(mask, SWUCR);
+
+	for (retry_count = 2 * PSTR_RETRIES; retry_count; retry_count--) {
+		if (!(__raw_readl(SWUCR) & mask))
+			break;
+		if (retry_count > PSTR_RETRIES)
+			udelay(PSTR_DELAY_US);
+		else
+			cpu_relax();
+	}
+	if (!retry_count)
+		ret = -EIO;
+
+	if (!r8a7740_pd->no_debug)
+		pr_debug("%s: Power on, 0x%08x -> PSTR = 0x%08x\n",
+			 r8a7740_pd->genpd.name, mask, __raw_readl(PSTR));
+
+out:
+	if (ret = 0 && r8a7740_pd->resume && do_resume)
+		r8a7740_pd->resume();
+
+	return ret;
+}
+
+static int pd_power_up(struct generic_pm_domain *genpd)
+{
+	return __pd_power_up(to_r8a7740_pd(genpd), true);
+}
+
+static bool pd_active_wakeup(struct device *dev)
+{
+	bool (*active_wakeup)(struct device *dev);
+
+	active_wakeup = dev_gpd_data(dev)->ops.active_wakeup;
+	return active_wakeup ? active_wakeup(dev) : true;
+}
+
+static int r8a7740_stop_dev(struct device *dev)
+{
+	int (*stop)(struct device *dev);
+
+	stop = dev_gpd_data(dev)->ops.stop;
+	if (stop) {
+		int ret = stop(dev);
+		if (ret)
+			return ret;
+	}
+	return pm_clk_suspend(dev);
+}
+
+static int r8a7740_start_dev(struct device *dev)
+{
+	int (*start)(struct device *dev);
+	int ret;
+
+	ret = pm_clk_resume(dev);
+	if (ret)
+		return ret;
+
+	start = dev_gpd_data(dev)->ops.start;
+	if (start)
+		ret = start(dev);
+
+	return ret;
+}
+
+void r8a7740_init_pm_domain(struct r8a7740_pm_domain *r8a7740_pd)
+{
+	struct generic_pm_domain *genpd = &r8a7740_pd->genpd;
+	struct dev_power_governor *gov = r8a7740_pd->gov;
+
+	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
+	genpd->dev_ops.stop		= r8a7740_stop_dev;
+	genpd->dev_ops.start		= r8a7740_start_dev;
+	genpd->dev_ops.active_wakeup	= pd_active_wakeup;
+	genpd->dev_irq_safe		= true;
+	genpd->power_off		= pd_power_down;
+	genpd->power_on			= pd_power_up;
+	__pd_power_up(r8a7740_pd, false);
+}
+
+void r8a7740_add_device_to_domain(struct r8a7740_pm_domain *r8a7740_pd,
+				 struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	pm_genpd_add_device(&r8a7740_pd->genpd, dev);
+	if (pm_clk_no_clocks(dev))
+		pm_clk_add(dev, NULL);
+}
+
+void r8a7740_pm_add_subdomain(struct r8a7740_pm_domain *r8a7740_pd,
+			     struct r8a7740_pm_domain *r8a7740_sd)
+{
+	pm_genpd_add_subdomain(&r8a7740_pd->genpd, &r8a7740_sd->genpd);
+}
+
+static int r8a7740_a4s_suspend(void)
+{
+	/*
+	 * The A4S domain contains the CPU core and therefore it should
+	 * only be turned off if the CPU is in use.
+	 */
+	return -EBUSY;
+}
+
+struct r8a7740_pm_domain r8a7740_a4s = {
+	.genpd.name	= "A4S",
+	.bit_shift	= 10,
+	.gov		= &pm_domain_always_on_gov,
+	.no_debug	= true,
+	.suspend	= r8a7740_a4s_suspend,
+};
+
+static int r8a7740_a3sp_suspend(void)
+{
+	/*
+	 * Serial consoles make use of SCIF hardware located in A3SP,
+	 * keep such power domain on if "no_console_suspend" is set.
+	 */
+	return console_suspend_enabled ? 0 : -EBUSY;
+}
+
+struct r8a7740_pm_domain r8a7740_a3sp = {
+	.genpd.name	= "A3SP",
+	.bit_shift	= 11,
+	.gov		= &pm_domain_always_on_gov,
+	.no_debug	= true,
+	.suspend	= r8a7740_a3sp_suspend,
+};
+#endif /* CONFIG_PM */
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 366311b..05a4660 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -398,10 +398,30 @@ void __init r8a7740_add_standard_devices(void)
 	r8a7740_i2c_workaround(&i2c0_device);
 	r8a7740_i2c_workaround(&i2c1_device);
 
+	/* PM domain */
+	r8a7740_init_pm_domain(&r8a7740_a4s);
+	r8a7740_init_pm_domain(&r8a7740_a3sp);
+
+	r8a7740_pm_add_subdomain(&r8a7740_a4s, &r8a7740_a3sp);
+
+	/* add devices */
 	platform_add_devices(r8a7740_early_devices,
 			    ARRAY_SIZE(r8a7740_early_devices));
 	platform_add_devices(r8a7740_late_devices,
 			     ARRAY_SIZE(r8a7740_late_devices));
+
+	/* add devices to PM domain  */
+
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif0_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif1_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif2_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif3_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif4_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif5_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif6_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif7_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scifb_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&i2c1_device);
 }
 
 static void __init r8a7740_earlytimer_init(void)
-- 
1.7.5.4

