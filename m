From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 03:46:46 +0000
Subject: Re: [PATCH v2 5/8] ARM: shmobile: add sh73a0-specific timer initialisation to kzm9g-reference
Message-Id: <20130213034646.GE30425@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360348712-29255-6-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360348712-29255-6-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 08, 2013 at 07:38:29PM +0100, Guennadi Liakhovetski wrote:
> This patch fixes failing boot of the kzm9g-reference kernel.

Magnus specifically asked for the DT reference code not to use
early timers.

As you have no doubt observed the current code doesn't work with SMP.
I have not been able to find a solution that does work with CONFIG_SMP
enabled without using early timers. I would welcome some ideas
on how to resolve this problem without using early timers.

> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Also a fix.
> 
>  arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> index 534eee6..9f5cab757 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> @@ -112,7 +112,7 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
>  	.init_irq	= sh73a0_init_irq_dt,
>  	.init_machine	= kzm_init,
>  	.init_late	= shmobile_init_late,
> -	.init_time	= shmobile_timer_init,
> +	.init_time	= sh73a0_earlytimer_init,
>  	.restart	= kzm9g_restart,
>  	.dt_compat	= kzm9g_boards_compat_dt,
>  MACHINE_END
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
