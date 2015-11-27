From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 27 Nov 2015 05:53:26 +0000
Subject: RE: [PATCH v5 1/4] phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
Message-Id: <SG2PR06MB09194141EF1D644C6C000805D8030@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445331471-5028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1445331471-5028-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <5657E84C.5010800@ti.com>
In-Reply-To: <5657E84C.5010800@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi,

Thank you for the review!

> From: Kishon Vijay Abraham I [mailto:kishon@ti.com]
> Sent: Friday, November 27, 2015 2:21 PM
> 
> Hi,
> 
> On Tuesday 20 October 2015 02:27 PM, Yoshihiro Shimoda wrote:
> > This patch adds support for R-Car generation 3 USB2 PHY driver.
> > This SoC has 3 EHCI/OHCI channels, and the channel 0 is shared
> > with the HSUSB (USB2.0 peripheral) device. And each channel has
> > independent registers about the PHYs.
> >
> > So, the purpose of this driver is:
> >  1) initializes some registers of SoC specific to use the
> >     {ehci,ohci}-platform driver.
> >
> >  2) detects id pin to select host or peripheral on the channel 0.
> >
> > For now, this driver only supports 1) above.
> 
> When you do 2), make sure to use the extcon framework.

Thank you for your proposal! I will use the extcon framework for it.

> One minor comment below and then I can queue it for 4.5.

Thank you!

< snip >
> > +	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> > +	if (IS_ERR(provider)) {
> > +		dev_err(dev, "Failed to register PHY provider\n");
> > +		return PTR_ERR(provider);
> > +	}
> > +
> > +	return 0;
> 
> This can simply be replaced with return PTR_ERR_OR_ZERO(provider);

Yes, I tested that this could simply be replaced with "return PTR_ERR_OR_ZERO(provider);".
So, should I send v6 patch?

Best regards,
Yoshihiro Shimoda

> Thanks
> Kishon
