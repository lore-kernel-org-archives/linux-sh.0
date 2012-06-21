From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jun 2012 05:38:39 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: armadillo800eva: Use late init machine hook
Message-Id: <87ipel8bs4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1340189605-22074-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1340189605-22074-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Magnus

> Since commit 21cc1b7ede3cf456cf1d51f8a906093261f7c111 ("ARM: shmobile:
> use machine specific hook for late init") suspend and CPU idle are not
> initialized automatically anymore. Set shmobile_init_late() as the
> machine late init hook to initialize them.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index c0ad535..a70993f 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -990,6 +990,7 @@ DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
>  	.init_irq	= r8a7740_init_irq,
>  	.handle_irq	= shmobile_handle_irq_intc,
>  	.init_machine	= eva_init,
> +	.init_late	= shmobile_init_late,
>  	.timer		= &shmobile_timer,
>  	.dt_compat	= eva_boards_compat_dt,
>  MACHINE_END
> -- 

Not only armadillo800eva, but also kzm9g/kzm9d (= new board) are missing it.

Kuninori Morimoto (2):
      ARM: shmobile: kzm9g: use late init machine hook
      ARM: shmobile: kzm9d: use late init machine hook

Best regards
---
Kuninori Morimoto
