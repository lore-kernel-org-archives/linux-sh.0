From: Colin Cross <ccross@google.com>
Date: Tue, 24 May 2011 07:51:10 +0000
Subject: Re: [PATCH 1/4] clk: Add a generic clock infrastructure
Message-Id: <BANLkTinmRt_fv1oJwFuJQ34aAky_5SB4Rw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<1305876469.326305.518470530485.1.gpush@pororo>
	<BANLkTin2Ho-Ce-4RurtHfAST7hqTLDrJ+g@mail.gmail.com>
	<20110524070236.GB22096@pengutronix.de>
In-Reply-To: <20110524070236.GB22096@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, May 24, 2011 at 12:02 AM, Sascha Hauer <s.hauer@pengutronix.de> wro=
te:
> On Mon, May 23, 2011 at 04:55:15PM -0700, Colin Cross wrote:
>> On Fri, May 20, 2011 at 12:27 AM, Jeremy Kerr <jeremy.kerr@canonical.com=
> wrote:
>> > We currently have ~21 definitions of struct clk in the ARM architectur=
e,
>> > each defined on a per-platform basis. This makes it difficult to define
>> > platform- (or architecture-) independent clock sources without making
>> > assumptions about struct clk, and impossible to compile two
>> > platforms with different struct clks into a single image.
>> >
>> > This change is an effort to unify struct clk where possible, by defini=
ng
>> > a common struct clk, and a set of clock operations. Different clock
>> > implementations can set their own operations, and have a standard
>> > interface for generic code. The callback interface is exposed to the
>> > kernel proper, while the clock implementations only need to be seen by
>> > the platform internals.
>> >
>> > The interface is split into two halves:
>> >
>> > =A0* struct clk, which is the generic-device-driver interface. This
>> > =A0 provides a set of functions which drivers may use to request
>> > =A0 enable/disable, query or manipulate in a hardware-independent mann=
er.
>> >
>> > =A0* struct clk_hw and struct clk_hw_ops, which is the hardware-specif=
ic
>> > =A0 interface. Clock drivers implement the ops, which allow the core
>> > =A0 clock code to implement the generic 'struct clk' API.
>> >
>> > This allows us to share clock code among platforms, and makes it
>> > possible to dynamically create clock devices in platform-independent
>> > code.
>> >
>> > Platforms can enable the generic struct clock through
>> > CONFIG_GENERIC_CLK. In this case, the clock infrastructure consists of=
 a
>> > common, opaque struct clk, and a set of clock operations (defined per
>> > type of clock):
>> >
>> > =A0struct clk_hw_ops {
>> > =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*prepare)(struct clk_hw *);
>> > =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0(*unprepare)(struct clk_hw =
*);
>> > =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*enable)(struct clk_hw *);
>> > =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0(*disable)(struct clk_hw *);
>> > =A0 =A0 =A0 =A0unsigned long =A0 (*recalc_rate)(struct clk_hw *);
>> > =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*set_rate)(struct clk_hw *,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0unsigned long, unsigned long *);
>> > =A0 =A0 =A0 =A0long =A0 =A0 =A0 =A0 =A0 =A0(*round_rate)(struct clk_hw=
 *, unsigned long);
>> > =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*set_parent)(struct clk_hw=
 *, struct clk *);
>> > =A0 =A0 =A0 =A0struct clk * =A0 =A0(*get_parent)(struct clk_hw *);
>> > =A0};
>>
>> You might want to split these into three separate structs, for mux
>> ops, rate ops, and gate ops. =A0That way, multiple building blocks (a
>> gate and a divider, for example), can be easily combined into a single
>> clock node. =A0Also, an init op that reads the clock tree state from the
>> hardware has been very useful on Tegra - there are often clocks that
>> you can't or won't change, and being able to view their state as
>> configured by the bootloader, and base other clocks off of them, is
>> helpful.
>
> The clock state is read initially from the hardware with the
> recalc_rate/get_parent ops. What do we need an additional init op for?

I see - I would rename them to make it clear they are for init, maybe
init_rate and init_parent, and not call them later - reading clock
state can be very expensive on some platforms, if not impossible -
Qualcomm requires RPCs to the modem to get clock state.  If every
clk_set_rate triggers state reads all the way through the descendants,
that could be a huge performance hit.  If you separate init and
recalculate, mux implementations can store their divider settings and
very easily recalculate their rate.

>> It also allows you to turn off clocks that are enabled by
>> the bootloader, but never enabled by the kernel (enabled=3D1,
>> enable_count=3D0).
>
> The enable count indeed is a problem. I don't think an init hook
> would be the right solution for this though as this sounds platform
> specific. struct clk_hw_ops should be specific to the type of clock
> (mux, divider, gate) and should be present only once per type.
>
> For the enable count (and whether a clock should initially be enabled or
> not) I can think of something like this:
>
> - A platform/SoC registers all clocks.
> - It then calls clk_prepare/enable for all vital core clocks
> =A0(SDRAM, CPU,...). At this time the enable counters are correct.
> - Then some hook in the generic clock layer is called. This hook
> =A0iterates over the tree and disables all clocks in hardware which
> =A0have a enable count of 0.

Is it always safe to disable a clock that is already disabled?  An
init_enable hook that set an enabled flag would let you only disable
clocks that were actually left on by the bootloader, and report to the
user which ones are actually being turned off (which has caught a lot
of problems on Tegra).

>> > +
>> > +struct clk {
>> > + =A0 =A0 =A0 const char =A0 =A0 =A0 =A0 =A0 =A0 =A0*name;
>> > + =A0 =A0 =A0 struct clk_hw_ops =A0 =A0 =A0 *ops;
>> > + =A0 =A0 =A0 struct clk_hw =A0 =A0 =A0 =A0 =A0 *hw;
>> > + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0enable_count;
>> > + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0prepare_count;
>> > + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*parent;
>>
>> Storing the list of possible parents at this level can help abstract
>> some common code from mux ops if you pass the index into the list of
>> the new parent into the op - most mux ops only need to know which of
>> their mux inputs needs to be enabled.
>
> Please don't. Only muxes have more than one possible parent, so this
> should be handled there.

The cost is one pointer per clock that is not actually a mux, and the
benefit is that you can move a very common search loop out of every
mux implementation into the framework.  It also lets you determine
which clocks are connected, which becomes necessary if you try to do
per-tree locking or sysfs controls for clocks.

>>
>> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 rate;
>>
>> If you add an init op, an enabled flag here is also useful to track
>> whether the bootloader left the clock on, which allows turning off
>> unnecessary clocks.
>>
>> I think you also need a list of current children of the clock to allow
>> propagating rate changes from parent to children.
>
> This is added in another patch in this series implementing clk_set_rate.

Thanks, I'll take a look.

>> > +
>> > +static void __clk_unprepare(struct clk *clk)
>> > +{
>> > + =A0 =A0 =A0 if (!clk)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > +
>> > + =A0 =A0 =A0 if (WARN_ON(clk->prepare_count =3D 0))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > +
>> > + =A0 =A0 =A0 if (--clk->prepare_count > 0)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > +
>> > + =A0 =A0 =A0 WARN_ON(clk->enable_count > 0);
>> > +
>> > + =A0 =A0 =A0 if (clk->ops->unprepare)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->ops->unprepare(clk->hw);
>> > +
>> > + =A0 =A0 =A0 __clk_unprepare(clk->parent);
>> > +}
>> Are there any cases where the unlocked versions of the clk calls need
>> to be exposed to the ops implementations? =A0For example, a set_rate op
>> may want to call clk_set_parent on itself to change its parent to a
>> better source, and then set its rate. =A0It would need to call
>> __clk_set_parent to avoid deadlocking on the prepare_lock.
>
> I hope we can avoid that. The decision of the best parent should be left
> up to the user. Doing this in the mux/divider implementation would
> torpedo attempts to implement generic building blocks.

I agree it would be nice, but it does push some knowledge of the clock
tree into device drivers.  For example, on Tegra the display driver
may need to change the source pll of the display clock to get the
required pclk, which requires passing all the possible parents of the
display clock into the display driver.  If this is a common usage
pattern, there needs to be a hook in the ops to allow the clock or
clock chip to make a more global decision.

>> > +
>> > +unsigned long clk_get_rate(struct clk *clk)
>> > +{
>> > + =A0 =A0 =A0 if (!clk)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> > + =A0 =A0 =A0 return clk->rate;
>> > +}
>> > +EXPORT_SYMBOL_GPL(clk_get_rate);
>> > +
>> > +long clk_round_rate(struct clk *clk, unsigned long rate)
>> > +{
>> > + =A0 =A0 =A0 if (clk && clk->ops->round_rate)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return clk->ops->round_rate(clk->hw, rat=
e);
>> > + =A0 =A0 =A0 return rate;
>> > +}
>> > +EXPORT_SYMBOL_GPL(clk_round_rate);
>>
>> I think you should hold the prepare mutex around calls to
>> clk_round_rate, which will allow some code simplification similar to
>> what Russell suggested in another thread. =A0If you hold the mutex here,
>> as well as in clk_set_rate, and you call the round_rate op before the
>> set_rate op in clk_set_rate, op implementers can compute the rate in
>> their round_rate op, and save the register values needed to get that
>> rate in private temporary storage. =A0The set_rate op can then assume
>> that those register values are correct, because the lock is still
>> held, and just write them. =A0That moves all the computation to one
>> place, and it only needs to run once.
>
> This won't work in the case of cascaded dividers. These have to call
> clk_round_rate in their set_rate op for each possible divider value
> to get the best result. They can't do this when both set_rate and
> round_rate acquire the lock.

Then they call __clk_round_rate if they already have the lock?

> [...]
>
>> > +struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *name)
>> > +{
>> > + =A0 =A0 =A0 struct clk *clk;
>> > +
>> > + =A0 =A0 =A0 clk =3D kzalloc(sizeof(*clk), GFP_KERNEL);
>> > + =A0 =A0 =A0 if (!clk)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> > +
>> > + =A0 =A0 =A0 clk->name =3D name;
>> > + =A0 =A0 =A0 clk->ops =3D ops;
>> > + =A0 =A0 =A0 clk->hw =3D hw;
>> > + =A0 =A0 =A0 hw->clk =3D clk;
>> > +
>> > + =A0 =A0 =A0 /* Query the hardware for parent and initial rate */
>> > +
>> > + =A0 =A0 =A0 if (clk->ops->get_parent)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We don't to lock against prepare/enab=
le here, as
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the clock is not yet accessible fro=
m anywhere */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->parent =3D clk->ops->get_parent(clk=
->hw);
>> > +
>> > + =A0 =A0 =A0 if (clk->ops->recalc_rate)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->rate =3D clk->ops->recalc_rate(clk-=
>hw);
>> > +
>> > +
>> > + =A0 =A0 =A0 return clk;
>> > +}
>> > +EXPORT_SYMBOL_GPL(clk_register);
>>
>> If you are requiring clk's parents (or possible parents?) to be
>> registered before clk, you could put the clk_lookup struct inside the
>> clk struct and call clkdev_add from clk_register, saving some
>> boilerplate in the platforms.
>
> There can be multiple struct clk_lookup for each clock.

Sure, and that could be handled by clk_register_alias.  Most of the
clocks have a single clk_lookup.

>> > + *
>> > + * @prepare: =A0 Prepare the clock for enabling. This must not return=
 until
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 the clock is fully prepared, and it's safe=
 to call clk_enable.
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 This callback is intended to allow clock i=
mplementations to
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 do any initialisation that may sleep. Call=
ed with
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 prepare_lock held.
>> > + *
>> > + * @unprepare: Release the clock from its prepared state. This will t=
ypically
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 undo any work done in the @prepare callbac=
k. Called with
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 prepare_lock held.
>> > + *
>> > + * @enable: =A0 =A0Enable the clock atomically. This must not return =
until the
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 clock is generating a valid clock signal, =
usable by consumer
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 devices. Called with enable_lock held. Thi=
s function must not
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 sleep.
>> > + *
>> > + * @disable: =A0 Disable the clock atomically. Called with enable_loc=
k held.
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 This function must not sleep.
>> > + *
>> > + * @recalc_rate =A0 =A0 =A0 =A0Recalculate the rate of this clock, by=
 quering hardware
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 and/or the clock's parent. Called with the=
 global clock mutex
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 held. Optional, but recommended - if this =
op is not set,
>> > + * =A0 =A0 =A0 =A0 =A0 =A0 clk_get_rate will return 0.
>> You need a callback to update the rate when the parent or parent's
>> rate changes, which I would call recalc_rate, as well as this
>> init-type call.
>
> This is already done on framework level, I think in the clk_set_rate
> patch.

I'll comment there.

> Sascha
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 =A0=
 =A0|
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-5121-=
206917-5555 |
>
