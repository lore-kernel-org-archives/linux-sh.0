From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 10 Apr 2013 10:57:10 +0000
Subject: Re: [PATCH 1/3 v2] sh-pfc: Add r8a7778 pinmux support
Message-Id: <11104721.EmusI4BMXq@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvyyk9yp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvyyk9yp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch. The code looks good, I just have a couple of minor 
comments.

On Wednesday 10 April 2013 02:32:02 Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> 
> This is based on
> 
> Subject: [PATCH v2 1/3] gpio-rcar: Add RCAR_GP_PIN macro
> Date:	Mon,  8 Apr 2013 12:05:30 +0200
> 
> v1 -> v2
>  - used SCIF_PFC_xxx() macro
>  - PORT_GP_26() -> PORT_GP_27()
>  - removed un-needed GPL comment
>  - add separator for each SCIF
>  - scif name order
> 
>  drivers/pinctrl/sh-pfc/Kconfig       |    5 +
>  drivers/pinctrl/sh-pfc/Makefile      |    1 +
>  drivers/pinctrl/sh-pfc/core.c        |    3 +
>  drivers/pinctrl/sh-pfc/core.h        |    1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 2369 +++++++++++++++++++++++++++++++
>  5 files changed, 2379 insertions(+)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> 

[snip]

> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c new file mode 100644
> index 0000000..8028d16
> --- /dev/null
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c

[snip]

> +/* Pin numbers for pins without a corresponding GPIO port number are
> computed + * from the row and column numbers with a 1000 offset to avoid
> collisions with + * GPIO port numbers.
> + */
> +#define PIN_NUMBER(row, col)		(1000+((row)-1)*25+(col)-1)
> +
> +/* - SCIF macro
> ------------------------------------------------------------- */ +#define
> SCIF_PFC_PIN(name, args...)					\
> +	static const unsigned int name ##_pins[] = { args }
> +#define SCIF_PFC_DAT(name, arg1, arg2)					\
> +	static const unsigned int name ##_mux[]  = { arg1##_MARK, arg2##_MARK, }

I would probably have named the arguments tx and rx instead of arg1 and arg2, 
but that's up to you.

> +#define SCIF_PFC_CTR(name, arg1, arg2)					\
> +	static const unsigned int name ##_mux[]  = { arg1##_MARK, arg2##_MARK, }

And cts and rts here.

> +#define SCIF_PFC_CLK(name, arg1)					\
> +	static const unsigned int name ##_mux[]  = { arg1##_MARK, }

And sck here (it's still up to you :-)).

> +
> +/* - SCIF0
> ------------------------------------------------------------------ */
> +SCIF_PFC_PIN(scif0_data_a,	RCAR_GP_PIN(1, 17),	RCAR_GP_PIN(1, 18));
> +SCIF_PFC_DAT(scif0_data_a,	TX0_A,			RX0_A);
> +SCIF_PFC_PIN(scif0_data_b,	RCAR_GP_PIN(2, 3),	RCAR_GP_PIN(2, 2));
> +SCIF_PFC_DAT(scif0_data_b,	TX0_B,			RX0_B);
> +SCIF_PFC_PIN(scif0_data_c,	RCAR_GP_PIN(4, 0),	RCAR_GP_PIN(3, 31));
> +SCIF_PFC_DAT(scif0_data_c,	TX0_C,			RX0_C);
> +SCIF_PFC_PIN(scif0_data_d,	RCAR_GP_PIN(3, 6),	RCAR_GP_PIN(3, 1));
> +SCIF_PFC_DAT(scif0_data_d,	TX0_D,			RX0_D);
> +SCIF_PFC_PIN(scif0_ctrl,	RCAR_GP_PIN(1, 20),	RCAR_GP_PIN(1, 21));
> +SCIF_PFC_CTR(scif0_ctrl,	CTS0,			RTS0);
> +SCIF_PFC_PIN(scif0_clk,		RCAR_GP_PIN(1, 19));
> +SCIF_PFC_CLK(scif0_clk,		SCK0);
> +
> +/* - SCIF1
> ------------------------------------------------------------------ */
> +SCIF_PFC_PIN(scif1_data_a,	RCAR_GP_PIN(4, 0),	RCAR_GP_PIN(4, 1));
> +SCIF_PFC_DAT(scif1_data_a,	TX1_A,			RX1_A);
> +SCIF_PFC_PIN(scif1_data_b,	RCAR_GP_PIN(2, 24),	RCAR_GP_PIN(2, 25));
> +SCIF_PFC_DAT(scif1_data_b,	TX1_B,			RX1_B);
> +SCIF_PFC_PIN(scif1_data_c,	RCAR_GP_PIN(3, 22),	RCAR_GP_PIN(3, 21));
> +SCIF_PFC_DAT(scif1_data_c,	TX1_C,			RX1_C);
> +SCIF_PFC_PIN(scif1_data_d,	RCAR_GP_PIN(1, 30),	RCAR_GP_PIN(1, 31));
> +SCIF_PFC_DAT(scif1_data_d,	TX1_D,			RX1_D);
> +SCIF_PFC_PIN(scif1_ctrl_a,	RCAR_GP_PIN(4, 3),	RCAR_GP_PIN(4, 4));
> +SCIF_PFC_CTR(scif1_ctrl_a,	CTS1_A,			RTS1_A);
> +SCIF_PFC_PIN(scif1_ctrl_c,	RCAR_GP_PIN(3, 23),	RCAR_GP_PIN(3, 19));
> +SCIF_PFC_CTR(scif1_ctrl_c,	CTS1_C,			RTS1_C);
> +SCIF_PFC_PIN(scif1_clk_a,	RCAR_GP_PIN(4, 2));
> +SCIF_PFC_CLK(scif1_clk_a,	SCK1_A);
> +SCIF_PFC_PIN(scif1_clk_c,	RCAR_GP_PIN(3, 20));
> +SCIF_PFC_CLK(scif1_clk_c,	SCK1_C);
> +
> +/* - SCIF2
> ------------------------------------------------------------------ */
> +SCIF_PFC_PIN(scif2_data_a,	RCAR_GP_PIN(2, 26),	RCAR_GP_PIN(2, 27));
> +SCIF_PFC_DAT(scif2_data_a,	TX2_A,			RX2_A);
> +SCIF_PFC_PIN(scif2_data_b,	RCAR_GP_PIN(0, 29),	RCAR_GP_PIN(0, 28));
> +SCIF_PFC_DAT(scif2_data_b,	TX2_B,			RX2_B);
> +SCIF_PFC_PIN(scif2_data_c,	RCAR_GP_PIN(4, 13),	RCAR_GP_PIN(4, 14));
> +SCIF_PFC_DAT(scif2_data_c,	TX2_C,			RX2_C);
> +SCIF_PFC_PIN(scif2_data_d,	RCAR_GP_PIN(4, 15),	RCAR_GP_PIN(4, 16));
> +SCIF_PFC_DAT(scif2_data_d,	TX2_D,			RX2_D);
> +SCIF_PFC_PIN(scif2_data_e,	RCAR_GP_PIN(0, 3),	RCAR_GP_PIN(0, 4));
> +SCIF_PFC_DAT(scif2_data_e,	TX2_E,			RX2_E);
> +SCIF_PFC_PIN(scif2_clk_a,	RCAR_GP_PIN(3, 9));
> +SCIF_PFC_CLK(scif2_clk_a,	SCK2_A);
> +SCIF_PFC_PIN(scif2_clk_b,	PIN_NUMBER(3, 20));
> +SCIF_PFC_CLK(scif2_clk_b,	SCK2_B);
> +SCIF_PFC_PIN(scif2_clk_c,	RCAR_GP_PIN(4, 12));
> +SCIF_PFC_CLK(scif2_clk_c,	SCK2_C);
> +
> +/* - SCIF3
> ------------------------------------------------------------------ */
> +SCIF_PFC_PIN(scif3_data_a,	RCAR_GP_PIN(1, 10),	RCAR_GP_PIN(1, 9));
> +SCIF_PFC_DAT(scif3_data_a,	TX3_A,			RX3_A);
> +SCIF_PFC_PIN(scif3_data_b,	RCAR_GP_PIN(3, 28),	RCAR_GP_PIN(3, 27));
> +SCIF_PFC_DAT(scif3_data_b,	TX3_B,			RX3_B);
> +SCIF_PFC_PIN(scif3_data_c,	RCAR_GP_PIN(1, 3),	RCAR_GP_PIN(0, 31));
> +SCIF_PFC_DAT(scif3_data_c,	TX3_C,			RX3_C);
> +SCIF_PFC_PIN(scif3_data_d,	RCAR_GP_PIN(3, 30),	RCAR_GP_PIN(3, 29));
> +SCIF_PFC_DAT(scif3_data_d,	TX3_D,			RX3_D);
> +
> +/* - SCIF4
> ------------------------------------------------------------------ */
> +SCIF_PFC_PIN(scif4_data_a,	RCAR_GP_PIN(2, 5),	RCAR_GP_PIN(2, 4));
> +SCIF_PFC_DAT(scif4_data_a,	TX4_A,			RX4_A);
> +SCIF_PFC_PIN(scif4_data_b,	RCAR_GP_PIN(3, 26),	RCAR_GP_PIN(3, 25));
> +SCIF_PFC_DAT(scif4_data_b,	TX4_B,			RX4_B);
> +SCIF_PFC_PIN(scif4_data_c,	RCAR_GP_PIN(3, 0),	RCAR_GP_PIN(2, 31));
> +SCIF_PFC_DAT(scif4_data_c,	TX4_C,			RX4_C);
> +
> +/* - SCIF5
> ------------------------------------------------------------------ */
> +SCIF_PFC_PIN(scif5_data_a,	RCAR_GP_PIN(3, 17),	RCAR_GP_PIN(3, 18));
> +SCIF_PFC_DAT(scif5_data_a,	TX5_A,			RX5_A);
> +SCIF_PFC_PIN(scif5_data_b,	RCAR_GP_PIN(1, 15),	RCAR_GP_PIN(1, 14));
> +SCIF_PFC_DAT(scif5_data_b,	TX5_B,			RX5_B);
> +
> +/* - HSCIF0
> ----------------------------------------------------------------- */
> +SCIF_PFC_PIN(hscif0_data_a,	RCAR_GP_PIN(1, 17),	RCAR_GP_PIN(1, 18));
> +SCIF_PFC_DAT(hscif0_data_a,	HTX0_A,			HRX0_A);
> +SCIF_PFC_PIN(hscif0_data_b,	RCAR_GP_PIN(0, 29),	RCAR_GP_PIN(0, 30));
> +SCIF_PFC_DAT(hscif0_data_b,	HTX0_B,			HRX0_B);
> +SCIF_PFC_PIN(hscif0_ctrl_a,	RCAR_GP_PIN(1, 21),	RCAR_GP_PIN(1, 20));
> +SCIF_PFC_CTR(hscif0_ctrl_a,	HRTS0_A,		HCTS0_A);
> +SCIF_PFC_PIN(hscif0_ctrl_b,	RCAR_GP_PIN(0, 28),	RCAR_GP_PIN(0, 31));
> +SCIF_PFC_CTR(hscif0_ctrl_b,	HRTS0_B,		HCTS0_B);
> +SCIF_PFC_PIN(hscif0_clk,	RCAR_GP_PIN(1, 19));
> +SCIF_PFC_CLK(hscif0_clk,	HSCK0);
> +
> +/* - HSCIF1
> ----------------------------------------------------------------- */
> +SCIF_PFC_PIN(hscif1_data_a,	RCAR_GP_PIN(3, 19),	RCAR_GP_PIN(3, 20));
> +SCIF_PFC_DAT(hscif1_data_a,	HTX1_A,			HRX1_A);
> +SCIF_PFC_PIN(hscif1_data_b,	RCAR_GP_PIN(4, 5),	RCAR_GP_PIN(4, 6));
> +SCIF_PFC_DAT(hscif1_data_b,	HTX1_B,			HRX1_B);
> +SCIF_PFC_PIN(hscif1_ctrl_a,	RCAR_GP_PIN(3, 21),	RCAR_GP_PIN(3, 22));
> +SCIF_PFC_CTR(hscif1_ctrl_a,	HRTS1_A,		HCTS1_A);
> +SCIF_PFC_PIN(hscif1_ctrl_b,	RCAR_GP_PIN(4, 7),	RCAR_GP_PIN(4, 8));
> +SCIF_PFC_CTR(hscif1_ctrl_b,	HRTS1_B,		HCTS1_B);
> +SCIF_PFC_PIN(hscif1_clk_a,	RCAR_GP_PIN(3, 23));
> +SCIF_PFC_CLK(hscif1_clk_a,	HSCK1_A);
> +SCIF_PFC_PIN(hscif1_clk_b,	RCAR_GP_PIN(4, 2));
> +SCIF_PFC_CLK(hscif1_clk_b,	HSCK1_B);

Could you please move HSCIF0 and HSCIF1 above SCIF* to keep the functions 
alphabetically sorted (here and below in pinmux_groups, pinmux_functions and 
in the *_groups arrays) ? Otherwise the code will become pretty difficult to 
navigate when we'll add more functions.

> +/* - SCIF CLOCK
> ------------------------------------------------------------- */
> +SCIF_PFC_PIN(scif_clk,		RCAR_GP_PIN(1, 16));
> +SCIF_PFC_CLK(scif_clk,		SCIF_CLK);
> +
> +static const struct sh_pfc_pin_group pinmux_groups[] = {
> +	SH_PFC_PIN_GROUP(scif0_data_a),
> +	SH_PFC_PIN_GROUP(scif0_data_b),
> +	SH_PFC_PIN_GROUP(scif0_data_c),
> +	SH_PFC_PIN_GROUP(scif0_data_d),
> +	SH_PFC_PIN_GROUP(scif0_ctrl),
> +	SH_PFC_PIN_GROUP(scif0_clk),
> +	SH_PFC_PIN_GROUP(scif1_data_a),
> +	SH_PFC_PIN_GROUP(scif1_data_b),
> +	SH_PFC_PIN_GROUP(scif1_data_c),
> +	SH_PFC_PIN_GROUP(scif1_data_d),
> +	SH_PFC_PIN_GROUP(scif1_ctrl_a),
> +	SH_PFC_PIN_GROUP(scif1_ctrl_c),
> +	SH_PFC_PIN_GROUP(scif1_clk_a),
> +	SH_PFC_PIN_GROUP(scif1_clk_c),
> +	SH_PFC_PIN_GROUP(scif2_data_a),
> +	SH_PFC_PIN_GROUP(scif2_data_b),
> +	SH_PFC_PIN_GROUP(scif2_data_c),
> +	SH_PFC_PIN_GROUP(scif2_data_d),
> +	SH_PFC_PIN_GROUP(scif2_data_e),
> +	SH_PFC_PIN_GROUP(scif2_clk_a),
> +	SH_PFC_PIN_GROUP(scif2_clk_b),
> +	SH_PFC_PIN_GROUP(scif2_clk_c),
> +	SH_PFC_PIN_GROUP(scif3_data_a),
> +	SH_PFC_PIN_GROUP(scif3_data_b),
> +	SH_PFC_PIN_GROUP(scif3_data_c),
> +	SH_PFC_PIN_GROUP(scif3_data_d),
> +	SH_PFC_PIN_GROUP(scif4_data_a),
> +	SH_PFC_PIN_GROUP(scif4_data_b),
> +	SH_PFC_PIN_GROUP(scif4_data_c),
> +	SH_PFC_PIN_GROUP(scif5_data_a),
> +	SH_PFC_PIN_GROUP(scif5_data_b),
> +	SH_PFC_PIN_GROUP(hscif0_data_a),
> +	SH_PFC_PIN_GROUP(hscif0_data_b),
> +	SH_PFC_PIN_GROUP(hscif0_ctrl_a),
> +	SH_PFC_PIN_GROUP(hscif0_ctrl_b),
> +	SH_PFC_PIN_GROUP(hscif0_clk),
> +	SH_PFC_PIN_GROUP(hscif1_data_a),
> +	SH_PFC_PIN_GROUP(hscif1_data_b),
> +	SH_PFC_PIN_GROUP(hscif1_ctrl_a),
> +	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
> +	SH_PFC_PIN_GROUP(hscif1_clk_a),
> +	SH_PFC_PIN_GROUP(hscif1_clk_b),
> +	SH_PFC_PIN_GROUP(scif_clk),
> +};
> +
> +static const char * const scif0_groups[] = {
> +	"scif0_data_a",
> +	"scif0_data_b",
> +	"scif0_data_c",
> +	"scif0_data_d",
> +	"scif0_ctrl",
> +	"scif0_clk",
> +};
> +
> +static const char * const scif1_groups[] = {
> +	"scif1_data_a",
> +	"scif1_data_b",
> +	"scif1_data_c",
> +	"scif1_data_d",
> +	"scif1_ctrl_a",
> +	"scif1_ctrl_c",
> +	"scif1_clk_a",
> +	"scif1_clk_c",
> +};
> +
> +static const char * const scif2_groups[] = {
> +	"scif2_data_a",
> +	"scif2_data_b",
> +	"scif2_data_c",
> +	"scif2_data_d",
> +	"scif2_data_e",
> +	"scif2_clk_a",
> +	"scif2_clk_b",
> +	"scif2_clk_c",
> +};
> +
> +static const char * const scif3_groups[] = {
> +	"scif3_data_a",
> +	"scif3_data_b",
> +	"scif3_data_c",
> +	"scif3_data_d",
> +};
> +
> +static const char * const scif4_groups[] = {
> +	"scif4_data_a",
> +	"scif4_data_b",
> +	"scif4_data_c",
> +};
> +
> +static const char * const scif5_groups[] = {
> +	"scif5_data_a",
> +	"scif5_data_b",
> +};
> +
> +static const char * const hscif0_groups[] = {
> +	"hscif0_data_a",
> +	"hscif0_data_b",
> +	"hscif0_ctrl_a",
> +	"hscif0_ctrl_b",
> +	"hscif0_clk",
> +};
> +
> +static const char * const hscif1_groups[] = {
> +	"hscif1_data_a",
> +	"hscif1_data_b",
> +	"hscif1_ctrl_a",
> +	"hscif1_ctrl_b",
> +	"hscif1_clk_a",
> +	"hscif1_clk_b",
> +};
> +
> +static const char * const scif_clk_groups[] = {
> +	"scif_clk",
> +};
> +
> +static const struct sh_pfc_function pinmux_functions[] = {
> +	SH_PFC_FUNCTION(scif0),
> +	SH_PFC_FUNCTION(scif1),
> +	SH_PFC_FUNCTION(scif2),
> +	SH_PFC_FUNCTION(scif3),
> +	SH_PFC_FUNCTION(scif4),
> +	SH_PFC_FUNCTION(scif5),
> +	SH_PFC_FUNCTION(hscif0),
> +	SH_PFC_FUNCTION(hscif1),
> +	SH_PFC_FUNCTION(scif_clk),
> +};

-- 
Regards,

Laurent Pinchart

