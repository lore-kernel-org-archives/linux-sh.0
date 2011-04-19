From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 19 Apr 2011 10:55:03 +0000
Subject: Re: [PATCH/RFC] ARM: mach-shmobile: sh7372 power domain prototype
Message-Id: <Pine.LNX.4.64.1104191253100.16641@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20110411194911.7991.79950.sendpatchset@t400s>
In-Reply-To: <20110411194911.7991.79950.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 15 Apr 2011, Guennadi Liakhovetski wrote:

> Hi Magnus
> 
> On Tue, 12 Apr 2011, Magnus Damm wrote:
> 
> > From: Magnus Damm <damm@opensource.se>
> > 
> > This experimental sh7372-specific Runtime PM prototype
> > adds support for the A4LC and A4MP power domains.
> > 
> > Tested on the Mackerel board together with the LCDC:
> > 
> > # blank HDMI fbdev
> > echo 3 > /sys/devices/platform/sh_mobile_lcdc_fb.1/graphics/fb1/blank
> > 
> > # blank LCD panel fbdev
> > echo 3 > /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank
> > # unblank LCD panel fbdev
> > echo 0 > /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank
> > 
> > Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> > 
> >  arch/arm/mach-shmobile/pm_runtime.c |  227 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 222 insertions(+), 5 deletions(-)
> 
> Your patch worked mostly, below is a small addition (to be applied on top 
> of your patch), that adds several new domains and devices and fixes a 
> couple of issues with your original patch. Notice an "#if 0" around i2c 
> devices: activating them causes problems - output on the LCDC disappears 
> and the boot process doesn't complete, but without a serial console I 
> couldn't tell, what exactly was the problem. Should be investigated 
> further.

Below is a fixed version of the earlier proposed fix;)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

diff --git a/arch/arm/mach-shmobile/pm_runtime.c b/arch/arm/mach-shmobile/pm_runtime.c
index 48d6e4d..ae8b7a1 100644
--- a/arch/arm/mach-shmobile/pm_runtime.c
+++ b/arch/arm/mach-shmobile/pm_runtime.c
@@ -31,6 +31,12 @@ struct pm_runtime_power_domain {
 
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
@@ -39,6 +45,14 @@ static struct pm_runtime_power_domain sh7372_a4mp = {
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
@@ -134,16 +148,27 @@ static int __power_domain_runtime_suspend(struct device *d)
 static int power_domain_runtime_suspend(struct device *dev)
 {
 	struct pm_runtime_data *prd = __to_prd(dev);
-	struct pm_runtime_power_domain *domain_data = prd->domain_data;
+	struct pm_runtime_power_domain *domain_data;
 	unsigned long flags;
 	int ret = 0;
 
+	if (!prd)
+		return 0;
+
+	domain_data = prd->domain_data;
+
 	dev_dbg(dev, "power_domain_runtime_suspend() %d\n",
 		domain_data->use_cnt);
 
 	spin_lock_irqsave(&domain_data->lock, flags);
 
-	list_add_tail(&prd->entry, &domain_data->idle_list);
+	/*
+	 * suspend can be called repeatedly - see rpm_suspend() -
+	 * rpm_check_suspend_allowed() returns 1, if already suspended, and the
+	 * process continues.
+	 */
+	if (list_empty(&prd->entry))
+		list_add_tail(&prd->entry, &domain_data->idle_list);
 	domain_data->use_cnt--;
 
 	if (domain_data->use_cnt = 0) {
@@ -213,7 +238,7 @@ static int power_domain_runtime_resume(struct device *dev)
 
 	if (ret = 0) {
 		domain_data->use_cnt++;
-		list_del(&prd->entry);
+		list_del_init(&prd->entry);
 	} else {
 		if (domain_data->use_cnt = 0)
 			power_down(domain_data);
@@ -235,23 +260,61 @@ static void power_domain_init(struct device *dev, struct pm_runtime_data *prd)
 
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
+		domain_data->use_cnt = 1;
 
 		dev_dbg(dev, "domain data available use cnt = %d\n",
 			domain_data->use_cnt);
@@ -291,7 +354,6 @@ int platform_pm_runtime_suspend(struct device *dev)
 			clk_disable(prd->clk);
 			clear_bit(BIT_CLK_ENABLED, &prd->flags);
 		}
-
 	}
 
 	return 0;
@@ -329,12 +391,20 @@ static int platform_bus_notify(struct notifier_block *nb,
 
 	dev_dbg(dev, "platform_bus_notify() %ld !\n", action);
 
-	if (action = BUS_NOTIFY_BIND_DRIVER) {
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
 		prd = devres_alloc(__devres_release, sizeof(*prd), GFP_KERNEL);
 		if (prd)
 			devres_add(dev, prd);
 		else
 			dev_err(dev, "unable to alloc memory for runtime pm\n");
+		break;
+	case BUS_NOTIFY_UNBIND_DRIVER:
+		prd = __to_prd(dev);
+		if (prd)
+			list_del(&prd->entry);
+		dev->pwr_domain = NULL;
+		break;
 	}
 
 	return 0;
@@ -380,6 +450,15 @@ static struct notifier_block platform_bus_notifier = {
 
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
