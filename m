From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 31 Dec 2013 00:57:23 +0000
Subject: Re: [PATCH 1/5] pinctl: sh-pfc: r8a7791: Group USB PWEN and OVC pins together
Message-Id: <1821696.sGzWNL2ABF@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1387548868-20943-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387548868-20943-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

Thank you for the patch.

On Friday 20 December 2013 18:14:24 Valentine Barshak wrote:
> This groups USB PWEN and OVC pins together on R8A7791 SoC,
> the same way it's done on R8A7790, since both are needed
> for a USB device.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

And applied to my tree.

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 40 +++++++++------------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c index ea02d37..894dd61 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> @@ -2649,33 +2649,21 @@ static const unsigned int sdhi2_wp_mux[] = {
>  	SD2_WP_MARK,
>  };
>  /* - USB0
> ------------------------------------------------------------------- */
> -static const unsigned int usb0_pwen_pins[] = {
> -	/* PWEN */
> -	RCAR_GP_PIN(7, 23),
> +static const unsigned int usb0_pins[] = {
> +	RCAR_GP_PIN(7, 23), /* PWEN */
> +	RCAR_GP_PIN(7, 24), /* OVC */
>  };
> -static const unsigned int usb0_pwen_mux[] = {
> +static const unsigned int usb0_mux[] = {
>  	USB0_PWEN_MARK,
> -};
> -static const unsigned int usb0_ovc_pins[] = {
> -	/* OVC */
> -	RCAR_GP_PIN(7, 24),
> -};
> -static const unsigned int usb0_ovc_mux[] = {
>  	USB0_OVC_MARK,
>  };
>  /* - USB1
> ------------------------------------------------------------------- */
> -static const unsigned int usb1_pwen_pins[] = {
> -	/* PWEN */
> -	RCAR_GP_PIN(7, 25),
> +static const unsigned int usb1_pins[] = {
> +	RCAR_GP_PIN(7, 25), /* PWEN */
> +	RCAR_GP_PIN(6, 30), /* OVC */
>  };
> -static const unsigned int usb1_pwen_mux[] = {
> +static const unsigned int usb1_mux[] = {
>  	USB1_PWEN_MARK,
> -};
> -static const unsigned int usb1_ovc_pins[] = {
> -	/* OVC */
> -	RCAR_GP_PIN(6, 30),
> -};
> -static const unsigned int usb1_ovc_mux[] = {
>  	USB1_OVC_MARK,
>  };
> 
> @@ -2810,10 +2798,8 @@ static const struct sh_pfc_pin_group pinmux_groups[]
> = { SH_PFC_PIN_GROUP(sdhi2_ctrl),
>  	SH_PFC_PIN_GROUP(sdhi2_cd),
>  	SH_PFC_PIN_GROUP(sdhi2_wp),
> -	SH_PFC_PIN_GROUP(usb0_pwen),
> -	SH_PFC_PIN_GROUP(usb0_ovc),
> -	SH_PFC_PIN_GROUP(usb1_pwen),
> -	SH_PFC_PIN_GROUP(usb1_ovc),
> +	SH_PFC_PIN_GROUP(usb0),
> +	SH_PFC_PIN_GROUP(usb1),
>  };
> 
>  static const char * const du_groups[] = {
> @@ -3016,12 +3002,10 @@ static const char * const sdhi2_groups[] = {
>  };
> 
>  static const char * const usb0_groups[] = {
> -	"usb0_pwen",
> -	"usb0_ovc",
> +	"usb0",
>  };
>  static const char * const usb1_groups[] = {
> -	"usb1_pwen",
> -	"usb1_ovc",
> +	"usb1",
>  };
> 
>  static const struct sh_pfc_function pinmux_functions[] = {
-- 
Regards,

Laurent Pinchart

