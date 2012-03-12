From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 12 Mar 2012 21:54:25 +0000
Subject: Re: [PATCH] sh_tmu / PM: Prevent power from being removed from TMU devices
Message-Id: <201203122254.25467.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201203030041.30244.rjw@sisk.pl>
In-Reply-To: <201203030041.30244.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, March 12, 2012, Simon Horman wrote:
> On Tue, Mar 06, 2012 at 11:13:10PM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, March 06, 2012, Paul Mundt wrote:
> > > On Mon, Mar 05, 2012 at 11:46:08PM +0100, Rafael J. Wysocki wrote:
> > > > On Monday, March 05, 2012, Rafael J. Wysocki wrote:
> > > > > Anyway, to use the same approach in all three drivers we need a flag that
> > > > > will allow a driver to say "don't power down the domain this device belongs to"
> > > > > to the core.  It shouldn't be very difficult to introduce it, but I'm still
> > > > > not sure that will make the "TMU vs system resume" problem mentioned above go
> > > > > away.
> > > > > 
> > > > > I'll try to prepare a patch for that later today anyway.
> > > > 
> > > > Is appended.  Without a changelog for now, because I need to add CMT and
> > > > MTU2 to it still.
> > > > 
> > > The updated version looks much nicer, and the interaction with early
> > > platform entry is quite obvious. If we can reuse this for CMT and MTU2
> > > then that should about take care of it.
> > 
> > I believe that we can.
> > 
> > > Thanks for persisting!
> > 
> > No problem.
> > 
> > Below is a full patch with a changelog and CMT and MTU2 changes too.
> > This has been tested on Mackerel both with and without the TMU driver
> > without causing any visible issues to appear.
> 
> Hi Rafael,
> 
> I apologise for not responding earlier, I returned from a vacation
> (without my Mackerel) last night,
> 
> I have tried the patch below (slightly modified as I have detailed inline)
> on top of 3.3-rc7, however, I am observing that the boot hangs in the
> usual spot when using the default config.

First off, the patch applies to 3.3-rc7 without any modifications for me.

> arm_vmregion_alloc: allocation too big (requested 0x7e9000)
> sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: unable to allocate buffer
> sh_mobile_lcdc_fb: probe of sh_mobile_lcdc_fb.1 failed with error -12
> SuperH SCI(F) driver initialized
> sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
> sh-sci sh-sci.0: start latency exceeded, new value 6084 ns
> console [ttySC0] enabled, bootconsole disabled
> console [ttySC0] enabled, bootconsole disabled

I've just tried the default .config for Mackerel and I cannot reproduce the
problem with the patch applied.

Can you double-check, please?

Thanks,
Rafael
