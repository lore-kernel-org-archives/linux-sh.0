From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 06 May 2013 22:50:36 +0000
Subject: Re: [PATCH v4 19/88] sh-pfc: r8a7779: Add USB pin groups and functions
Message-Id: <518833BC.3020903@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363215633-4264-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363215633-4264-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 03/14/2013 01:59 AM, Laurent Pinchart wrote:

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 42 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> index 946572bc..6043d2c 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> @@ -2198,6 +2198,30 @@ static const unsigned int sdhi3_wp_pins[] = {
>   static const unsigned int sdhi3_wp_mux[] = {
>   	SD3_WP_MARK,
>   };
> +/* - USB0 ------------------------------------------------------------------- */
> +static const unsigned int usb0_pins[] = {
> +	/* OVC */
> +	150, 154,
> +};
> +static const unsigned int usb0_mux[] = {
> +	USB_OVC0_MARK, USB_PENC0_MARK,
> +};
> +/* - USB1 ------------------------------------------------------------------- */
> +static const unsigned int usb1_pins[] = {
> +	/* OVC */
> +	152, 155,
> +};
> +static const unsigned int usb1_mux[] = {
> +	USB_OVC1_MARK, USB_PENC1_MARK,
> +};
> +/* - USB2 ------------------------------------------------------------------- */
> +static const unsigned int usb2_pins[] = {
> +	/* OVC, PENC */
> +	125, 156,
> +};
> +static const unsigned int usb2_mux[] = {
> +	USB_OVC2_MARK, USB_PENC2_MARK,
> +};
>   

    The PENCn and USB_OVCn were erroneously grouped together (I've already
explained that the latter is usually unused 3.3V signal). This causes 
the following
(false) error messages when booting on Marzen:

sh-pfc pfc-r8a7779: pin GP_4_22 already requested by sh-hspi.0; cannot 
claim for
  ehci-platform.0
sh-pfc pfc-r8a7779: pin-150 (ehci-platform.0) status -22
sh-pfc pfc-r8a7779: could not request pin 150 on device sh-pfc

     GP_4_22 is multiplexed with USB_OVC0 (unused on Marzen) and HSPI_CLK0.
This needs fixing.

WBR, Sergei

