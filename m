From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Mon, 07 Feb 2011 08:08:32 +0000
Subject: Re: [RFC,PATCH 1/3] Add a common struct clk
Message-Id: <20110207080832.GD27982@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800158.458894385837.1.gpush@pororo>
In-Reply-To: <1297058877.800158.458894385837.1.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, Feb 07, 2011 at 02:07:57PM +0800, Jeremy Kerr wrote:
> We currently have ~21 definitions of struct clk in the ARM architecture,
> each defined on a per-platform basis. This makes it difficult to define
> platform- (or architecture-) independent clock sources without making
> assumptions about struct clk, and impossible to compile two
> platforms with different struct clks into a single image.
>=20
> This change is an effort to unify struct clk where possible, by defining
> a common struct clk, containing a set of clock operations. Different
> clock implementations can set their own operations, and have a standard
> interface for generic code. The callback interface is exposed to the
> kernel proper, while the clock implementations only need to be seen by
> the platform internals.
>=20
> This allows us to share clock code among platforms, and makes it
> possible to dynamically create clock devices in platform-independent
> code.
>=20
> Platforms can enable the generic struct clock through
> CONFIG_USE_COMMON_STRUCT_CLK. In this case, the clock infrastructure
> consists of a common struct clk:
>=20
> struct clk {
> 	const struct clk_ops	*ops;
> 	unsigned int		enable_count;
> 	unsigned int		prepare_count;
> 	spinlock_t		enable_lock;
> 	struct mutex		prepare_lock;
> };
>=20
> And a set of clock operations (defined per type of clock):
>=20
> struct clk_ops {
> 	int             (*enable)(struct clk *);
> 	void            (*disable)(struct clk *);
> 	unsigned long   (*get_rate)(struct clk *);
> 	[...]
> };
>=20
> To define a hardware-specific clock, machine code can "subclass" the
> struct clock into a new struct (adding any device-specific data), and
> provide a set of operations:
>=20
> struct clk_foo {
> 	struct clk	clk;
> 	void __iomem	*some_register;
> };
>=20
> struct clk_ops clk_foo_ops =3D {
> 	.get_rate =3D clk_foo_get_rate,
> };
>=20
> The common clock definitions are based on a development patch from Ben
> Herrenschmidt <benh@kernel.crashing.org>.
>=20
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
>=20
> ---
>  drivers/clk/Kconfig  |    3=20
>  drivers/clk/Makefile |    1=20
>  drivers/clk/clk.c    |  134 +++++++++++++++++++++++++++++++
>  drivers/clk/clkdev.c |    5 +
>  include/linux/clk.h  |  184 ++++++++++++++++++++++++++++++++++++++++---
>  5 files changed, 318 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 4168c88..6e3ae54 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -2,3 +2,6 @@
>  config CLKDEV_LOOKUP
>  	bool
>  	select HAVE_CLK
> +
> +config USE_COMMON_STRUCT_CLK
> +	bool
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 07613fa..a1a06d3 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -1,2 +1,3 @@
> =20
>  obj-$(CONFIG_CLKDEV_LOOKUP)	+=3D clkdev.o
> +obj-$(CONFIG_USE_COMMON_STRUCT_CLK) +=3D clk.o
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> new file mode 100644
> index 0000000..12e0daf
> --- /dev/null
> +++ b/drivers/clk/clk.c
> @@ -0,0 +1,134 @@
> +/*
> + * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Standard functionality for the common clock API.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +
> +int clk_prepare(struct clk *clk)
> +{
> +	int ret =3D 0;
> +
> +	if (!clk->ops->prepare)
> +		return 0;
> +
> +	mutex_lock(&clk->prepare_lock);
> +	if (clk->prepare_count =3D 0)
> +		ret =3D clk->ops->prepare(clk);
> +
> +	if (!ret)
> +		clk->prepare_count++;
> +	mutex_unlock(&clk->prepare_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(clk_prepare);
> +
> +void clk_unprepare(struct clk *clk)
> +{
> +	if (!clk->ops->unprepare)
> +		return;
> +
> +	mutex_lock(&clk->prepare_lock);
> +	if (--clk->prepare_count =3D 0)
> +		clk->ops->unprepare(clk);
> +
> +	mutex_unlock(&clk->prepare_lock);
> +}
> +EXPORT_SYMBOL_GPL(clk_unprepare);
> +
> +int clk_enable(struct clk *clk)
> +{
> +	int ret =3D 0;
> +
> +	if (!clk->ops->enable)
> +		return 0;
> +
> +	spin_lock(&clk->enable_lock);
> +	if (!clk->enable_count)
> +		ret =3D clk->ops->enable(clk);
> +
> +	if (!ret)
> +		clk->enable_count++;
> +	spin_unlock(&clk->enable_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(clk_enable);
> +
> +void clk_disable(struct clk *clk)
> +{
> +	if (!clk->ops->disable)
> +		return;
> +
> +	spin_lock(&clk->enable_lock);
> +
> +	WARN_ON(!clk->enable_count);
> +
> +	if (!--clk->enable_count)
> +		clk->ops->disable(clk);
> +
> +	spin_unlock(&clk->enable_lock);
> +}
> +EXPORT_SYMBOL_GPL(clk_disable);
> +
> +unsigned long clk_get_rate(struct clk *clk)
> +{
> +	if (clk->ops->get_rate)
> +		return clk->ops->get_rate(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(clk_get_rate);
> +
> +int __clk_get(struct clk *clk)
> +{
> +	if (clk->ops->get)
> +		return clk->ops->get(clk);
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(__clk_get);
> +
> +void clk_put(struct clk *clk)
> +{
> +	if (clk->ops->put)
> +		clk->ops->put(clk);
> +}
> +EXPORT_SYMBOL_GPL(clk_put);
> +
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	if (clk->ops->round_rate)
> +		return clk->ops->round_rate(clk, rate);
> +	return -ENOSYS;
> +}
> +EXPORT_SYMBOL_GPL(clk_round_rate);
> +
> +int clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	if (clk->ops->set_rate)
> +		return clk->ops->set_rate(clk, rate);
> +	return -ENOSYS;
> +}
> +EXPORT_SYMBOL_GPL(clk_set_rate);
> +
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	if (clk->ops->set_parent)
> +		return clk->ops->set_parent(clk, parent);
> +	return -ENOSYS;
> +}
> +EXPORT_SYMBOL_GPL(clk_set_parent);
> +
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	if (clk->ops->get_parent)
> +		return clk->ops->get_parent(clk);
> +	return ERR_PTR(-ENOSYS);
> +}
> +EXPORT_SYMBOL_GPL(clk_get_parent);
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 0fc0a79..17619c7 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -84,12 +84,17 @@ struct clk *clk_get(struct device *dev, const char *c=
on_id)
>  }
>  EXPORT_SYMBOL(clk_get);
> =20
> +#ifndef CONFIG_USE_COMMON_STRUCT_CLK
> +/* For the common struct clk case, clk_put is provided by clk.c */
> +
>  void clk_put(struct clk *clk)
>  {
>  	__clk_put(clk);
>  }
>  EXPORT_SYMBOL(clk_put);
> =20
> +#endif
> +
>  void clkdev_add(struct clk_lookup *cl)
>  {
>  	mutex_lock(&clocks_mutex);
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 1d37f42..e081ca1 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -3,6 +3,7 @@
>   *
>   *  Copyright (C) 2004 ARM Limited.
>   *  Written by Deep Blue Solutions Limited.
> + *  Copyright (c) 2010-2011 Jeremy Kerr <jeremy.kerr@canonical.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -11,18 +12,189 @@
>  #ifndef __LINUX_CLK_H
>  #define __LINUX_CLK_H
> =20
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +
>  struct device;
> =20
> -/*
> - * The base API.
> +#ifdef CONFIG_USE_COMMON_STRUCT_CLK
> +
> +/* If we're using the common struct clk, we define the base clk object h=
ere */
> +
> +/**
> + * struct clk - hardware independent clock structure
> + * @ops:		implementation-specific ops for this clock
> + * @enable_count:	count of clk_enable() calls active on this clock
> + * @flags:		platform-independent flags
> + * @lock:		lock for enable/disable or other HW-specific ops
> + *
> + * The base clock object, used by drivers for hardware-independent manip=
ulation
> + * of clock lines. This will be 'subclassed' by device-specific implemen=
tations,
> + * which add device-specific data to struct clk. For example:
> + *
> + *  struct clk_foo {
> + *      struct clk;
> + *      [device specific fields]
> + *  };
> + *
> + * The clock driver code will manage the device-specific data, and pass
> + * clk_foo.clk to the common clock code. The clock driver will be called
> + * through the @ops callbacks.
> + *
> + * The @lock member provides either a spinlock or a mutex to protect (at=
 least)
> + * @enable_count. The type of lock used will depend on @flags; if CLK_AT=
OMIC is
> + * set, then the core clock code will use a spinlock, otherwise a mutex.=
 This
> + * lock will be acquired during clk_enable and clk_disable, so for atomic
> + * clocks, these ops callbacks must not sleep.
> + *
> + * The choice of atomic or non-atomic clock depends on how the clock is =
enabled.
> + * Typically, you'll want to use a non-atomic clock. For clocks that nee=
d to be
> + * enabled/disabled in interrupt context, use CLK_ATOMIC. Note that atom=
ic
> + * clocks with parents will typically cascade enable/disable operations =
to
> + * their parent, so the parent of an atomic clock *must* be atomic too.
>   */
This comment needs a general overhaul.

(I had this comment already in my first mail, but I must have deleted it
when removing the unrealted quotes.)

> +struct clk {
> +	const struct clk_ops	*ops;
> +	unsigned int		enable_count;
> +	unsigned int		prepare_count;
> +	spinlock_t		enable_lock;
> +	struct mutex		prepare_lock;
> +};

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
