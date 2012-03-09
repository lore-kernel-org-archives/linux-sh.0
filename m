From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 09 Mar 2012 21:41:56 +0000
Subject: Re: [PATCH 02/03] ARM: mach-shmobile: sh7372 generic board support via DT
Message-Id: <201203092141.56581.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20110630094710.10442.59532.sendpatchset@t400s>
In-Reply-To: <20110630094710.10442.59532.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 09 March 2012, Magnus Damm wrote:

> >>  arch/arm/mach-shmobile/setup-sh7372.c |   39 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 39 insertions(+)
> >
> > I think so far everyone has added the device tree source files to the kernel
> > when they did the conversion. I'd suggest you do that, too.
> 
> Sure, that indeed sounds like a good idea. I intend to hack on V2 next
> week and that is most likely a good time to include dts and dtsi
> files. At this point they are rather boring due to interrupt bindings
> not working, so we cannot even hook up board specific ethernet
> controllers via the device tree due to lack of interrupts. My plan is
> to hack up some IRQ domain prototype code to play more with the DT and
> also create some proper dts/dtsi files.

Ok. Note that a number of people are currently working on IRQ controller
bindings for various platforms, and some of that is now in the arm-soc
tree but not in v3.3. Best look at what others are doing so you don't
end up duplicating too much work.

> >> --- 0034/arch/arm/mach-shmobile/setup-sh7372.c
> >> +++ work/arch/arm/mach-shmobile/setup-sh7372.c        2012-03-06 14:04:36.000000000 +0900
> >> @@ -1082,3 +1082,42 @@ void __init sh7372_add_early_devices(voi
> >>       /* override timer setup with soc-specific code */
> >>       shmobile_timer.init = sh7372_earlytimer_init;
> >>  }
> >> +
> >> +#ifdef CONFIG_USE_OF
> >> +
> >> +void __init sh7372_add_early_devices_dt(void)
> >> +{
> >> +     shmobile_setup_delay(800, 1, 3); /* Cortex-A8 @ 800MHz */
> >> +
> >> +     early_platform_add_devices(sh7372_early_devices,
> >> +                                ARRAY_SIZE(sh7372_early_devices));
> >> +
> >> +     /* setup early console here as well */
> >> +     shmobile_setup_console();
> >> +}
> >
> > Are these always 800MHz? Maybe it would be better to read the "clock-frequency"
> > property from the root node and use the value that is given for a particular
> > board.
> 
> You are correct that the CPU frequency may change depending on a few
> things. At this point the actual hardware is configured to use with
> whatever value the boot loader has setup for us, which should work
> well with the worst case loops-per-jiffy value based on the spec of
> the SoC.
> 
> My idea with the code above is keep it as simple as possible and be
> fail safe. So the 800 Mhz value in this case is coming from the sh7372
> data sheet as the maximum allowed frequency for sh7372. The point in
> setting the maximum allowed frequency is to come up with a OK worst
> case loops per jiffy value without using any timer during early boot.
> The non-DT mach-shmobile platforms are using early platform driver
> code to allow setting up a timer early during boot, and this timer is
> then used with the common calibrate delay loops-per-jiffy calculation
> code. With this shmobile_setup_delay() function we can delay the timer
> creation until whenever the normal driver model code is setting up
> drivers. This should make it easy to use DT for timers too.

Ok.

> Initially my patch had some late initcall that recalculated the delay
> after the driver model (and also timers) have been initialized. This
> looked like it would work in theory and it would match well with
> whatever that needs to be done together with cpu frequency scaling.
> This sounds a bit like what you requested. However, it seems to me
> that the generic calibrate delay code that ARM is using doesn't allow
> updating the loops-per-jiffy value! The loops-per-jiffy value is
> stored in a static per-cpu variable and the code does not seem to like
> recalculating the delay after the first time. Perhaps someone is
> working on fixing that up. Architectures like blackfin do their own
> thing and do not make use of the generic calibrate delay code, and I
> believe they update the loops-per-jiffy directly from their cpufreq
> drivers. ARM platforms that do frequency scaling must use some other
> technique.

I think we do the same on ARM, at least that's what I got from reading
drivers/cpufreq/omap-cpufreq.c, which updates
per_cpu(cpu_data, i).loops_per_jiffy in a loop when changing the
frequency.

> Anyway, so based on this I decided to go with a static worst case
> frequency value to calculate a safe loops-per-jiffy value and at the
> same time add "adjust generic calibrate delay code to allow updating
> frequency over time" to my TODO list. I feel it is better to solve
> that issue in a generic way and use the common calibrate delay code to
> calculate a proper delay value instead of extending my local
> mach-shmobile code more.
> 
> Does it sound sane?

Yes, sounds good for now.

	Arnd
