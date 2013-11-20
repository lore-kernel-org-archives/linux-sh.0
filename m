From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 20 Nov 2013 21:15:58 +0000
Subject: Re: [PATCH 8/9] usb: phy: rcar-gen2: register using usb_add_phy_dev()
Message-Id: <528D268E.2030409@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384969086-8920-9-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1384969086-8920-9-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/20/2013 09:38 PM, Ulrich Hecht wrote:
> Allows binding of PCI USB host controllers to this phy.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> ---
>   drivers/usb/phy/phy-rcar-gen2-usb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
> index a99a695..25fdd91 100644
> --- a/drivers/usb/phy/phy-rcar-gen2-usb.c
> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
> @@ -212,8 +212,9 @@ static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
>   	priv->phy.init = rcar_gen2_usb_phy_init;
>   	priv->phy.shutdown = rcar_gen2_usb_phy_shutdown;
>   	priv->phy.set_suspend = rcar_gen2_usb_phy_set_suspend;
> +	priv->phy.type = USB_PHY_TYPE_USB2;

The above line is not really needed.
I think we should switch to usb_bind_phy and bind USB phy to the renesas_usbhs device instead.
In this case usbhs device probe will be deferred unless usb phy is available.

>
> -	retval = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
> +	retval = usb_add_phy_dev(&priv->phy);
>   	if (retval < 0) {
>   		dev_err(dev, "Failed to add USB phy\n");
>   		return retval;
>

Thanks,
Val.
