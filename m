From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Jul 2013 05:55:08 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a73a4: reorganise device instantiation in DT case
Message-Id: <Pine.LNX.4.64.1307050724260.28169@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1372970438-21549-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372970438-21549-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus

On Fri, 5 Jul 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Fri, Jul 5, 2013 at 5:40 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Extract serial interface and CMT device instantiation into a separate
> > function to be called in both full DT and dummy DT modes. This doesn't
> > change the behaviour in the dummy DT case, only the instantiation order
> > changes slightly. The full DT case is extended, previously these devices
> > were not available there. Also following the r8a7790 example we remove the
> > call to of_platform_populate() from the exported method to let platforms
> > extend its parameters if needed.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >  arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1 +
> >  arch/arm/mach-shmobile/setup-r8a73a4.c        |   17 ++++++++++++++---
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
> > index 12a4ee9..2266747 100644
> > --- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
> > +++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
> > @@ -17,6 +17,7 @@ enum {
> >  };
> >
> >  void r8a73a4_add_standard_devices(void);
> > +void r8a73a4_add_standard_devices_dt(void);
> >  void r8a73a4_clock_init(void);
> >  void r8a73a4_pinmux_init(void);
> >  void r8a73a4_init_delay(void);
> > diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
> > index 6aa80645..52bf60c 100644
> > --- a/arch/arm/mach-shmobile/setup-r8a73a4.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
> > @@ -302,7 +302,7 @@ static struct resource dma_resources[] = {
> >         },
> >  };
> >
> > -void __init r8a73a4_add_standard_devices(void)
> > +static void __init r8a73a4_add_common_devices(void)
> >  {
> >         r8a73a4_register_scif(SCIFA0);
> >         r8a73a4_register_scif(SCIFA1);
> > @@ -310,10 +310,15 @@ void __init r8a73a4_add_standard_devices(void)
> >         r8a73a4_register_scif(SCIFB1);
> >         r8a73a4_register_scif(SCIFB2);
> >         r8a73a4_register_scif(SCIFB3);
> > +       r8a7790_register_cmt(10);
> > +}
> > +
> > +void __init r8a73a4_add_standard_devices(void)
> > +{
> >         r8a73a4_register_irqc(0);
> >         r8a73a4_register_irqc(1);
> > +       r8a73a4_add_common_devices();
> >         r8a73a4_register_thermal();
> > -       r8a7790_register_cmt(10);
> >         platform_device_register_resndata(&platform_bus, "sh-dma-engine", 0,
> >                                 dma_resources, ARRAY_SIZE(dma_resources),
> >                                 &dma_platform_data, sizeof(dma_platform_data));
> > @@ -329,7 +334,13 @@ void __init r8a73a4_init_delay(void)
> >  #ifdef CONFIG_USE_OF
> >  void __init r8a73a4_add_standard_devices_dt(void)
> >  {
> > +       r8a73a4_add_common_devices();
> >         platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
> > +}
> > +
> > +static void __init add_devices_dt(void)
> > +{
> > +       r8a73a4_add_standard_devices_dt();
> >         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> >  }
> >
> > @@ -340,7 +351,7 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
> >
> >  DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
> >         .init_early     = r8a73a4_init_delay,
> > -       .init_machine   = r8a73a4_add_standard_devices_dt,
> > +       .init_machine   = add_devices_dt,
> >         .init_time      = shmobile_timer_init,
> >         .dt_compat      = r8a73a4_boards_compat_dt,
> >  MACHINE_END
> 
> Thanks for you efforts on this, but despite what the change log says
> (what is dummy DT?), doesn't this change the behaviour of
> ->init_machine() above? It looks like you add platform devices to me,
> which is exactly what I don't want.

Sure, I can remove this line, and do it differently, but let's see why I 
did that:

As the commit message says, I tried to model this patch set after the 
recent similar series from Simon:

http://thread.gmane.org/gmane.linux.ports.sh.devel/24711

which, I understand, should be a real example to follow, when doing this. 
In that patch .init_machine() is used for Lager to call 
r8a7790_add_standard_devices_dt(). That function existed before on 
r8a7790, but, I believe, was unused. So, Simon has extended it to 
initialise clocks and add some standard devices from the SoC data.

I did the same: I call r8a73a4_add_standard_devices_dt() from ape6evm's 
.init_machine(). I also extended r8a73a4_add_standard_devices_dt() to add 
some common devices from SoC code. But the difference with r8a7790 is, 
that that function is also used by the r8a73a4 "generic" board. So, I took 
the liberty to also add those devices to the generic case. Ok, if that's 
not desired, I can remove that. But my reasoning was - if board-specific 
DT boots can do that, why cannot the generic one do that as well? One more 
change I did to that function was removing of_platform_populate() from it 
and making calling it each board's own task - again, similar to r8a7790.

> I'd like ->init_machine() to become NULL, but  above it seems that I
> overlooked the odd commit when platform_device_register_simple() was
> added. So ideally I'd like that non-standard
> platform_device_register_simple() to simply go away, but that is out
> of scope for this change I believe. So I'm not sure about the point of
> the above hunks.
> 
> As mentioned earlier, please model this change following Simon's Lager
> DT reference support. Leave ->init_machine() in setup-r8a73a4.c
> untouched - no platform devices. If you need platform devices for
> certain things like SCIF and/or CMT then tie in callbacks from
> board-specific DT_MACHINE and do leave this SoC specific DT_MACHINE
> as-is.
> 
> In a separate commit, please try to figure out what to do about that
> platform_device_register_simple() line.

You mean the cpufreq device? What's wrong with it? Would you prefer to 
have it added by each platform? Seems like suboptimal to me. Or add it in 
DT? Not sure if that would work. And yes, I looked it up from some another 
platform.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
