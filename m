From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Dec 2015 03:56:24 +0000
Subject: Re: [PATCH v3 2/3] usb: renesas_usbhs: add fallback compatibility strings
Message-Id: <20151211035624.GA12611@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1449799947-19866-1-git-send-email-horms+renesas@verge.net.au>
 <1449799947-19866-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449799947-19866-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, Dec 11, 2015 at 11:12:26AM +0900, Simon Horman wrote:
> Add fallback compatibility strings for R-Car Gen2 and Gen3.
> This is in keeping with the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Binding looks okay, but one possible typo.

Acked-by: Rob Herring <robh@kernel.org>

> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c
> @@ -481,6 +481,15 @@ static const struct of_device_id usbhs_of_match[] = {
>  		.compatible = "renesas,usbhs-r8a7795",
>  		.data = (void *)USBHS_TYPE_RCAR_GEN2,
>  	},
> +	{
> +		.compatible = "renesas,rcar-gen2-usbhs",
> +		.data = (void *)USBHS_TYPE_RCAR_GEN2,
> +	},
> +	{
> +		/* Gen3 is compatible with Gen2 */
> +		.compatible = "renesas,rcar-gen3-usbhs",
> +		.data = (void *)USBHS_TYPE_RCAR_GEN2,

This supposed to be GEN3?

