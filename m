From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 01 Oct 2010 16:21:42 +0000
Subject: Re: [PATCH 1/2] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock
Message-Id: <Pine.LNX.4.64.1010011813430.5953@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 1 Oct 2010, Kuninori Morimoto wrote:

> 
> This patch add late_main_clks clock array,
> because these clock needs div6 clocks for use
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/clock-sh7372.c        |  132 ++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/sh7372.h |    2 +
>  2 files changed, 134 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
> index 8b9f50a..6f8eabe 100644
> --- a/arch/arm/mach-shmobile/clock-sh7372.c
> +++ b/arch/arm/mach-shmobile/clock-sh7372.c
> @@ -50,6 +50,9 @@
>  #define SMSTPCR3	0xe615013c
>  #define SMSTPCR4	0xe6150140
>  
> +#define FSIDIVA		0xFE1F8000
> +#define FSIDIVB		0xFE1F8008
> +
>  /* Platforms must set frequency on their DV_CLKI pin */
>  struct clk sh7372_dv_clki_clk = {
>  };
> @@ -417,6 +420,132 @@ static struct clk div6_reparent_clks[DIV6_REPARENT_NR] = {
>  				      fsibckcr_parent, ARRAY_SIZE(fsibckcr_parent), 6, 2),
>  };
>  
> +/* FSI DIV */
> +
> +static void fsidiv_init(struct clk *clk)
> +{
> +	clk->enable_reg = ioremap_nocache((unsigned long)clk->enable_reg, 8);

What happens, if ioremap() fails? On the whole, for some reason I don't 
really like this

void x_init(struct foo *x)
{
	x->reg = ioremap(x->reg, N);
}

approach very much... But maybe it's just me. Why not just add the ioremap 
to this loop

> @@ -582,6 +711,9 @@ void __init sh7372_clock_init(void)
>  	if (!ret)
>  		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
>  
> +	for (k = 0; !ret && (k < ARRAY_SIZE(late_main_clks)); k++)
> +		ret = clk_register(late_main_clks[k]);
> +
>  	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>  
>  	if (!ret)

and only register the respective clock, if it succeeds?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
