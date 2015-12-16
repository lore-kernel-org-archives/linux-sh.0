From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 16 Dec 2015 01:43:11 +0000
Subject: RE: [PATCH] usb: gadget: renesas_usb3: add support for Renesas USB3.0 peripheral controller
Message-Id: <SG2PR06MB0919CA1AB72D7DC17B7EC13FD8EF0@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450162472-6664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <7989573.HuGUrIYJy9@wuerfel>
In-Reply-To: <7989573.HuGUrIYJy9@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "balbi@ti.com" <balbi@ti.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Arnd,

Thank you very much for your review!

> From: Arnd Bergmann
> Sent: Tuesday, December 15, 2015 6:30 PM
> 
> On Tuesday 15 December 2015 15:54:32 Yoshihiro Shimoda wrote:
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
> 
> Looks good overall, I've found a few small details:
> 
> >  .../devicetree/bindings/usb/renesas_usb3.txt       |   23 +
> >  drivers/usb/gadget/udc/Kconfig                     |   11 +
> >  drivers/usb/gadget/udc/Makefile                    |    1 +
> >  drivers/usb/gadget/udc/renesas_usb3.c              | 1720 ++++++++++++++++++++
> >  drivers/usb/gadget/udc/renesas_usb3.h              |  284 ++++
> 
> The header file is only used by one .c file, so just merge it all into that
> file.

I got it. I will merge the header file to the c file.

> > +Required properties:
> > +  - compatible: Must contain one of the following:
> > +	- "renesas,usb3-peri-r8a7795"
> > +  - reg: Base address and length of the register for the USB3.0 Peripheral
> > +  - interrupts: Interrupt specifier for the USB3.0 Peripheral
> > +  - clocks: A list of phandle + clock specifier pairs
> 
> The clock specifier contains the phandle, please rephrase the last line

I will revise it as the following:
 - clocks: clock phandle and specifier pair

> > diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
> > new file mode 100644
> > index 0000000..f302c89
> > --- /dev/null
> > +++ b/drivers/usb/gadget/udc/renesas_usb3.c
< snip >
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/slab.h>
> > +#include <linux/usb/ch9.h>
> > +#include <linux/usb/gadget.h>
> 
> As the 0-say bot found, this needs #include <linux/sizes.h>

Thank you for the detail. I will add it here.

> > +static int renesas_usb3_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
> > +				 gfp_t gfp_flags);
> > +static void usb3_start_pipen(struct renesas_usb3_ep *usb3_ep,
> > +			     struct renesas_usb3_request *usb3_req);
> 
> Can you try to reorder the functions so you don't need forward declarations?

Thank you for the point. I could reorder the functions.

> > +static void usb3_write(struct renesas_usb3 *usb3, u32 data, u32 offs)
> > +{
> > +	iowrite32(data, usb3->reg + offs);
> > +}
> > +
> > +static u32 usb3_read(struct renesas_usb3 *usb3, u32 offs)
> > +{
> > +	return ioread32(usb3->reg + offs);
> > +}
> 
> I think using readl() is more common than ioread32() if the driver cannot
> use IORESOURCE_IO but only IORESOURCE_MEM.
> 
> On ARM, the two are the same, but on some architectures ioread32 is more
> expensive, so using the former is preferred.

I will use {read,write}l() instead of io{read,write}32().
Also I will change io{read,write}32_rep() functions too.

> > +	for (i = 0; i < USB3_WAIT_NS; i++) {
> > +		if ((usb3_read(usb3, reg) & mask) = expected)
> > +			return 0;
> > +		ndelay(1);
> > +	}
> 
> ndelay(1) is unusual, maybe use cpu_relax() instead, or document why
> you call ndelay()?

Thank you for the point. udelay(1) is enough in this function.
So, I will fix it.

> > +static void usb3_init_phy(struct renesas_usb3 *usb3)
> > +{
> > +}
> 
> If the function is empty, don't add or call it, it's easy to add if you
> need it later.

Thank you for the point. I will remove it.

> > +static struct platform_driver renesas_usb3_driver = {
> > +	.remove =	__exit_p(renesas_usb3_remove),
> > +	.driver		= {
> > +		.name =	(char *)udc_name,
> > +		.of_match_table = of_match_ptr(usb3_of_match),
> > +	},
> > +};
> > +module_platform_driver_probe(renesas_usb3_driver, renesas_usb3_probe);
> 
> module_platform_driver_probe() won't work if you get into deferred probing,
> I'd suggest using module_platform_driver() and not marking the remove
> function as __exit

Thank you for your suggestion. I will use module_platform_driver().

> > +struct renesas_usb3;
> > +struct renesas_usb3_request {
> > +	struct usb_request	req;
> > +	struct list_head	queue;
> > +};
> 
> There is already a list_head in struct usb_request. Could you use that?
> (I don't know, just asking because this looks odd)

The list_head in strcut usb_request is used by a gadget driver (drivers/usb/gadget/function/*.c).
So, a udc driver (e.g. drivers/usb/gadget/udc/*.c) cannot use it.

> > +#define USB3_EP_NAME_SIZE	8
> > +struct renesas_usb3_ep {
> > +	struct usb_ep ep;
> > +	struct renesas_usb3 *usb3;
> > +	int num;
> > +	char ep_name[USB3_EP_NAME_SIZE];
> > +	struct list_head queue;
> > +	u32 rammap_val;
> > +	bool dir_in;
> > +	bool halt;
> > +	bool wedge;
> > +	bool started;
> > +};
> > +
> > +struct renesas_usb3_priv {
> > +	int ramsize_per_ramif;		/* unit = bytes */
> > +	int num_ramif;
> > +	int ramsize_per_pipe;		/* unit = bytes */
> > +	unsigned workaround_for_vbus:1;	/* if 1, don't check vbus signal */
> > +};
> 
> You use 'bool' in one structure, and bit fields in the other.
> Maybe pick one of the two styles consistently.

Thank you for the point. I will use "bool" consistently.

Best regards,
Yoshihiro Shimoda

> 	Arnd

