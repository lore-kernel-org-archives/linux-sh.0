From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 16 Dec 2015 02:26:26 +0000
Subject: RE: [PATCH] usb: gadget: renesas_usb3: add support for Renesas USB3.0 peripheral controller
Message-Id: <SG2PR06MB0919D7F6AC941F8B1456AF26D8EF0@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450162472-6664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <7989573.HuGUrIYJy9@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "balbi@ti.com" <balbi@ti.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Arnd again,

> From: Yoshihiro Shimoda
> Sent: Wednesday, December 16, 2015 10:43 AM
< snip >
> > > +static void usb3_write(struct renesas_usb3 *usb3, u32 data, u32 offs)
> > > +{
> > > +	iowrite32(data, usb3->reg + offs);
> > > +}
> > > +
> > > +static u32 usb3_read(struct renesas_usb3 *usb3, u32 offs)
> > > +{
> > > +	return ioread32(usb3->reg + offs);
> > > +}
> >
> > I think using readl() is more common than ioread32() if the driver cannot
> > use IORESOURCE_IO but only IORESOURCE_MEM.
> >
> > On ARM, the two are the same, but on some architectures ioread32 is more
> > expensive, so using the former is preferred.
> 
> I will use {read,write}l() instead of io{read,write}32().
> Also I will change io{read,write}32_rep() functions too.

Oops. If I used {read,write}sl() instead of io{read,write}32_rep(),
build error happened in x86 environment.

  CC [M]  drivers/usb/gadget/udc/renesas_usb3.o
./drivers/usb/gadget/udc/renesas_usb3.c: In function 'usb3_write_pipe':
./drivers/usb/gadget/udc/renesas_usb3.c:879:3: error: implicit declaration of function 'writesl' [-Werror=implicit-function-declaration]
   writesl(usb3->reg + fifo_reg, buf, len / 4);
   ^
./drivers/usb/gadget/udc/renesas_usb3.c: In function 'usb3_read_pipe':
./drivers/usb/gadget/udc/renesas_usb3.c:923:3: error: implicit declaration of function 'readsl' [-Werror=implicit-function-declaration]
   readsl(usb3->reg + fifo_reg, buf, len / 4);

So, I will keep to use io{read,write}32(_rep) functions.

Best regards,
Yoshihiro Shimoda

