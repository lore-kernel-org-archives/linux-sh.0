From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 04 Feb 2011 11:18:41 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <20110204111841.GG14627@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<4D48741F.8060006@codeaurora.org>
	<20110201212409.GU31216@n2100.arm.linux.org.uk>
	<20110204095424.GB2347@richard-laptop>
	<20110204104832.GE14627@n2100.arm.linux.org.uk>
	<AANLkTi=sfBTHLXejWxAWGa=Tcw+LoQfw6sUtcn6L+JeM@mail.gmail.com>
In-Reply-To: <AANLkTi=sfBTHLXejWxAWGa=Tcw+LoQfw6sUtcn6L+JeM@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 04, 2011 at 08:04:03PM +0900, Jassi Brar wrote:
> On Fri, Feb 4, 2011 at 7:48 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>=20
> > int clk_enable(struct clk *clk)
> > {
> > =A0 =A0 =A0 =A0unsigned long flags;
> > =A0 =A0 =A0 =A0int ret =3D 0;
> >
> > =A0 =A0 =A0 =A0if (clk) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (WARN_ON(!clk->prepare_count))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&clk->lock, flags);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (clk->enable_count++ =3D 0)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D clk->ops->enable=
(clk);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&clk->lock, flags=
);
> > =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0return ret;
> > }
> >
> > is entirely sufficient to catch the case of a single-use clock not being
> > prepared before clk_enable() is called.
> >
> > We're after detecting drivers missing calls to clk_prepare(), we're not
> > after detecting concurrent calls to clk_prepare()/clk_unprepare().
>=20
> I hope you mean 'making sure the clock is prepared before it's enabled
> ' rather than
> 'catching a driver that doesn't do clk_prepare before clk_enable'.
> Because, the above implementation still doesn't catch a driver that
> doesn't call clk_prepare
> but simply uses a clock that happens to have been already prepare'd by
> some other
> driver or the platform.

No, I mean what I said.

The only way to do what you're asking is to attach a list of identifiers
which have prepared a clock to the struct clk, where each identifier is
unique to each driver instance.

So what that becomes is:

struct prepared_instance {
	struct list_head node;
	void *driver_id;
};

int clk_prepare(struct clk *clk, void *driver_id)
{
	struct prepared_instance *inst;
	int ret =3D 0;

	if (clk) {
		inst =3D kmalloc(sizeof(*inst), GFP_KERNEL);
		if (!inst)
			return -ENOMEM;

		inst->driver_id =3D driver_id;

		mutex_lock(&clk->mutex);
		if (clk->prepare_count++ =3D 0)
			ret =3D clk->ops->prepare(clk);

		if (ret =3D 0) {
			spin_lock_irqsave(&clk->lock, flags);
			list_add(&inst->node, &clk->prepare_list);
			spin_unlock_irqrestore(&clk->lock, flags);
		} else
			clk->prepare_count--;
		mutex_unlock(&clk->mutex);
	}
	return ret;
}

int clk_enable(struct clk *clk, void *driver_id)
{
	unsigned long flags;
	int ret =3D 0;

	if (clk) {
		struct prepare_instance *inst;

		spin_lock_irqsave(&clk->lock, flags);
		list_for_each_entry(inst, &clk->prepare_list, node)
			if (inst =3D driver_id)
				ret =3D -EINVAL;

		if (ret =3D 0 && clk->enable_count++ =3D 0) {
			ret =3D clk->ops->enable(clk);
			if (ret)
				clk->enable_count--;
		}
		spin_unlock_irqrestore(&clk->lock, flags);
	}
	return ret;
}

I think that's going completely over the top, and adds needless complexity
to drivers, which now have to pass an instance specific cookie into every
clk API call.
