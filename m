From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Oct 2013 05:50:46 +0000
Subject: Re: [PATCH] usb: phy: phy-rcar-gen2-usb: Fix phy initialization
Message-Id: <20131029055046.GA11580@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1382720832-10267-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1382720832-10267-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 25, 2013 at 09:07:12PM +0400, Valentine Barshak wrote:
> Add missing USB UGCTRL2 register offset.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

This seems reasonable to me.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

Felipe, please consider applying this change.

> ---
>  drivers/usb/phy/phy-rcar-gen2-usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
> index a99a695..db3ab34 100644
> --- a/drivers/usb/phy/phy-rcar-gen2-usb.c
> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
> @@ -107,10 +107,10 @@ static void __rcar_gen2_usb_phy_init(struct rcar_gen2_usb_phy_priv *priv)
>  	clk_prepare_enable(priv->clk);
>  
>  	/* Set USB channels in the USBHS UGCTRL2 register */
> -	val = ioread32(priv->base);
> +	val = ioread32(priv->base + USBHS_UGCTRL2_REG);
>  	val &= ~(USBHS_UGCTRL2_USB0_HS | USBHS_UGCTRL2_USB2_SS);
>  	val |= priv->ugctrl2;
> -	iowrite32(val, priv->base);
> +	iowrite32(val, priv->base + USBHS_UGCTRL2_REG);
>  }
>  
>  /* Shutdown USB channels */
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
