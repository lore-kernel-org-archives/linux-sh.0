From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Mar 2013 12:28:05 +0000
Subject: Re: SDHI and MMCIF with kzm9g-reference
Message-Id: <20130301122805.GD24364@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130301110802.GB24364@verge.net.au>
In-Reply-To: <20130301110802.GB24364@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[ Cc Magnus ]

Hi Guennadi,

On Fri, Mar 01, 2013 at 12:34:53PM +0100, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Fri, 1 Mar 2013, Simon Horman wrote:
> 
> > Hi Guennadi,
> > 
> > this is a heads-up about the state of SDHI and MMCIF with kzm9g-reference
> > in the current next and topic/all+next branches.
> > 
> > Currently the boot will not complete. It stalls in SDHI or MMCIF
> > initialisation (whichever comes first), though it doesn't say so.
> > 
> > The reason is msleep() calls. In the case of SDHI in the driver itself.
> > In the case of MMCIF in the MMC core code.
> > 
> > I had the following patch in next for a while but removed it a few days
> > ago because for some reason I thought my tests showed it was no longer needed.
> > I now believe it is needed and I will put it back into next and
> > topic/all+next ASAP. I do not plan to make any other changes to my branches
> > in what is left of today for me.
> 
> Hmm, interesting. You've got mmcif and sdhi drivers compiled in, looks 
> like, not as modules.

Yes, compiled-in. No modules. As per the defconfig.

> You know, core driver people (gkh et al.) are pretty 
> sensitive to the top-level Makefile changes like this. They affect 
> everyone and violate the general principle - we shouldn't depend on the 
> link order...

I'm not very keen on the change. And if not depending on linking
order is a rule, then we have a problem. I'll leave the patch out
of my tree for now.

> My question to this though - you say kzm9g-reference is 
> affected. Does it mean kzm9g with devices initialised from C code is ok? 
> Maybe we could try to find what the difference is?

The difference is the way that clock sources and timers are initialised,
though I've never quite understood if its only one of them that
leads to the problem or not.

In the current scheme there are no early devices for kzm9g and no early
timers. If, for example using the following small patch, I switch things
around to use early device initialisation for the CMT clock source and
early timers, then probing MMCIF and SDHI works. If not then there is the
problem I describe above.

The reason that the code is like it is and not the way it would be
with the patch below (errors aside), is because Magnus specifically
asked for no early devices or early timers.

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 63992a2..604906a 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -96,10 +96,10 @@ static const char *kzm9g_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
-	.init_early	= sh73a0_init_delay,
+	.init_early	= sh73a0_add_early_devices_dt,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= irqchip_init,
 	.init_machine	= kzm_init,
-	.init_time	= shmobile_timer_init,
+	.init_time	= sh73a0_earlytimer_init,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index c401c8d..34c717f 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -34,12 +34,12 @@ extern int sh7372_do_idle_sysc(unsigned long sleep_mode);
 extern struct clk sh7372_extal1_clk;
 extern struct clk sh7372_extal2_clk;
 
-extern void sh73a0_init_delay(void);
 extern void sh73a0_init_irq(void);
 extern void sh73a0_init_irq_dt(void);
 extern void sh73a0_map_io(void);
 extern void sh73a0_earlytimer_init(void);
 extern void sh73a0_add_early_devices(void);
+extern void sh73a0_add_early_devices_dt(void);
 extern void sh73a0_add_standard_devices(void);
 extern void sh73a0_add_standard_devices_dt(void);
 extern void sh73a0_clock_init(void);
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 6259e07..96dc21b 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -913,6 +913,9 @@ static struct platform_device *sh73a0_devices_dt[] __initdata = {
 	&scif6_device,
 	&scif7_device,
 	&scif8_device,
+};
+
+static struct platform_device *sh73a0_early_devices_dt[] __initdata = {
 	&cmt10_device,
 };
 
@@ -945,6 +948,8 @@ void __init sh73a0_add_standard_devices(void)
 
 	platform_add_devices(sh73a0_devices_dt,
 			    ARRAY_SIZE(sh73a0_devices_dt));
+	platform_add_devices(sh73a0_early_devices_dt,
+			    ARRAY_SIZE(sh73a0_devices_dt));
 	platform_add_devices(sh73a0_early_devices,
 			    ARRAY_SIZE(sh73a0_early_devices));
 	platform_add_devices(sh73a0_late_devices,
@@ -965,6 +970,8 @@ void __init sh73a0_add_early_devices(void)
 {
 	early_platform_add_devices(sh73a0_devices_dt,
 				   ARRAY_SIZE(sh73a0_devices_dt));
+	early_platform_add_devices(sh73a0_early_devices_dt,
+				   ARRAY_SIZE(sh73a0_early_devices_dt));
 	early_platform_add_devices(sh73a0_early_devices,
 				   ARRAY_SIZE(sh73a0_early_devices));
 
@@ -974,9 +981,10 @@ void __init sh73a0_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-void __init sh73a0_init_delay(void)
+void __init sh73a0_add_early_devices_dt(void)
 {
-	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
+	early_platform_add_devices(sh73a0_early_devices_dt,
+				   ARRAY_SIZE(sh73a0_early_devices_dt));
 }
 
 static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
@@ -1002,11 +1010,11 @@ static const char *sh73a0_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
-	.init_early	= sh73a0_init_delay,
+	.init_early	= sh73a0_add_early_devices_dt,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= irqchip_init,
 	.init_machine	= sh73a0_add_standard_devices_dt,
-	.init_time	= shmobile_timer_init,
+	.init_time	= sh73a0_earlytimer_init,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
