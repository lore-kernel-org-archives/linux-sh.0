From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 09 Jul 2014 00:08:48 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: add R-Car Gen. 2 init and power control
Message-Id: <87y4w3v1fa.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1404831571-19817-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1404831571-19817-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Ulrich

Thank you for your patch

> In preparation for DT conversion to reduce reliance on platform device
> callbacks.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
(snip)
> @@ -186,6 +192,8 @@ struct renesas_usbhs_platform_info {
>  	 * driver use these param for some register
>  	 */
>  	struct renesas_usbhs_driver_param	driver_param;
> +
> +	struct usb_phy *phy;
>  };

Using renesas_usbhs_platform_info for *phy is not good idea from my point of view.
Because its memory is located on platform side.
(this is the reason why usbhs_probe() using memcpy() for getting info->xxx)

I guess struct usbhs_priv is good place,
and you can use usbhs_pdev_to_priv() for this purpose ?

Best regards
---
Kuninori Morimoto
