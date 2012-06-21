From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 21 Jun 2012 10:22:41 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: kzm9g: use late init machine hook
Message-Id: <201206211222.42086.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <87hau58bpn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hau58bpn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday, June 21, 2012, Kuninori Morimoto wrote:
> Since commit 21cc1b7ede3cf456cf1d51f8a906093261f7c111 ("ARM: shmobile:
> use machine specific hook for late init") suspend and CPU idle are not
> initialized automatically anymore. Set shmobile_init_late() as the
> machine late init hook to initialize them.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied to the fixes branch of the renesas.git tree.

Thanks,
Rafael


> ---
>  arch/arm/mach-shmobile/board-kzm9g.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index d8e33b6..c0ae815 100644
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
> 

