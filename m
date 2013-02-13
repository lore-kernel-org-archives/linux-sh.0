From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 Feb 2013 18:07:20 +0000
Subject: Re: [PATCH/RFC 2/3] pinctrl: sh-pfc: add pin groups for all SD/MMC interfaces on sh73a0
Message-Id: <2233270.PJVsbzX7e8@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1360684204-12888-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360684204-12888-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

Thanks for the patch.

On Tuesday 12 February 2013 16:50:03 Guennadi Liakhovetski wrote:
> Add pin group definitions for SDHI0, SDHI1, SDHI2 and MMCIF interfaces on
> sh73a0.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

As this patch doesn't strictly depend on 1/3 I've taken it in my tree. I will 
push it along with a sparse GPIO numbering fix (I'm currently reviewing 1/3).

> ---
>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c |  194 ++++++++++++++++++++++++++++++++
>  1 files changed, 194 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c index 937986c..b7f80cb 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> @@ -2215,6 +2215,146 @@ static const unsigned int scifb_ctrl_1_mux[] = {
>  	PORT245_SCIFB_RTS__MARK, PORT244_SCIFB_CTS__MARK,
>  };
> 
> +static const unsigned int sdhi0_data1_pins[] = {
> +	/* D0 */
> +	252,
> +};
> +static const unsigned int sdhi0_data1_mux[] = {
> +	SDHID0_0_MARK,
> +};
> +static const unsigned int sdhi0_data4_pins[] = {
> +	/* D[0:3] */
> +	252, 253, 254, 255,
> +};
> +static const unsigned int sdhi0_data4_mux[] = {
> +	SDHID0_0_MARK, SDHID0_1_MARK, SDHID0_2_MARK, SDHID0_3_MARK,
> +};
> +static const unsigned int sdhi0_ctrl_pins[] = {
> +	/* CMD, CLK */
> +	256, 250,
> +};
> +static const unsigned int sdhi0_ctrl_mux[] = {
> +	SDHICMD0_MARK, SDHICLK0_MARK,
> +};
> +static const unsigned int sdhi0_cd_pins[] = {
> +	/* CD */
> +	251,
> +};
> +static const unsigned int sdhi0_cd_mux[] = {
> +	SDHICD0_MARK,
> +};
> +static const unsigned int sdhi0_wp_pins[] = {
> +	/* WP */
> +	257,
> +};
> +static const unsigned int sdhi0_wp_mux[] = {
> +	SDHIWP0_MARK,
> +};
> +
> +static const unsigned int sdhi1_data1_pins[] = {
> +	/* D0 */
> +	259,
> +};
> +static const unsigned int sdhi1_data1_mux[] = {
> +	SDHID1_0_MARK,
> +};
> +static const unsigned int sdhi1_data4_pins[] = {
> +	/* D[0:3] */
> +	259, 260, 261, 262,
> +};
> +static const unsigned int sdhi1_data4_mux[] = {
> +	SDHID1_0_MARK, SDHID1_1_MARK, SDHID1_2_MARK, SDHID1_3_MARK,
> +};
> +static const unsigned int sdhi1_ctrl_pins[] = {
> +	/* CMD, CLK */
> +	263, 258,
> +};
> +static const unsigned int sdhi1_ctrl_mux[] = {
> +	SDHICMD1_MARK, SDHICLK1_MARK,
> +};
> +
> +static const unsigned int sdhi2_data1_pins[] = {
> +	/* D0 */
> +	265,
> +};
> +static const unsigned int sdhi2_data1_mux[] = {
> +	SDHID2_0_MARK,
> +};
> +static const unsigned int sdhi2_data4_pins[] = {
> +	/* D[0:3] */
> +	265, 266, 267, 268,
> +};
> +static const unsigned int sdhi2_data4_mux[] = {
> +	SDHID2_0_MARK, SDHID2_1_MARK, SDHID2_2_MARK, SDHID2_3_MARK,
> +};
> +static const unsigned int sdhi2_ctrl_pins[] = {
> +	/* CMD, CLK */
> +	269, 264,
> +};
> +static const unsigned int sdhi2_ctrl_mux[] = {
> +	SDHICMD2_MARK, SDHICLK2_MARK,
> +};
> +
> +static const unsigned int mmc0_data1_0_pins[] = {
> +	/* D[0] */
> +	271,
> +};
> +static const unsigned int mmc0_data1_0_mux[] = {
> +	MMCD0_0_MARK,
> +};
> +static const unsigned int mmc0_data4_0_pins[] = {
> +	/* D[0:3] */
> +	271, 272, 273, 274,
> +};
> +static const unsigned int mmc0_data4_0_mux[] = {
> +	MMCD0_0_MARK, MMCD0_1_MARK, MMCD0_2_MARK, MMCD0_3_MARK,
> +};
> +static const unsigned int mmc0_data8_0_pins[] = {
> +	/* D[0:7] */
> +	271, 272, 273, 274, 275, 276, 277, 278,
> +};
> +static const unsigned int mmc0_data8_0_mux[] = {
> +	MMCD0_0_MARK, MMCD0_1_MARK, MMCD0_2_MARK, MMCD0_3_MARK,
> +	MMCD0_4_MARK, MMCD0_5_MARK, MMCD0_6_MARK, MMCD0_7_MARK,
> +};
> +static const unsigned int mmc0_ctrl_0_pins[] = {
> +	/* CMD, CLK */
> +	279, 270,
> +};
> +static const unsigned int mmc0_ctrl_0_mux[] = {
> +	MMCCMD0_MARK, MMCCLK0_MARK,
> +};
> +
> +static const unsigned int mmc0_data1_1_pins[] = {
> +	/* D[0] */
> +	305,
> +};
> +static const unsigned int mmc0_data1_1_mux[] = {
> +	MMCD1_0_MARK,
> +};
> +static const unsigned int mmc0_data4_1_pins[] = {
> +	/* D[0:3] */
> +	305, 304, 303, 302,
> +};
> +static const unsigned int mmc0_data4_1_mux[] = {
> +	MMCD1_0_MARK, MMCD1_1_MARK, MMCD1_2_MARK, MMCD1_3_MARK,
> +};
> +static const unsigned int mmc0_data8_1_pins[] = {
> +	/* D[0:7] */
> +	305, 304, 303, 302, 301, 300, 299, 298,
> +};
> +static const unsigned int mmc0_data8_1_mux[] = {
> +	MMCD1_0_MARK, MMCD1_1_MARK, MMCD1_2_MARK, MMCD1_3_MARK,
> +	MMCD1_4_MARK, MMCD1_5_MARK, MMCD1_6_MARK, MMCD1_7_MARK,
> +};
> +static const unsigned int mmc0_ctrl_1_pins[] = {
> +	/* CMD, CLK */
> +	297, 289,
> +};
> +static const unsigned int mmc0_ctrl_1_mux[] = {
> +	MMCCMD1_MARK, MMCCLK1_MARK,
> +};
> +
>  static const struct sh_pfc_pin_group pinmux_groups[] = {
>  	SH_PFC_PIN_GROUP(fsia_mclk_in),
>  	SH_PFC_PIN_GROUP(fsia_mclk_out),
> @@ -2301,6 +2441,25 @@ static const struct sh_pfc_pin_group pinmux_groups[]
> = { SH_PFC_PIN_GROUP(scifb_data_1),
>  	SH_PFC_PIN_GROUP(scifb_clk_1),
>  	SH_PFC_PIN_GROUP(scifb_ctrl_1),
> +	SH_PFC_PIN_GROUP(sdhi0_data1),
> +	SH_PFC_PIN_GROUP(sdhi0_data4),
> +	SH_PFC_PIN_GROUP(sdhi0_ctrl),
> +	SH_PFC_PIN_GROUP(sdhi0_cd),
> +	SH_PFC_PIN_GROUP(sdhi0_wp),
> +	SH_PFC_PIN_GROUP(sdhi1_data1),
> +	SH_PFC_PIN_GROUP(sdhi1_data4),
> +	SH_PFC_PIN_GROUP(sdhi1_ctrl),
> +	SH_PFC_PIN_GROUP(sdhi2_data1),
> +	SH_PFC_PIN_GROUP(sdhi2_data4),
> +	SH_PFC_PIN_GROUP(sdhi2_ctrl),
> +	SH_PFC_PIN_GROUP(mmc0_data1_0),
> +	SH_PFC_PIN_GROUP(mmc0_data4_0),
> +	SH_PFC_PIN_GROUP(mmc0_data8_0),
> +	SH_PFC_PIN_GROUP(mmc0_ctrl_0),
> +	SH_PFC_PIN_GROUP(mmc0_data1_1),
> +	SH_PFC_PIN_GROUP(mmc0_data4_1),
> +	SH_PFC_PIN_GROUP(mmc0_data8_1),
> +	SH_PFC_PIN_GROUP(mmc0_ctrl_1),
>  };
> 
>  static const char * const fsia_groups[] = {
> @@ -2438,6 +2597,37 @@ static const char * const scifb_groups[] = {
>  	"scifb_ctrl_1",
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
> +};
> +
> +static const char * const sdhi2_groups[] = {
> +	"sdhi2_data1",
> +	"sdhi2_data4",
> +	"sdhi2_ctrl",
> +};
> +
> +static const char * const mmc0_groups[] = {
> +	"mmc0_data1_0",
> +	"mmc0_data4_0",
> +	"mmc0_data8_0",
> +	"mmc0_ctrl_0",
> +	"mmc0_data1_1",
> +	"mmc0_data4_1",
> +	"mmc0_data8_1",
> +	"mmc0_ctrl_1",
> +};
> +
>  static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(fsia),
>  	SH_PFC_FUNCTION(fsib),
> @@ -2456,6 +2646,10 @@ static const struct sh_pfc_function
> pinmux_functions[] = { SH_PFC_FUNCTION(scifa6),
>  	SH_PFC_FUNCTION(scifa7),
>  	SH_PFC_FUNCTION(scifb),
> +	SH_PFC_FUNCTION(sdhi0),
> +	SH_PFC_FUNCTION(sdhi1),
> +	SH_PFC_FUNCTION(sdhi2),
> +	SH_PFC_FUNCTION(mmc0),
>  };
> 
>  #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
-- 
Regards,

Laurent Pinchart

