From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 08:25:10 +0000
Subject: Re: [PATCH] usb: renesas_usbhs: Add support for R-Car H3
Message-Id: <87a8skyw7s.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442556232-6564-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1442556232-6564-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org


Hi Shimoda-san

> This patch adds a compatible string to support for R-Car H3.
> 
> Since the HS-USB controller of R-Car H3 is almost the same specification
> with R-Car Gen2 (these have 16 pipes and usb-dmac), this patch
> sets the "type" of renesas_usbhs_driver_param to USBHS_TYPE_RCAR_GEN2.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
(snip)
> diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
> index 7b98e1d..2becd6b 100644
> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c
> @@ -476,6 +476,10 @@ static const struct of_device_id usbhs_of_match[] = {
>  		.compatible = "renesas,usbhs-r8a7794",
>  		.data = (void *)USBHS_TYPE_RCAR_GEN2,
>  	},
> +	{
> +		.compatible = "renesas,usbhs-r8a7795",
> +		.data = (void *)USBHS_TYPE_RCAR_GEN2,
> +	},

It is helpful for user if it is indicating Gen2 compatible.
Because r8a7795 is Gen3

