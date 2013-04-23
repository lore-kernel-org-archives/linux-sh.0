From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 23 Apr 2013 23:45:09 +0000
Subject: Re: [PATCH 1/2] sh-pfc: r8a7778: add Ether pin groups
Message-Id: <1977640.GLBB0PbUoD@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201304232334.58125.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304232334.58125.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Tuesday 23 April 2013 23:34:57 Sergei Shtylyov wrote:
> Add Ether RMII/LINK/MAGIC pin groups to R8A7778 PFC driver.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   42 +++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> Index: renesas/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> =================================> --- renesas.orig/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> +++ renesas/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> @@ -1558,6 +1558,38 @@ static const unsigned int vin1_sync_pins
>  static const unsigned int vin1_sync_mux[] = {
>  	VI1_HSYNC_MARK, VI1_VSYNC_MARK,
>  };
> +/* - Ether
> ------------------------------------------------------------------ */

Could you please keep the sections alphabetically sorted ?

> +static const unsigned int ether_rmii_pins[] = {
> +	/*
> +	 * ETH_TXD0, ETH_TXD1, ETH_TX_EN,  ETH_REF_CLK,
> +	 * ETH_RXD0, ETH_RXD1, ETH_CRS_DV, ETH_RX_ER,
> +	 * ETH_MDIO, ETH_MDC
> +	 */
> +	RCAR_GP_PIN(4, 10), RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 13),
> +	RCAR_GP_PIN(4, 9),
> +	RCAR_GP_PIN(4, 15), RCAR_GP_PIN(4, 16), RCAR_GP_PIN(4, 12),
> +	RCAR_GP_PIN(4, 14),
> +	RCAR_GP_PIN(4, 18), RCAR_GP_PIN(4, 17),
> +};
> +static const unsigned int ether_rmii_mux[] = {
> +	ETH_TXD0_MARK, ETH_TXD1_MARK, ETH_TX_EN_MARK,  ETH_REF_CLK_MARK,
> +	ETH_RXD0_MARK, ETH_RXD1_MARK, ETH_CRS_DV_MARK, ETH_RX_ER_MARK,
> +	ETH_MDIO_MARK, ETH_MDC_MARK,
> +};
> +static const unsigned int ether_link_pins[] = {
> +	/* ETH_LINK */
> +	RCAR_GP_PIN(4, 19),
> +};
> +static const unsigned int ether_link_mux[] = {
> +	ETH_LINK_MARK,
> +};
> +static const unsigned int ether_magic_pins[] = {
> +	/* ETH_MAGIC */
> +	RCAR_GP_PIN(4, 20),
> +};
> +static const unsigned int ether_magic_mux[] = {
> +	ETH_MAGIC_MARK,
> +};
> 
>  static const struct sh_pfc_pin_group pinmux_groups[] = {
>  	SH_PFC_PIN_GROUP(hscif0_data_a),
> @@ -1634,6 +1666,9 @@ static const struct sh_pfc_pin_group pin
>  	SH_PFC_PIN_GROUP(vin1_data8),
>  	SH_PFC_PIN_GROUP(vin1_clk),
>  	SH_PFC_PIN_GROUP(vin1_sync),
> +	SH_PFC_PIN_GROUP(ether_rmii),
> +	SH_PFC_PIN_GROUP(ether_link),
> +	SH_PFC_PIN_GROUP(ether_magic),

Same for the groups here.

>  };
> 
>  static const char * const hscif0_groups[] = {
> @@ -1753,6 +1788,12 @@ static const char * const vin1_groups[]
>  	"vin1_sync",
>  };
> 
> +static const char * const ether_groups[] = {
> +	"ether_rmii",
> +	"ether_link",
> +	"ether_magic",
> +};

And here.

> +
>  static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(hscif0),
>  	SH_PFC_FUNCTION(hscif1),
> @@ -1768,6 +1809,7 @@ static const struct sh_pfc_function pinm
>  	SH_PFC_FUNCTION(sdhi2),
>  	SH_PFC_FUNCTION(vin0),
>  	SH_PFC_FUNCTION(vin1),
> +	SH_PFC_FUNCTION(ether),

And for the functions here.

>  };
> 
>  static struct pinmux_cfg_reg pinmux_config_regs[] = {

Same comment for 2/2.

The patches otherwise look good to me.

-- 
Regards,

Laurent Pinchart

