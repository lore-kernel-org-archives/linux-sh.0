From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Dec 2015 08:55:20 +0000
Subject: Re: [PATCH] usb: gadget: renesas_usb3: add support for Renesas USB3.0 peripheral controller
Message-Id: <1682829.86QFiIiJjD@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1450162472-6664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <7989573.HuGUrIYJy9@wuerfel> <SG2PR06MB0919D7F6AC941F8B1456AF26D8EF0@SG2PR06MB0919.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB0919D7F6AC941F8B1456AF26D8EF0-ESzmfEwOt/zNQ8RBPPB5A20DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wednesday 16 December 2015 02:26:26 Yoshihiro Shimoda wrote:
> Hi Arnd again,
> 
> > From: Yoshihiro Shimoda
> > Sent: Wednesday, December 16, 2015 10:43 AM
> < snip >
> > > > +static void usb3_write(struct renesas_usb3 *usb3, u32 data, u32 offs)
> > > > +{
> > > > +	iowrite32(data, usb3->reg + offs);
> > > > +}
> > > > +
> > > > +static u32 usb3_read(struct renesas_usb3 *usb3, u32 offs)
> > > > +{
> > > > +	return ioread32(usb3->reg + offs);
> > > > +}
> > >
> > > I think using readl() is more common than ioread32() if the driver cannot
> > > use IORESOURCE_IO but only IORESOURCE_MEM.
> > >
> > > On ARM, the two are the same, but on some architectures ioread32 is more
> > > expensive, so using the former is preferred.
> > 
> > I will use {read,write}l() instead of io{read,write}32().
> > Also I will change io{read,write}32_rep() functions too.
> 
> Oops. If I used {read,write}sl() instead of io{read,write}32_rep(),
> build error happened in x86 environment.
> 
>   CC [M]  drivers/usb/gadget/udc/renesas_usb3.o
> ./drivers/usb/gadget/udc/renesas_usb3.c: In function 'usb3_write_pipe':
> ./drivers/usb/gadget/udc/renesas_usb3.c:879:3: error: implicit declaration of function 'writesl' [-Werror=implicit-function-declaration]
>    writesl(usb3->reg + fifo_reg, buf, len / 4);
>    ^
> ./drivers/usb/gadget/udc/renesas_usb3.c: In function 'usb3_read_pipe':
> ./drivers/usb/gadget/udc/renesas_usb3.c:923:3: error: implicit declaration of function 'readsl' [-Werror=implicit-function-declaration]
>    readsl(usb3->reg + fifo_reg, buf, len / 4);
> 
> So, I will keep to use io{read,write}32(_rep) functions.

Sounds ok. I actually thought we had added readsl to all architectures, but apparently
we only changed some architectures that needed it in the past.

	Arnd
