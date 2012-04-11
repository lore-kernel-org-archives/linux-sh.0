From: phil.edworthy@renesas.com
Date: Wed, 11 Apr 2012 16:28:43 +0000
Subject: Re: [PATCH 2/4] sh: Add sh7264 device
Message-Id: <OF685E526A.1CC126B1-ON802579DD.0059B85B-802579DD.005A84FB@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334062853-23045-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1334062853-23045-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

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

> div4 clocks presently assume 32-bit access, too. So it looks like I'll
> have to extend the previous patch to handle those in the same way.

Ok, I have reworked the patches, but without 16-bit div4 clock regs, the
board runs really slowly (probably writing to another reg at the same 
time).
To test my patches, I just hacked the div4 functions to use ioread16/
iowrite16.

I used your patch for 8bit module stop, so should I wait for your 16bit
div4 clock regs patch or send my patches now?

Thanks
Phil
