From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Mar 2013 00:29:47 +0000
Subject: Re: [PATCH 2/7] ARM: shmobile: marzen: add USB EHCI driver support
Message-Id: <87li9q4ydj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <1352446306-19945-3-git-send-email-horms@verge.net.au>
 <5140F35F.3090702@cogentembedded.com>
In-Reply-To: <5140F35F.3090702@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Sergei

> > +/* USB */
> > +static struct usb_phy *phy;
> > +static int usb_power_on(struct platform_device *pdev)
> > +{
> > +	if (!phy)
> > +		return -EIO;
> > +
> > +	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_get_sync(&pdev->dev);
> > +
> > +	usb_phy_init(phy);
> > +
> > +	return 0;
> > +}
> > +
> > +static void usb_power_off(struct platform_device *pdev)
> > +{
> > +	if (!phy)
> > +		return;
> > +
> > +	usb_phy_shutdown(phy);
> > +
> > +	pm_runtime_put_sync(&pdev->dev);
> > +	pm_runtime_disable(&pdev->dev);
> > +}
> > +
> > +static struct usb_ehci_pdata ehcix_pdata = {
> > +	.power_on	= usb_power_on,
> > +	.power_off	= usb_power_off,
> > +	.power_suspend	= usb_power_off,
> > +};
(snip)
>     Morimoto-san, I don't understand why this SoC specific platform device
> ended up in the board file? Could you explain your reasons please?
>     I think this is generally a bad practice as this approach scales badly.

Do you mean it should exist in setup-r8a7779.c ?

I forgot detail of it, but these usb is using callback function,
and it is using *phy*.
This phy came from marzen_init_late() with usb_get_phy(USB_PHY_TYPE_USB2);
This usb_get_phy() is not needed if board doesn't have USB.

You can modify it if you want

Best regards
---
Kuninori Morimoto
