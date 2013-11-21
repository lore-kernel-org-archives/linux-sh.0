From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Nov 2013 03:57:55 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: marzen: remove SDHI0 WP pin setting
Message-Id: <20131121035753.GB31130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <871u2bahi7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871u2bahi7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 19, 2013 at 07:17:55PM -0800, Kuninori Morimoto wrote:
> WP pin is not implemented on Marzen
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I will queue this up.
Assuming all goes will I plan to push this and other updates
today or tomorrow.

> ---
>  arch/arm/mach-shmobile/board-marzen.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> index 4f9e3ec..d832a44 100644
> --- a/arch/arm/mach-shmobile/board-marzen.c
> +++ b/arch/arm/mach-shmobile/board-marzen.c
> @@ -347,8 +347,6 @@ static const struct pinctrl_map marzen_pinctrl_map[] = {
>  				  "sdhi0_ctrl", "sdhi0"),
>  	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
>  				  "sdhi0_cd", "sdhi0"),
> -	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
> -				  "sdhi0_wp", "sdhi0"),
>  	/* SMSC */
>  	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a7779",
>  				  "intc_irq1_b", "intc"),
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
