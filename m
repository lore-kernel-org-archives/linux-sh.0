From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 29 Nov 2013 17:30:40 +0000
Subject: Re: [PATCH 2/4] sh-pfc: r8a7790: Add Audio pin support
Message-Id: <2184696.xKNVBzokNQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87mwkn52sx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mwkn52sx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Thursday 28 November 2013 19:01:37 Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I've applied the patch to my tree and will send a pull request to Linus 
Walleij for v3.14.

Please see below for one small comment.

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c |   69 +++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index a7fa443..6d567d3 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> @@ -1739,6 +1739,57 @@ static struct sh_pfc_pin pinmux_pins[] = {
>  	SH_PFC_PIN_NAMED(ROW_GROUP_A('H'), 15, AH15),
>  };
> 
> +/* - AUDIO CLOCK ------------------------------------------------------- */
> +static const unsigned int audio_clk_a_pins[] = {
> +	/* CLK A */
> +	RCAR_GP_PIN(4, 25),
> +};
> +static const unsigned int audio_clk_a_mux[] = {
> +	AUDIO_CLKA_MARK,
> +};
> +static const unsigned int audio_clk_b_pins[] = {
> +	/* CLK B */
> +	RCAR_GP_PIN(4, 26),
> +};
> +static const unsigned int audio_clk_b_mux[] = {
> +	AUDIO_CLKB_MARK,
> +};
> +static const unsigned int audio_clk_c_pins[] = {
> +	/* CLK C */
> +	RCAR_GP_PIN(5, 27),
> +};
> +static const unsigned int audio_clk_c_mux[] = {
> +	AUDIO_CLKC_MARK,
> +};
> +static const unsigned int audio_clkout_pins[] = {
> +	/* CLK OUT */
> +	RCAR_GP_PIN(5, 16),
> +};
> +static const unsigned int audio_clkout_mux[] = {
> +	AUDIO_CLKOUT_MARK,
> +};
> +static const unsigned int audio_clkout_b_pins[] = {
> +	/* CLK OUT B */
> +	RCAR_GP_PIN(0, 23),
> +};
> +static const unsigned int audio_clkout_b_mux[] = {
> +	AUDIO_CLKOUT_B_MARK,
> +};
> +static const unsigned int audio_clkout_c_pins[] = {
> +	/* CLK OUT C */
> +	RCAR_GP_PIN(5, 27),
> +};
> +static const unsigned int audio_clkout_c_mux[] = {
> +	AUDIO_CLKOUT_C_MARK,
> +};
> +static const unsigned int audio_clkout_d_pins[] = {
> +	/* CLK OUT D */
> +	RCAR_GP_PIN(5, 20),
> +};
> +static const unsigned int audio_clkout_d_mux[] = {
> +	AUDIO_CLKOUT_D_MARK,
> +};
> +

The file has no blank line after all the other groups, I've thus removed this 
blank line. Please let me know if you're fine with that.

>  /* - DU RGB ------------------------------------------------------------ */
>  static const unsigned int du_rgb666_pins[] = {
>  	/* R[7:2], G[7:2], B[7:2] */
> @@ -3278,6 +3329,13 @@ static const unsigned int vin1_clk_mux[] = {
>  };
> 
>  static const struct sh_pfc_pin_group pinmux_groups[] = {
> +	SH_PFC_PIN_GROUP(audio_clk_a),
> +	SH_PFC_PIN_GROUP(audio_clk_b),
> +	SH_PFC_PIN_GROUP(audio_clk_c),
> +	SH_PFC_PIN_GROUP(audio_clkout),
> +	SH_PFC_PIN_GROUP(audio_clkout_b),
> +	SH_PFC_PIN_GROUP(audio_clkout_c),
> +	SH_PFC_PIN_GROUP(audio_clkout_d),
>  	SH_PFC_PIN_GROUP(du_rgb666),
>  	SH_PFC_PIN_GROUP(du_rgb888),
>  	SH_PFC_PIN_GROUP(du_clk_out_0),
> @@ -3488,6 +3546,16 @@ static const struct sh_pfc_pin_group pinmux_groups[]
> = { SH_PFC_PIN_GROUP(vin1_clk),
>  };
> 
> +static const char * const audio_clk_groups[] = {
> +	"audio_clk_a",
> +	"audio_clk_b",
> +	"audio_clk_c",
> +	"audio_clkout",
> +	"audio_clkout_b",
> +	"audio_clkout_c",
> +	"audio_clkout_d",
> +};
> +
>  static const char * const du_groups[] = {
>  	"du_rgb666",
>  	"du_rgb888",
> @@ -3808,6 +3876,7 @@ static const char * const vin1_groups[] = {
>  };
> 
>  static const struct sh_pfc_function pinmux_functions[] = {
> +	SH_PFC_FUNCTION(audio_clk),
>  	SH_PFC_FUNCTION(du),
>  	SH_PFC_FUNCTION(du0),
>  	SH_PFC_FUNCTION(du1),
-- 
Regards,

Laurent Pinchart

