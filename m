From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 24 Jul 2013 09:58:45 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva: tidyup ST1232 pin settings
Message-Id: <2439753.x4g5oclBBG@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wednesday 24 July 2013 17:16:12 Kuninori Morimoto wrote:
> 89ae7b5bbd3e65bc6ab7a577ca5ec18569589c8c
> (ARM: shmobile: armadillo800eva: Register pinctrl mapping for INTC)
> adds gpio request for 166pin, but it will be requested from
> st1232 driver itself via st1232_pdata :: reset_gpio.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> 
> >> Simon, Hiep-san, Laurent
> 
> Could you please check this patch ?
> 
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    3 ---
>  1 file changed, 3 deletions(-)

Oops, I've submitted an identical patch that I had in my tree before seeing 
yours. That probably means the code is correct, and it implies my Acked-by :-)

> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c
> b/arch/arm/mach-shmobile/board-armadillo800eva.c index 2412fca..4cfcbbe
> 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -1205,9 +1205,6 @@ static void __init eva_init(void)
>  	/* LCDC0 */
>  	gpio_request_one(61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
> 
> -	/* Touchscreen */
> -	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
> -
>  	/* GETHER */
>  	gpio_request_one(18, GPIOF_OUT_INIT_HIGH, NULL); /* PHY_RST */

-- 
Regards,

Laurent Pinchart

