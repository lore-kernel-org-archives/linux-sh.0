From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 29 Apr 2011 17:19:26 +0000
Subject: Re: [PATCH/RFC] ARM: mach-shmobile: sh7372 power domain prototype
Message-Id: <Pine.LNX.4.64.1104291913000.17813@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20110411194911.7991.79950.sendpatchset@t400s>
In-Reply-To: <20110411194911.7991.79950.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 21 Apr 2011, Guennadi Liakhovetski wrote:

> On Tue, 19 Apr 2011, Guennadi Liakhovetski wrote:
> 
> > On Fri, 15 Apr 2011, Guennadi Liakhovetski wrote:
> > 
> > > Hi Magnus
> > > 
> > > On Tue, 12 Apr 2011, Magnus Damm wrote:
> > > 
> > > > From: Magnus Damm <damm@opensource.se>
> > > > 
> > > > This experimental sh7372-specific Runtime PM prototype
> > > > adds support for the A4LC and A4MP power domains.
> > > > 
> > > > Tested on the Mackerel board together with the LCDC:
> > > > 
> > > > # blank HDMI fbdev
> > > > echo 3 > /sys/devices/platform/sh_mobile_lcdc_fb.1/graphics/fb1/blank
> > > > 
> > > > # blank LCD panel fbdev
> > > > echo 3 > /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank
> > > > # unblank LCD panel fbdev
> > > > echo 0 > /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank
> > > > 
> > > > Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
> > > > ---
> > > > 
> > > >  arch/arm/mach-shmobile/pm_runtime.c |  227 ++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 222 insertions(+), 5 deletions(-)
> > > 
> > > Your patch worked mostly, below is a small addition (to be applied on top 
> > > of your patch), that adds several new domains and devices and fixes a 
> > > couple of issues with your original patch. Notice an "#if 0" around i2c 
> > > devices: activating them causes problems - output on the LCDC disappears 
> > > and the boot process doesn't complete, but without a serial console I 
> > > couldn't tell, what exactly was the problem. Should be investigated 
> > > further.
> > 
> > Below is a fixed version of the earlier proposed fix;)
> 
> v3: I think, I've got the use-counting and power-domain initialisation 
> correct this time too. At least this version works without any need to 
> modify the runtime PM core.

v4: (1) add checks for BIT_ACTIVE for devices without any clocks 
associated with them, this fixes Oopses. (2) I think, this time I've 
finally found _the_ correct time and place to remove the "prd" from the 
list. As before, this is a work in progress, subject to change, depending 
on surrounding developments. Posting here just for reference.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

diff --git a/arch/arm/mach-shmobile/pm_runtime.c b/arch/arm/mach-shmobile/pm_runtime.c
index 48d6e4d..320d24d 100644
--- a/arch/arm/mach-shmobile/pm_runtime.c
+++ b/arch/arm/mach-shmobile/pm_runtime.c
@@ -31,6 +33,12 @@ struct pm_runtime_power_domain {
 
 /* sh7372 specific stuff in common file, FIXME this should be broken out */
 
+/*
+ * Further domains:
+ * A4R: CEU, VEU, BEU, VOU, VPU, CSI2, MSIOF0, IIC0/2
+ * A3SP: MMCIF, MSIOF1/2, SDHI0/1/2, SCIFA, SCIFB, IIC1/3/4, DMAC1/2/3
+ */
+
 static struct pm_runtime_power_domain sh7372_a4lc = {
 	.power_domain_bit = 1,
 };
@@ -39,6 +47,14 @@ static struct pm_runtime_power_domain sh7372_a4mp = {
 	.power_domain_bit = 2,
 };
 
+static struct pm_runtime_power_domain sh7372_a4r = {
+	.power_domain_bit = 5,
+};
+
+static struct pm_runtime_power_domain sh7372_a3sp = {
+	.power_domain_bit = 11,
+};
+
 #define SPDCR 0xe6180008
 #define SWUCR 0xe6180014
 #define PSTR 0xe6180080
@@ -93,6 +109,8 @@ static void __devres_release(struct device *dev, void *res)
 
 	dev_dbg(dev, "__devres_release()\n");
 
+	list_del(&prd->entry);
+
 	if (test_bit(BIT_CLK_ENABLED, &prd->flags))
 		clk_disable(prd->clk);
 
@@ -117,10 +135,12 @@ static int __power_domain_runtime_suspend(struct device *d)
 	if (!test_bit(BIT_SUSPENDED, &prd->flags)) {
 		if (d->driver && d->driver->pm &&
 		    d->driver->pm->runtime_suspend) {
-			if (!test_bit(BIT_CLK_ENABLED, &prd->flags))
+			if (test_bit(BIT_ACTIVE, &prd->flags) &&
+			    !test_bit(BIT_CLK_ENABLED, &prd->flags))
 				clk_enable(prd->clk);
 			ret = d->driver->pm->runtime_suspend(d);
-			clk_disable(prd->clk);
+			if (test_bit(BIT_ACTIVE, &prd->flags))
+				clk_disable(prd->clk);
 			clear_bit(BIT_CLK_ENABLED, &prd->flags);
 
 			if (ret = 0)
@@ -143,7 +163,14 @@ static int power_domain_runtime_suspend(struct device *dev)
 
 	spin_lock_irqsave(&domain_data->lock, flags);
 
-	list_add_tail(&prd->entry, &domain_data->idle_list);
+	/*
+	 * suspend can be called repeatedly - see rpm_suspend() -
+	 * rpm_check_suspend_allowed() returns 1, if already suspended, and the
+	 * process continues.
+	 */
+	if (list_empty(&prd->entry))
+		list_add_tail(&prd->entry, &domain_data->idle_list);
+
 	domain_data->use_cnt--;
 
 	if (domain_data->use_cnt = 0) {
@@ -169,12 +196,13 @@ static int __power_domain_runtime_resume(struct device *d)
 	struct pm_runtime_data *prd = __to_prd(d);
 	int ret = 0;
 
-	dev_dbg(d, "__power_domain_runtime_resume()\n");
+	dev_dbg(d, "__power_domain_runtime_resume(): %lu\n", prd->flags);
 
 	BUG_ON(!prd);
 
 	if (test_bit(BIT_SUSPENDED, &prd->flags)) {
-		if (!test_bit(BIT_CLK_ENABLED, &prd->flags)) {
+		if (test_bit(BIT_ACTIVE, &prd->flags) &&
+		    !test_bit(BIT_CLK_ENABLED, &prd->flags)) {
 			clk_enable(prd->clk);
 			set_bit(BIT_CLK_ENABLED, &prd->flags);
 		}
@@ -186,7 +214,8 @@ static int __power_domain_runtime_resume(struct device *d)
 		if (ret = 0)
 			clear_bit(BIT_SUSPENDED, &prd->flags);
 		else {
-			clk_disable(prd->clk);
+			if (test_bit(BIT_ACTIVE, &prd->flags))
+				clk_disable(prd->clk);
 			clear_bit(BIT_CLK_ENABLED, &prd->flags);
 		}
 	}
@@ -213,7 +242,7 @@ static int power_domain_runtime_resume(struct device *dev)
 
 	if (ret = 0) {
 		domain_data->use_cnt++;
-		list_del(&prd->entry);
+		list_del_init(&prd->entry);
 	} else {
 		if (domain_data->use_cnt = 0)
 			power_down(domain_data);
@@ -235,23 +264,60 @@ static void power_domain_init(struct device *dev, struct pm_runtime_data *prd)
 
 	if (strcmp(dev_name(dev), "sh_mobile_lcdc_fb.0") = 0)
 		domain_data = &sh7372_a4lc;
-
-	if (strcmp(dev_name(dev), "sh_mobile_lcdc_fb.1") = 0)
+	else if (strcmp(dev_name(dev), "sh_mobile_lcdc_fb.1") = 0)
 		domain_data = &sh7372_a4lc;
-
-	if (strcmp(dev_name(dev), "sh_fsi2") = 0)
+	else if (strcmp(dev_name(dev), "sh-mipi-dsi.0") = 0)
+		domain_data = &sh7372_a4lc;
+	else if (strcmp(dev_name(dev), "sh_fsi2") = 0)
 		domain_data = &sh7372_a4mp;
+	else if (strcmp(dev_name(dev), "sh_mobile_sdhi.0") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh_mobile_sdhi.1") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh_mobile_sdhi.2") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh-dma-engine.0") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh-dma-engine.1") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh-dma-engine.2") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh-sci.0") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh-sci.1") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh-sci.2") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh-sci.3") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh-sci.4") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh-sci.5") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh-sci.6") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "sh_mobile_ceu.0") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "i2c-sh_mobile.1") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "i2c-sh_mobile.3") = 0)
+		domain_data = &sh7372_a3sp;
+	else if (strcmp(dev_name(dev), "i2c-sh_mobile.4") = 0)
+		domain_data = &sh7372_a3sp;
+#if 0
+	else if (strcmp(dev_name(dev), "i2c-sh_mobile.0") = 0)
+		domain_data = &sh7372_a4r;
+	else if (strcmp(dev_name(dev), "i2c-sh_mobile.2") = 0)
+		domain_data = &sh7372_a4r;
+#endif
+	else if (strcmp(dev_name(dev), "sh_mmcif.0") = 0)
+		domain_data = &sh7372_a3sp;
 
 	if (domain_data) {
 		dev->pwr_domain = &power_domain;
 		prd->dev = dev;
 		INIT_LIST_HEAD(&prd->entry);
 		prd->domain_data = domain_data;
-		domain_data->use_cnt++;
-		if (domain_data->use_cnt = 1) {
-			INIT_LIST_HEAD(&domain_data->idle_list);
-			spin_lock_init(&domain_data->lock);
-		}
 
 		dev_dbg(dev, "domain data available use cnt = %d\n",
 			domain_data->use_cnt);
@@ -266,7 +332,8 @@ static void platform_pm_runtime_init(struct device *dev,
 		if (!IS_ERR(prd->clk)) {
 			set_bit(BIT_ACTIVE, &prd->flags);
 			dev_info(dev, "clocks managed by runtime pm\n");
-			power_domain_init(dev, prd);
+		} else {
+			dev_err(dev, "clk-get error %ld\n", PTR_ERR(prd->clk));
 		}
 	}
 }
@@ -291,7 +358,6 @@ int platform_pm_runtime_suspend(struct device *dev)
 			clk_disable(prd->clk);
 			clear_bit(BIT_CLK_ENABLED, &prd->flags);
 		}
-
 	}
 
 	return 0;
@@ -329,12 +395,19 @@ static int platform_bus_notify(struct notifier_block *nb,
 
 	dev_dbg(dev, "platform_bus_notify() %ld !\n", action);
 
-	if (action = BUS_NOTIFY_BIND_DRIVER) {
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
 		prd = devres_alloc(__devres_release, sizeof(*prd), GFP_KERNEL);
-		if (prd)
+		if (prd) {
 			devres_add(dev, prd);
-		else
+			power_domain_init(dev, prd);
+		} else {
 			dev_err(dev, "unable to alloc memory for runtime pm\n");
+		}
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		dev->pwr_domain = NULL;
+		break;
 	}
 
 	return 0;
@@ -380,6 +453,15 @@ static struct notifier_block platform_bus_notifier = {
 
 static int __init sh_pm_runtime_init(void)
 {
+	INIT_LIST_HEAD(&sh7372_a4lc.idle_list);
+	spin_lock_init(&sh7372_a4lc.lock);
+	INIT_LIST_HEAD(&sh7372_a4mp.idle_list);
+	spin_lock_init(&sh7372_a4mp.lock);
+	INIT_LIST_HEAD(&sh7372_a4r.idle_list);
+	spin_lock_init(&sh7372_a4r.lock);
+	INIT_LIST_HEAD(&sh7372_a3sp.idle_list);
+	spin_lock_init(&sh7372_a3sp.lock);
+
 	bus_register_notifier(&platform_bus_type, &platform_bus_notifier);
 	return 0;
 }
