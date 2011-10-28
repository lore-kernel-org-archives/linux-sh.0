From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Oct 2011 10:53:19 +0000
Subject: Re: Question about clk->usecount
Message-Id: <87r51x9yli.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwihj3x8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwihj3x8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul
Cc Magnus, Rafael

Thank you for your reply

> > Does hwblk/pm_runtime (?) not care clk->usecount ?
> 
> I suspect this is a result of hwblk bitrot with regards to the rest of
> the runtime PM changes. We can of course simply inhibit the late clock
> disabling, but the proper solution would be to fix up (or simply kill
> off) the hwblk bits completely.
> 
> We can also just add a kernel command line option for inhibiting the late
> disable for testing/development cases, but this is not something we'd
> want to rely on in general.

I investigated hwblk, and I noticed that arch/sh pm_runtime seems
enable/disable hwblk by direct access (out of clk framework).
I guess this is the reason why clk->usecount is 0.

Below is very x10 rough patch which try to use clk framework on hwblk/pm_runtime.
But DON'T believe it, because I'm not good at hwblk/pm_runtime you know.

it seems rescue sh_eth on Ecovec board for me.
But NOT be well tested ;P

Magnus, Rafael

Does this patch become hint to fix this issue ?

---
 arch/sh/include/asm/hwblk.h              |    5 ++-
 arch/sh/kernel/cpu/hwblk.c               |   18 ++++++++++++--
 arch/sh/kernel/cpu/shmobile/pm_runtime.c |   36 ++++++++++++++++++++++++-----
 3 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/arch/sh/include/asm/hwblk.h b/arch/sh/include/asm/hwblk.h
index 855e945..85515ef 100644
--- a/arch/sh/include/asm/hwblk.h
+++ b/arch/sh/include/asm/hwblk.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_SH_HWBLK_H
 #define __ASM_SH_HWBLK_H
 
+#include <linux/clk.h>
 #include <asm/clock.h>
 #include <asm/io.h>
 
@@ -35,6 +36,7 @@ struct hwblk {
 	unsigned char bit;
 	unsigned char area;
 	int cnt[HWBLK_CNT_NR];
+	struct clk *clk;
 };
 
 struct hwblk_info {
@@ -51,8 +53,7 @@ int arch_hwblk_sleep_mode(void);
 int hwblk_register(struct hwblk_info *info);
 int hwblk_init(void);
 
-void hwblk_enable(struct hwblk_info *info, int hwblk);
-void hwblk_disable(struct hwblk_info *info, int hwblk);
+struct clk* hwblk_get_clk(struct hwblk_info *info, int hwblk);
 
 void hwblk_cnt_inc(struct hwblk_info *info, int hwblk, int cnt);
 void hwblk_cnt_dec(struct hwblk_info *info, int hwblk, int cnt);
diff --git a/arch/sh/kernel/cpu/hwblk.c b/arch/sh/kernel/cpu/hwblk.c
index 3e985aa..b982bad 100644
--- a/arch/sh/kernel/cpu/hwblk.c
+++ b/arch/sh/kernel/cpu/hwblk.c
@@ -55,7 +55,14 @@ void hwblk_cnt_dec(struct hwblk_info *info, int hwblk, int counter)
 	hwblk_mod_cnt(info, hwblk, counter, -1, 0);
 }
 
-void hwblk_enable(struct hwblk_info *info, int hwblk)
+struct clk* hwblk_get_clk(struct hwblk_info *info, int hwblk)
+{
+	struct hwblk *hp = info->hwblks + hwblk;
+
+	return hp->clk;
+}
+
+static void hwblk_enable(struct hwblk_info *info, int hwblk)
 {
 	struct hwblk *hp = info->hwblks + hwblk;
 	unsigned long tmp;
@@ -74,7 +81,7 @@ void hwblk_enable(struct hwblk_info *info, int hwblk)
 	spin_unlock_irqrestore(&hwblk_lock, flags);
 }
 
-void hwblk_disable(struct hwblk_info *info, int hwblk)
+static void hwblk_disable(struct hwblk_info *info, int hwblk)
 {
 	struct hwblk *hp = info->hwblks + hwblk;
 	unsigned long tmp;
@@ -152,7 +159,12 @@ int __init sh_hwblk_clk_register(struct clk *clks, int nr)
 			continue;
 
 		clkp->ops = &sh_hwblk_clk_ops;
-		ret |= clk_register(clkp);
+		ret = clk_register(clkp);
+		if (ret < 0)
+			return ret;
+
+		if (hwblk_info)
+			hwblk_info->hwblks[k].clk = clkp;
 	}
 
 	return ret;
diff --git a/arch/sh/kernel/cpu/shmobile/pm_runtime.c b/arch/sh/kernel/cpu/shmobile/pm_runtime.c
index bf280c8..aa20456 100644
--- a/arch/sh/kernel/cpu/shmobile/pm_runtime.c
+++ b/arch/sh/kernel/cpu/shmobile/pm_runtime.c
@@ -40,13 +40,18 @@ static int __platform_pm_runtime_resume(struct platform_device *pdev)
 {
 	struct device *d = &pdev->dev;
 	struct pdev_archdata *ad = &pdev->archdata;
+	struct clk *clk;
 	int hwblk = ad->hwblk_id;
 	int ret = -ENOSYS;
 
 	dev_dbg(d, "__platform_pm_runtime_resume() [%d]\n", hwblk);
 
+	clk = hwblk_get_clk(hwblk_info, hwblk);
+	if (!clk)
+		return -EIO;
+
 	if (d->driver) {
-		hwblk_enable(hwblk_info, hwblk);
+		clk_enable(clk);
 		ret = 0;
 
 		if (test_bit(PDEV_ARCHDATA_FLAG_SUSP, &ad->flags)) {
@@ -56,7 +61,7 @@ static int __platform_pm_runtime_resume(struct platform_device *pdev)
 			if (!ret)
 				clear_bit(PDEV_ARCHDATA_FLAG_SUSP, &ad->flags);
 			else
-				hwblk_disable(hwblk_info, hwblk);
+				clk_disable(clk);
 		}
 	}
 
@@ -70,9 +75,14 @@ static int __platform_pm_runtime_suspend(struct platform_device *pdev)
 {
 	struct device *d = &pdev->dev;
 	struct pdev_archdata *ad = &pdev->archdata;
+	struct clk *clk;
 	int hwblk = ad->hwblk_id;
 	int ret = -ENOSYS;
 
+	clk = hwblk_get_clk(hwblk_info, hwblk);
+	if (!clk)
+		return -EIO;
+
 	dev_dbg(d, "__platform_pm_runtime_suspend() [%d]\n", hwblk);
 
 	if (d->driver) {
@@ -80,9 +90,9 @@ static int __platform_pm_runtime_suspend(struct platform_device *pdev)
 		ret = 0;
 
 		if (d->driver->pm && d->driver->pm->runtime_suspend) {
-			hwblk_enable(hwblk_info, hwblk);
+			clk_enable(clk);
 			ret = d->driver->pm->runtime_suspend(d);
-			hwblk_disable(hwblk_info, hwblk);
+			clk_disable(clk);
 		}
 
 		if (!ret) {
@@ -143,6 +153,7 @@ static int default_platform_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pdev_archdata *ad = &pdev->archdata;
+	struct clk *clk;
 	unsigned long flags;
 	int hwblk = ad->hwblk_id;
 	int ret = 0;
@@ -153,6 +164,12 @@ static int default_platform_runtime_suspend(struct device *dev)
 	if (!hwblk)
 		goto out;
 
+	clk = hwblk_get_clk(hwblk_info, hwblk);
+	if (!clk) {
+		ret = -EIO;
+		goto out;
+	}
+
 	/* interrupt context not allowed */
 	might_sleep();
 
@@ -166,7 +183,7 @@ static int default_platform_runtime_suspend(struct device *dev)
 	mutex_lock(&ad->mutex);
 
 	/* disable clock */
-	hwblk_disable(hwblk_info, hwblk);
+	clk_disable(clk);
 
 	/* put device on idle list */
 	spin_lock_irqsave(&hwblk_lock, flags);
@@ -271,18 +288,23 @@ static int platform_bus_notify(struct notifier_block *nb,
 	struct device *dev = data;
 	struct platform_device *pdev = to_platform_device(dev);
 	int hwblk = pdev->archdata.hwblk_id;
+	struct clk *clk;
 
 	/* ignore off-chip platform devices */
 	if (!hwblk)
 		return 0;
 
+	clk = hwblk_get_clk(hwblk_info, hwblk);
+	if (!clk)
+		return -EIO;
+
 	switch (action) {
 	case BUS_NOTIFY_ADD_DEVICE:
 		INIT_LIST_HEAD(&pdev->archdata.entry);
 		mutex_init(&pdev->archdata.mutex);
 		/* platform devices without drivers should be disabled */
-		hwblk_enable(hwblk_info, hwblk);
-		hwblk_disable(hwblk_info, hwblk);
+		clk_enable(clk);
+		clk_disable(clk);
 		/* make sure driver re-inits itself once */
 		__set_bit(PDEV_ARCHDATA_FLAG_INIT, &pdev->archdata.flags);
 		dev->pm_domain = &default_pm_domain;
-- 
1.7.5.4

