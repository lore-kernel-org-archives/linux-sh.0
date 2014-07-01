From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 01 Jul 2014 07:11:04 +0000
Subject: Re: [PATCH] sh-pfc: r8a7791: add CAN pin groups
Message-Id: <1960550.2TAjlAm9xj@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201407010211.23665.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407010211.23665.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Tuesday 01 July 2014 02:11:22 Sergei Shtylyov wrote:
> Add CAN0/1 data/clock pin groups to R8A7791 PFC driver.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
> repo.
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  153 +++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
> 
> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> =================================> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> @@ -1726,6 +1726,119 @@ static const unsigned int audio_clkout_m
>  	AUDIO_CLKOUT_MARK,
>  };
> 
> +/* - CAN --------------------------------------------------------------- */

[snip]

> +static const unsigned int can_clk_c_pins[] = {
> +	RCAR_GP_PIN(4, 31),

Shouldn't this be (4, 30) ?

> +};
> 
>  /* - DU ---------------------------------------------------------------- */
> static const unsigned int du_rgb666_pins[] = {
> @@ -4055,6 +4168,20 @@ static const struct sh_pfc_pin_group pin
>  	SH_PFC_PIN_GROUP(audio_clk_b_b),
>  	SH_PFC_PIN_GROUP(audio_clk_c),
>  	SH_PFC_PIN_GROUP(audio_clkout),
> +	SH_PFC_PIN_GROUP(can0_data_a),
> +	SH_PFC_PIN_GROUP(can0_data_b),
> +	SH_PFC_PIN_GROUP(can0_data_c),
> +	SH_PFC_PIN_GROUP(can0_data_d),
> +	SH_PFC_PIN_GROUP(can0_data_e),
> +	SH_PFC_PIN_GROUP(can0_data_f),
> +	SH_PFC_PIN_GROUP(can1_data_a),
> +	SH_PFC_PIN_GROUP(can1_data_b),
> +	SH_PFC_PIN_GROUP(can1_data_c),
> +	SH_PFC_PIN_GROUP(can1_data_d),
> +	SH_PFC_PIN_GROUP(can_clk_a),
> +	SH_PFC_PIN_GROUP(can_clk_b),
> +	SH_PFC_PIN_GROUP(can_clk_c),
> +	SH_PFC_PIN_GROUP(can_clk_d),
>  	SH_PFC_PIN_GROUP(du_rgb666),
>  	SH_PFC_PIN_GROUP(du_rgb888),
>  	SH_PFC_PIN_GROUP(du_clk_out_0),
> @@ -4367,6 +4494,30 @@ static const char * const audio_clk_grou
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

Linus, can a group be listed as part of two different functions ?

> +};
> +
>  static const char * const du_groups[] = {
>  	"du_rgb666",
>  	"du_rgb888",
> @@ -4790,6 +4941,8 @@ static const char * const vin2_groups[]
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

