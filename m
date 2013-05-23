From: Simon Horman <horms@verge.net.au>
Date: Thu, 23 May 2013 01:39:22 +0000
Subject: Re: [PATCH FOR v3.10] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
Message-Id: <20130523013921.GF22608@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1369132771-15422-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1369132771-15422-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 21, 2013 at 12:39:31PM +0200, Laurent Pinchart wrote:
> The USB_OVCn pins are alternate options for USB over-current detection
> when using a 3.3V USB interface. As they're not mandatory they can be
> used independently of the USB PENC pins. Don't group the USB_OVCn and
> PENC pins to avoid conflicts when the USB_OVCn pins are used by another
> function.
> 
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 45 ++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 9 deletions(-)
> 
> This patch is a rebased version of "[PATCH v2] sh-pfc: r8a7779: Don't group USB
> OVC and PENC pins" on top of v3.10-rc2.

Thanks.

I have queued-this up for v3.10 in pinmux-fixes branch and intend
to send a pull request in the not to distant future.

I then rebased the pinmux branch, which is targeted at v3.11,
on top of pinmux-fixes branch. In the course of doing so I resolved
some conflicts in:

sh-pfc: r8a7779: Replace hardcoded pin numbers with RCAR_GP_PIN macro
sh-pfc: r8a7779: add VIN pin groups

> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> index 791a671..8cd90e7 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> @@ -2357,27 +2357,48 @@ static const unsigned int sdhi3_wp_mux[] = {
>  };
>  /* - USB0 ------------------------------------------------------------------- */
>  static const unsigned int usb0_pins[] = {
> -	/* OVC */
> -	150, 154,
> +	/* PENC */
> +	154,
>  };
>  static const unsigned int usb0_mux[] = {
> -	USB_OVC0_MARK, USB_PENC0_MARK,
> +	USB_PENC0_MARK,
> +};
> +static const unsigned int usb0_ovc_pins[] = {
> +	/* USB_OVC */
> +	150
> +};
> +static const unsigned int usb0_ovc_mux[] = {
> +	USB_OVC0_MARK,
>  };
>  /* - USB1 ------------------------------------------------------------------- */
>  static const unsigned int usb1_pins[] = {
> -	/* OVC */
> -	152, 155,
> +	/* PENC */
> +	155,
>  };
>  static const unsigned int usb1_mux[] = {
> -	USB_OVC1_MARK, USB_PENC1_MARK,
> +	USB_PENC1_MARK,
> +};
> +static const unsigned int usb1_ovc_pins[] = {
> +	/* USB_OVC */
> +	152,
> +};
> +static const unsigned int usb1_ovc_mux[] = {
> +	USB_OVC1_MARK,
>  };
>  /* - USB2 ------------------------------------------------------------------- */
>  static const unsigned int usb2_pins[] = {
> -	/* OVC, PENC */
> -	125, 156,
> +	/* PENC */
> +	156,
>  };
>  static const unsigned int usb2_mux[] = {
> -	USB_OVC2_MARK, USB_PENC2_MARK,
> +	USB_PENC2_MARK,
> +};
> +static const unsigned int usb2_ovc_pins[] = {
> +	/* USB_OVC */
> +	125,
> +};
> +static const unsigned int usb2_ovc_mux[] = {
> +	USB_OVC2_MARK,
>  };
>  
>  static const struct sh_pfc_pin_group pinmux_groups[] = {
> @@ -2501,8 +2522,11 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
>  	SH_PFC_PIN_GROUP(sdhi3_cd),
>  	SH_PFC_PIN_GROUP(sdhi3_wp),
>  	SH_PFC_PIN_GROUP(usb0),
> +	SH_PFC_PIN_GROUP(usb0_ovc),
>  	SH_PFC_PIN_GROUP(usb1),
> +	SH_PFC_PIN_GROUP(usb1_ovc),
>  	SH_PFC_PIN_GROUP(usb2),
> +	SH_PFC_PIN_GROUP(usb2_ovc),
>  };
>  
>  static const char * const du0_groups[] = {
> @@ -2683,14 +2707,17 @@ static const char * const sdhi3_groups[] = {
>  
>  static const char * const usb0_groups[] = {
>  	"usb0",
> +	"usb0_ovc",
>  };
>  
>  static const char * const usb1_groups[] = {
>  	"usb1",
> +	"usb1_ovc",
>  };
>  
>  static const char * const usb2_groups[] = {
>  	"usb2",
> +	"usb2_ovc",
>  };
>  
>  static const struct sh_pfc_function pinmux_functions[] = {
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
