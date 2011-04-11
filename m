From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 Apr 2011 19:49:11 +0000
Subject: [PATCH/RFC] ARM: mach-shmobile: sh7372 power domain prototype
Message-Id: <20110411194911.7991.79950.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This experimental sh7372-specific Runtime PM prototype
adds support for the A4LC and A4MP power domains.

Tested on the Mackerel board together with the LCDC:

# blank HDMI fbdev
echo 3 > /sys/devices/platform/sh_mobile_lcdc_fb.1/graphics/fb1/blank

# blank LCD panel fbdev
echo 3 > /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank
# unblank LCD panel fbdev
echo 0 > /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pm_runtime.c |  227 ++++++++++++++++++++++++++++++++++-
 1 file changed, 222 insertions(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/pm_runtime.c
+++ work/arch/arm/mach-shmobile/pm_runtime.c	2011-04-12 04:37:17.000000000 +0900
@@ -3,7 +3,7 @@
  *
  * Runtime PM support code for SuperH Mobile ARM
  *
- *  Copyright (C) 2009-2010 Magnus Damm
+ *  Copyright (C) 2009-2011 Magnus Damm
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -20,13 +20,71 @@
 #include <linux/bitmap.h>
 
 #ifdef CONFIG_PM_RUNTIME
+
+struct pm_runtime_power_domain {
+	spinlock_t lock;
+	struct list_head idle_list;
+	unsigned int use_cnt;
+	unsigned int powered_off;
+	unsigned int power_domain_bit;
+};
+
+/* sh7372 specific stuff in common file, FIXME this should be broken out */
+
+static struct pm_runtime_power_domain sh7372_a4lc = {
+	.power_domain_bit = 1,
+};
+
+static struct pm_runtime_power_domain sh7372_a4mp = {
+	.power_domain_bit = 2,
+};
+
+#define SPDCR 0xe6180008
+#define SWUCR 0xe6180014
+#define PSTR 0xe6180080
+
+static void power_down(struct pm_runtime_power_domain *domain_data)
+{
+	unsigned int mask = 1 << domain_data->power_domain_bit;
+
+	if (__raw_readl(PSTR) & mask) {
+		__raw_writel(mask, SPDCR);
+
+		while (__raw_readl(SPDCR) & mask)
+			;
+
+		pr_info("sh7372 power domain down 0x%08x -> PSTR = 0x%08x\n",
+		       mask, __raw_readl(PSTR));
+	}
+}
+
+static void power_up(struct pm_runtime_power_domain *domain_data)
+{
+	unsigned int mask = 1 << domain_data->power_domain_bit;
+
+	if (!(__raw_readl(PSTR) & mask)) {
+		__raw_writel(mask, SWUCR);
+
+		while (__raw_readl(SWUCR) & mask)
+			;
+
+		pr_info("sh7372 power domain up 0x%08x -> PSTR = 0x%08x\n",
+			mask, __raw_readl(PSTR));
+	}
+}
+
 #define BIT_ONCE 0
 #define BIT_ACTIVE 1
 #define BIT_CLK_ENABLED 2
+#define BIT_SUSPENDED 3
 
 struct pm_runtime_data {
 	unsigned long flags;
 	struct clk *clk;
+
+	struct device *dev;
+	struct list_head entry; /* for pm_runtime_power_domain idle_list */
+	struct pm_runtime_power_domain *domain_data;
 };
 
 static void __devres_release(struct device *dev, void *res)
@@ -47,6 +105,159 @@ static struct pm_runtime_data *__to_prd(
 	return devres_find(dev, __devres_release, NULL, NULL);
 }
 
+static int __power_domain_runtime_suspend(struct device *d)
+{
+	struct pm_runtime_data *prd = __to_prd(d);
+	int ret = 0;
+
+	dev_dbg(d, "__power_domain_runtime_suspend()\n");
+
+	BUG_ON(!prd);
+
+	if (!test_bit(BIT_SUSPENDED, &prd->flags)) {
+		if (d->driver && d->driver->pm &&
+		    d->driver->pm->runtime_suspend) {
+			if (!test_bit(BIT_CLK_ENABLED, &prd->flags))
+				clk_enable(prd->clk);
+			ret = d->driver->pm->runtime_suspend(d);
+			clk_disable(prd->clk);
+			clear_bit(BIT_CLK_ENABLED, &prd->flags);
+
+			if (ret = 0)
+				set_bit(BIT_SUSPENDED, &prd->flags);
+		}
+	}
+
+	return ret;
+}
+
+static int power_domain_runtime_suspend(struct device *dev)
+{
+	struct pm_runtime_data *prd = __to_prd(dev);
+	struct pm_runtime_power_domain *domain_data = prd->domain_data;
+	unsigned long flags;
+	int ret = 0;
+
+	dev_dbg(dev, "power_domain_runtime_suspend() %d\n",
+		domain_data->use_cnt);
+
+	spin_lock_irqsave(&domain_data->lock, flags);
+
+	list_add_tail(&prd->entry, &domain_data->idle_list);
+	domain_data->use_cnt--;
+
+	if (domain_data->use_cnt = 0) {
+		struct pm_runtime_data *p;
+
+		list_for_each_entry(p, &domain_data->idle_list, entry) {
+			ret = __power_domain_runtime_suspend(p->dev);
+			if (ret)
+				break;
+		}
+
+		if (ret = 0)
+			power_down(domain_data);
+	}
+
+	spin_unlock_irqrestore(&domain_data->lock, flags);
+
+	return ret;
+}
+
+static int __power_domain_runtime_resume(struct device *d)
+{
+	struct pm_runtime_data *prd = __to_prd(d);
+	int ret = 0;
+
+	dev_dbg(d, "__power_domain_runtime_resume()\n");
+
+	BUG_ON(!prd);
+
+	if (test_bit(BIT_SUSPENDED, &prd->flags)) {
+		if (!test_bit(BIT_CLK_ENABLED, &prd->flags)) {
+			clk_enable(prd->clk);
+			set_bit(BIT_CLK_ENABLED, &prd->flags);
+		}
+
+		if (d->driver && d->driver->pm &&
+		    d->driver->pm->runtime_resume)
+			ret = d->driver->pm->runtime_resume(d);
+
+		if (ret = 0)
+			clear_bit(BIT_SUSPENDED, &prd->flags);
+		else {
+			clk_disable(prd->clk);
+			clear_bit(BIT_CLK_ENABLED, &prd->flags);
+		}
+	}
+
+	return ret;
+}
+
+static int power_domain_runtime_resume(struct device *dev)
+{
+	struct pm_runtime_data *prd = __to_prd(dev);
+	struct pm_runtime_power_domain *domain_data = prd->domain_data;
+	unsigned long flags;
+	int ret = 0;
+
+	dev_dbg(dev, "power_domain_runtime_resume() %d\n",
+		domain_data->use_cnt);
+
+	spin_lock_irqsave(&domain_data->lock, flags);
+
+	if (domain_data->use_cnt = 0)
+		power_up(domain_data);
+
+	ret = __power_domain_runtime_resume(dev);
+
+	if (ret = 0) {
+		domain_data->use_cnt++;
+		list_del(&prd->entry);
+	} else {
+		if (domain_data->use_cnt = 0)
+			power_down(domain_data);
+	}
+
+	spin_unlock_irqrestore(&domain_data->lock, flags);
+
+	return ret;
+}
+
+static struct dev_power_domain power_domain = {
+	.ops.runtime_suspend = power_domain_runtime_suspend,
+	.ops.runtime_resume = power_domain_runtime_resume,
+};
+
+static void power_domain_init(struct device *dev, struct pm_runtime_data *prd)
+{
+	struct pm_runtime_power_domain *domain_data = NULL;
+
+	if (strcmp(dev_name(dev), "sh_mobile_lcdc_fb.0") = 0)
+		domain_data = &sh7372_a4lc;
+
+	if (strcmp(dev_name(dev), "sh_mobile_lcdc_fb.1") = 0)
+		domain_data = &sh7372_a4lc;
+
+	if (strcmp(dev_name(dev), "sh_fsi2") = 0)
+		domain_data = &sh7372_a4mp;
+
+	if (domain_data) {
+		dev->pwr_domain = &power_domain;
+		prd->dev = dev;
+		INIT_LIST_HEAD(&prd->entry);
+		prd->domain_data = domain_data;
+		domain_data->use_cnt++;
+		if (domain_data->use_cnt = 1) {
+			INIT_LIST_HEAD(&domain_data->idle_list);
+			spin_lock_init(&domain_data->lock);
+		}
+
+		dev_dbg(dev, "domain data available use cnt = %d\n",
+			domain_data->use_cnt);
+	}
+}
+
 static void platform_pm_runtime_init(struct device *dev,
 				     struct pm_runtime_data *prd)
 {
@@ -55,6 +266,7 @@ static void platform_pm_runtime_init(str
 		if (!IS_ERR(prd->clk)) {
 			set_bit(BIT_ACTIVE, &prd->flags);
 			dev_info(dev, "clocks managed by runtime pm\n");
+			power_domain_init(dev, prd);
 		}
 	}
 }
@@ -75,8 +287,11 @@ int platform_pm_runtime_suspend(struct d
 	platform_pm_runtime_bug(dev, prd);
 
 	if (prd && test_bit(BIT_ACTIVE, &prd->flags)) {
-		clk_disable(prd->clk);
-		clear_bit(BIT_CLK_ENABLED, &prd->flags);
+		if (test_bit(BIT_CLK_ENABLED, &prd->flags)) {
+			clk_disable(prd->clk);
+			clear_bit(BIT_CLK_ENABLED, &prd->flags);
+		}
+
 	}
 
 	return 0;
@@ -91,8 +306,10 @@ int platform_pm_runtime_resume(struct de
 	platform_pm_runtime_init(dev, prd);
 
 	if (prd && test_bit(BIT_ACTIVE, &prd->flags)) {
-		clk_enable(prd->clk);
-		set_bit(BIT_CLK_ENABLED, &prd->flags);
+		if (!test_bit(BIT_CLK_ENABLED, &prd->flags)) {
+			clk_enable(prd->clk);
+			set_bit(BIT_CLK_ENABLED, &prd->flags);
+		}
 	}
 
 	return 0;
