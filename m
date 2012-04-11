From: phil.edworthy@renesas.com
Date: Wed, 11 Apr 2012 07:44:08 +0000
Subject: Re: [PATCH 2/4] sh: Add sh7264 device
Message-Id: <OF1DA56E26.CC2F9841-ON802579DD.002A5419-802579DD.002A7DFF@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334062853-23045-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1334062853-23045-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

Thanks for your comments. I'll rework the patches accordingly.

Phil

> From: Paul Mundt <lethal@linux-sh.org>
> To: Phil Edworthy <phil.edworthy@renesas.com>, 
> Cc: linux-sh@vger.kernel.org
> Date: 11/04/2012 04:43
> Subject: Re: [PATCH 2/4] sh: Add sh7264 device
> 
> On Tue, Apr 10, 2012 at 02:00:51PM +0100, Phil Edworthy wrote:
> > This is an sh2a device.
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Your changelog is a bit lacking. Some information on the device would be
> nice.
> 
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -288,6 +288,13 @@ config CPU_SUBTYPE_SH7263
> >     select SYS_SUPPORTS_CMT
> >     select SYS_SUPPORTS_MTU2
> > 
> > +config CPU_SUBTYPE_SH7264
> > +   bool "Support SH7264 processor"
> > +   select CPU_SH2A
> > +   select CPU_HAS_FPU
> > +   select SYS_SUPPORTS_CMT
> > +   select SYS_SUPPORTS_MTU2
> > +
> 
> You don't have to deal with I/O space swapping after all?
> 
> > @@ -570,6 +577,7 @@ config SH_PCLK_FREQ
> >                 CPU_SUBTYPE_SH7206 || \
> >                 CPU_SUBTYPE_SH7263 || \
> >                 CPU_SUBTYPE_MXG
> > +   default "36000000" if CPU_SUBTYPE_SH7264
> >     default "60000000" if CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R
> >     default "66000000" if CPU_SUBTYPE_SH4_202
> >     default "50000000"
> 
> It looks like you've gotten tripped up by legacy vs non-legacy clock
> framework utilization. This config option depends on SH_CLK_CPG_LEGACY,
> which we don't want set for any new CPUs. The logic is a bit backwards 
at
> the moment largely because there are more CPUs that depend on it than
> those that don't, which is something that will change incrementally.
> 
> The first thing you want to do is ensure that SH_CLK_CPG_LEGACY is
> unset, which means adding in a !CPU_SUBTYPE_SH7264. This will then get
> rid of the master/peripheral/bus/cpu clock bits, which are all legacy
> lookups that we have no interest in for new parts.
> 
> > diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7264.c b/arch/sh/
> kernel/cpu/sh2a/clock-sh7264.c
> > new file mode 100644
> > index 0000000..dbc9449
> > --- /dev/null
> > +++ b/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
> > @@ -0,0 +1,184 @@
> > +/*
> > + * arch/sh/kernel/cpu/sh2/clock-sh7264.c
> > + *
> > + * SH7264 support for the clock framework
> > + *
> > + *  Copyright (C) 2012  Phil Edworthy
> > + *
> > + * Based on clock-sh7206.c
> > + *  Copyright (C) 2006  Yoshinori Sato
> > + *
> > + * Based on clock-sh4.c
> > + *  Copyright (C) 2005  Paul Mundt
> > + *
> > + * This file is subject to the terms and conditions of the GNU 
> General Public
> > + * License.  See the file "COPYING" in the main directory of this 
archive
> > + * for more details.
> > + */
> 
> Then you will probably want to consult a reasonably modern
> implementation, like arch/sh/kernel/cpu/sh4a/clock-sh7786.c (or in this
> case, perhaps something more like 
arch/sh/kernel/cpu/sh4a/clock-sh7366.c).
> The copyright carrying around isn't necessary, as they're all based on
> each other some way or another.
> 
> > +/* Fixed 32 KHz root clock for RTC */
> > +static struct clk r_clk = {
> > +   .rate           = 32768,
> > +};
> > +
> > +/*
> > + * Default rate for the root input clock, reset this with 
clk_set_rate()
> > + * from the platform code.
> > + */
> > +static struct clk extal_clk = {
> > +   .rate      = 18000000,
> > +};
> > +
> These look good.
> 
> > +static unsigned long master_clk_recalc(struct clk *clk)
> > +{
> > +   unsigned long rate = clk->parent->rate * pll2_mult;
> > +   return rate * pll1rate[(__raw_readw(FREQCR) >> 8) & 1];
> > +}
> 
> ..
> 
> > +static struct clk *main_clocks[] = {
> ..
> > +   &master_clk,
> > +   &peripheral_clk,
> > +   &bus_clk,
> > +   &cpu_clk,
> > +};
> > +
> This is all legacy cruft that you don't want.
> 
> The clock framework already has helpers for all of this, these are
> specifically what we refer to as div4 clocks, which you can set up 
pretty
> easily as well as appropriate nesting with the pll2 clock designated as
> the parent.
> 
> div4 clocks presently assume 32-bit access, too. So it looks like I'll
> have to extend the previous patch to handle those in the same way.
> 
> > +#define STBCR3 0xfffe0408
> > +#define STBCR4 0xfffe040c
> > +#define STBCR5 0xfffe0410
> > +#define STBCR6 0xfffe0414
> > +#define STBCR7 0xfffe0418
> > +#define STBCR8 0xfffe041c
> > +
> > +#define MSTP(_parent, _reg, _bit, _flags) \
> > +   SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
> > +
> These wrappers are starting to get out of hand, so it's preferable to
> just use SH_CLK_MSTP() directly. Using the patch I posted previously you
> can use SH_CLK_MSTP8 or 16 or whatever.
> 
> > +#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
> > +
> Not needed, it's provided generically by linux/sh_clk.h.
> 
> > +void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
> > +{
> > +}
> > +
> Not needed by non-legacy.
> 
> Overall the patch looks fine otherwise.

