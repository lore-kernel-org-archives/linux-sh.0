From: Simon Horman <horms@verge.net.au>
Date: Thu, 27 Jun 2013 07:16:52 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: r8a73a4: safeguard against wrong clk_set_rate() uses
Message-Id: <20130627071652.GC25014@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371798638-10530-1-git-send-email-g.liakhovetski@gmx.de>
 <1371798638-10530-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1371798638-10530-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jun 21, 2013 at 09:10:35AM +0200, Guennadi Liakhovetski wrote:
> clk_set_rate() should only be called with exact rates, returned by
> clk_round_rate(). However, it is still good to verify, that the value,
> passed to clock's .set_rate() method is at least valid. This patch adds
> such a check for the Z-clock on r8a73a4.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks, I have queued this up for v3.12 in the soc branch.

> ---
>  arch/arm/mach-shmobile/clock-r8a73a4.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
> index eb42740..cbf9852 100644
> --- a/arch/arm/mach-shmobile/clock-r8a73a4.c
> +++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
> @@ -225,16 +225,28 @@ static int zclk_set_rate(struct clk *clk, unsigned long rate)
>  		goto done;
>  	}
>  
> -	frqcrc = clk->mapped_reg + (FRQCRC - (u32)clk->enable_reg);
> +	/*
> +	 * Users are supposed to first call clk_set_rate() only with
> +	 * clk_round_rate() results. So, we don't fix wrong rates here, but
> +	 * guard against them anyway
> +	 */
>  
>  	p_rate = clk_get_rate(clk->parent);
>  	if (rate = p_rate) {
>  		val = 0;
>  	} else {
>  		step = DIV_ROUND_CLOSEST(p_rate, 32);
> +
> +		if (rate > p_rate || rate < step) {
> +			ret = -EINVAL;
> +			goto done;
> +		}
> +
>  		val = 32 - rate / step;
>  	}
>  
> +	frqcrc = clk->mapped_reg + (FRQCRC - (u32)clk->enable_reg);
> +
>  	iowrite32((ioread32(frqcrc) & ~(clk->div_mask << clk->enable_bit)) |
>  		  (val << clk->enable_bit), frqcrc);
>  
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
