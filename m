From: Simon Horman <horms@verge.net.au>
Date: Tue, 21 Jun 2011 10:32:36 +0000
Subject: Re: [PATCH] drivers: sh: late disabling of clocks V2
Message-Id: <20110621103229.GD2292@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110621075512.24672.78879.sendpatchset@t400s>
In-Reply-To: <20110621075512.24672.78879.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 21, 2011 at 04:55:12PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This V2 patch changes the clock disabling behavior during boot.
> Two different changes are made:
> 
> 1) Delay disabling of clocks until late in the boot process. 
>    This fixes an existing issue where in-use clocks without
>    software reference are disabled by mistake during boot.
>    One example of this is the handling of the Mackerel serial
>    console output that shares clock with the I2C controller.
> 
> 2) Write out the "disabled" state to the hardware for clocks
>    that not have been used by the kernel. In other words, 
>    make sure so far unused clocks actually get turned off.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Changes since V1:
>  - move out the spinlock and let it protect allow_disable
> 
>  Thanks to Simon Horman for code improvements.
> 
>  This would be useful to have in a topic branch so we can
>  go through each platform and extend the clock framework
>  to a more complete coverage.

Code improvement aspect
Acked-by: Simon Horman <horms@verge.net.au>

> 
>  drivers/sh/clk/core.c |   27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> --- 0001/drivers/sh/clk/core.c
> +++ work/drivers/sh/clk/core.c	2011-06-21 16:27:00.000000000 +0900
> @@ -34,6 +34,9 @@ static LIST_HEAD(clock_list);
>  static DEFINE_SPINLOCK(clock_lock);
>  static DEFINE_MUTEX(clock_list_sem);
>  
> +/* clock disable operations are not passed on to hardware during boot */
> +static int allow_disable;
> +
>  void clk_rate_table_build(struct clk *clk,
>  			  struct cpufreq_frequency_table *freq_table,
>  			  int nr_freqs,
> @@ -228,7 +231,7 @@ static void __clk_disable(struct clk *cl
>  		return;
>  
>  	if (!(--clk->usecount)) {
> -		if (likely(clk->ops && clk->ops->disable))
> +		if (likely(allow_disable && clk->ops && clk->ops->disable))
>  			clk->ops->disable(clk);
>  		if (likely(clk->parent))
>  			__clk_disable(clk->parent);
> @@ -747,3 +750,25 @@ err_out:
>  	return err;
>  }
>  late_initcall(clk_debugfs_init);
> +
> +static int __init clk_late_init(void)
> +{
> +	unsigned long flags;
> +	struct clk *clk;
> +
> +	/* disable all clocks with zero use count */
> +	mutex_lock(&clock_list_sem);
> +	spin_lock_irqsave(&clock_lock, flags);
> +
> +	list_for_each_entry(clk, &clock_list, node)
> +		if (!clk->usecount && clk->ops && clk->ops->disable)
> +			clk->ops->disable(clk);
> +
> +	/* from now on allow clock disable operations */
> +	allow_disable = 1;
> +
> +	spin_unlock_irqrestore(&clock_lock, flags);
> +	mutex_unlock(&clock_list_sem);
> +	return 0;
> +}
> +late_initcall(clk_late_init);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
