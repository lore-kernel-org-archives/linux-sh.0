From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Mon, 07 Feb 2011 07:09:18 +0000
Subject: Re: [RFC,PATCH 1/3] Add a common struct clk
Message-Id: <20110207070918.GB27982@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1297058877.800158.458894385837.1.gpush@pororo>
In-Reply-To: <1297058877.800158.458894385837.1.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, Feb 07, 2011 at 08:05:24AM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Feb 07, 2011 at 02:07:57PM +0800, Jeremy Kerr wrote:
> > We currently have ~21 definitions of struct clk in the ARM architecture,
> > each defined on a per-platform basis. This makes it difficult to define
> > platform- (or architecture-) independent clock sources without making
> > assumptions about struct clk, and impossible to compile two
> > platforms with different struct clks into a single image.
> >=20
> > This change is an effort to unify struct clk where possible, by defining
> > a common struct clk, containing a set of clock operations. Different
> > clock implementations can set their own operations, and have a standard
> > interface for generic code. The callback interface is exposed to the
> > kernel proper, while the clock implementations only need to be seen by
> > the platform internals.
> >=20
> > This allows us to share clock code among platforms, and makes it
> > possible to dynamically create clock devices in platform-independent
> > code.
> >=20
> > Platforms can enable the generic struct clock through
> > CONFIG_USE_COMMON_STRUCT_CLK. In this case, the clock infrastructure
> > consists of a common struct clk:
> >=20
> > struct clk {
> > 	const struct clk_ops	*ops;
> > 	unsigned int		enable_count;
> > 	unsigned int		prepare_count;
> > 	spinlock_t		enable_lock;
> > 	struct mutex		prepare_lock;
> > };
> >=20
> > And a set of clock operations (defined per type of clock):
> >=20
> > struct clk_ops {
> > 	int             (*enable)(struct clk *);
> > 	void            (*disable)(struct clk *);
> > 	unsigned long   (*get_rate)(struct clk *);
> > 	[...]
> > };
> >=20
> > To define a hardware-specific clock, machine code can "subclass" the
> > struct clock into a new struct (adding any device-specific data), and
> > provide a set of operations:
> >=20
> > struct clk_foo {
> > 	struct clk	clk;
> > 	void __iomem	*some_register;
> > };
> >=20
> > struct clk_ops clk_foo_ops =3D {
> > 	.get_rate =3D clk_foo_get_rate,
> > };
> >=20
> > The common clock definitions are based on a development patch from Ben
> > Herrenschmidt <benh@kernel.crashing.org>.
> >=20
> > Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> >=20
> > ---
> >  drivers/clk/Kconfig  |    3=20
> >  drivers/clk/Makefile |    1=20
> >  drivers/clk/clk.c    |  134 +++++++++++++++++++++++++++++++
> >  drivers/clk/clkdev.c |    5 +
> >  include/linux/clk.h  |  184 ++++++++++++++++++++++++++++++++++++++++---
> >  5 files changed, 318 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 4168c88..6e3ae54 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -2,3 +2,6 @@
> >  config CLKDEV_LOOKUP
> >  	bool
> >  	select HAVE_CLK
> > +
> > +config USE_COMMON_STRUCT_CLK
> > +	bool
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index 07613fa..a1a06d3 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -1,2 +1,3 @@
> > =20
> >  obj-$(CONFIG_CLKDEV_LOOKUP)	+=3D clkdev.o
> > +obj-$(CONFIG_USE_COMMON_STRUCT_CLK) +=3D clk.o
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > new file mode 100644
> > index 0000000..12e0daf
> > --- /dev/null
> > +++ b/drivers/clk/clk.c
> > @@ -0,0 +1,134 @@
> > +/*
> > + * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * Standard functionality for the common clock API.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> > +
> > +int clk_prepare(struct clk *clk)
> > +{
> > +	int ret =3D 0;
> > +
> > +	if (!clk->ops->prepare)
> > +		return 0;
> > +
> > +	mutex_lock(&clk->prepare_lock);
> > +	if (clk->prepare_count =3D 0)
> > +		ret =3D clk->ops->prepare(clk);
> > +
> > +	if (!ret)
> > +		clk->prepare_count++;
> > +	mutex_unlock(&clk->prepare_lock);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(clk_prepare);
> > +
> > +void clk_unprepare(struct clk *clk)
> > +{
> > +	if (!clk->ops->unprepare)
> > +		return;
> > +
> > +	mutex_lock(&clk->prepare_lock);
> > +	if (--clk->prepare_count =3D 0)
> > +		clk->ops->unprepare(clk);
> > +
> > +	mutex_unlock(&clk->prepare_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(clk_unprepare);
> > +
> > +int clk_enable(struct clk *clk)
> > +{
> > +	int ret =3D 0;
> > +
> Did we want to check for prepare_count > 0 here?  Russell's suggestion
> was to do that without holding any lock.
> (To make this a tad safer, you could use
> ACCESS_ONCE(clk->enable_count)++ below. (Suggested by paulmck on irc.))
s/enable_count/prepare_count/ of course.  And I saw I was to quick, you
added that check in patch 3.  Sorry

Uwe
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
