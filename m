From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 05 Aug 2012 23:45:54 +0000
Subject: [PATCH 9/15] PM / Domains: Rename the always_on device flag to syscore
Message-Id: <201208060145.54959.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207291612.43138.rjw@sisk.pl> <201208060138.03950.rjw@sisk.pl>
In-Reply-To: <201208060138.03950.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>


The always_on device flag is used to mark the devices (belonging to
a PM domain) that should never be turned off, except for the system
core (syscore) suspend/hibernation and resume stages.  Change name
of that flag to "syscore" to better reflect its purpose.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c   |   24 ++++++++++++------------
 drivers/clocksource/sh_cmt.c  |    2 +-
 drivers/clocksource/sh_mtu2.c |    2 +-
 drivers/clocksource/sh_tmu.c  |    2 +-
 include/linux/pm_domain.h     |    6 +++---
 5 files changed, 18 insertions(+), 18 deletions(-)

Index: linux/include/linux/pm_domain.h
=================================--- linux.orig/include/linux/pm_domain.h
+++ linux/include/linux/pm_domain.h
@@ -114,7 +114,7 @@ struct generic_pm_domain_data {
 	struct mutex lock;
 	unsigned int refcount;
 	bool need_restore;
-	bool always_on;
+	bool syscore;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
@@ -153,7 +153,7 @@ static inline int pm_genpd_of_add_device
 
 extern int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 				  struct device *dev);
-extern void pm_genpd_dev_always_on(struct device *dev, bool val);
+extern void pm_genpd_dev_syscore(struct device *dev, bool val);
 extern void pm_genpd_dev_need_restore(struct device *dev, bool val);
 extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 				  struct generic_pm_domain *new_subdomain);
@@ -199,7 +199,7 @@ static inline int pm_genpd_remove_device
 {
 	return -ENOSYS;
 }
-static inline void pm_genpd_dev_always_on(struct device *dev, bool val) {}
+static inline void pm_genpd_dev_syscore(struct device *dev, bool val) {}
 static inline void pm_genpd_dev_need_restore(struct device *dev, bool val) {}
 static inline int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 					 struct generic_pm_domain *new_sd)
Index: linux/drivers/base/power/domain.c
=================================--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -436,7 +436,7 @@ static int pm_genpd_poweroff(struct gene
 	not_suspended = 0;
 	list_for_each_entry(pdd, &genpd->dev_list, list_node)
 		if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
-		    || pdd->dev->power.irq_safe || to_gpd_data(pdd)->always_on))
+		    || pdd->dev->power.irq_safe || to_gpd_data(pdd)->syscore))
 			not_suspended++;
 
 	if (not_suspended > genpd->in_progress)
@@ -578,7 +578,7 @@ static int pm_genpd_runtime_suspend(stru
 
 	might_sleep_if(!genpd->dev_irq_safe);
 
-	if (dev_gpd_data(dev)->always_on)
+	if (dev_gpd_data(dev)->syscore)
 		return -EBUSY;
 
 	stop_ok = genpd->gov ? genpd->gov->stop_ok : NULL;
@@ -983,7 +983,7 @@ static int pm_genpd_suspend_noirq(struct
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (genpd->suspend_power_off || dev_gpd_data(dev)->always_on
+	if (genpd->suspend_power_off || dev_gpd_data(dev)->syscore
 	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
 		return 0;
 
@@ -1016,7 +1016,7 @@ static int pm_genpd_resume_noirq(struct
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (genpd->suspend_power_off || dev_gpd_data(dev)->always_on
+	if (genpd->suspend_power_off || dev_gpd_data(dev)->syscore
 	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
 		return 0;
 
@@ -1136,7 +1136,7 @@ static int pm_genpd_freeze_noirq(struct
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off || dev_gpd_data(dev)->always_on ?
+	return genpd->suspend_power_off || dev_gpd_data(dev)->syscore ?
 		0 : genpd_stop_dev(genpd, dev);
 }
 
@@ -1157,7 +1157,7 @@ static int pm_genpd_thaw_noirq(struct de
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off || dev_gpd_data(dev)->always_on ?
+	return genpd->suspend_power_off || dev_gpd_data(dev)->syscore ?
 		0 : genpd_start_dev(genpd, dev);
 }
 
@@ -1253,7 +1253,7 @@ static int pm_genpd_restore_noirq(struct
 
 	pm_genpd_sync_poweron(genpd);
 
-	return dev_gpd_data(dev)->always_on ? 0 : genpd_start_dev(genpd, dev);
+	return dev_gpd_data(dev)->syscore ? 0 : genpd_start_dev(genpd, dev);
 }
 
 /**
@@ -1526,11 +1526,11 @@ int pm_genpd_remove_device(struct generi
 }
 
 /**
- * pm_genpd_dev_always_on - Set/unset the "always on" flag for a given device.
+ * pm_genpd_dev_syscore - Set/unset the "syscore" flag for a given device.
  * @dev: Device to set/unset the flag for.
- * @val: The new value of the device's "always on" flag.
+ * @val: The new value of the device's "syscore" flag.
  */
-void pm_genpd_dev_always_on(struct device *dev, bool val)
+void pm_genpd_dev_syscore(struct device *dev, bool val)
 {
 	struct pm_subsys_data *psd;
 	unsigned long flags;
@@ -1539,11 +1539,11 @@ void pm_genpd_dev_always_on(struct devic
 
 	psd = dev_to_psd(dev);
 	if (psd && psd->domain_data)
-		to_gpd_data(psd->domain_data)->always_on = val;
+		to_gpd_data(psd->domain_data)->syscore = val;
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 }
-EXPORT_SYMBOL_GPL(pm_genpd_dev_always_on);
+EXPORT_SYMBOL_GPL(pm_genpd_dev_syscore);
 
 /**
  * pm_genpd_dev_need_restore - Set/unset the device's "need restore" flag.
Index: linux/drivers/clocksource/sh_cmt.c
=================================--- linux.orig/drivers/clocksource/sh_cmt.c
+++ linux/drivers/clocksource/sh_cmt.c
@@ -717,7 +717,7 @@ static int __devinit sh_cmt_probe(struct
 		struct sh_timer_config *cfg = pdev->dev.platform_data;
 
 		if (cfg->clocksource_rating || cfg->clockevent_rating)
-			pm_genpd_dev_always_on(&pdev->dev, true);
+			pm_genpd_dev_syscore(&pdev->dev, true);
 	}
 
 	if (p) {
Index: linux/drivers/clocksource/sh_mtu2.c
=================================--- linux.orig/drivers/clocksource/sh_mtu2.c
+++ linux/drivers/clocksource/sh_mtu2.c
@@ -323,7 +323,7 @@ static int __devinit sh_mtu2_probe(struc
 		struct sh_timer_config *cfg = pdev->dev.platform_data;
 
 		if (cfg->clockevent_rating)
-			pm_genpd_dev_always_on(&pdev->dev, true);
+			pm_genpd_dev_syscore(&pdev->dev, true);
 	}
 
 	if (p) {
Index: linux/drivers/clocksource/sh_tmu.c
=================================--- linux.orig/drivers/clocksource/sh_tmu.c
+++ linux/drivers/clocksource/sh_tmu.c
@@ -453,7 +453,7 @@ static int __devinit sh_tmu_probe(struct
 		struct sh_timer_config *cfg = pdev->dev.platform_data;
 
 		if (cfg->clocksource_rating || cfg->clockevent_rating)
-			pm_genpd_dev_always_on(&pdev->dev, true);
+			pm_genpd_dev_syscore(&pdev->dev, true);
 	}
 
 	if (p) {

