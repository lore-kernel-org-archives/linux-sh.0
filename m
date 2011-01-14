From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 14 Jan 2011 16:53:00 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-sh7372: fixup pllc2 set_rate
Message-Id: <Pine.LNX.4.64.1101141752160.1889@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Morimoto-san

Thanks for the patch, it does fix the regression.

On Tue, 11 Jan 2011, Kuninori Morimoto wrote:

> This patch fixup 421b446abeec55bed1251fab80cb5c12be58b773
>  - Care clk->rate
>  - Don't over write PLLC2 enable bit
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
> Guennadi
> 
> Thank you for your report about it.
> Is this patch solve your issue ?
> I tested this patch on ap4evb, mackerel on Paul's rmobile-latest.
> 
>  arch/arm/mach-shmobile/clock-sh7372.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
> index 9aa8d68..e9731b5 100644
> --- a/arch/arm/mach-shmobile/clock-sh7372.c
> +++ b/arch/arm/mach-shmobile/clock-sh7372.c
> @@ -234,7 +234,9 @@ static int pllc2_set_rate(struct clk *clk, unsigned long rate)
>  
>  	value = __raw_readl(PLLC2CR) & ~(0x3f << 24);
>  
> -	__raw_writel((value & ~0x80000000) | ((idx + 19) << 24), PLLC2CR);
> +	__raw_writel(value | ((idx + 19) << 24), PLLC2CR);
> +
> +	clk->rate = clk->freq_table[idx].frequency;
>  
>  	return 0;
>  }
> -- 
> 1.7.1
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
