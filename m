From: Simon Horman <horms@verge.net.au>
Date: Sat, 25 May 2013 00:56:28 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: tidyup FSI pinctrl
Message-Id: <20130525005626.GB4476@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87hahu4gz5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hahu4gz5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 22, 2013 at 06:34:10PM -0700, Kuninori Morimoto wrote:
> sh73a0 needs "sh_fsi2", not "sh_fsi2.0"
> 
> Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I will queue this up for v3.11 in the boards-kzm9g branch.

> ---
>  arch/arm/mach-shmobile/board-kzm9g.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index ceabb44..ca95724 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -799,13 +799,13 @@ static unsigned long pin_pullup_conf[] = {
>  
>  static const struct pinctrl_map kzm_pinctrl_map[] = {
>  	/* FSIA (AK4648) */
> -	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2", "pfc-sh73a0",
>  				  "fsia_mclk_in", "fsia"),
> -	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2", "pfc-sh73a0",
>  				  "fsia_sclk_in", "fsia"),
> -	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2", "pfc-sh73a0",
>  				  "fsia_data_in", "fsia"),
> -	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2", "pfc-sh73a0",
>  				  "fsia_data_out", "fsia"),
>  	/* I2C3 */
>  	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
