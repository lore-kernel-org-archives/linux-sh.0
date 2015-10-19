From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 19 Oct 2015 08:35:29 +0000
Subject: RE: [PATCH v4 3/3] phy: rcar-gen3-usb2: add runtime ID/VBUS pin detection
Message-Id: <SG2PR06MB0919E43CDBA0D6EDA978A496D83A0@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444731726-5328-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1444731726-5328-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <5621AA2A.9000000@ti.com>
In-Reply-To: <5621AA2A.9000000@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi,

> Sent: Saturday, October 17, 2015 10:54 AM
> 
> Hi,
> 
> On Tuesday 13 October 2015 03:52 PM, Yoshihiro Shimoda wrote:
> > This patch adds support for runtime ID/VBUS pin detection if
> > the channel 0 of R-Car gen3 is used. So, we are able to use
> > the channel as both host and peripheral.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  2 +
> >  drivers/phy/phy-rcar-gen3-usb2.c                   | 43 +++++++++++++++++++++-
> >  2 files changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > index 589f5c0..b30a98a 100644
> > --- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > @@ -18,6 +18,7 @@ properties. This is because HSUSB has registers to select USB 2.0 host or
> >  peripheral at that channel:
> >  - reg: offset and length of the partial HSUSB register block.
> >  - reg-names: must be "hsusb".
> > +- interrupts: interrupt specifier for the PHY.
> >
> >  Example (R-Car H3):
> >
> > @@ -25,6 +26,7 @@ Example (R-Car H3):
> >  		compatible = "renesas,usb2-phy-r8a7795";
> >  		reg = <0 0xee080200 0 0x700>, <0 0xe6590100 0 0x100>;
> >  		reg-names = "usb2_host", "hsusb";
> > +		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> >  		clocks = <&mstp7_clks R8A7795_CLK_EHCI0>,
> >  			 <&mstp7_clks R8A7795_CLK_HSUSB>;
> >  	};
> > diff --git a/drivers/phy/phy-rcar-gen3-usb2.c b/drivers/phy/phy-rcar-gen3-usb2.c
> > index 03d7079..40d0005 100644
> > --- a/drivers/phy/phy-rcar-gen3-usb2.c
> > +++ b/drivers/phy/phy-rcar-gen3-usb2.c
> > @@ -12,6 +12,7 @@
> >   * published by the Free Software Foundation.
> >   */
> >
> > +#include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -26,14 +27,18 @@
> >  #define USB2_SPD_RSM_TIMSET	0x10c
> >  #define USB2_OC_TIMSET		0x110
> >  #define USB2_COMMCTRL		0x600
> > +#define USB2_OBINTSTA		0x604
> > +#define USB2_OBINTEN		0x608
> >  #define USB2_VBCTRL		0x60c
> >  #define USB2_LINECTRL1		0x610
> >  #define USB2_ADPCTRL		0x630
> >
> >  /* INT_ENABLE */
> > +#define USB2_INT_ENABLE_UCOM_INTEN	BIT(3)
> >  #define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)
> >  #define USB2_INT_ENABLE_USBH_INTA_EN	BIT(1)
> > -#define USB2_INT_ENABLE_INIT		(USB2_INT_ENABLE_USBH_INTB_EN | \
> > +#define USB2_INT_ENABLE_INIT		(USB2_INT_ENABLE_UCOM_INTEN | \
> > +					 USB2_INT_ENABLE_USBH_INTB_EN | \
> >  					 USB2_INT_ENABLE_USBH_INTA_EN)
> >
> >  /* USBCTR */
> > @@ -49,6 +54,12 @@
> >  /* COMMCTRL */
> >  #define USB2_COMMCTRL_OTG_PERI		BIT(31)	/* 1 = Peripheral mode */
> >
> > +/* OBINTSTA and OBINTEN */
> > +#define USB2_OBINT_SESSVLDCHG		BIT(12)
> > +#define USB2_OBINT_IDDIGCHG		BIT(11)
> > +#define USB2_OBINT_BITS			(USB2_OBINT_SESSVLDCHG | \
> > +					 USB2_OBINT_IDDIGCHG)
> > +
> >  /* VBCTRL */
> >  #define USB2_VBCTRL_DRVVBUSSEL		BIT(8)
> >
> > @@ -178,6 +189,9 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
> >
> >  	tmp = readl(usb2_base + USB2_VBCTRL);
> >  	writel(tmp | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
> > +	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
> > +	tmp = readl(usb2_base + USB2_OBINTEN);
> > +	writel(tmp | USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
> >  	tmp = readl(usb2_base + USB2_ADPCTRL);
> >  	writel(tmp | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
> >  	tmp = readl(usb2_base + USB2_LINECTRL1);
> > @@ -289,6 +303,23 @@ static struct phy_ops rcar_gen3_phy_usb2_ops = {
> >  	.owner		= THIS_MODULE,
> >  };
> >
> > +static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
> > +{
> > +	struct rcar_gen3_chan *ch = _ch;
> > +	void __iomem *usb2_base = ch->usb2.base;
> > +	u32 status = readl(usb2_base + USB2_OBINTSTA);
> > +	irqreturn_t ret = IRQ_NONE;
> > +
> > +	if (status & USB2_OBINT_BITS) {
> > +		dev_dbg(&ch->phy->dev, "%s: %08x\n", __func__, status);
> 
> This can be removed or use dev_vdbg.

I got it. I will use dev_vdbg().

> > +		writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
> > +		rcar_gen3_device_recognition(ch);
> > +		ret = IRQ_HANDLED;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
> >  	{ .compatible = "renesas,usb2-phy-r8a7795" },
> >  	{ }
> > @@ -323,9 +354,19 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
> >
> >  	/* To avoid error message by devm_ioremap_resource() */
> >  	if (res) {
> > +		int ret, irq;
> > +
> >  		channel->hsusb.base = devm_ioremap_resource(dev, res);
> >  		if (IS_ERR(channel->hsusb.base))
> >  			channel->hsusb.base = NULL;
> > +		/* call request_irq for OTG */
> > +		ret = irq = platform_get_irq(pdev, 0);
> is irq optional property? even then you don't need 2 variables to handle
> the same return value.

Yes, the irq is optional property.
Oops, thank you for the point. I will fix it.

> Thanks
> Kishon

