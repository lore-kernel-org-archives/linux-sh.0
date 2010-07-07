From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 07 Jul 2010 20:28:34 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Runtime PM prototype
Message-Id: <Pine.LNX.4.64.1007072226430.22987@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20100705092122.22936.76406.sendpatchset@t400s>
In-Reply-To: <20100705092122.22936.76406.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus

On Mon, 5 Jul 2010, Magnus Damm wrote:

> From: Magnus Damm <damm@opensource.se>
> 
> This is a simple prototype that enables Runtime PM
> on SH-Mobile ARM processors. Only clocks are managed
> at this point. Needs more work, especially WRT the
> shared ARM bits.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

I think, something like this is needed on top of your patch:

diff --git a/arch/arm/mach-shmobile/pm_runtime.c b/arch/arm/mach-shmobile/pm_runtime.c
index 93950dc..4036269 100644
--- a/arch/arm/mach-shmobile/pm_runtime.c
+++ b/arch/arm/mach-shmobile/pm_runtime.c
@@ -40,20 +40,27 @@ static void platform_pm_init_bug(struct platform_device *pdev)
 int platform_pm_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
 
 	dev_dbg(dev, "platform_pm_runtime_suspend()\n");
 
 	platform_pm_init_bug(pdev);
 
+	if (dev->driver && dev->driver->pm && dev->driver->pm->runtime_suspend)
+		ret = dev->driver->pm->runtime_suspend(dev);
+	else
+		ret = 0;
+
 	if (pdev->archdata.clk)
 		clk_disable(pdev->archdata.clk);
 
-	return 0;
+	return ret;
 }
 
 int platform_pm_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
 
 	dev_dbg(dev, "platform_pm_runtime_resume()\n");
 
@@ -62,7 +69,12 @@ int platform_pm_runtime_resume(struct device *dev)
 	if (pdev->archdata.clk)
 		clk_enable(pdev->archdata.clk);
 
-	return 0;
+	if (dev->driver && dev->driver->pm && dev->driver->pm->runtime_resume)
+		ret = dev->driver->pm->runtime_resume(dev);
+	else
+		ret = 0;
+
+	return ret;
 }
 
 int platform_pm_runtime_idle(struct device *dev)

I.e., you also have to call driver runtime-pm methofs, similarly to how it 
is done on SuperH. Otherwise, e.g., lcdcfb doesn't work.

Thanks
Guennadi

> ---
> 
>  arch/arm/include/asm/device.h         |    3 
>  arch/arm/mach-shmobile/Kconfig        |    2 
>  arch/arm/mach-shmobile/Makefile       |    2 
>  arch/arm/mach-shmobile/clock-sh7372.c |    2 
>  arch/arm/mach-shmobile/pm_runtime.c   |  109 +++++++++++++++++++++++++++++++++
>  5 files changed, 116 insertions(+), 2 deletions(-)
> 
> --- 0001/arch/arm/include/asm/device.h
> +++ work/arch/arm/include/asm/device.h	2010-07-05 15:36:34.000000000 +0900
> @@ -13,6 +13,9 @@ struct dev_archdata {
>  };
>  
>  struct pdev_archdata {
> +#ifdef CONFIG_ARCH_SHMOBILE
> +	struct clk *clk;
> +#endif
>  };
>  
>  #endif
> --- 0001/arch/arm/mach-shmobile/Kconfig
> +++ work/arch/arm/mach-shmobile/Kconfig	2010-07-05 15:36:34.000000000 +0900
> @@ -25,6 +25,8 @@ config ARCH_SH7372
>  	select COMMON_CLKDEV
>  	select SH_CLK_CPG
>  	select GENERIC_CLOCKEVENTS
> +	select PM
> +	select PM_RUNTIME
>  
>  comment "SH-Mobile Board Type"
>  
> --- 0001/arch/arm/mach-shmobile/Makefile
> +++ work/arch/arm/mach-shmobile/Makefile	2010-07-05 15:36:55.000000000 +0900
> @@ -3,7 +3,7 @@
>  #
>  
>  # Common objects
> -obj-y				:= timer.o console.o clock.o
> +obj-y				:= timer.o console.o clock.o pm_runtime.o
>  
>  # CPU objects
>  obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
> --- 0001/arch/arm/mach-shmobile/clock-sh7372.c
> +++ work/arch/arm/mach-shmobile/clock-sh7372.c	2010-07-05 15:37:50.000000000 +0900
> @@ -274,7 +274,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP201] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 1, 0), /* SCIFA3 */
>  	[MSTP200] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, 0), /* SCIFA4 */
>  	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
> -	[MSTP328] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR3, 28, CLK_ENABLE_ON_INIT), /* FSIA */
> +	[MSTP328] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR3, 28, 0), /* FSIA */
>  	[MSTP323] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 23, 0), /* IIC1 */
>  	[MSTP322] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 22, 0), /* USB0 */
>  	[MSTP314] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 14, 0), /* SDHI0 */
> --- /dev/null
> +++ work/arch/arm/mach-shmobile/pm_runtime.c	2010-07-05 16:21:52.000000000 +0900
> @@ -0,0 +1,109 @@
> +/*
> + * arch/arm/mach-shmobile/pm_runtime.c
> + *
> + * Runtime PM support code for SuperH Mobile ARM
> + *
> + *  Copyright (C) 2009-2010 Magnus Damm
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +//#define DEBUG
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
> +#include <linux/mutex.h>
> +#include <linux/clk.h>
> +#include <linux/sh_clk.h>
> +
> +static struct clk uninitialized_clock;
> +
> +static void platform_pm_init_once(struct platform_device *pdev)
> +{
> +	if (pdev->archdata.clk = &uninitialized_clock) {
> +		pdev->archdata.clk = clk_get(&pdev->dev, NULL);
> +		dev_info(&pdev->dev, "clocks managed by runtime pm\n");
> +	}
> +}
> +
> +static void platform_pm_init_bug(struct platform_device *pdev)
> +{
> +	if (pdev->archdata.clk = &uninitialized_clock) {
> +		pdev->archdata.clk = NULL;
> +		dev_info(&pdev->dev, "incorrect runtime pm usage\n");
> +	}
> +}
> +
> +int platform_pm_runtime_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	dev_dbg(dev, "platform_pm_runtime_suspend()\n");
> +
> +	platform_pm_init_bug(pdev);
> +
> +	if (pdev->archdata.clk)
> +		clk_disable(pdev->archdata.clk);
> +
> +	return 0;
> +}
> +
> +int platform_pm_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	dev_dbg(dev, "platform_pm_runtime_resume()\n");
> +
> +	platform_pm_init_once(pdev);
> +
> +	if (pdev->archdata.clk)
> +		clk_enable(pdev->archdata.clk);
> +
> +	return 0;
> +}
> +
> +int platform_pm_runtime_idle(struct device *dev)
> +{
> +	/* suspend synchronously to disable clocks immediately */
> +	return pm_runtime_suspend(dev);
> +}
> +
> +static int platform_bus_notify(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{
> +	struct device *dev = data;
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	dev_dbg(dev, "platform_bus_notify() %ld !\n", action);
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		pdev->archdata.clk = &uninitialized_clock;
> +
> +		break;
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		if (pdev->archdata.clk &&
> +		    pdev->archdata.clk != &uninitialized_clock)
> +			clk_put(pdev->archdata.clk);
> +
> +		pdev->archdata.clk = NULL;
> +		break;
> +	}
> +
> +
> +	return 0;
> +}
> +
> +static struct notifier_block platform_bus_notifier = {
> +	.notifier_call = platform_bus_notify
> +};
> +
> +static int __init sh_pm_runtime_init(void)
> +{
> +	bus_register_notifier(&platform_bus_type, &platform_bus_notifier);
> +	return 0;
> +}
> +core_initcall(sh_pm_runtime_init);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
