From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Sep 2015 12:42:23 +0000
Subject: RE: [PATCH] phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
Message-Id: <SG2PR06MB0919D459785C1CEAB1F22F35D8420@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440493835-6732-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <55FBAA4D.3000704@ti.com> <56000DB2.5010004@kernel.org>
In-Reply-To: <56000DB2.5010004@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Rob,

Thank you for your comment!
And, I'm sorry for the delayed response.

> Sent: Monday, September 21, 2015 11:01 PM
> 
> On 09/18/2015 01:08 AM, Kishon Vijay Abraham I wrote:
> > Hi,
> >
> > On Tuesday 25 August 2015 02:40 PM, Yoshihiro Shimoda wrote:
> >> This patch adds support for R-Car generation 3 USB2 PHY driver.
> >> This SoC has 3 EHCI/OHCI channels, and the channel 0 is shared
> >> with the HSUSB (USB2.0 peripheral) device.
> >
> > From the description it looks like it's a single PHY with multiple
> > channels. In that case you should have a singe dt node for the PHY
> > provider and each channel should be modelled as the child node of the
> > PHY provider dt node.
> 
> You only need sub-nodes if you need per channel properties. Otherwise,
> #phy-cells can be 1 and the cell value can be the channel number.

Thank you for the information. I got it.

< snip >
> >> diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> >> new file mode 100644
> >> index 0000000..1d57766
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> >> @@ -0,0 +1,35 @@
> >> +* Renesas R-Car generation 3 USB 2.0 PHY
> >> +
> >> +This file provides information on what the device node for the R-Car generation
> >> +3 USB 2.0 PHY contains.
> >> +
> >> +Required properties:
> >> +- compatible: "renesas,usb2-phy-r8a7795" if the device is a part of an R8A7795
> >> +	      SoC.
> >> +- reg: offset and length of the USB2.0 host register block.
> 
> host register block? You mean phy register block?

Oops, thank you for the point. I will fix it.

> >> +- reg-names: must be "usb2".
> >> +- clocks: clock phandle and specifier pair(s).
> >> +- #phy-cells: see phy-bindings.txt in the same directory, must be <0>.
> >> +
> >> +Optional properties:
> >> +To use a USB channel where EHCI/OHCI and HSUSB are combined, the device tree
> >> +node should set HSUSB properties to reg and reg-names properties:
> >> +- reg: offset and length of the HSUSB register block.
> >> +- reg-names: must be "hsusb".
> >> +
> >> +Example (R-Car H3):
> >> +
> >> +	usb-phy@ee080200 {
> >> +		compatible = "renesas,usb2-phy-r8a7795";
> >> +		reg = <0 0xee080200 0 0x6ff>, <0 0xe6590100 0 0x100>;
> >> +		reg-names = "usb2", "hsusb";
> >
> > hsusb is missing in Documentation.
> 
> usb2 is the host controller? It is questionable that these should be
> combined. Does this appear under another node? If so, don't overlap
> resources in the DT.

Thank you for the point.
I don't think that this appears under another node.
However, to avoid such a situation, I should change the name somehow.

Best regards,
Yoshihiro Shimoda

