From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Mon, 04 Feb 2008 08:57:37 +0000
Subject: Re: [PATCH] - Merger of companionchips HD64461 and HD64465 header
Message-Id: <20080204095737.cd2ffb9d.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080204031351.GA25862@linux-sh.org>
In-Reply-To: <20080204031351.GA25862@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 4 Feb 2008 12:13:51 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Wed, Jan 16, 2008 at 10:29:02PM -0800, Kristoffer Ericson wrote:
> > This is the header patch, I've already fixed the build errors in my
> > local tree, but need to apply to linux-sh tree.  I also removed the
> > io.h file since it really shouldn't be needed any longer. I got a
> > devboard with hd64465 companionchipset so I plan to get it up to shape
> > shortly, this is step one.
> > 
> > Just want quick feedback on the idea and how the patch looks. (should
> > io.h stay? Is the lcd functions hd6446x or hd64461 specific?)
> > 
> > Ive confirmed hp6xx booting as usual using these hd6446x defines (of
> > course changed in all effected files) in my local tree.
> > 
> There are a few things that need some thinking about with hd6446x.
> One of the main things is where exactly we need the information for the
> I/O base. It would be really nice if we could just rip out the hardcoded
> I/O base from the Kconfig and allow hp6xx and others to simply hand this
> off as a platform device. The only place we seem to need the I/O base
> early is for doing the PCMCIA memory aperture remapping (or more
> specifically, setting up the special PTE bits for this), but we can
> already do that from the setup code where we register the platform
> device, since we'll already know the I/O base at that time.
> 

I/O base is same for both hd64461/hd64465 so don't know why its even
set as an option. We could manage just as well with just the CONFIG_HD64461 or CONFIG_HD64465 setting.

The only driver using the include file to some major extent is the pcmcia driver agreed. The others, for instance
framebuffer driver uses it relativly little. And believe keyboard/touchscreen almost use none.

> > --- /dev/null
> > +++ b/include/asm-sh/hd64465_gpio.h
> > @@ -0,0 +1,46 @@
> > +#ifndef _ASM_SH_HD64465_GPIO_
> > +#define _ASM_SH_HD64465_GPIO_ 1
> > +/*
> > + * $Id: gpio.h,v 1.3 2003/05/04 19:30:14 lethal Exp $
> > + *
> > + * Hitachi HD64465 companion chip: General Purpose IO pins support.
> > + * This layer enables other device drivers to configure GPIO
> > + * pins, get and set their values, and register an interrupt
> > + * routine for when input pins change in hardware.
> > + *
> > + * by Greg Banks <gbanks@pocketpenguins.com>
> > + * (c) 2000 PocketPenguins Inc.
> > + */
> > +#include <asm/hd64465.h>
> > +
> > +/* Macro to construct a portpin number (used in all
> > + * subsequent functions) from a port letter and a pin
> > + * number, e.g. HD64465_GPIO_PORTPIN('A', 5).
> > + */
> > +#define HD64465_GPIO_PORTPIN(port,pin)	(((port)-'A')<<3|(pin))
> > +
> > +/* Pin configuration constants for _configure() */
> > +#define HD64465_GPIO_FUNCTION2	0	/* use the pin's *other* function */
> > +#define HD64465_GPIO_OUT	1	/* output */
> > +#define HD64465_GPIO_IN_PULLUP	2	/* input, pull-up MOS on */
> > +#define HD64465_GPIO_IN		3	/* input */
> > +
> > +/* Configure a pin's direction */
> > +extern void hd64465_gpio_configure(int portpin, int direction);
> > +
> > +/* Get, set value */
> > +extern void hd64465_gpio_set_pin(int portpin, unsigned int value);
> > +extern unsigned int hd64465_gpio_get_pin(int portpin);
> > +extern void hd64465_gpio_set_port(int port, unsigned int value);
> > +extern unsigned int hd64465_gpio_get_port(int port);
> > +
> > +/* mode constants for _register_irq() */
> > +#define HD64465_GPIO_FALLING	0
> > +#define HD64465_GPIO_RISING	1
> > +
> > +/* Interrupt on external value change */
> > +extern void hd64465_gpio_register_irq(int portpin, int mode,
> > +	void (*handler)(int portpin, void *dev), void *dev);
> > +extern void hd64465_gpio_unregister_irq(int portpin);
> > +
> > +#endif /* _ASM_SH_HD64465_GPIO_  */
> 
> It's really not worth dragging around this broken GPIO code. Obviously
> there's nothing in-tree that's making use of this, so I would just rip it
> out completely and add it back in under gpio-lib (currently in -mm, and
> queued for 2.6.25) if there's a real need for it.

Agreed.

> 
> > +/* System adresses */
> > +#define HD6446x_SRR		(CONFIG_HD6446x_IOBASE + 0x000c)
> > +#define HD6446x_SDID		(CONFIG_HD6446x_IOBASE + 0x0010)
> > +#define HD6446x_HD64465_SDID	0x8122						/* HD64465 device ID */
> > +
> Do not use lower case characters in CONFIG_ space. Also, hardcoding all
> of these CONFIG_XXX_IOBASE things all over the place is ultimately not
> helpful. You should have a proper mfd driver managing this device, and
> force the drivers to go through that in a centralized location.
> 

mfd seems the way to go then.


> You would basically be better off purging any mention of hd6446x (and
> h64461/h64465) from include/asm-sh and starting over by defining the bare
> essentials for what you need, and then building on top of that. This
> existing code has been around forever, and it's obviously not going to
> get cleaner any time soon without drastic measures.
> 

Agreed.


> > +/* arch/sh/cchips/hd6446x/hd64461/setup.c */
> > +int hd6446x_irq_demux(int irq);
> > +void hd6446x_register_irq_demux(int irq,
> > +				int (*demux) (int irq, void *dev), void *dev);
> > +void hd6446x_unregister_irq_demux(int irq);
> > +
> There doesn't seem to be any compelling need for this either. You can get
> away with IRQF_SHARED, or setting up a chained handler.
> 

Agreed.

> Also, all of the changes that this header depends on (ie. the Kconfig
> bits) are completely absent, so this patch would simply break the tree if
> it were applied.
> 

I have all Kconfig / Makefile changes ready to be sent off.

> In short, the hd6446x stuff is so hopelessly broken and bitrotted, you
> are better off spending some time rewriting it completely rather than
> trying to keep the existing support limping along. The drivers should
> generally be unaffected with the exception of how they get at their
> registers, but that's a fairly trivial fixup. You really want to start
> with a sane mfd driver before worrying about the rest of these
> trivialities.

I'll take that as a 'get working on sane mfd' message :) If its the next logical step to get this
sorted so be it.

Big thanks for feedback, include files are abit of grey area (what to keep/what to remove/what is needed/documentation...)

