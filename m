From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 07 Jan 2011 10:24:29 +0000
Subject: Re: [RFC][PATCH 6/6] ARM: mach-shmobile: clock-sh7372: remove pllc2
Message-Id: <Pine.LNX.4.64.1101071122080.32550@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 19 Nov 2010, Kuninori Morimoto wrote:

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch kills HDMI video with

sh-mobile-hdmi sh-mobile-hdmi: Cannot set rate 74250000: -2

and sometimes locks the ap4evb up.

Thanks
Guennadi

> ---
>  arch/arm/mach-shmobile/board-ap4evb.c |    5 +++++
>  arch/arm/mach-shmobile/clock-sh7372.c |   12 ++----------
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> index 53a281b..a1d8384 100644
> --- a/arch/arm/mach-shmobile/board-ap4evb.c
> +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> @@ -969,6 +969,11 @@ static int __init hdmi_init_pm_clock(void)
>  		goto out;
>  	}
>  
> +	ret = clk_enable(&sh7372_pllc2_clk);
> +	if (ret < 0) {
> +		pr_err("Cannot enable pllc2 clock\n");
> +		goto out;
> +	}
>  	pr_debug("PLLC2 set frequency %lu\n", rate);
>  
>  	ret = clk_set_parent(hdmi_ick, &sh7372_pllc2_clk);
> diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
> index cbeca28..e18a124 100644
> --- a/arch/arm/mach-shmobile/clock-sh7372.c
> +++ b/arch/arm/mach-shmobile/clock-sh7372.c
> @@ -230,21 +230,13 @@ static int pllc2_set_rate(struct clk *clk,
>  	if (idx < 0)
>  		return idx;
>  
> -	if (rate = clk->parent->rate) {
> -		pllc2_disable(clk);
> -		return 0;
> -	}
> +	if (rate = clk->parent->rate)
> +		return -EINVAL;
>  
>  	value = __raw_readl(PLLC2CR) & ~(0x3f << 24);
>  
> -	if (value & 0x80000000)
> -		pllc2_disable(clk);
> -
>  	__raw_writel((value & ~0x80000000) | ((idx + 19) << 24), PLLC2CR);
>  
> -	if (value & 0x80000000)
> -		return pllc2_enable(clk);
> -
>  	return 0;
>  }
>  
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
