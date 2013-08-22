From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Aug 2013 01:28:17 +0000
Subject: Re: [PATCH 1/5] sh-pfc: r8a7778: add SRU/SSI pin support
Message-Id: <2734831.WKpsDbcXlG@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <8738qmjgav.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738qmjgav.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Tuesday 06 August 2013 21:06:19 Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  163 +++++++++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c index 428d2a6..a1bc846 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> @@ -1304,6 +1304,22 @@ SH_PFC_MUX1(ether_link,		ETH_LINK);
>  SH_PFC_PINS(ether_magic,	RCAR_GP_PIN(4, 20));
>  SH_PFC_MUX1(ether_magic,	ETH_MAGIC);
> 
> +/* - AUDIO macro ------------------------------------------------------- */
> +#define AUDIO_PFC_PIN(name, pin)	SH_PFC_PINS(name, pin)
> +#define AUDIO_PFC_DAT(name, pin)	SH_PFC_MUX1(name, pin)
> +
> +/* - AUDIO clock --------------------------------------------------------*/
> +AUDIO_PFC_PIN(audio_clk_a,	RCAR_GP_PIN(2, 22));
> +AUDIO_PFC_DAT(audio_clk_a,	AUDIO_CLKA);
> +AUDIO_PFC_PIN(audio_clk_b,	RCAR_GP_PIN(2, 23));
> +AUDIO_PFC_DAT(audio_clk_b,	AUDIO_CLKB);
> +AUDIO_PFC_PIN(audio_clk_c,	RCAR_GP_PIN(2, 7));
> +AUDIO_PFC_DAT(audio_clk_c,	AUDIO_CLKC);
> +AUDIO_PFC_PIN(audio_clkout_a,	RCAR_GP_PIN(2, 16));
> +AUDIO_PFC_DAT(audio_clkout_a,	AUDIO_CLKOUT_A);
> +AUDIO_PFC_PIN(audio_clkout_b,	RCAR_GP_PIN(1, 16));
> +AUDIO_PFC_DAT(audio_clkout_b,	AUDIO_CLKOUT_B);
> +

Could you please move this block up to keep the blocks alphabetically sorted ?

>  /* - SCIF macro -------------------------------------------------------- */
>  #define SCIF_PFC_PIN(name, args...)	SH_PFC_PINS(name, args)
>  #define SCIF_PFC_DAT(name, tx, rx)	SH_PFC_MUX2(name, tx, rx)
> @@ -1577,6 +1593,105 @@ SDHI_PFC_WPPN(sdhi2_wp_a,	SD2_WP_A);
>  SDHI_PFC_PINS(sdhi2_wp_b,	RCAR_GP_PIN(3, 28));
>  SDHI_PFC_WPPN(sdhi2_wp_b,	SD2_WP_B);
> 
> +/* - SSI macro --------------------------------------------------------- */
> +#define SSI_PFC_PINS(name, args...)		SH_PFC_PINS(name, args)
> +#define SSI_PFC_SETS(name, sck, ws, d)		SH_PFC_MUX3(name, sck, ws, d)
> +#define SSI_PFC_MULT(name, sck, ws, d1, d2)	SH_PFC_MUX4(name, sck, ws,\
> +							    d1, d2)
> +/* - SSI0
> --------------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi0,	RCAR_GP_PIN(3, 6),	RCAR_GP_PIN(3, 7),
> +			RCAR_GP_PIN(3, 10));
> +SSI_PFC_SETS(ssi0,	SSI_SCK012,		SSI_WS012,
> +			SSI_SDATA0);
> +
> +/* - SSI01 --------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi01,	RCAR_GP_PIN(3, 6),	RCAR_GP_PIN(3, 7),
> +			RCAR_GP_PIN(3, 10),	RCAR_GP_PIN(3, 9));
> +SSI_PFC_MULT(ssi01,	SSI_SCK012,		SSI_WS012,
> +			SSI_SDATA0,		SSI_SDATA1);
> +
> +/* - SSI012 -------------------------------------------------------------*/
> +static const unsigned ssi012_pins[] = {
> +	RCAR_GP_PIN(3, 6),	RCAR_GP_PIN(3, 7),
> +	RCAR_GP_PIN(3, 10),	RCAR_GP_PIN(3, 9),
> +	RCAR_GP_PIN(3, 8),
> +};
> +
> +static const unsigned int ssi012_mux[] = {
> +	SSI_SCK012_MARK,	SSI_WS012_MARK,
> +	SSI_SDATA0_MARK,	SSI_SDATA1_MARK,
> +	SSI_SDATA2_MARK,
> +};
> +
> +/* - SSI02
> -------------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi02,	RCAR_GP_PIN(3, 6),	RCAR_GP_PIN(3, 7),
> +			RCAR_GP_PIN(3, 10),	RCAR_GP_PIN(3, 8));
> +SSI_PFC_MULT(ssi02,	SSI_SCK012,		SSI_WS012,
> +			SSI_SDATA0,		SSI_SDATA2);

This looks a bit complex to me. Could you please explain how the various pins 
are used ? I see that the SSI_DATA1 and SSI_DATA2 signals are used here and 
below. What are the possible combinations ? For instance, if I select ssi02, 
will SDATA0 and SDATA2 be driven by the SSI0 instance, or by the SSI0 and SSI2 
instances respectively ?

> +
> +/* - SSI1
> --------------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi1_a,	RCAR_GP_PIN(2, 20),	RCAR_GP_PIN(2, 21),
> +			RCAR_GP_PIN(3, 9));
> +SSI_PFC_SETS(ssi1_a,	SSI_SCK1_A,		SSI_WS1_A,
> +			SSI_SDATA1);
> +SSI_PFC_PINS(ssi1_b,	PIN_NUMBER(3, 20),	RCAR_GP_PIN(1, 3),
> +			RCAR_GP_PIN(3, 9));
> +SSI_PFC_SETS(ssi1_b,	SSI_SCK1_B,		SSI_WS1_B,
> +			SSI_SDATA1);
> +
> +/* - SSI2
> --------------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi2_a,	RCAR_GP_PIN(2, 26),	RCAR_GP_PIN(3, 4),
> +			RCAR_GP_PIN(3, 8));
> +SSI_PFC_SETS(ssi2_a,	SSI_SCK2_A,		SSI_WS2_A,
> +			SSI_SDATA2);
> +
> +SSI_PFC_PINS(ssi2_b,	RCAR_GP_PIN(2, 6),	RCAR_GP_PIN(2, 17),
> +			RCAR_GP_PIN(3, 8));
> +SSI_PFC_SETS(ssi2_b,	SSI_SCK2_B,		SSI_WS2_B,
> +			SSI_SDATA2);
> +
> +/* - SSI3
> --------------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi3,	RCAR_GP_PIN(3, 2),	RCAR_GP_PIN(3, 3),
> +			RCAR_GP_PIN(3, 5));
> +SSI_PFC_SETS(ssi3,	SSI_SCK34,		SSI_WS34,
> +			SSI_SDATA3);
> +
> +/* - SSI34
> -------------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi34,	RCAR_GP_PIN(3, 2),	RCAR_GP_PIN(3, 3),
> +			RCAR_GP_PIN(3, 5),	RCAR_GP_PIN(3, 4));
> +SSI_PFC_MULT(ssi34,	SSI_SCK34,		SSI_WS34,
> +			SSI_SDATA3,		SSI_SDATA4);

Can SSI_SDATA4 be used without SSI_SDATA3 ? Same question for SSI_DATA7 and 
SSI_DATA8 below.

> +/* - SSI4
> --------------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi4,	RCAR_GP_PIN(1, 22),	RCAR_GP_PIN(1, 23),
> +			RCAR_GP_PIN(3, 4));
> +SSI_PFC_SETS(ssi4,	SSI_SCK4,		SSI_WS4,
> +			SSI_SDATA4);
> +
> +/* - SSI5
> --------------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi5,	RCAR_GP_PIN(2, 31),	RCAR_GP_PIN(3, 0),
> +			RCAR_GP_PIN(3, 1));
> +SSI_PFC_SETS(ssi5,	SSI_SCK5,		SSI_WS5,
> +			SSI_SDATA5);
> +
> +/* - SSI6
> --------------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi6,	RCAR_GP_PIN(2, 28),	RCAR_GP_PIN(2, 29),
> +			RCAR_GP_PIN(2, 30));
> +SSI_PFC_SETS(ssi6,	SSI_SCK6,		SSI_WS6,
> +			SSI_SDATA6);
> +
> +/* - SSI7
> --------------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi7,	RCAR_GP_PIN(2, 24),	RCAR_GP_PIN(2, 25),
> +			RCAR_GP_PIN(2, 27));
> +SSI_PFC_SETS(ssi7,	SSI_SCK78,		SSI_WS78,
> +			SSI_SDATA7);
> +
> +/* - SSI78
> --------------------------------------------------------------------*/
> +SSI_PFC_PINS(ssi78,	RCAR_GP_PIN(2, 24),	RCAR_GP_PIN(2, 25),
> +			RCAR_GP_PIN(2, 27),	RCAR_GP_PIN(2, 26));
> +SSI_PFC_MULT(ssi78,	SSI_SCK78,		SSI_WS78,
> +			SSI_SDATA7,		SSI_SDATA8);
> +
>  /* - USB0
> ------------------------------------------------------------------- */
> SH_PFC_PINS(usb0,		RCAR_GP_PIN(0, 1));
>  SH_PFC_MUX1(usb0,		PENC0);
> @@ -1624,6 +1739,11 @@ VIN_PFC_PINS(vin1_sync,		RCAR_GP_PIN(3,
> 21),	RCAR_GP_PIN(3, 22)); VIN_PFC_SYNC(vin1_sync,		VI1_HSYNC,		
VI1_VSYNC);
> 
>  static const struct sh_pfc_pin_group pinmux_groups[] = {
> +	SH_PFC_PIN_GROUP(audio_clk_a),
> +	SH_PFC_PIN_GROUP(audio_clk_b),
> +	SH_PFC_PIN_GROUP(audio_clk_c),
> +	SH_PFC_PIN_GROUP(audio_clkout_a),
> +	SH_PFC_PIN_GROUP(audio_clkout_b),
>  	SH_PFC_PIN_GROUP(ether_rmii),
>  	SH_PFC_PIN_GROUP(ether_link),
>  	SH_PFC_PIN_GROUP(ether_magic),
> @@ -1713,6 +1833,21 @@ static const struct sh_pfc_pin_group pinmux_groups[]
> = { SH_PFC_PIN_GROUP(sdhi2_data4_b),
>  	SH_PFC_PIN_GROUP(sdhi2_wp_a),
>  	SH_PFC_PIN_GROUP(sdhi2_wp_b),
> +	SH_PFC_PIN_GROUP(ssi0),
> +	SH_PFC_PIN_GROUP(ssi01),
> +	SH_PFC_PIN_GROUP(ssi012),
> +	SH_PFC_PIN_GROUP(ssi02),
> +	SH_PFC_PIN_GROUP(ssi1_a),
> +	SH_PFC_PIN_GROUP(ssi1_b),
> +	SH_PFC_PIN_GROUP(ssi2_a),
> +	SH_PFC_PIN_GROUP(ssi2_b),
> +	SH_PFC_PIN_GROUP(ssi3),
> +	SH_PFC_PIN_GROUP(ssi34),
> +	SH_PFC_PIN_GROUP(ssi4),
> +	SH_PFC_PIN_GROUP(ssi5),
> +	SH_PFC_PIN_GROUP(ssi6),
> +	SH_PFC_PIN_GROUP(ssi7),
> +	SH_PFC_PIN_GROUP(ssi78),
>  	SH_PFC_PIN_GROUP(usb0),
>  	SH_PFC_PIN_GROUP(usb0_ovc),
>  	SH_PFC_PIN_GROUP(usb1),
> @@ -1725,6 +1860,14 @@ static const struct sh_pfc_pin_group pinmux_groups[]
> = { SH_PFC_PIN_GROUP(vin1_sync),
>  };
> 
> +static const char * const audio_clk_groups[] = {
> +	"audio_clk_a",
> +	"audio_clk_b",
> +	"audio_clk_c",
> +	"audio_clkout_a",
> +	"audio_clkout_b",
> +};
> +
>  static const char * const ether_groups[] = {
>  	"ether_rmii",
>  	"ether_link",
> @@ -1875,6 +2018,24 @@ static const char * const sdhi2_groups[] = {
>  	"sdhi2_wp_b",
>  };
> 
> +static const char * const ssi_groups[] = {
> +	"ssi0",
> +	"ssi01",
> +	"ssi012",
> +	"ssi02",
> +	"ssi1_a",
> +	"ssi1_b",
> +	"ssi2_a",
> +	"ssi2_b",
> +	"ssi3",
> +	"ssi34",
> +	"ssi4",
> +	"ssi5",
> +	"ssi6",
> +	"ssi7",
> +	"ssi78",
> +};

I'm not familiar with SSI so I could be wrong, but shouldn't we have one group 
per SSI instance ?

> +
>  static const char * const usb0_groups[] = {
>  	"usb0",
>  	"usb0_ovc",
> @@ -1898,6 +2059,7 @@ static const char * const vin1_groups[] = {
>  };
> 
>  static const struct sh_pfc_function pinmux_functions[] = {
> +	SH_PFC_FUNCTION(audio_clk),
>  	SH_PFC_FUNCTION(ether),
>  	SH_PFC_FUNCTION(hscif0),
>  	SH_PFC_FUNCTION(hscif1),
> @@ -1918,6 +2080,7 @@ static const struct sh_pfc_function pinmux_functions[]
> = { SH_PFC_FUNCTION(sdhi0),
>  	SH_PFC_FUNCTION(sdhi1),
>  	SH_PFC_FUNCTION(sdhi2),
> +	SH_PFC_FUNCTION(ssi),
>  	SH_PFC_FUNCTION(usb0),
>  	SH_PFC_FUNCTION(usb1),
>  	SH_PFC_FUNCTION(vin0),
-- 
Regards,

Laurent Pinchart

