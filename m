From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 05 Mar 2012 22:46:08 +0000
Subject: Re: [PATCH] sh_tmu / PM: Prevent power from being removed from TMU devices
Message-Id: <201203052346.09193.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201203030041.30244.rjw@sisk.pl>
In-Reply-To: <201203030041.30244.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, March 05, 2012, Rafael J. Wysocki wrote:
> On Monday, March 05, 2012, Paul Mundt wrote:
> > On Mon, Mar 05, 2012 at 05:01:20PM +0900, Magnus Damm wrote:
> > > On Mon, Mar 5, 2012 at 2:47 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > > > On Sun, Mar 04, 2012 at 10:50:53PM +0100, Rafael J. Wysocki wrote:
> > > >> On Sunday, March 04, 2012, Paul Mundt wrote:
> > > >> > Presumably we also need the same for the MTU2 and CMT drivers?
> > > >>
> > > >> Yes, we do in principle, although this isn't strictly necessary for things to
> > > >> work at the moment.
> > > >>
> > > >> I can post analogous patches for the other drivers if you want me to.
> > > >>
> > > > It would be nice to ensure that we don't run in to the same problems on
> > > > the other drivers in the interim at least. I'll take a look at getting
> > > > proper PM support taken care of for them afterwards.
> > > 
> > > I agree, but I wonder how much of an actual issue it is at this point.
> > > In the long run of course the drivers should be fixed up, but this
> > > patch more looks like a workaround for 3.3-rc.
> > > 
> > > As for actual hardware timers, MTU2 is not used on any platform with
> > > power domain support today and the CMT is located in a always-on power
> > > domain. So they should not cause any issues for 3.3-rc.
> > > 
> > It doesn't matter. If we're going to band-aid around the TMU case for a
> > PM incompatability then the same fix needs to be applied to the other
> > relevant drivers, barring a proper fix.
> 
> There is a problem applying that "fix" (or perhaps workaround would be a better
> name) to the CMT driver, because that would make the system never suspend,
> which isn't exactly desirable.  Sorry that I didn't notice that earlier.
> 
> > We aren't going to be making
> > random band-aid fixes that in turn bring the drivers behaviourly out of
> > sync simply because of some imagined timeline issue with 3.3-rc. Again,
> > none of this thread would have even been necessary had the job been done
> > right from the beginning.
> 
> Well, there seems to be a problem with TMU and system suspend that isn't
> directly related to turning off the A4R domain (system resume doesn't appear
> to work with TMU even if that domain is always on).  And it looks like that
> problem has been there forever.

OK, so my previous testing was flawed somehow and the patch below actually
works.

> Anyway, to use the same approach in all three drivers we need a flag that
> will allow a driver to say "don't power down the domain this device belongs to"
> to the core.  It shouldn't be very difficult to introduce it, but I'm still
> not sure that will make the "TMU vs system resume" problem mentioned above go
> away.
> 
> I'll try to prepare a patch for that later today anyway.

Is appended.  Without a changelog for now, because I need to add CMT and
MTU2 to it still.

Thanks,
Rafael

---
 arch/arm/mach-shmobile/setup-sh7372.c |    2 ++
 drivers/base/power/domain.c           |   25 +++++++++++++++++++++++--
 drivers/clocksource/sh_tmu.c          |    4 ++++
 include/linux/pm_domain.h             |    3 +++
 4 files changed, 32 insertions(+), 2 deletions(-)

Index: linux/drivers/base/power/domain.c
=================================--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -372,7 +372,7 @@ static int pm_genpd_poweroff(struct gene
 	not_suspended = 0;
 	list_for_each_entry(pdd, &genpd->dev_list, list_node)
 		if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
-		    || pdd->dev->power.irq_safe))
+		    || pdd->dev->power.irq_safe || to_gpd_data(pdd)->always_on))
 			not_suspended++;
 
 	if (not_suspended > genpd->in_progress)
@@ -864,7 +864,8 @@ static int pm_genpd_suspend_noirq(struct
 		return -EINVAL;
 
 	if (genpd->suspend_power_off
-	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
+	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
+	    || dev_gpd_data(dev)->always_on)
 		return 0;
 
 	genpd_stop_dev(genpd, dev);
@@ -1281,6 +1282,26 @@ int pm_genpd_remove_device(struct generi
 }
 
 /**
+ * pm_genpd_dev_always_on - Set/unset the "always on" flag for a given device.
+ * @dev: Device to set/unset the flag for.
+ * @val: The new value of the device's "always on" flag.
+ */
+void pm_genpd_dev_always_on(struct device *dev, bool val)
+{
+	struct pm_subsys_data *psd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+
+	psd = dev_to_psd(dev);
+	if (psd && psd->domain_data)
+		to_gpd_data(psd->domain_data)->always_on = val;
+
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_dev_always_on);
+
+/**
  * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
  * @genpd: Master PM domain to add the subdomain to.
  * @subdomain: Subdomain to be added.
Index: linux/include/linux/pm_domain.h
=================================--- linux.orig/include/linux/pm_domain.h
+++ linux/include/linux/pm_domain.h
@@ -97,6 +97,7 @@ struct generic_pm_domain_data {
 	struct gpd_dev_ops ops;
 	struct gpd_timing_data td;
 	bool need_restore;
+	bool always_on;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
@@ -125,6 +126,7 @@ static inline int pm_genpd_add_device(st
 
 extern int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 				  struct device *dev);
+extern void pm_genpd_dev_always_on(struct device *dev, bool val);
 extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 				  struct generic_pm_domain *new_subdomain);
 extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
@@ -167,6 +169,7 @@ static inline int pm_genpd_remove_device
 {
 	return -ENOSYS;
 }
+static inline void pm_genpd_dev_always_on(struct device *dev, bool val) {}
 static inline int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 					 struct generic_pm_domain *new_sd)
 {
Index: linux/drivers/clocksource/sh_tmu.c
=================================--- linux.orig/drivers/clocksource/sh_tmu.c
+++ linux/drivers/clocksource/sh_tmu.c
@@ -32,6 +32,7 @@
 #include <linux/sh_timer.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/pm_domain.h>
 
 struct sh_tmu_priv {
 	void __iomem *mapbase;
@@ -410,6 +411,9 @@ static int __devinit sh_tmu_probe(struct
 	struct sh_tmu_priv *p = platform_get_drvdata(pdev);
 	int ret;
 
+	if (!is_early_platform_device(pdev))
+		pm_genpd_dev_always_on(&pdev->dev, true);
+
 	if (p) {
 		dev_info(&pdev->dev, "kept as earlytimer\n");
 		return 0;
Index: linux/arch/arm/mach-shmobile/setup-sh7372.c
=================================--- linux.orig/arch/arm/mach-shmobile/setup-sh7372.c
+++ linux/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1043,6 +1043,8 @@ void __init sh7372_add_standard_devices(
 	sh7372_add_device_to_domain(&sh7372_a4r, &veu2_device);
 	sh7372_add_device_to_domain(&sh7372_a4r, &veu3_device);
 	sh7372_add_device_to_domain(&sh7372_a4r, &jpu_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &tmu00_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &tmu01_device);
 }
 
 void __init sh7372_add_early_devices(void)
