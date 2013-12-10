From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 10 Dec 2013 15:29:43 +0000
Subject: Re: [PATCH] ARM: shmobile: mackerel: Use pinconf API to configure pin pull-down
Message-Id: <173349858.zqd3Wj5xck@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1385651878-7002-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385651878-7002-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thursday 28 November 2013 16:17:58 Laurent Pinchart wrote:
> The USB0 and USB1 VBUS pins must be pulled down. Add corresponding
> configuration entries in the pinctrl map table instead of manually
> poking the pin control registers.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/board-mackerel.c | 17 +++++++++--------
>  arch/arm/mach-shmobile/sh-gpio.h        | 19 -------------------
>  2 files changed, 9 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-mackerel.c
> b/arch/arm/mach-shmobile/board-mackerel.c index d90d2f1..207acf0 100644
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c

[snip]

> @@ -1396,17 +1401,19 @@ static const struct pinctrl_map
> mackerel_pinctrl_map[] = { /* USBHS0 */
>  	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.0", "pfc-sh7372",
>  				  "usb0_vbus", "usb0"),
> +	PIN_MAP_CONFIGS_GROUP_DEFAULT("renesas_usbhs.0", "pfc-sh7372",
> +				      "usb0_vbus", pin_pulldown_conf),
>  	/* USBHS1 */
>  	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
>  				  "usb1_vbus", "usb1"),
> +	PIN_MAP_CONFIGS_GROUP_DEFAULT("renesas_usbhs.&", "pfc-sh7372",
> +				      "usb1_vbus", pin_pulldown_conf),

This is obviously a mistake ('&' should be '1'). Should I submit a v2 with the 
typo fixed, or a new patch that fixes the bug ?

>  	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
>  				  "usb1_otg_id_0", "usb1"),
>  };

-- 
Regards,

Laurent Pinchart

