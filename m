From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 23 Mar 2011 14:01:00 +0000
Subject: Re: [patch] sh: clkfwk: potential null deref in debug code
Message-Id: <Pine.LNX.4.64.1103231459290.6836@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20110320111249.GH2008@bicker>
In-Reply-To: <20110320111249.GH2008@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 23 Mar 2011, Paul Mundt wrote:

> On Sun, Mar 20, 2011 at 04:57:50PM +0100, Guennadi Liakhovetski wrote:
> > Hi Dan
> > 
> > On Sun, 20 Mar 2011, Dan Carpenter wrote:
> > 
> > > This function is designed to accept a NULL for "best_freq" but the
> > > debug code dereferences it unconditionally.
> > > 
> > > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > > ---
> > > Btw.  Smatch complains that "best" could NULL as well, but I don't
> > > know if actually that's possible so I left it as is.
> > > 
> > > diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
> > > index 5f63c3b..dee971c 100644
> > > --- a/drivers/sh/clk/core.c
> > > +++ b/drivers/sh/clk/core.c
> > > @@ -616,7 +616,7 @@ long clk_round_parent(struct clk *clk, unsigned long target,
> > >  
> > >  		pr_debug("%u / %lu = %lu, / %lu = %lu, best %lu, parent %u\n",
> > >  			 freq->frequency, div, freq_high, div + 1, freq_low,
> > > -			 *best_freq, best->frequency);
> > > +			 best_freq ? *best_freq : -1, best->frequency);
> > 
> > What about another occasion of dereferencing best_freq at the top of the 
> > clk_round_parent() function:
> > 
> > 	if (!parent) {
> > 		*parent_freq = 0;
> > 		*best_freq = clk_round_rate(clk, target);
> > 		return abs(target - *best_freq);
> > 	}
> > 
> > ?
> > 
> Do we actually have users that are passing in NULL for best_freq? I don't
> recall writing this code, so I assume you did :-)

That seems very likely;) Yes, that's from my patch, and so far we have 
only one user - ap4evb_clk_optimize() and it doesn't pass NULL to the fn. 
But perhaps it is better to be consistent and if the variable is checked 
for NULL on some occasions, it should be checked everywhere.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
