From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 Apr 2013 12:04:31 +0000
Subject: Re: [PATCH v3] irqchip: Add support for ARMv7-M's NVIC
Message-Id: <201304221404.31281.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130419150927.GE15233@pengutronix.de>
 <20130422100219.GH15233@pengutronix.de>
In-Reply-To: <20130422100219.GH15233@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Monday 22 April 2013, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> (for the new readers of this thread: This is about using
>=20
> 	u32 mask =3D 1 << (d->hwirq % 32);
>=20
> instead of
>=20
> 	u32 mask =3D 1 << (d->irq - gc->irq_base);

While not technically any different, I would suggest writing the above
as (d->hwirq & 0x1f), which makes it clear to the reader that this is
intended to be a cheap bit mask operation rather than an expensive
division.
>=20
> arch/arm/mach-s5p64x0/common.c
> 	-> uses irq_base=101 for irq_alloc_generic_chip

I think there are plans to replace this code with
drivers/pinctrl/pinctrl-samsung.c, but I don't know if patches
exist already.

> arch/arm/plat-orion/gpio.c
> 	-> depends on how orion_gpio_of_init is called. No callers
> 	found.

As of f9e7592230b, this code has been replaced with a pinctrl driver
and can be killed.

> arch/arm/plat-orion/irq.c
> arch/arm/plat-samsung/irq-vic-timer.c
> 	-> used for a single irq that isn't a multiple of 32

Tomasz Figa has a patch set to remove this file, will likely get merged
in 3.11.

> arch/arm/plat-samsung/s5p-irq-gpioint.c
> 	-> would need % 8?

AFAICT this code is the same driver as arch/arm/mach-s5p64x0/common.c
and will meet the same fate.

> arch/sh/boards/mach-se/7343/irq.c
> 	-> uses irq_base =3D irq_linear_revmap(se7343_irq_domain, 0) where
> 	se7343_irq_domain is a linear domain.
> 	AFAICT this is a bug. (After adding the domain they map all irqs
> 	in increasing order which currently seems to guarantee that it
> 	works. But IMHO it should use a legacy domain.)
>=20
> arch/sh/boards/mach-se/7722/irq.c
> 	as above.

Right. I think irq_domain_add_simple() is the right interface to use
here.

> For the uncommented files using %32 instead of -gc->irq_base should
> work.

I'm not sure I understand why this doesn't work for the ones that use
a base that isn't a multiple of 32. Since you are masking the hwirq
rather than the irq number, it will still be zero-based, won't it?

	Arnd
