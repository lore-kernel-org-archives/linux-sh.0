From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Jul 2013 04:42:21 +0000
Subject: Re: [PATCH v5 1/5] ARM: shmobile: r8a7740: Fix TPU clock name
Message-Id: <20130719044218.GA10959@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373970728-28648-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1373970728-28648-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 16, 2013 at 12:32:04PM +0200, Laurent Pinchart wrote:
> The TPU device is called renesas-tpu-pwm, not renesas_tpu_pwm. Fix the
> clock name accordingly.

Thanks, I have queued this up for v3.12 in the fixes-for-v3.12 branch.

> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7740.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> index de10fd7..f4265e5 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> @@ -596,7 +596,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("e6bd0000.mmcif",         &mstp_clks[MSTP312]),
>  	CLKDEV_DEV_ID("r8a7740-gether",		&mstp_clks[MSTP309]),
>  	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
> -	CLKDEV_DEV_ID("renesas_tpu_pwm",	&mstp_clks[MSTP304]),
> +	CLKDEV_DEV_ID("renesas-tpu-pwm",	&mstp_clks[MSTP304]),
>  
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
>  	CLKDEV_DEV_ID("e6870000.sdhi",          &mstp_clks[MSTP415]),
> -- 
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
