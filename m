From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 16 May 2016 07:36:04 +0000
Subject: Re: [PATCH RESEND 05/12] sh: DeviceTree support update
Message-Id: <87vb2ee9p7.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
	<1462079316-27771-6-git-send-email-ysato@users.sourceforge.jp>
	<20160504031005.GO21636@brightrain.aerifal.cx>
	<87a8jypben.wl-ysato@users.sourceforge.jp>
	<20160510162807.GH21636@brightrain.aerifal.cx>
In-Reply-To: <20160510162807.GH21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 11 May 2016 01:28:07 +0900,
Rich Felker wrote:
> 
> On Tue, May 10, 2016 at 05:25:36PM +0900, Yoshinori Sato wrote:
> > On Wed, 04 May 2016 12:10:05 +0900,
> > Rich Felker wrote:
> > > 
> > > On Sun, May 01, 2016 at 02:08:29PM +0900, Yoshinori Sato wrote:
> > > > Changes bellow
> > > > - FDT setup timing fix.
> > > > - chosen/bootargs support.
> > > > - zImage support.
> > > > - DT binding helper macro.
> > > > 
> > > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > > ---
> > > >  arch/sh/boards/of-generic.c                        | 23 +++++++++++-----------
> > > >  arch/sh/boot/compressed/head_32.S                  |  5 +++--
> > > >  arch/sh/boot/dts/include/dt-bindings               |  1 +
> > > >  arch/sh/kernel/setup.c                             | 19 ++++++++++++++++++
> > > >  include/dt-bindings/interrupt-controller/sh_intc.h |  2 ++
> > > >  5 files changed, 36 insertions(+), 14 deletions(-)
> > > >  create mode 120000 arch/sh/boot/dts/include/dt-bindings
> > > >  create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h
> > > > 
> > > > diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
> > > > index bf3a166..9570873 100644
> > > > --- a/arch/sh/boards/of-generic.c
> > > > +++ b/arch/sh/boards/of-generic.c
> > > > @@ -112,29 +112,25 @@ static int noopi(void)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static void __init sh_of_mem_reserve(void)
> > > > +static void __init sh_of_mem_init(void)
> > > >  {
> > > >  	early_init_fdt_reserve_self();
> > > >  	early_init_fdt_scan_reserved_mem();
> > > >  }
> > > >  
> > > > -static void __init sh_of_time_init(void)
> > > > -{
> > > > -	pr_info("SH generic board support: scanning for clocksource devices\n");
> > > > -	clocksource_probe();
> > > > -}
> > > 
> > > Why did you remove this? Without it you won't get clock
> > > event/clocksource devices from the device tree so the only way to have
> > > a working timer interrupt is if the driver is hard-coded somewhere.
> > 
> > It not needed on Common Clock Framework.
> > tmu define in dts.
> 
> It is needed. clocksources are something completely different from
> "clk"s. A clocksource is the modern source of time data for the kernel
> timekeeping system (without one, you're stuck using jiffies and very
> low-res time), and the probe also gets clock_event_devices which are
> the source of timer interrupts. Without this, unless you have a
> hard-coded source of timer interrupt for the board, you won't get a
> timer interrupt and the kernel will hang early in the boot process.

OK.

> > > >  {
> > > > -	unflatten_device_tree();
> > > > -
> > > > -	board_time_init = sh_of_time_init;
> > > > +	struct device_node *cpu;
> > > > +	int freq;
> > > >  
> > > >  	sh_mv.mv_name = of_flat_dt_get_machine_name();
> > > >  	if (!sh_mv.mv_name)
> > > >  		sh_mv.mv_name = "Unknown SH model";
> > > >  
> > > >  	sh_of_smp_probe();
> > > > +	cpu = of_find_node_by_name(NULL, "cpu");
> > > > +	if (!of_property_read_u32(cpu, "clock-frequency", &freq))
> > > > +		preset_lpj = freq / 500;
> > > >  }
> > > 
> > > I setup the DT-based pseudo-board to use the generic calibrate-delay
> > > rather than hard-coding lpj. Ideally we could just get rid of bogomips
> > > completely but there are probably still some things using it. Is there
> > > a reason you prefer making up a value for lpj based on the cpu clock
> > > rate?
> > 
> > clockevent initalize after calibrate delay.
> > So don't work interrupt based calibrate.
> 
> Currently, it initializes before, but you removed the probe that
> initializes it (above), clocksource_probe().

OK.

> > > >  static int sh_of_irq_demux(int irq)
> > > > @@ -167,8 +163,7 @@ static struct sh_machine_vector __initmv sh_of_generic_mv = {
> > > >  	.mv_init_irq	= sh_of_init_irq,
> > > >  	.mv_clk_init	= sh_of_clk_init,
> > > >  	.mv_mode_pins	= noopi,
> > > > -	.mv_mem_init	= noop,
> > > > -	.mv_mem_reserve	= sh_of_mem_reserve,
> > > > +	.mv_mem_init	= sh_of_mem_init,
> > > 
> > > Is there a reason for this renaming? The function seems to be dealing
> > > purely with reserving memory ranges.
> > 
> > mv_mem_reserve too late call in MMU system.
> 
> OK.
> 
> > > >  	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
> > > >  		pr_crit("Error: invalid device tree blob"
> > > > @@ -267,8 +276,13 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
> > > >  
> > > >  void __init setup_arch(char **cmdline_p)
> > > >  {
> > > > +#ifdef CONFIG_OF
> > > > +	unflatten_device_tree();
> > > > +#endif
> > > >  	enable_mmu();
> > > 
> > > Was this moved to setup_arch to have it before enable_mmu? I think
> > > that makes sense.
> > 
> > early_init_dt_alloc_memory_arch used physical address.
> > It override on sh-specific, can after enable_mmu.
> > But I don't feel an advantage.
> 
> I dont think we should be putting sh-specific code in
> early_init_dt_alloc_memory. If calling unflatten_device_tree before
> enable_mmu avoids the need to do that, it seems like the right choice.
> Is this how other archs do it? I think we should try to be as
> consistent as possible with general practice across the kernel.

OK.
It's considered.

> > > > +#ifndef CONFIG_OF
> > > >  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
> > > >  
> > > >  	printk(KERN_NOTICE "Boot params:\n"
> > > > @@ -290,6 +304,7 @@ void __init setup_arch(char **cmdline_p)
> > > >  
> > > >  	if (!MOUNT_ROOT_RDONLY)
> > > >  		root_mountflags &= ~MS_RDONLY;
> > > > +#endif
> > > 
> > > Do these boot params only make sense for non-DT setups?
> > > 
> > > > +#if !defined(CONFIG_OF) || defined(USE_BUILTIN_DTB)
> > > >  	/* Save unparsed command line copy for /proc/cmdline */
> > > >  	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
> > > >  	*cmdline_p = command_line;
> > > > +#else
> > > > +	*cmdline_p = boot_command_line;
> > > > +#endif
> > > 
> > > I think this is wrong -- it causes the builtin command line and
> > > bootloader-provided command line to be ignored on DT kernels. Do you
> > > just want to deprecate builtin and bootloader-provided command lines?
> > > Or is it just a side effect of adding support for chosen/bootarg?
> > 
> > Yes. I think zero-page passing only non-DT.
> > DT using chosen/bootargs.
> 
> This precludes having the bootloader provide a DTB from ROM, since it
> needs to be able to patch the DTB with user preferences, and also
> requires DTB-patching code to be added to the bootloader. At the very
> least we should retain the ability to have a builtin command line in
> the kernel that's appended to the one from the DTB (and possibly allow
> the order to be changed), but I think we should also allow the
> bootloader to pass in a command line like in the non-DTB setup.
> 
> DTB and command line are very different things (hardware description
> vs user preference, and OS-generic vs OS-specific) and the whole
> chosen/bootargs system is something of a hack.

It's better to decide a requirement to a boot loader.
u-boot is passing to bootargs in easy way.

> > > >  	parse_early_param();
> > > >  
> > > > diff --git a/include/dt-bindings/interrupt-controller/sh_intc.h b/include/dt-bindings/interrupt-controller/sh_intc.h
> > > > new file mode 100644
> > > > index 0000000..8c9dcdc
> > > > --- /dev/null
> > > > +++ b/include/dt-bindings/interrupt-controller/sh_intc.h
> > > > @@ -0,0 +1,2 @@
> > > > +#define evt2irq(evt)		(((evt) >> 5) - 16)
> > > > +#define irq2evt(irq)		(((irq) + 16) << 5)
> > > 
> > > This seems unrelated to other things in this patch.
> > 
> > It using DT define.
> 
> Ah, I see, it's used later in the dts itself. But why not just put the
> actual IRQ numbers in the dts directly? The evt numbers seem like an
> implementation detail, whereas device tree bindings should be stable
> and independent of kernel sources.

An IRQ is the virtual value, so it's necessary to convert from EVT.
SH3/4 interrupt controller using EVT.

> If evt numbers are really what makes sense to have in the dts, then
> sh_intc should probably define its irq_domain so that it maps evt
> numbers to irq numbers. But that doesn't seem necessary.

It good way.

> 
> Rich

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
