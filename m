From: Colin Cross <ccross@google.com>
Date: Mon, 23 May 2011 23:55:15 +0000
Subject: Re: [PATCH 1/4] clk: Add a generic clock infrastructure
Message-Id: <BANLkTin2Ho-Ce-4RurtHfAST7hqTLDrJ+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<1305876469.326305.518470530485.1.gpush@pororo>
In-Reply-To: <1305876469.326305.518470530485.1.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, May 20, 2011 at 12:27 AM, Jeremy Kerr <jeremy.kerr@canonical.com> w=
rote:
> We currently have ~21 definitions of struct clk in the ARM architecture,
> each defined on a per-platform basis. This makes it difficult to define
> platform- (or architecture-) independent clock sources without making
> assumptions about struct clk, and impossible to compile two
> platforms with different struct clks into a single image.
>
> This change is an effort to unify struct clk where possible, by defining
> a common struct clk, and a set of clock operations. Different clock
> implementations can set their own operations, and have a standard
> interface for generic code. The callback interface is exposed to the
> kernel proper, while the clock implementations only need to be seen by
> the platform internals.
>
> The interface is split into two halves:
>
> =A0* struct clk, which is the generic-device-driver interface. This
> =A0 provides a set of functions which drivers may use to request
> =A0 enable/disable, query or manipulate in a hardware-independent manner.
>
> =A0* struct clk_hw and struct clk_hw_ops, which is the hardware-specific
> =A0 interface. Clock drivers implement the ops, which allow the core
> =A0 clock code to implement the generic 'struct clk' API.
>
> This allows us to share clock code among platforms, and makes it
> possible to dynamically create clock devices in platform-independent
> code.
>
> Platforms can enable the generic struct clock through
> CONFIG_GENERIC_CLK. In this case, the clock infrastructure consists of a
> common, opaque struct clk, and a set of clock operations (defined per
> type of clock):
>
> =A0struct clk_hw_ops {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*prepare)(struct clk_hw *);
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0(*unprepare)(struct clk_hw *);
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*enable)(struct clk_hw *);
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0(*disable)(struct clk_hw *);
> =A0 =A0 =A0 =A0unsigned long =A0 (*recalc_rate)(struct clk_hw *);
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*set_rate)(struct clk_hw *,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0unsigned long, unsigned long *);
> =A0 =A0 =A0 =A0long =A0 =A0 =A0 =A0 =A0 =A0(*round_rate)(struct clk_hw *,=
 unsigned long);
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*set_parent)(struct clk_hw *,=
 struct clk *);
> =A0 =A0 =A0 =A0struct clk * =A0 =A0(*get_parent)(struct clk_hw *);
> =A0};

You might want to split these into three separate structs, for mux
ops, rate ops, and gate ops.  That way, multiple building blocks (a
gate and a divider, for example), can be easily combined into a single
clock node.  Also, an init op that reads the clock tree state from the
hardware has been very useful on Tegra - there are often clocks that
you can't or won't change, and being able to view their state as
configured by the bootloader, and base other clocks off of them, is
helpful.  It also allows you to turn off clocks that are enabled by
the bootloader, but never enabled by the kernel (enabled=3D1,
enable_count=3D0).

Also, OMAP currently has a second level of global ops that are called
before the per-clk ops, which handle the common parts of clock enable
(the "clockdomains" part), which I modeled as each clk having a
clk_chip, and the clk_chip having some ops.  It does add a lot of
complexity to the error handling, and OMAP doesn't have very many op
implementations, so unless other architectures need it, I don't see a
problem pushing those down into each op implementation.

> Platform clock code can register a clock through clk_register, passing a
> set of operations, and a pointer to hardware-specific data:
>
> =A0struct clk_hw_foo {
> =A0 =A0 =A0 =A0struct clk_hw clk;
> =A0 =A0 =A0 =A0void __iomem *enable_reg;
> =A0};
>
> =A0#define to_clk_foo(c) offsetof(c, clk_hw_foo, clk)
>
> =A0static int clk_foo_enable(struct clk_hw *clk)
> =A0{
> =A0 =A0 =A0 =A0struct clk_foo *foo =3D to_clk_foo(clk);
> =A0 =A0 =A0 =A0raw_writeb(foo->enable_reg, 1);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0struct clk_hw_ops clk_foo_ops =3D {
> =A0 =A0 =A0 =A0.enable =3D clk_foo_enable,
> =A0};
>
> And in the platform initialisation code:
>
> =A0struct clk_foo my_clk_foo;
>
> =A0void init_clocks(void)
> =A0{
> =A0 =A0 =A0 =A0my_clk_foo.enable_reg =3D ioremap(...);
>
> =A0 =A0 =A0 =A0clk_register(&clk_foo_ops, &my_clk_foo, NULL);
> =A0}
>
> Changes from Thomas Gleixner <tglx@linutronix.de>.
>
> The common clock definitions are based on a development patch from Ben
> Herrenschmidt <benh@kernel.crashing.org>.
>
> TODO:
>
> =A0* We don't keep any internal reference to the clock topology at presen=
t.
>
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> ---
> =A0drivers/clk/Kconfig =A0| =A0 =A03
> =A0drivers/clk/Makefile | =A0 =A01
> =A0drivers/clk/clk.c =A0 =A0| =A0229 ++++++++++++++++++++++++++++++++++++=
+++++++
> =A0drivers/clk/clkdev.c | =A0 =A07 +
> =A0include/linux/clk.h =A0| =A0102 +++++++++++++++++--
> =A05 files changed, 332 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 4168c88..e611e34 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -2,3 +2,6 @@
> =A0config CLKDEV_LOOKUP
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0select HAVE_CLK
> +
> +config GENERIC_CLK
> + =A0 =A0 =A0 bool
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 07613fa..570d5b9 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -1,2 +1,3 @@
>
> =A0obj-$(CONFIG_CLKDEV_LOOKUP) =A0 =A0+=3D clkdev.o
> +obj-$(CONFIG_GENERIC_CLK) =A0 =A0 =A0+=3D clk.o
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> new file mode 100644
> index 0000000..ad90a90
> --- /dev/null
> +++ b/drivers/clk/clk.c
> @@ -0,0 +1,229 @@
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
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +struct clk {
> + =A0 =A0 =A0 const char =A0 =A0 =A0 =A0 =A0 =A0 =A0*name;
> + =A0 =A0 =A0 struct clk_hw_ops =A0 =A0 =A0 *ops;
> + =A0 =A0 =A0 struct clk_hw =A0 =A0 =A0 =A0 =A0 *hw;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0enable_count;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0prepare_count;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*parent;

Storing the list of possible parents at this level can help abstract
some common code from mux ops if you pass the index into the list of
the new parent into the op - most mux ops only need to know which of
their mux inputs needs to be enabled.

> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 rate;

If you add an init op, an enabled flag here is also useful to track
whether the bootloader left the clock on, which allows turning off
unnecessary clocks.

I think you also need a list of current children of the clock to allow
propagating rate changes from parent to children.

> +};
> +
> +static DEFINE_SPINLOCK(enable_lock);
> +static DEFINE_MUTEX(prepare_lock);

There was some discussion earlier of per-tree locking instead of
global locking.  I have a clock tree that does per-tree locking, as
well as runtime addition of clocks to the tree (for example, a codec
chip that is complex enough to treat the internal clocks using the clk
api, but fed off a clock output from the main SoC), but it adds a ton
of complexity to the locking.

> +
> +static void __clk_unprepare(struct clk *clk)
> +{
> + =A0 =A0 =A0 if (!clk)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (WARN_ON(clk->prepare_count =3D 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (--clk->prepare_count > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 WARN_ON(clk->enable_count > 0);
> +
> + =A0 =A0 =A0 if (clk->ops->unprepare)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->ops->unprepare(clk->hw);
> +
> + =A0 =A0 =A0 __clk_unprepare(clk->parent);
> +}
Are there any cases where the unlocked versions of the clk calls need
to be exposed to the ops implementations?  For example, a set_rate op
may want to call clk_set_parent on itself to change its parent to a
better source, and then set its rate.  It would need to call
__clk_set_parent to avoid deadlocking on the prepare_lock.

> +void clk_unprepare(struct clk *clk)
> +{
> + =A0 =A0 =A0 mutex_lock(&prepare_lock);
> + =A0 =A0 =A0 __clk_unprepare(clk);
> + =A0 =A0 =A0 mutex_unlock(&prepare_lock);
> +}
> +EXPORT_SYMBOL_GPL(clk_unprepare);
> +
> +static int __clk_prepare(struct clk *clk)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!clk)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (clk->prepare_count =3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __clk_prepare(clk->parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (clk->ops->prepare) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk->ops->prepare(c=
lk->hw);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clk_unpre=
pare(clk->parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clk->prepare_count++;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int clk_prepare(struct clk *clk)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 mutex_lock(&prepare_lock);
> + =A0 =A0 =A0 ret =3D __clk_prepare(clk);
> + =A0 =A0 =A0 mutex_unlock(&prepare_lock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL_GPL(clk_prepare);
> +
> +static void __clk_disable(struct clk *clk)
> +{
> + =A0 =A0 =A0 if (!clk)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (WARN_ON(clk->enable_count =3D 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (--clk->enable_count > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (clk->ops->disable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->ops->disable(clk->hw);
> + =A0 =A0 =A0 __clk_disable(clk->parent);
> +}
> +
> +void clk_disable(struct clk *clk)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&enable_lock, flags);
> + =A0 =A0 =A0 __clk_disable(clk);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&enable_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(clk_disable);
> +
> +static int __clk_enable(struct clk *clk)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (!clk)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (WARN_ON(clk->prepare_count =3D 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ESHUTDOWN;
> +
> +
> + =A0 =A0 =A0 if (clk->enable_count =3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __clk_enable(clk->parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (clk->ops->enable) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk->ops->enable(cl=
k->hw);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clk_disab=
le(clk->parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clk->enable_count++;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int clk_enable(struct clk *clk)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&enable_lock, flags);
> + =A0 =A0 =A0 ret =3D __clk_enable(clk);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&enable_lock, flags);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL_GPL(clk_enable);
> +
> +unsigned long clk_get_rate(struct clk *clk)
> +{
> + =A0 =A0 =A0 if (!clk)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return clk->rate;
> +}
> +EXPORT_SYMBOL_GPL(clk_get_rate);
> +
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> + =A0 =A0 =A0 if (clk && clk->ops->round_rate)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return clk->ops->round_rate(clk->hw, rate);
> + =A0 =A0 =A0 return rate;
> +}
> +EXPORT_SYMBOL_GPL(clk_round_rate);

I think you should hold the prepare mutex around calls to
clk_round_rate, which will allow some code simplification similar to
what Russell suggested in another thread.  If you hold the mutex here,
as well as in clk_set_rate, and you call the round_rate op before the
set_rate op in clk_set_rate, op implementers can compute the rate in
their round_rate op, and save the register values needed to get that
rate in private temporary storage.  The set_rate op can then assume
that those register values are correct, because the lock is still
held, and just write them.  That moves all the computation to one
place, and it only needs to run once.

> +int clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> + =A0 =A0 =A0 /* not yet implemented */
> + =A0 =A0 =A0 return -ENOSYS;
> +}
> +EXPORT_SYMBOL_GPL(clk_set_rate);

Here's my implementation, slightly modified and untested to work with
your variable names (sorry if whitespace gets mangled):

/*
 * called on a clock when it or any of its ancestors change parents or rates
 * must be called with prepare_lock held
 */
static void _propagate_rate(struct clk *clk)
{
	struct clk *child;

	if (clk->ops->recalc_rate)
		clk->rate =3D clk->ops->recalc_rate(clk);
	else if (clk->parent)
		clk->rate =3D clk->parent->rate;

	list_for_each_entry(child, &clk->children, parent_node)
		_propagate_rate(child);
}

long __clk_round_rate(struct clk *clk, unsigned long rate)
{
	if (clk->ops->round_rate)
		return clk->ops->round_rate(clk, rate);

	return clk->rate;
}

int __clk_set_rate(struct clk *clk, unsigned long rate)
{
	long new_rate;
	int ret;

	if (!clk->ops->set_rate)
		return -ENOSYS;

	new_rate =3D __clk_round_rate(clk, rate);
	if (new_rate < 0)
		return new_rate;

	ret =3D clk->ops->set_rate(clk, new_rate);
	if (ret)
		return ret;

	clk->rate =3D new_rate;

	_propagate_rate(clk);

	return 0;
}

int clk_set_rate(struct clk *clk, unsigned long rate)
{
	int ret;

	mutex_lock(&prepare_lock);

	ret =3D __clk_set_rate(clk, rate);

	mutex_unlock(prepare_lock);

	return ret;
}


> +struct clk *clk_get_parent(struct clk *clk)
> +{
> + =A0 =A0 =A0 if (!clk)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 return clk->parent;
> +}
> +EXPORT_SYMBOL_GPL(clk_get_parent);
> +
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> + =A0 =A0 =A0 /* not yet implemented */
> + =A0 =A0 =A0 return -ENOSYS;
> +}
> +EXPORT_SYMBOL_GPL(clk_set_parent);
> +
> +struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *name)
> +{
> + =A0 =A0 =A0 struct clk *clk;
> +
> + =A0 =A0 =A0 clk =3D kzalloc(sizeof(*clk), GFP_KERNEL);
> + =A0 =A0 =A0 if (!clk)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 clk->name =3D name;
> + =A0 =A0 =A0 clk->ops =3D ops;
> + =A0 =A0 =A0 clk->hw =3D hw;
> + =A0 =A0 =A0 hw->clk =3D clk;
> +
> + =A0 =A0 =A0 /* Query the hardware for parent and initial rate */
> +
> + =A0 =A0 =A0 if (clk->ops->get_parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We don't to lock against prepare/enable =
here, as
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the clock is not yet accessible from a=
nywhere */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->parent =3D clk->ops->get_parent(clk->h=
w);
> +
> + =A0 =A0 =A0 if (clk->ops->recalc_rate)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->rate =3D clk->ops->recalc_rate(clk->hw=
);
> +
> +
> + =A0 =A0 =A0 return clk;
> +}
> +EXPORT_SYMBOL_GPL(clk_register);

If you are requiring clk's parents (or possible parents?) to be
registered before clk, you could put the clk_lookup struct inside the
clk struct and call clkdev_add from clk_register, saving some
boilerplate in the platforms.

> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 6db161f..e2a9719 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -23,6 +23,13 @@
> =A0static LIST_HEAD(clocks);
> =A0static DEFINE_MUTEX(clocks_mutex);
>
> +/* For USE_COMMON_STRUCT_CLK, these are provided in clk.c, but not expor=
ted
> + * through other headers; we don't want them used anywhere but here. */
> +#ifdef CONFIG_USE_COMMON_STRUCT_CLK
> +extern int __clk_get(struct clk *clk);
> +extern void __clk_put(struct clk *clk);
> +#endif
> +
> =A0/*
> =A0* Find the correct struct clk for the device and connection ID.
> =A0* We do slightly fuzzy matching here:
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 1d37f42..93ff870 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -3,6 +3,7 @@
> =A0*
> =A0* =A0Copyright (C) 2004 ARM Limited.
> =A0* =A0Written by Deep Blue Solutions Limited.
> + * =A0Copyright (c) 2010-2011 Jeremy Kerr <jeremy.kerr@canonical.com>
> =A0*
> =A0* This program is free software; you can redistribute it and/or modify
> =A0* it under the terms of the GNU General Public License version 2 as
> @@ -11,17 +12,103 @@
> =A0#ifndef __LINUX_CLK_H
> =A0#define __LINUX_CLK_H
>
> +#include <linux/err.h>
> +#include <linux/spinlock.h>
> +
> =A0struct device;
>
> -/*
> - * The base API.
> +struct clk;
> +
> +#ifdef CONFIG_GENERIC_CLK
> +
> +struct clk_hw {
> + =A0 =A0 =A0 struct clk *clk;
> +};
> +
> +/**
> + * struct clk_hw_ops - =A0Callback operations for hardware clocks; these=
 are to
> + * be provided by the clock implementation, and will be called by drivers
> + * through the clk_* API.
> + *
> + * @prepare: =A0 Prepare the clock for enabling. This must not return un=
til
> + * =A0 =A0 =A0 =A0 =A0 =A0 the clock is fully prepared, and it's safe to=
 call clk_enable.
> + * =A0 =A0 =A0 =A0 =A0 =A0 This callback is intended to allow clock impl=
ementations to
> + * =A0 =A0 =A0 =A0 =A0 =A0 do any initialisation that may sleep. Called =
with
> + * =A0 =A0 =A0 =A0 =A0 =A0 prepare_lock held.
> + *
> + * @unprepare: Release the clock from its prepared state. This will typi=
cally
> + * =A0 =A0 =A0 =A0 =A0 =A0 undo any work done in the @prepare callback. =
Called with
> + * =A0 =A0 =A0 =A0 =A0 =A0 prepare_lock held.
> + *
> + * @enable: =A0 =A0Enable the clock atomically. This must not return unt=
il the
> + * =A0 =A0 =A0 =A0 =A0 =A0 clock is generating a valid clock signal, usa=
ble by consumer
> + * =A0 =A0 =A0 =A0 =A0 =A0 devices. Called with enable_lock held. This f=
unction must not
> + * =A0 =A0 =A0 =A0 =A0 =A0 sleep.
> + *
> + * @disable: =A0 Disable the clock atomically. Called with enable_lock h=
eld.
> + * =A0 =A0 =A0 =A0 =A0 =A0 This function must not sleep.
> + *
> + * @recalc_rate =A0 =A0 =A0 =A0Recalculate the rate of this clock, by qu=
ering hardware
> + * =A0 =A0 =A0 =A0 =A0 =A0 and/or the clock's parent. Called with the gl=
obal clock mutex
> + * =A0 =A0 =A0 =A0 =A0 =A0 held. Optional, but recommended - if this op =
is not set,
> + * =A0 =A0 =A0 =A0 =A0 =A0 clk_get_rate will return 0.
You need a callback to update the rate when the parent or parent's
rate changes, which I would call recalc_rate, as well as this
init-type call.

> + *
> + * @get_parent Query the parent of this clock; for clocks with multiple
> + * =A0 =A0 =A0 =A0 =A0 =A0 possible parents, query the hardware for the =
current
> + * =A0 =A0 =A0 =A0 =A0 =A0 parent. Currently only called when the clock =
is first
> + * =A0 =A0 =A0 =A0 =A0 =A0 registered.
> + *
> + * The clk_enable/clk_disable and clk_prepare/clk_unprepare pairs allow
> + * implementations to split any work between atomic (enable) and sleepab=
le
> + * (prepare) contexts. =A0If a clock requires sleeping code to be turned=
 on, this
> + * should be done in clk_prepare. Switching that will not sleep should b=
e done
> + * in clk_enable.
> + *
> + * Typically, drivers will call clk_prepare when a clock may be needed l=
ater
> + * (eg. when a device is opened), and clk_enable when the clock is actua=
lly
> + * required (eg. from an interrupt). Note that clk_prepare *must* have b=
een
> + * called before clk_enable.
> + */
> +struct clk_hw_ops {
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*prepare)(struct clk_hw *);
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*unprepare)(struct clk_hw *);
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*enable)(struct clk_hw *);
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*disable)(struct clk_hw *);
> + =A0 =A0 =A0 unsigned long =A0 (*recalc_rate)(struct clk_hw *);
> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0(*round_rate)(struct clk_hw *, =
unsigned long);
> + =A0 =A0 =A0 struct clk * =A0 =A0(*get_parent)(struct clk_hw *);
> +};
> +
> +/**
> + * clk_prepare - prepare clock for atomic enabling.
> + *
> + * @clk: The clock to prepare
> + *
> + * Do any possibly sleeping initialisation on @clk, allowing the clock t=
o be
> + * later enabled atomically (via clk_enable). This function may sleep.
> =A0*/
> +int clk_prepare(struct clk *clk);
>
> +/**
> + * clk_unprepare - release clock from prepared state
> + *
> + * @clk: The clock to release
> + *
> + * Do any (possibly sleeping) cleanup on clk. This function may sleep.
> + */
> +void clk_unprepare(struct clk *clk);
> +
> +#else /* !CONFIG_GENERIC_CLK */
>
> =A0/*
> - * struct clk - an machine class defined object / cookie.
> + * For !CONFIG_GENERIC_CLK, we don't enforce any atomicity
> + * requirements for clk_enable/clk_disable, so the prepare and unprepare
> + * functions are no-ops
> =A0*/
> -struct clk;
> +static inline int clk_prepare(struct clk *clk) { return 0; }
> +static inline void clk_unprepare(struct clk *clk) { }
> +
> +#endif /* !CONFIG_GENERIC_CLK */
>
> =A0/**
> =A0* clk_get - lookup and obtain a reference to a clock producer.
> @@ -67,6 +154,7 @@ void clk_disable(struct clk *clk);
> =A0/**
> =A0* clk_get_rate - obtain the current clock rate (in Hz) for a clock sou=
rce.
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 This is only valid once the clock source=
 has been enabled.
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 Returns zero if the clock rate is unknown.
> =A0* @clk: clock source
> =A0*/
> =A0unsigned long clk_get_rate(struct clk *clk);
> @@ -83,12 +171,6 @@ unsigned long clk_get_rate(struct clk *clk);
> =A0*/
> =A0void clk_put(struct clk *clk);
>
> -
> -/*
> - * The remaining APIs are optional for machine class support.
> - */
> -
> -
> =A0/**
> =A0* clk_round_rate - adjust a rate to the exact rate a clock can provide
> =A0* @clk: clock source
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
