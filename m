From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 07 Mar 2013 19:00:24 +0000
Subject: Re: SDHI and MMCIF with kzm9g-reference
Message-Id: <Pine.LNX.4.64.1303071911020.16065@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20130301110802.GB24364@verge.net.au>
In-Reply-To: <20130301110802.GB24364@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus

On Mon, 4 Mar 2013, Magnus Damm wrote:

> On Mon, Mar 4, 2013 at 10:40 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Mon, 4 Mar 2013, Simon Horman wrote:
> >> On Mon, Mar 04, 2013 at 09:55:56PM +0900, Magnus Damm wrote:
> >> > On Fri, Mar 1, 2013 at 9:28 PM, Simon Horman <horms@verge.net.au> wrote:
> >> > > The reason that the code is like it is and not the way it would be
> >> > > with the patch below (errors aside), is because Magnus specifically
> >> > > asked for no early devices or early timers.
> >> >
> >> > Thanks for making sure that we're not enabling early timers when it is
> >> > unclear if we really need to.
> >>
> >> Thanks for reviewing the situation.
> >>
> >> > Would it be possible for you to check if the timer drivers (CMT, TMU)
> >> > get probe():d before the MMC drivers?
> >>
> >> My analysis is that the clock sources are probed after MMCIF and SDHI.
> >
> > Related to this: the problem with TWD on kzm9g with DT was, that CMT was
> > initialised too late too. The TWD driver should be initialised before the
> > secondary CPU is brought up. It is performing a calibration, and if CMT
> > isn't initialised by then, the calibration never ends... So, my "local
> > hack" to just enable TWD on kzm9g-reference to test CPUFreq interaction
> > was to use early timers too.
> 
> Uhm, if shmobile_setup_delay() is used then the delay calculation will
> be bypassed. Not sure which state the code was in when you tried
> though.
> 
> So the shmobile_setup_delay() function should work for both boot and
> secondary cpus. Keep in mind that configurations with both local
> timers (TWD) and broad cast timer needs to work.

Let me reply to this with a pseudo patch-series:-) Based on topic/all+next 
of today (tip commit a7dba2b "Merge branch 'topic/intc-external-irq' into 
topic/all+next") with 3 my hack-patches to bring kzm9g-reference up with a 
network, a naive way of adding a TWD clock like

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 81d44d8..8253493 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -132,6 +132,14 @@ static void __init kzm_init(void)
 #endif
 }
 
+void sh73a0_register_twd(void);
+
+static __init void kzm9g_init_time(void)
+{
+	shmobile_timer_init();
+	sh73a0_register_twd();
+}
+
 static const char *kzm9g_boards_compat_dt[] __initdata = {
 	"renesas,kzm9g-reference",
 	NULL,
@@ -144,6 +152,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq_intc_dt,
 	.init_machine	= kzm_init,
-	.init_time	= shmobile_timer_init,
+	.init_time	= kzm9g_init_time,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END

locks up with no console output. To actually boot and get the twd running 
I have to do

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 81d44d8..3eaaab6 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -140,10 +140,10 @@ static const char *kzm9g_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
-	.init_early	= sh73a0_init_delay,
+	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq_intc_dt,
 	.init_machine	= kzm_init,
-	.init_time	= shmobile_timer_init,
+	.init_time	= sh73a0_earlytimer_init,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END

Once again: follow-up patches 1 and 2 are not for the mainline. Patch 3 
might actually make be good - provided we get a confirmation, that twd 
frequency on sh73a0 is indeed fixed Z clock / 4.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
