From: Simon Horman <horms@verge.net.au>
Date: Tue, 14 Jun 2011 06:41:31 +0000
Subject: Re: [PATCH][RFC] drivers: sh: late disabling of clocks
Message-Id: <20110614064125.GA5593@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609091339.14510.31590.sendpatchset@t400s>
In-Reply-To: <20110609091339.14510.31590.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 13, 2011 at 05:59:08PM +0900, Simon Horman wrote:
> On Thu, Jun 09, 2011 at 06:13:39PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > This RFC patch kills two birds with one stone:
> > 
> > 1) Fix existing issue where in-use clocks without software
> >    reference are disabled during boot. One example of this
> >    is the handling of the Mackerel serial console output.
> > 
> > 2) Make sure so far unused clocks actually get turned off 
> 
> Is access to allow_disable SMP-safe?
> In particular, does the the access in clk_late_init()
> need to be guarded by clock_lock as calls to __clk_disable() are?

On reflection I think that the problem is a bit deeper.

I think allow_disable is set to 1 prematurely, as it indicates
to __clk_disable() that calling clk->ops->disable(clk) is allowed,
even if the iteration of the loop in clk_late_init() is not complete. 

My proposed re-working of clk_late_init() is below.
Completely untested.

> 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> > 
> >  drivers/sh/clk/core.c |   26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> > 
> > --- 0001/drivers/sh/clk/core.c
> > +++ work/drivers/sh/clk/core.c	2011-06-09 14:13:02.000000000 +0900
> > @@ -34,6 +34,9 @@ static LIST_HEAD(clock_list);
> >  static DEFINE_SPINLOCK(clock_lock);
> >  static DEFINE_MUTEX(clock_list_sem);
> >  
> > +/* clock disable operations are not passed on to hardware during boot */
> > +static int allow_disable;
> > +
> >  void clk_rate_table_build(struct clk *clk,
> >  			  struct cpufreq_frequency_table *freq_table,
> >  			  int nr_freqs,
> > @@ -228,7 +231,7 @@ static void __clk_disable(struct clk *cl
> >  		return;
> >  
> >  	if (!(--clk->usecount)) {
> > -		if (likely(clk->ops && clk->ops->disable))
> > +		if (likely(allow_disable && clk->ops && clk->ops->disable))
> >  			clk->ops->disable(clk);
> >  		if (likely(clk->parent))
> >  			__clk_disable(clk->parent);
> > @@ -747,3 +750,24 @@ err_out:
> >  	return err;
> >  }
> >  late_initcall(clk_debugfs_init);
> > +
> > +static int __init clk_late_init(void)
> > +{
> > +	unsigned long flags;
> > +	struct clk *clk;
> > +
> > +	/* from now on allow clock disable operations */
> > +	allow_disable = 1;
> > +
> > +	/* disable all clocks with zero use count */
> > +	mutex_lock(&clock_list_sem);
> > +	list_for_each_entry(clk, &clock_list, node) {
> > +		spin_lock_irqsave(&clock_lock, flags);
> > +		if (!clk->usecount && clk->ops && clk->ops->disable)
> > +			clk->ops->disable(clk);
> > +		spin_unlock_irqrestore(&clock_lock, flags);
> > +	}
> > +	mutex_unlock(&clock_list_sem);
> > +	return 0;
> > +}

static int __init clk_late_init(void)
{
	unsigned long flags;
	struct clk *clk;

	mutex_lock(&clock_list_sem);
	spin_lock_irqsave(&clock_lock, flags);

	/* disable all clocks with zero use count */
	list_for_each_entry(clk, &clock_list, node)
		if (!clk->usecount && clk->ops && clk->ops->disable)
			clk->ops->disable(clk);

	/* from now on allow clock disable operations */
	allow_disable = 1;

	spin_unlock_irqrestore(&clock_lock, flags);
	mutex_unlock(&clock_list_sem);

	return 0;
}


> > +late_initcall(clk_late_init);
