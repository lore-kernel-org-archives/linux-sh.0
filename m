From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Jan 2015 12:03:36 +0000
Subject: Re: [PATCH] sh-pfc: r8a7790: add MLB+ pin group
Message-Id: <3255630.XVnHYj4Bh6@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <4254413.Ay0OtsgpoE@wasted.cogentembedded.com>
In-Reply-To: <4254413.Ay0OtsgpoE@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linus.walleij@linaro.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Saturday 10 January 2015 21:20:47 Sergei Shtylyov wrote:
> Add MLB+ 3-pin mode pin group to R8A7790 PFC driver.
> 
> Based on original patch by Andrey Gusakov
> <andrey.gusakov@cogentembedded.com>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
> repo.
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> =================================> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> @@ -2241,6 +2241,13 @@ static const unsigned int intc_irq3_pins
>  static const unsigned int intc_irq3_mux[] = {
>  	IRQ3_MARK,
>  };
> +/* - MLB+
> ------------------------------------------------------------------- */
> +static const unsigned int mlb_3pin_pins[] = {
> +	RCAR_GP_PIN(4, 0), RCAR_GP_PIN(4, 1), RCAR_GP_PIN(4, 2),
> +};
> +static const unsigned int mlb_3pin_mux[] = {
> +	MLB_CLK_MARK, MLB_SIG_MARK, MLB_DAT_MARK,
> +};
>  /* - MMCIF0
> ----------------------------------------------------------------- */ static
> const unsigned int mmc0_data1_pins[] = {
>  	/* D[0] */
> @@ -3873,6 +3880,7 @@ static const struct sh_pfc_pin_group pin
>  	SH_PFC_PIN_GROUP(intc_irq1),
>  	SH_PFC_PIN_GROUP(intc_irq2),
>  	SH_PFC_PIN_GROUP(intc_irq3),
> +	SH_PFC_PIN_GROUP(mlb_3pin),
>  	SH_PFC_PIN_GROUP(mmc0_data1),
>  	SH_PFC_PIN_GROUP(mmc0_data4),
>  	SH_PFC_PIN_GROUP(mmc0_data8),
> @@ -4198,6 +4206,10 @@ static const char * const intc_groups[]
>  	"intc_irq3",
>  };
> 
> +static const char * const mlb_groups[] = {
> +	"mlb_3pin",
> +};
> +
>  static const char * const mmc0_groups[] = {
>  	"mmc0_data1",
>  	"mmc0_data4",
> @@ -4511,6 +4523,7 @@ static const struct sh_pfc_function pinm
>  	SH_PFC_FUNCTION(iic2),
>  	SH_PFC_FUNCTION(iic3),
>  	SH_PFC_FUNCTION(intc),
> +	SH_PFC_FUNCTION(mlb),
>  	SH_PFC_FUNCTION(mmc0),
>  	SH_PFC_FUNCTION(mmc1),
>  	SH_PFC_FUNCTION(msiof0),

-- 
Regards,

Laurent Pinchart

