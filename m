From: Simon Horman <horms@verge.net.au>
Date: Mon, 12 Mar 2012 05:18:45 +0000
Subject: Re: [PATCH] sh_tmu / PM: Prevent power from being removed from TMU devices
Message-Id: <20120312051845.GA8448@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201203030041.30244.rjw@sisk.pl>
In-Reply-To: <201203030041.30244.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 06, 2012 at 11:13:10PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, March 06, 2012, Paul Mundt wrote:
> > On Mon, Mar 05, 2012 at 11:46:08PM +0100, Rafael J. Wysocki wrote:
> > > On Monday, March 05, 2012, Rafael J. Wysocki wrote:
> > > > Anyway, to use the same approach in all three drivers we need a flag that
> > > > will allow a driver to say "don't power down the domain this device belongs to"
> > > > to the core.  It shouldn't be very difficult to introduce it, but I'm still
> > > > not sure that will make the "TMU vs system resume" problem mentioned above go
> > > > away.
> > > > 
> > > > I'll try to prepare a patch for that later today anyway.
> > > 
> > > Is appended.  Without a changelog for now, because I need to add CMT and
> > > MTU2 to it still.
> > > 
> > The updated version looks much nicer, and the interaction with early
> > platform entry is quite obvious. If we can reuse this for CMT and MTU2
> > then that should about take care of it.
> 
> I believe that we can.
> 
> > Thanks for persisting!
> 
> No problem.
> 
> Below is a full patch with a changelog and CMT and MTU2 changes too.
> This has been tested on Mackerel both with and without the TMU driver
> without causing any visible issues to appear.

Hi Rafael,

I apologise for not responding earlier, I returned from a vacation
(without my Mackerel) last night,

I have tried the patch below (slightly modified as I have detailed inline)
on top of 3.3-rc7, however, I am observing that the boot hangs in the
usual spot when using the default config.

arm_vmregion_alloc: allocation too big (requested 0x7e9000)
sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: unable to allocate buffer
sh_mobile_lcdc_fb: probe of sh_mobile_lcdc_fb.1 failed with error -12
SuperH SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
sh-sci sh-sci.0: start latency exceeded, new value 6084 ns
console [ttySC0] enabled, bootconsole disabled
console [ttySC0] enabled, bootconsole disabled


> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / shmobile: Mark clocksource devices as "always on"
> 
> The TMU device on the Mackerel board belongs to the A4R power domain
> and loses power when the domain is turned off.  Unfortunately, the
> TMU driver is not prepared to cope with such situations and crashes
> the system when that happens.  To work around this problem introduce
> a new helper function, pm_genpd_dev_always_on(), allowing a device
> driver to mark its device as "always on" in case it belongs to a PM
> domain, which will make the generic PM domains core code avoid
> powering off the domain containing the device, both at run time and
> during system suspend.
> 
> Make the TMU driver use pm_genpd_dev_always_on() to prevent the
> A4R domain from losing power and make the other SH colocksource
> drivers, sh_cmt and sh_mtu2, behave analogously.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  arch/arm/mach-shmobile/setup-sh7372.c |    2 ++
>  drivers/base/power/domain.c           |   28 ++++++++++++++++++++++++++--
>  drivers/clocksource/sh_cmt.c          |    4 ++++
>  drivers/clocksource/sh_mtu2.c         |    4 ++++
>  drivers/clocksource/sh_tmu.c          |    4 ++++
>  include/linux/pm_domain.h             |    3 +++
>  6 files changed, 43 insertions(+), 2 deletions(-)
> 
> Index: linux/drivers/base/power/domain.c
> =================================> --- linux.orig/drivers/base/power/domain.c
> +++ linux/drivers/base/power/domain.c
> @@ -372,7 +372,7 @@ static int pm_genpd_poweroff(struct gene
>  	not_suspended = 0;
>  	list_for_each_entry(pdd, &genpd->dev_list, list_node)
>  		if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
> -		    || pdd->dev->power.irq_safe))
> +		    || pdd->dev->power.irq_safe || to_gpd_data(pdd)->always_on))
>  			not_suspended++;
>  
>  	if (not_suspended > genpd->in_progress)
> @@ -509,6 +509,9 @@ static int pm_genpd_runtime_suspend(stru
>  
>  	might_sleep_if(!genpd->dev_irq_safe);
>  
> +	if (dev_gpd_data(dev)->always_on)
> +		return -EBUSY;
> +
>  	stop_ok = genpd->gov ? genpd->gov->stop_ok : NULL;
>  	if (stop_ok && !stop_ok(dev))
>  		return -EBUSY;
> @@ -864,7 +867,8 @@ static int pm_genpd_suspend_noirq(struct
>  		return -EINVAL;
>  
>  	if (genpd->suspend_power_off
> -	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
> +	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
> +	    || dev_gpd_data(dev)->always_on)
>  		return 0;
>  
>  	genpd_stop_dev(genpd, dev);

I modified the above hunk as follows as the genpd_dev_active_wakeup()
line does not seem to be present in pm_genpd_runtime_suspend().
Perhaps I need another patch?


@@ -880,7 +883,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
        if (IS_ERR(genpd))
                return -EINVAL;
 
-       if (genpd->suspend_power_off)
+       if (genpd->suspend_power_off || dev_gpd_data(dev)->always_on)
                return 0;
 
        /*

> @@ -1281,6 +1285,26 @@ int pm_genpd_remove_device(struct generi
>  }
>  
>  /**
> + * pm_genpd_dev_always_on - Set/unset the "always on" flag for a given device.
> + * @dev: Device to set/unset the flag for.
> + * @val: The new value of the device's "always on" flag.
> + */
> +void pm_genpd_dev_always_on(struct device *dev, bool val)
> +{
> +	struct pm_subsys_data *psd;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +
> +	psd = dev_to_psd(dev);
> +	if (psd && psd->domain_data)
> +		to_gpd_data(psd->domain_data)->always_on = val;
> +
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_dev_always_on);
> +
> +/**
>   * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
>   * @genpd: Master PM domain to add the subdomain to.
>   * @subdomain: Subdomain to be added.
> Index: linux/include/linux/pm_domain.h
> =================================> --- linux.orig/include/linux/pm_domain.h
> +++ linux/include/linux/pm_domain.h
> @@ -97,6 +97,7 @@ struct generic_pm_domain_data {
>  	struct gpd_dev_ops ops;
>  	struct gpd_timing_data td;
>  	bool need_restore;
> +	bool always_on;
>  };
>  
>  #ifdef CONFIG_PM_GENERIC_DOMAINS
> @@ -125,6 +126,7 @@ static inline int pm_genpd_add_device(st
>  
>  extern int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>  				  struct device *dev);
> +extern void pm_genpd_dev_always_on(struct device *dev, bool val);
>  extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>  				  struct generic_pm_domain *new_subdomain);
>  extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
> @@ -167,6 +169,7 @@ static inline int pm_genpd_remove_device
>  {
>  	return -ENOSYS;
>  }
> +static inline void pm_genpd_dev_always_on(struct device *dev, bool val) {}
>  static inline int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>  					 struct generic_pm_domain *new_sd)
>  {
> Index: linux/drivers/clocksource/sh_tmu.c
> =================================> --- linux.orig/drivers/clocksource/sh_tmu.c
> +++ linux/drivers/clocksource/sh_tmu.c
> @@ -32,6 +32,7 @@
>  #include <linux/sh_timer.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/pm_domain.h>
>  
>  struct sh_tmu_priv {
>  	void __iomem *mapbase;
> @@ -410,6 +411,9 @@ static int __devinit sh_tmu_probe(struct
>  	struct sh_tmu_priv *p = platform_get_drvdata(pdev);
>  	int ret;
>  
> +	if (!is_early_platform_device(pdev))
> +		pm_genpd_dev_always_on(&pdev->dev, true);
> +
>  	if (p) {
>  		dev_info(&pdev->dev, "kept as earlytimer\n");
>  		return 0;
> Index: linux/arch/arm/mach-shmobile/setup-sh7372.c
> =================================> --- linux.orig/arch/arm/mach-shmobile/setup-sh7372.c
> +++ linux/arch/arm/mach-shmobile/setup-sh7372.c
> @@ -1043,6 +1043,8 @@ void __init sh7372_add_standard_devices(
>  	sh7372_add_device_to_domain(&sh7372_a4r, &veu2_device);
>  	sh7372_add_device_to_domain(&sh7372_a4r, &veu3_device);
>  	sh7372_add_device_to_domain(&sh7372_a4r, &jpu_device);
> +	sh7372_add_device_to_domain(&sh7372_a4r, &tmu00_device);
> +	sh7372_add_device_to_domain(&sh7372_a4r, &tmu01_device);
>  }
>  
>  void __init sh7372_add_early_devices(void)
> Index: linux/drivers/clocksource/sh_cmt.c
> =================================> --- linux.orig/drivers/clocksource/sh_cmt.c
> +++ linux/drivers/clocksource/sh_cmt.c
> @@ -32,6 +32,7 @@
>  #include <linux/sh_timer.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/pm_domain.h>
>  
>  struct sh_cmt_priv {
>  	void __iomem *mapbase;
> @@ -689,6 +690,9 @@ static int __devinit sh_cmt_probe(struct
>  	struct sh_cmt_priv *p = platform_get_drvdata(pdev);
>  	int ret;
>  
> +	if (!is_early_platform_device(pdev))
> +		pm_genpd_dev_always_on(&pdev->dev, true);
> +
>  	if (p) {
>  		dev_info(&pdev->dev, "kept as earlytimer\n");
>  		return 0;
> Index: linux/drivers/clocksource/sh_mtu2.c
> =================================> --- linux.orig/drivers/clocksource/sh_mtu2.c
> +++ linux/drivers/clocksource/sh_mtu2.c
> @@ -31,6 +31,7 @@
>  #include <linux/sh_timer.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/pm_domain.h>
>  
>  struct sh_mtu2_priv {
>  	void __iomem *mapbase;
> @@ -306,6 +307,9 @@ static int __devinit sh_mtu2_probe(struc
>  	struct sh_mtu2_priv *p = platform_get_drvdata(pdev);
>  	int ret;
>  
> +	if (!is_early_platform_device(pdev))
> +		pm_genpd_dev_always_on(&pdev->dev, true);
> +
>  	if (p) {
>  		dev_info(&pdev->dev, "kept as earlytimer\n");
>  		return 0;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
