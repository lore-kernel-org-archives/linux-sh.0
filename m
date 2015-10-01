From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 01 Oct 2015 10:01:29 +0000
Subject: RE: [PATCH] phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
Message-Id: <SG2PR06MB09198E86925430DC0D500B59D84C0@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440493835-6732-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <55FBAA4D.3000704@ti.com> <56000DB2.5010004@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Rob,

> Sent: Friday, September 25, 2015 9:42 PM
> 
> Hi Rob,
> 
> Thank you for your comment!
> And, I'm sorry for the delayed response.
> 
> > Sent: Monday, September 21, 2015 11:01 PM
> >
> > On 09/18/2015 01:08 AM, Kishon Vijay Abraham I wrote:
< snip >
> > >> +Example (R-Car H3):
> > >> +
> > >> +	usb-phy@ee080200 {
> > >> +		compatible = "renesas,usb2-phy-r8a7795";
> > >> +		reg = <0 0xee080200 0 0x6ff>, <0 0xe6590100 0 0x100>;
> > >> +		reg-names = "usb2", "hsusb";
> > >
> > > hsusb is missing in Documentation.
> >
> > usb2 is the host controller? It is questionable that these should be
> > combined. Does this appear under another node? If so, don't overlap
> > resources in the DT.
> 
> Thank you for the point.
> I don't think that this appears under another node.
> However, to avoid such a situation, I should change the name somehow.

Perhaps I misunderstood your point. So, let me comment below again:

- This "usb2" means the partial registers of USB 2.0 host block.
  That host registers can control the USB2.0 PHY.
  This "hsusb" means the partial registers of USB 2.0 peripheral block.
  That peripheral registers can control the selector (host or peripheral).
  So, these should be combined in this driver.

- These resources don't appear under another nodes.

Best regards,
Yoshihiro Shimoda

