From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 05 Aug 2013 00:28:58 +0000
Subject: Re: [PATCH 1/3 v3] ARM: shmobile: r8a7778: add usb phy power control function
Message-Id: <87bo5dt1yw.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi again

> > >> + if (IS_ERR(phy)) {
> > >> + pr_err("it doesn't have usb phy driver\n");
> > >
> > > I would still like this message corrected.
> > 
> > Yes, something like "cannot get usb2 phy driver"
> 
> Thank you for re-pointing it
> I will fix it and send v4 patch soon

int r8a7778_usb_phy_power(bool enable)
{
	static struct usb_phy *phy = NULL;
	int ret = 0;

	if (!phy)
		phy = usb_get_phy(USB_PHY_TYPE_USB2);

	if (IS_ERR(phy)) {
		pr_err("it doesn't have usb phy driver\n");
		return PTR_ERR(phy);
	}
	...
}

This r8a7778_usb_phy_power() can be called many times on r8a7778.
Then, usb_get_phy() line is called only 1 time,
(because, "phy" is static, and default was NULL)
but, IS_ERR() check will be called many times.

So, for me, error messages like

cannot get usb2 phy driver
cannot get usb2 phy driver
cannot get usb2 phy driver
cannot get usb2 phy driver

are miss leading user.

it doesn't have usb phy driver
it doesn't have usb phy driver
it doesn't have usb phy driver
it doesn't have usb phy driver

are reasonable I think, but yes, this "it" is unclear word here

Kernel doesn't have usb phy driver
Kernel doesn't have usb phy driver
Kernel doesn't have usb phy driver
Kernel doesn't have usb phy driver

I will use "Kernel" here

Thankk you

Best regards
---
Kuninori Morimoto
