From: Valentine <valentine.barshak@cogentembedded.com>
Date: Mon, 09 Dec 2013 19:33:09 +0000
Subject: Re: [PATCH] usb: phy: R-Car Gen2: Use usb_phy_add_dev
Message-Id: <52A61AF5.9090708@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386592505-24585-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386592505-24585-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 12/09/2013 04:35 PM, Valentine Barshak wrote:
> Use add_phy_dev instead of usb_phy_add, so that devices can
> be bound to the phy. This is needed to set up USB phy for
> some internal PCI USB host controllers on R-Car Gen2.
>
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>   drivers/usb/phy/phy-rcar-gen2-usb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
> index db3ab34..551e0a6 100644
> --- a/drivers/usb/phy/phy-rcar-gen2-usb.c
> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
> @@ -213,7 +213,7 @@ static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
>   	priv->phy.shutdown = rcar_gen2_usb_phy_shutdown;
>   	priv->phy.set_suspend = rcar_gen2_usb_phy_set_suspend;
>
> -	retval = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
> +	retval = usb_add_phy_dev(&priv->phy);
>   	if (retval < 0) {
>   		dev_err(dev, "Failed to add USB phy\n");
>   		return retval;
>

Please, disregard this one as it uses slightly incorrect function names in the commit log.
I'll update the log message and submit V2 in a bit.
Sorry for the noise.

Thanks,
Val.
