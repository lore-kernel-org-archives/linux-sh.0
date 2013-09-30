From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 30 Sep 2013 11:44:31 +0000
Subject: Re: [PATCH] sh-pfc: r8a7778: add CAN pin groups
Message-Id: <2473774.pT69DUnWDx@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201309280307.22017.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201309280307.22017.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Saturday 28 September 2013 03:07:21 Sergei Shtylyov wrote:
> Add CAN data and clock pin groups to R8A7778 PFC driver.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I've applied the patch to my tree and will send a pull request for v3.13.

> ---
> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
> repo.
> 
> Linus, could you please publish your tree in the MAINTAINERS file at last,
> so that people don't have to guess where it is?
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   55 +++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> =================================> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> @@ -1304,6 +1304,33 @@ AUDIO_PFC_DAT(audio_clkout_a,	AUDIO_CLKO
>  AUDIO_PFC_PIN(audio_clkout_b,	RCAR_GP_PIN(1, 16));
>  AUDIO_PFC_DAT(audio_clkout_b,	AUDIO_CLKOUT_B);
> 
> +/* - CAN macro
> --------_----------------------------------------------------- */ +#define
> CAN_PFC_PINS(name, args...)		SH_PFC_PINS(name, args)
> +#define CAN_PFC_DATA(name, tx, rx)		SH_PFC_MUX2(name, tx, rx)
> +#define CAN_PFC_CLK(name, clk)			SH_PFC_MUX1(name, clk)
> +
> +/* - CAN0
> ------------------------------------------------------------------- */
> +CAN_PFC_PINS(can0_data_a,	RCAR_GP_PIN(1, 30),	RCAR_GP_PIN(1, 31));
> +CAN_PFC_DATA(can0_data_a,	CAN0_TX_A,		CAN0_RX_A);
> +CAN_PFC_PINS(can0_data_b,	RCAR_GP_PIN(2, 26),	RCAR_GP_PIN(2, 27));
> +CAN_PFC_DATA(can0_data_b,	CAN0_TX_B,		CAN0_RX_B);
> +
> +/* - CAN1
> ------------------------------------------------------------------- */
> +CAN_PFC_PINS(can1_data_a,	RCAR_GP_PIN(4, 20),	RCAR_GP_PIN(4, 19));
> +CAN_PFC_DATA(can1_data_a,	CAN1_TX_A,		CAN1_RX_A);
> +CAN_PFC_PINS(can1_data_b,	RCAR_GP_PIN(2, 28),	RCAR_GP_PIN(2, 29));
> +CAN_PFC_DATA(can1_data_b,	CAN1_TX_B,		CAN1_RX_B);
> +
> +/* - CAN_CLK 
> --------------------------------------------------------------- */
> +CAN_PFC_PINS(can_clk_a,		RCAR_GP_PIN(3, 24));
> +CAN_PFC_CLK(can_clk_a,		CAN_CLK_A);
> +CAN_PFC_PINS(can_clk_b,		RCAR_GP_PIN(1, 16));
> +CAN_PFC_CLK(can_clk_b,		CAN_CLK_B);
> +CAN_PFC_PINS(can_clk_c,		RCAR_GP_PIN(4, 24));
> +CAN_PFC_CLK(can_clk_c,		CAN_CLK_C);
> +CAN_PFC_PINS(can_clk_d,		RCAR_GP_PIN(2, 25));
> +CAN_PFC_CLK(can_clk_d,		CAN_CLK_D);
> +
>  /* - Ether
> ------------------------------------------------------------------ */
> SH_PFC_PINS(ether_rmii,		RCAR_GP_PIN(4, 10),	RCAR_GP_PIN(4, 11),
>  				RCAR_GP_PIN(4, 13),	RCAR_GP_PIN(4, 9),
> @@ -1698,6 +1725,14 @@ static const struct sh_pfc_pin_group pin
>  	SH_PFC_PIN_GROUP(audio_clk_c),
>  	SH_PFC_PIN_GROUP(audio_clkout_a),
>  	SH_PFC_PIN_GROUP(audio_clkout_b),
> +	SH_PFC_PIN_GROUP(can0_data_a),
> +	SH_PFC_PIN_GROUP(can0_data_b),
> +	SH_PFC_PIN_GROUP(can1_data_a),
> +	SH_PFC_PIN_GROUP(can1_data_b),
> +	SH_PFC_PIN_GROUP(can_clk_a),
> +	SH_PFC_PIN_GROUP(can_clk_b),
> +	SH_PFC_PIN_GROUP(can_clk_c),
> +	SH_PFC_PIN_GROUP(can_clk_d),
>  	SH_PFC_PIN_GROUP(ether_rmii),
>  	SH_PFC_PIN_GROUP(ether_link),
>  	SH_PFC_PIN_GROUP(ether_magic),
> @@ -1826,6 +1861,24 @@ static const char * const audio_clk_grou
>  	"audio_clkout_b",
>  };
> 
> +static const char * const can0_groups[] = {
> +	"can0_data_a",
> +	"can0_data_b",
> +	"can_clk_a",
> +	"can_clk_b",
> +	"can_clk_c",
> +	"can_clk_d",
> +};
> +
> +static const char * const can1_groups[] = {
> +	"can1_data_a",
> +	"can1_data_b",
> +	"can_clk_a",
> +	"can_clk_b",
> +	"can_clk_c",
> +	"can_clk_d",
> +};
> +
>  static const char * const ether_groups[] = {
>  	"ether_rmii",
>  	"ether_link",
> @@ -2022,6 +2075,8 @@ static const char * const vin1_groups[]
> 
>  static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(audio_clk),
> +	SH_PFC_FUNCTION(can0),
> +	SH_PFC_FUNCTION(can1),
>  	SH_PFC_FUNCTION(ether),
>  	SH_PFC_FUNCTION(hscif0),
>  	SH_PFC_FUNCTION(hscif1),

-- 
Regards,

Laurent Pinchart

