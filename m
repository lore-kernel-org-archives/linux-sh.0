From: Simon Horman <horms@verge.net.au>
Date: Tue, 04 Jun 2013 01:59:11 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: r8a7779: Fix missing MOD_SEL2 entry
Message-Id: <20130604015911.GO23054@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370245948-2769-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1370245948-2769-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 03, 2013 at 08:52:28AM +0100, Phil Edworthy wrote:
> The list of functions selected by the MOD_SEL2 register was missing
> an entry. This caused all entries after this to modify the MOD_SEL2
> register incorrectly.
> 
> This bug showed up when selecting i2c2_c pins on the Renesas Hurricane board.
> 
> This bug has been present since pinmux support was added for the
> r8a7779 SoC by 881023d28b465eb457067dc8bbca0f24d8b34279 ("sh-pfc: Add
> r8a7779 pinmux support") in v3.8-rc4.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Hi Phil,

thanks.

It seems that I find myself under some pressure to minimise the
fixes are included in v3.10. And as the Hurricane board is not
upstream I am now thinking that it would be better to delay this
fix and include it in v3.11.

> ---
> v2: Improved the changelog
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> index 13feaa0..5dfeb3e 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> @@ -2525,7 +2525,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
>  	    /* SEL_SCIF [2] */
>  	    FN_SEL_SCIF_0, FN_SEL_SCIF_1, FN_SEL_SCIF_2, FN_SEL_SCIF_3,
>  	    /* SEL_CANCLK [2] */
> -	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2,
> +	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2, 0,
>  	    /* SEL_CAN0 [1] */
>  	    FN_SEL_CAN0_0, FN_SEL_CAN0_1,
>  	    /* SEL_HSCIF1 [1] */
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
