From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Date: Wed, 21 May 2008 09:25:33 +0000
Subject: Re: [PATCH 00/03][RFC] Reusable UIO Platform Driver
Message-Id: <20080521092533.GB29607@digi.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080520105132.1474.73941.sendpatchset@rx1.opensource.se> <20080520210713.GE3220@local> <aec7e5c30805202031x62b3b463lfde0b9e7eb32d35@mail.gmail.com> <20080521064938.GA11580@digi.com> <aec7e5c30805210109p664fd917r32f8dc6aa1c4c746@mail.gmail.com>
In-Reply-To: <aec7e5c30805210109p664fd917r32f8dc6aa1c4c746@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "Hans J. Koch" <hjk@linutronix.de>, linux-kernel@vger.kernel.org, lethal@linux-sh.org, gregkh@suse.de, linux-sh@vger.kernel.org

Magnus Damm wrote:
> Hi Uwe!
>=20
> Thanks for your email.
>=20
> On Wed, May 21, 2008 at 3:49 PM, Uwe Kleine-K=F6nig
> <Uwe.Kleine-Koenig@digi.com> wrote:
> > Magnus Damm wrote:
> >> The uio_pdrv driver doesn't do what I need at this point, though I may
> >> be able to extend it with the following:
> >> - Interrupt enable/disable code
> >> - Physically contiguous memory support
> >>
> >> The interrupt code may be placed in the board/cpu code, but I need to
> >> share that code between multiple UIO driver instances. We want to use
> >> the same UIO driver for many different processor models and hardware
> >> blocks.
> > What about adding uio_platform_handler (with a different name) to
> > uio_pdrv.c?
>=20
> I'm not sure if it will help. What would such function do? Please explain.
Just add irq_disabled to struct uio_platdata and define

	irqreturn_t uio_pdrv_disirq(int irq, struct uio_info *dev_info)
	{
		struct uio_platdata *pdata =3D container_of(dev_info, struct uio_platdata=
, uio_info);

		disable_irq(irq);
		pdata->irq_disabled =3D 1;
		return IRQ_HANDLED;
	}
	EXPORT_SYMBOL(uio_pdrv_disirq);

	void uio_pdrv_enirq(struct uio_info *dev_info)
	{
		...
	}
	EXPORT_SYMBOL(uio_pdrv_enirq);

and then you can do

	info->handler =3D uio_pdrv_disirq;
	info->enable_irq =3D uio_pdrv_enirq;

in the arch specific code.  I just realize that you need to compile UIO
statically then :-(

IMHO something like prep_read_poll is a better name than enable_irq for
the new member of uio_info.

> > OTOH I don't see why you want to disable the irq.  Can you describe the
> > reason?
>=20
> Most UIO kernel drivers today contain hardware device specific code to
> acknowledge interrupts. In other words, most UIO interrupt handlers
> touches some device specific bits so the interrupt gets deasserted.
>=20
> My uio_platform driver handles interrupts in a different way. The
> kernel UIO driver is not aware of the hardware device specific method
> to acknowledge the interrupt, instead it simply disables the interrupt
> and notifies user space which instead will acknowledge the interrupt.
> Next time a read() or poll() call gets made, the interrupt is enabled
> again.
>=20
> This allows us to export a hardware device to user space and allow
> user space to handle interrupts without knowing in kernel space how to
> acknowledge interrupts.
OK, got it.  The down-side is that you can only get a single interrupt
between two calls to read() (or poll()).  So you might or might not
loose information.  And you might run into problems if your device or
your interrupt goes berserk as your handler always returns IRQ_HANDLED.
With a functional handler you can rely on existing mechanisms in the
kernel.
=20
> >> To be frank, I have my doubts in adding an extra forwarding-only
> >> platform layer on top of UIO compared to using uio_register_device()
> >> directly from the board code. I like that the platform layer is using
> >> struct resource and handles resource ranges for us automatically, but
> >> wouldn't it make more sense to extend the UIO core to always use
> >> struct resource instead of struct uio_mem? I'd be happy to help out -
> >> just point me in the right direction.
> > That alone doesn't help.  You need a struct device to register a uio
> > device.  So a platform device is the straight forward approach.
>=20
> I don't mind that you are using platform devices. Actually, I think
> platform devices are great. We use them for all sorts of things on the
> SuperH architecture. I'm trying to suggest that maybe it's a good idea
> to change the UIO core code to use struct resource instead of struct
> uio_mem. Or maybe that's not a good idea, I'm not sure.
struct resource alone doesn't provide enough information.  At least
memtype is needed.  And you don't need the pointers *parent, *sibling,
*child, so in my eyes it's fine to have a dedicated structure for uio.
=20
> >> >> The interrupt handling code in uio_platform assumes the device is t=
he
> >> >> only user of the assigned interrupt.
> >> >
> >> > Uwe's approach doesn't have this limitation.
> >>
> >> True, but the uio_pdrv driver is choosing to not deal with interrupts
> >> at all. I'd like to have shared interrupt handling code. With my
> >> driver, you just feed it io memory window parameters and an interrupt
> >> number and off you go. No need for any callbacks.
> > In my eyes this isn't completly correct.  Just the way you specify your
> > handler is a bit different.  You can pass a handler via platform data
> > with my driver, too.
>=20
> I don't want to pass any handler. All devices share the same interrupt
> handler, the only thing that differs between multiple uio_platform
> devices on one system is memory window information and irq number.
See above.  That would be the cost to share code with "my" driver.

All in all I'm not conviced that it's a good idea to use the irq_disable
trick to save acking in kernel space.  This doesn't need to stop you
doing it that way of course.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisach, =
Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962
