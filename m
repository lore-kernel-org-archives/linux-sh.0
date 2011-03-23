From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 23 Mar 2011 13:32:31 +0000
Subject: Re: [patch] sh: clkfwk: potential null deref in debug code
Message-Id: <20110323133231.GC17693@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110320111249.GH2008@bicker>
In-Reply-To: <20110320111249.GH2008@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 20, 2011 at 04:57:50PM +0100, Guennadi Liakhovetski wrote:
> Hi Dan
> 
> On Sun, 20 Mar 2011, Dan Carpenter wrote:
> 
> > This function is designed to accept a NULL for "best_freq" but the
> > debug code dereferences it unconditionally.
> > 
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> > Btw.  Smatch complains that "best" could NULL as well, but I don't
> > know if actually that's possible so I left it as is.
> > 
> > diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
> > index 5f63c3b..dee971c 100644
> > --- a/drivers/sh/clk/core.c
> > +++ b/drivers/sh/clk/core.c
> > @@ -616,7 +616,7 @@ long clk_round_parent(struct clk *clk, unsigned long target,
> >  
> >  		pr_debug("%u / %lu = %lu, / %lu = %lu, best %lu, parent %u\n",
> >  			 freq->frequency, div, freq_high, div + 1, freq_low,
> > -			 *best_freq, best->frequency);
> > +			 best_freq ? *best_freq : -1, best->frequency);
> 
> What about another occasion of dereferencing best_freq at the top of the 
> clk_round_parent() function:
> 
> 	if (!parent) {
> 		*parent_freq = 0;
> 		*best_freq = clk_round_rate(clk, target);
> 		return abs(target - *best_freq);
> 	}
> 
> ?
> 
Do we actually have users that are passing in NULL for best_freq? I don't
recall writing this code, so I assume you did :-)
