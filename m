From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 21 Jun 2012 09:06:05 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: kzm9g: use late init machine hook
Message-Id: <7019574.FE0MYK3kQk@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87hau58bpn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hau58bpn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Wednesday 20 June 2012 22:40:08 Kuninori Morimoto wrote:
> Since commit 21cc1b7ede3cf456cf1d51f8a906093261f7c111 ("ARM: shmobile:
> use machine specific hook for late init") suspend and CPU idle are not
> initialized automatically anymore. Set shmobile_init_late() as the
> machine late init hook to initialize them.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/mach-shmobile/board-kzm9g.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c
> b/arch/arm/mach-shmobile/board-kzm9g.c index d8e33b6..c0ae815 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -455,6 +455,7 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g")
>  	.init_irq	= sh73a0_init_irq,
>  	.handle_irq	= gic_handle_irq,
>  	.init_machine	= kzm_init,
> +	.init_late	= shmobile_init_late,
>  	.timer		= &shmobile_timer,
>  	.dt_compat	= kzm9g_boards_compat_dt,
>  MACHINE_END
-- 
Regards,

Laurent Pinchart

