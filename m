From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Sep 2015 12:41:37 +0000
Subject: RE: [PATCH] phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
Message-Id: <SG2PR06MB09193BA27CEED692028909ADD8420@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440493835-6732-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <55FBAA4D.3000704@ti.com>
In-Reply-To: <55FBAA4D.3000704-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Kishon,

Thank you for the review!
And I'm sorry for the delayed response.

> Sent: Friday, September 18, 2015 3:08 PM
> 
> Hi,
> 
> On Tuesday 25 August 2015 02:40 PM, Yoshihiro Shimoda wrote:
> > This patch adds support for R-Car generation 3 USB2 PHY driver.
> > This SoC has 3 EHCI/OHCI channels, and the channel 0 is shared
> > with the HSUSB (USB2.0 peripheral) device.
> 
> From the description it looks like it's a single PHY with multiple
> channels. In that case you should have a singe dt node for the PHY
> provider and each channel should be modelled as the child node of the
> PHY provider dt node.

Sorry for my lack information.
As my understanding, each EHCI/OHCI channel has a PHY because the following
things are differnce:
 - Memory map
  - ch0 = 0xee080000
  - ch1 = 0xee0a0000
  - ch2 = 0xee0c0000

 - Clock ("module stop")
  - Each channel has a specific clock ("module stop bit").

< snip >
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > @@ -0,0 +1,35 @@
> > +* Renesas R-Car generation 3 USB 2.0 PHY
> > +
> > +This file provides information on what the device node for the R-Car generation
> > +3 USB 2.0 PHY contains.
> > +
> > +Required properties:
> > +- compatible: "renesas,usb2-phy-r8a7795" if the device is a part of an R8A7795
> > +	      SoC.
> > +- reg: offset and length of the USB2.0 host register block.
> > +- reg-names: must be "usb2".
> > +- clocks: clock phandle and specifier pair(s).
> > +- #phy-cells: see phy-bindings.txt in the same directory, must be <0>.
> > +
> > +Optional properties:
> > +To use a USB channel where EHCI/OHCI and HSUSB are combined, the device tree
> > +node should set HSUSB properties to reg and reg-names properties:
> > +- reg: offset and length of the HSUSB register block.
> > +- reg-names: must be "hsusb".
> > +
> > +Example (R-Car H3):
> > +
> > +	usb-phy@ee080200 {
> > +		compatible = "renesas,usb2-phy-r8a7795";
> > +		reg = <0 0xee080200 0 0x6ff>, <0 0xe6590100 0 0x100>;
> > +		reg-names = "usb2", "hsusb";
> 
> hsusb is missing in Documentation.

I wrote the "hsusb" as Optional properties in the Documentation.
Or, Is my understanding about your comment wrong?

< snip >
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 0fe9bff..406dc43 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -116,6 +116,12 @@ config PHY_RCAR_GEN2
> >  	help
> >  	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
> >
> > +config PHY_RCAR_GEN3_USB2
> > +	tristate "Renesas R-Car generation 3 USB 2.0 PHY driver"
> > +	depends on GENERIC_PHY
> 
> depends on OF?

Thank you for the point. I will fix it.

Best regards,
Yoshihiro Shimoda

> Thanks
> Kishon
