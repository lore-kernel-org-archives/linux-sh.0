From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 21 Feb 2015 14:31:26 +0000
Subject: Re: [PATCH] sh-pfc: r8a7794: add SDHI pin groups
Message-Id: <5818484.Q8KaUzSayY@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <2355038.irqYpO1ia4@wasted.cogentembedded.com>
In-Reply-To: <2355038.irqYpO1ia4@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linus.walleij@linaro.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, shinobu.uehara.xc@renesas.com

Hi Sergio,

Thank you for the patch.

On Saturday 21 February 2015 02:04:53 Sergei Shtylyov wrote:
> From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> 
> Add SDHI0/1/2 pin groups to R8A7794 PFC driver.
> 
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> [Sergei: renamed SD data pins to match the driver, rebased, renamed, added
> changelog.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
> repo plus  the R8A7794 PFC support patch posted last week and the R8A7794
> MMCIF pin group patch posted this week.
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7794.c |  153 +++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
> 
> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
> =================================> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
> @@ -2640,6 +2640,117 @@ static const unsigned int scifb2_ctrl_pi
>  static const unsigned int scifb2_ctrl_mux[] = {
>  	SCIFB2_RTS_N_MARK, SCIFB2_CTS_N_MARK,
>  };
> +/* - SDHI0
> ------------------------------------------------------------------ */
> +static const unsigned int sdhi0_data1_pins[] = {
> +	/* D0 */
> +	RCAR_GP_PIN(6, 2),
> +};
> +static const unsigned int sdhi0_data1_mux[] = {
> +	SD0_DATA0_MARK,
> +};
> +static const unsigned int sdhi0_data4_pins[] = {
> +	/* D[0:3] */
> +	RCAR_GP_PIN(6, 2), RCAR_GP_PIN(6, 3),
> +	RCAR_GP_PIN(6, 4), RCAR_GP_PIN(6, 5),
> +};
> +static const unsigned int sdhi0_data4_mux[] = {
> +	SD0_DATA0_MARK, SD0_DATA1_MARK, SD0_DATA2_MARK, SD0_DATA3_MARK,
> +};
> +static const unsigned int sdhi0_ctrl_pins[] = {
> +	/* CLK, CMD */
> +	RCAR_GP_PIN(6, 0), RCAR_GP_PIN(6, 1),
> +};
> +static const unsigned int sdhi0_ctrl_mux[] = {
> +	SD0_CLK_MARK, SD0_CMD_MARK,
> +};
> +static const unsigned int sdhi0_cd_pins[] = {
> +	/* CD */
> +	RCAR_GP_PIN(6, 6),
> +};
> +static const unsigned int sdhi0_cd_mux[] = {
> +	SD0_CD_MARK,
> +};
> +static const unsigned int sdhi0_wp_pins[] = {
> +	/* WP */
> +	RCAR_GP_PIN(6, 7),
> +};
> +static const unsigned int sdhi0_wp_mux[] = {
> +	SD0_WP_MARK,
> +};
> +/* - SDHI1
> ------------------------------------------------------------------ */
> +static const unsigned int sdhi1_data1_pins[] = {
> +	/* D0 */
> +	RCAR_GP_PIN(6, 10),
> +};
> +static const unsigned int sdhi1_data1_mux[] = {
> +	SD1_DATA0_MARK,
> +};
> +static const unsigned int sdhi1_data4_pins[] = {
> +	/* D[0:3] */
> +	RCAR_GP_PIN(6, 10), RCAR_GP_PIN(6, 11),
> +	RCAR_GP_PIN(6, 12), RCAR_GP_PIN(6, 13),
> +};
> +static const unsigned int sdhi1_data4_mux[] = {
> +	SD1_DATA0_MARK, SD1_DATA1_MARK, SD1_DATA2_MARK, SD1_DATA3_MARK,
> +};
> +static const unsigned int sdhi1_ctrl_pins[] = {
> +	/* CLK, CMD */
> +	RCAR_GP_PIN(6, 8), RCAR_GP_PIN(6, 9),
> +};
> +static const unsigned int sdhi1_ctrl_mux[] = {
> +	SD1_CLK_MARK, SD1_CMD_MARK,
> +};
> +static const unsigned int sdhi1_cd_pins[] = {
> +	/* CD */
> +	RCAR_GP_PIN(6, 14),
> +};
> +static const unsigned int sdhi1_cd_mux[] = {
> +	SD1_CD_MARK,
> +};
> +static const unsigned int sdhi1_wp_pins[] = {
> +	/* WP */
> +	RCAR_GP_PIN(6, 15),
> +};
> +static const unsigned int sdhi1_wp_mux[] = {
> +	SD1_WP_MARK,
> +};
> +/* - SDHI2
> ------------------------------------------------------------------ */
> +static const unsigned int sdhi2_data1_pins[] = {
> +	/* D0 */
> +	RCAR_GP_PIN(6, 18),
> +};
> +static const unsigned int sdhi2_data1_mux[] = {
> +	SD2_DATA0_MARK,
> +};
> +static const unsigned int sdhi2_data4_pins[] = {
> +	/* D[0:3] */
> +	RCAR_GP_PIN(6, 18), RCAR_GP_PIN(6, 19),
> +	RCAR_GP_PIN(6, 20), RCAR_GP_PIN(6, 21),
> +};
> +static const unsigned int sdhi2_data4_mux[] = {
> +	SD2_DATA0_MARK, SD2_DATA1_MARK, SD2_DATA2_MARK, SD2_DATA3_MARK,
> +};
> +static const unsigned int sdhi2_ctrl_pins[] = {
> +	/* CLK, CMD */
> +	RCAR_GP_PIN(6, 16), RCAR_GP_PIN(6, 17),
> +};
> +static const unsigned int sdhi2_ctrl_mux[] = {
> +	SD2_CLK_MARK, SD2_CMD_MARK,
> +};
> +static const unsigned int sdhi2_cd_pins[] = {
> +	/* CD */
> +	RCAR_GP_PIN(6, 22),
> +};
> +static const unsigned int sdhi2_cd_mux[] = {
> +	SD2_CD_MARK,
> +};
> +static const unsigned int sdhi2_wp_pins[] = {
> +	/* WP */
> +	RCAR_GP_PIN(6, 23),
> +};
> +static const unsigned int sdhi2_wp_mux[] = {
> +	SD2_WP_MARK,
> +};
> 
>  static const struct sh_pfc_pin_group pinmux_groups[] = {
>  	SH_PFC_PIN_GROUP(eth_link),
> @@ -2800,6 +2911,21 @@ static const struct sh_pfc_pin_group pin
>  	SH_PFC_PIN_GROUP(scifb2_data),
>  	SH_PFC_PIN_GROUP(scifb2_clk),
>  	SH_PFC_PIN_GROUP(scifb2_ctrl),
> +	SH_PFC_PIN_GROUP(sdhi0_data1),
> +	SH_PFC_PIN_GROUP(sdhi0_data4),
> +	SH_PFC_PIN_GROUP(sdhi0_ctrl),
> +	SH_PFC_PIN_GROUP(sdhi0_cd),
> +	SH_PFC_PIN_GROUP(sdhi0_wp),
> +	SH_PFC_PIN_GROUP(sdhi1_data1),
> +	SH_PFC_PIN_GROUP(sdhi1_data4),
> +	SH_PFC_PIN_GROUP(sdhi1_ctrl),
> +	SH_PFC_PIN_GROUP(sdhi1_cd),
> +	SH_PFC_PIN_GROUP(sdhi1_wp),
> +	SH_PFC_PIN_GROUP(sdhi2_data1),
> +	SH_PFC_PIN_GROUP(sdhi2_data4),
> +	SH_PFC_PIN_GROUP(sdhi2_ctrl),
> +	SH_PFC_PIN_GROUP(sdhi2_cd),
> +	SH_PFC_PIN_GROUP(sdhi2_wp),
>  };
> 
>  static const char * const eth_groups[] = {
> @@ -3050,6 +3176,30 @@ static const char * const scifb2_groups[
>  	"scifb2_ctrl",
>  };
> 
> +static const char * const sdhi0_groups[] = {
> +	"sdhi0_data1",
> +	"sdhi0_data4",
> +	"sdhi0_ctrl",
> +	"sdhi0_cd",
> +	"sdhi0_wp",
> +};
> +
> +static const char * const sdhi1_groups[] = {
> +	"sdhi1_data1",
> +	"sdhi1_data4",
> +	"sdhi1_ctrl",
> +	"sdhi1_cd",
> +	"sdhi1_wp",
> +};
> +
> +static const char * const sdhi2_groups[] = {
> +	"sdhi2_data1",
> +	"sdhi2_data4",
> +	"sdhi2_ctrl",
> +	"sdhi2_cd",
> +	"sdhi2_wp",
> +};
> +
>  static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(eth),
>  	SH_PFC_FUNCTION(hscif0),
> @@ -3081,6 +3231,9 @@ static const struct sh_pfc_function pinm
>  	SH_PFC_FUNCTION(scifb0),
>  	SH_PFC_FUNCTION(scifb1),
>  	SH_PFC_FUNCTION(scifb2),
> +	SH_PFC_FUNCTION(sdhi0),
> +	SH_PFC_FUNCTION(sdhi1),
> +	SH_PFC_FUNCTION(sdhi2),
>  };
> 
>  static const struct pinmux_cfg_reg pinmux_config_regs[] = {

-- 
Regards,

Laurent Pinchart

