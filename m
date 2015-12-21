From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 21 Dec 2015 09:34:23 +0000
Subject: RE: [PATCH v2] usb: gadget: renesas_usb3: add support for Renesas USB3.0 peripheral controller
Message-Id: <SG2PR06MB0919CD95414FC0671C0CC4C4D8E40@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450234319-5872-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20151219041930.GR14936@rob-hp-laptop>
In-Reply-To: <20151219041930.GR14936@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "balbi@ti.com" <balbi@ti.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Rob,

> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Saturday, December 19, 2015 1:20 PM
> 
> On Wed, Dec 16, 2015 at 11:51:59AM +0900, Yoshihiro Shimoda wrote:
> > R-Car H3 has USB3.0 peripheral controllers. This controller's has the
> > following features:
> >  - Supports super, high and full speed
> >  - Contains 30 pipes for bulk or interrupt transfer
> >  - Contains dedicated DMA controller
> >
> > This driver doesn't support the dedicated DMAC for now.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  This patch is based on the latest Felipe's usb.git / testing/next branch.
> >  (commit id = e9284de9fae69f1d5e57a4817bfc36dc5f3adf71)
> >
> >  Changes from v1:
> >   - fix build error in i386 environment if COMPILE_TEST=y
> >   - merge the header file code into the .c file
> >   - revise the device tree document about "clocks"
> >   - remove prototype declarations
> >   - use udelay(1) instead of ndelay(1) in usb3_wait()
> >   - remove empty function "usb3_init_phy()"
> >   - use module_platform_driver()
> >   - remove bit fields member in some structures
> >
> >  .../devicetree/bindings/usb/renesas_usb3.txt       |   23 +
> >  drivers/usb/gadget/udc/Kconfig                     |   11 +
> >  drivers/usb/gadget/udc/Makefile                    |    1 +
> >  drivers/usb/gadget/udc/renesas_usb3.c              | 1975 ++++++++++++++++++++
> >  4 files changed, 2010 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/renesas_usb3.txt
> >  create mode 100644 drivers/usb/gadget/udc/renesas_usb3.c
> >
> > diff --git a/Documentation/devicetree/bindings/usb/renesas_usb3.txt
> b/Documentation/devicetree/bindings/usb/renesas_usb3.txt
> > new file mode 100644
> > index 0000000..71bee11
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/renesas_usb3.txt
> > @@ -0,0 +1,23 @@
> > +Renesas Electronics USB3.0 Peripheral driver
> > +
> > +Required properties:
> > +  - compatible: Must contain one of the following:
> > +	- "renesas,usb3-peri-r8a7795"
> 
> Aren't you all doing <chip>-<peripheral> order for new bindings?

Oops, thank you for the point. I will fix this.

Best regards,
Yoshihiro Shimoda

> Rob
