From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 01 Jul 2014 21:05:05 +0000
Subject: Re: [PATCH v2] sh-pfc: r8a7791: add CAN pin groups
Message-Id: <3292402.Bq7FGTh5pV@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201407020058.17369.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407020058.17369.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Wednesday 02 July 2014 00:58:16 Sergei Shtylyov wrote:
> Add CAN0/1 data/clock pin groups to R8A7791 PFC driver.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Assuming that the same pin group can be specified in different functions (I'm 
waiting for Linus' comment on that),

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
> repo.
> 
> Changes in version 2:
> - fixed CAN_CLK_C pin mapping;
> - renamed can[01]_{clk|data}_a_*[] to can[01]_{clk|data}_*[];
> - added pin name comments to can*_pins[] initializers.
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  167 +++++++++++++++++++++++++++++++
>  1 file changed, 167 insertions(+)
> 
> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> =================================> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> @@ -1726,6 +1726,133 @@ static const unsigned int audio_clkout_m
>  	AUDIO_CLKOUT_MARK,
>  };
> 
> +/* - CAN
> -------------------------------------------------------------------- */ +
> +static const unsigned int can0_data_pins[] = {
> +	/* TX, RX */
> +	RCAR_GP_PIN(3, 26), RCAR_GP_PIN(3, 29),
> +};
> +
> +static const unsigned int can0_data_mux[] = {
> +	CAN0_TX_MARK, CAN0_RX_MARK,
> +};
> +
> +static const unsigned int can0_data_b_pins[] = {
> +	/* TX, RX */
> +	RCAR_GP_PIN(7, 4), RCAR_GP_PIN(7, 3),
> +};
> +
> +static const unsigned int can0_data_b_mux[] = {
> +	CAN0_TX_B_MARK, CAN0_RX_B_MARK,
> +};
> +
> +static const unsigned int can0_data_c_pins[] = {
> +	/* TX, RX */
> +	RCAR_GP_PIN(5, 17), RCAR_GP_PIN(5, 18),
> +};
> +
> +static const unsigned int can0_data_c_mux[] = {
> +	CAN0_TX_C_MARK,	CAN0_RX_C_MARK,
> +};
> +
> +static const unsigned int can0_data_d_pins[] = {
> +	/* TX, RX */
> +	RCAR_GP_PIN(2, 26), RCAR_GP_PIN(2, 27),
> +};
> +
> +static const unsigned int can0_data_d_mux[] = {
> +	CAN0_TX_D_MARK, CAN0_RX_D_MARK,
> +};
> +
> +static const unsigned int can0_data_e_pins[] = {
> +	/* TX, RX */
> +	RCAR_GP_PIN(4, 18), RCAR_GP_PIN(4, 28),
> +};
> +
> +static const unsigned int can0_data_e_mux[] = {
> +	CAN0_TX_E_MARK, CAN0_RX_E_MARK,
> +};
> +
> +static const unsigned int can0_data_f_pins[] = {
> +	/* TX, RX */
> +	RCAR_GP_PIN(6, 7), RCAR_GP_PIN(6, 6),
> +};
> +
> +static const unsigned int can0_data_f_mux[] = {
> +	CAN0_TX_F_MARK, CAN0_RX_F_MARK,
> +};
> +
> +static const unsigned int can1_data_pins[] = {
> +	/* TX, RX */
> +	 RCAR_GP_PIN(3, 21), RCAR_GP_PIN(3, 20),
> +};
> +
> +static const unsigned int can1_data_mux[] = {
> +	CAN1_TX_MARK, CAN1_RX_MARK,
> +};
> +
> +static const unsigned int can1_data_b_pins[] = {
> +	/* TX, RX */
> +	RCAR_GP_PIN(7, 8), RCAR_GP_PIN(7, 9),
> +};
> +
> +static const unsigned int can1_data_b_mux[] = {
> +	CAN1_TX_B_MARK, CAN1_RX_B_MARK,
> +};
> +
> +static const unsigned int can1_data_c_pins[] = {
> +	/* TX, RX */
> +	RCAR_GP_PIN(5, 20), RCAR_GP_PIN(5, 19),
> +};
> +
> +static const unsigned int can1_data_c_mux[] = {
> +	CAN1_TX_C_MARK, CAN1_RX_C_MARK,
> +};
> +
> +static const unsigned int can1_data_d_pins[] = {
> +	/* TX, RX */
> +	 RCAR_GP_PIN(4, 29), RCAR_GP_PIN(4, 31),
> +};
> +
> +static const unsigned int can1_data_d_mux[] = {
> +	CAN1_TX_D_MARK, CAN1_RX_D_MARK,
> +};
> +
> +static const unsigned int can_clk_pins[] = {
> +	/* CLK */
> +	RCAR_GP_PIN(7, 2),
> +};
> +
> +static const unsigned int can_clk_mux[] = {
> +	CAN_CLK_MARK,
> +};
> +
> +static const unsigned int can_clk_b_pins[] = {
> +	/* CLK */
> +	RCAR_GP_PIN(5, 21),
> +};
> +
> +static const unsigned int can_clk_b_mux[] = {
> +	CAN_CLK_B_MARK,
> +};
> +
> +static const unsigned int can_clk_c_pins[] = {
> +	/* CLK */
> +	RCAR_GP_PIN(4, 30),
> +};
> +
> +static const unsigned int can_clk_c_mux[] = {
> +	CAN_CLK_C_MARK,
> +};
> +
> +static const unsigned int can_clk_d_pins[] = {
> +	/* CLK */
> +	RCAR_GP_PIN(7, 19),
> +};
> +
> +static const unsigned int can_clk_d_mux[] = {
> +	CAN_CLK_D_MARK,
> +};
> 
>  /* - DU
> --------------------------------------------------------------------- */
> static const unsigned int du_rgb666_pins[] = {
> @@ -4055,6 +4182,20 @@ static const struct sh_pfc_pin_group pin
>  	SH_PFC_PIN_GROUP(audio_clk_b_b),
>  	SH_PFC_PIN_GROUP(audio_clk_c),
>  	SH_PFC_PIN_GROUP(audio_clkout),
> +	SH_PFC_PIN_GROUP(can0_data),
> +	SH_PFC_PIN_GROUP(can0_data_b),
> +	SH_PFC_PIN_GROUP(can0_data_c),
> +	SH_PFC_PIN_GROUP(can0_data_d),
> +	SH_PFC_PIN_GROUP(can0_data_e),
> +	SH_PFC_PIN_GROUP(can0_data_f),
> +	SH_PFC_PIN_GROUP(can1_data),
> +	SH_PFC_PIN_GROUP(can1_data_b),
> +	SH_PFC_PIN_GROUP(can1_data_c),
> +	SH_PFC_PIN_GROUP(can1_data_d),
> +	SH_PFC_PIN_GROUP(can_clk),
> +	SH_PFC_PIN_GROUP(can_clk_b),
> +	SH_PFC_PIN_GROUP(can_clk_c),
> +	SH_PFC_PIN_GROUP(can_clk_d),
>  	SH_PFC_PIN_GROUP(du_rgb666),
>  	SH_PFC_PIN_GROUP(du_rgb888),
>  	SH_PFC_PIN_GROUP(du_clk_out_0),
> @@ -4367,6 +4508,30 @@ static const char * const audio_clk_grou
>  	"audio_clkout",
>  };
> 
> +static const char * const can0_groups[] = {
> +	"can0_data_a",
> +	"can0_data_b",
> +	"can0_data_c",
> +	"can0_data_d",
> +	"can0_data_e",
> +	"can0_data_f",
> +	"can_clk_a",
> +	"can_clk_b",
> +	"can_clk_c",
> +	"can_clk_d",
> +};
> +
> +static const char * const can1_groups[] = {
> +	"can1_data_a",
> +	"can1_data_b",
> +	"can1_data_c",
> +	"can1_data_d",
> +	"can_clk_a",
> +	"can_clk_b",
> +	"can_clk_c",
> +	"can_clk_d",
> +};
> +
>  static const char * const du_groups[] = {
>  	"du_rgb666",
>  	"du_rgb888",
> @@ -4790,6 +4955,8 @@ static const char * const vin2_groups[]
> 
>  static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(audio_clk),
> +	SH_PFC_FUNCTION(can0),
> +	SH_PFC_FUNCTION(can1),
>  	SH_PFC_FUNCTION(du),
>  	SH_PFC_FUNCTION(du0),
>  	SH_PFC_FUNCTION(du1),

-- 
Regards,

Laurent Pinchart

