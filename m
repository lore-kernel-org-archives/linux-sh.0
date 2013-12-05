From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Dec 2013 05:08:03 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: r8a7740: add FSI clock support for DT
Message-Id: <20131205050801.GD12774@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjohz9on.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zjohz9on.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 03, 2013 at 05:28:27PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7740.c |    1 +
>  1 file changed, 1 insertion(+)

Thanks, I will queue this up.

> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> index 6bfc879..dd989f9 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> @@ -585,6 +585,7 @@ static struct clk_lookup lookups[] = {
>  
>  	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
>  	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
> +	CLKDEV_DEV_ID("fe1f0000.sound",		&mstp_clks[MSTP328]),
>  	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
>  	CLKDEV_DEV_ID("e6c20000.i2c",		&mstp_clks[MSTP323]),
>  	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
> -- 
> 1.7.9.5
> 
