From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 26 Jan 2014 17:04:03 +0000
Subject: Re: [PATCH 5/8] phy-rcar-usb-gen2: add device tree support
Message-Id: <52E54DF6.5070601@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk> <1390754945-28142-6-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390754945-28142-6-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

On 01/26/2014 07:49 PM, Ben Dooks wrote:

> Add support for the phy-rcar-gen2-usb driver to be probed from device tree.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
> Fixes from v1:
> 	- use of_property_reasd-bool()
> 	- remove unused of_id variable

> Cc: linux-usb@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: devicetree@vger.kernel.org
> ---
>   drivers/usb/phy/phy-rcar-gen2-usb.c | 31 ++++++++++++++++++++++++++-----
>   1 file changed, 26 insertions(+), 5 deletions(-)

> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
> index db3ab34..d146388 100644
> --- a/drivers/usb/phy/phy-rcar-gen2-usb.c
> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
[...]
> @@ -203,16 +210,29 @@ static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
[...]
> +	if (of_id) {

    You've removed the variable but not its use. Have you tried to compile 
this patch?

> +		if (of_property_read_bool(dev->of_node, "renesas,usb0-hs"))
> +			priv->ugctrl2 = USBHS_UGCTRL2_USB0_HS;
> +		else
> +			priv->ugctrl2 = USBHS_UGCTRL2_USB0_PCI;
> +
> +		if (of_property_read_bool(dev->of_node, "renesas,usb2-ss"))
> +			priv->ugctrl2 |= USBHS_UGCTRL2_USB2_SS;
> +		else
> +			priv->ugctrl2 |= USBHS_UGCTRL2_USB2_PCI;
> +	} else {
> +		priv->ugctrl2 = pdata->chan0_pci ?
> +			USBHS_UGCTRL2_USB0_PCI : USBHS_UGCTRL2_USB0_HS;
> +		priv->ugctrl2 |= pdata->chan2_pci ?
> +			USBHS_UGCTRL2_USB2_PCI : USBHS_UGCTRL2_USB2_SS;
> +	}
> +
>   	retval = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
>   	if (retval < 0) {
>   		dev_err(dev, "Failed to add USB phy\n");

WBR, Sergei


