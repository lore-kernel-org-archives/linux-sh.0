From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 04 Feb 2011 12:05:25 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <20110204120525.GH14627@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<4D48741F.8060006@codeaurora.org>
	<20110201212409.GU31216@n2100.arm.linux.org.uk>
	<20110204095424.GB2347@richard-laptop>
	<20110204104832.GE14627@n2100.arm.linux.org.uk>
	<AANLkTi=sfBTHLXejWxAWGa=Tcw+LoQfw6sUtcn6L+JeM@mail.gmail.com>
	<20110204111841.GG14627@n2100.arm.linux.org.uk>
	<AANLkTinB7jin5jDyNdTJYN2DZdTA3iJFvGJtsmtCUNsE@mail.gmail.com>
In-Reply-To: <AANLkTinB7jin5jDyNdTJYN2DZdTA3iJFvGJtsmtCUNsE@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 04, 2011 at 08:51:15PM +0900, Jassi Brar wrote:
> On Fri, Feb 4, 2011 at 8:18 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Feb 04, 2011 at 08:04:03PM +0900, Jassi Brar wrote:
> >> On Fri, Feb 4, 2011 at 7:48 PM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >>
> >> > int clk_enable(struct clk *clk)
> >> > {
> >> > =A0 =A0 =A0 =A0unsigned long flags;
> >> > =A0 =A0 =A0 =A0int ret =3D 0;
> >> >
> >> > =A0 =A0 =A0 =A0if (clk) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (WARN_ON(!clk->prepare_count))
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> >> >
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&clk->lock, flags);
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (clk->enable_count++ =3D 0)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D clk->ops->ena=
ble(clk);
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&clk->lock, fl=
ags);
> >> > =A0 =A0 =A0 =A0}
> >> > =A0 =A0 =A0 =A0return ret;
> >> > }
> >> >
> >> > is entirely sufficient to catch the case of a single-use clock not b=
eing
> >> > prepared before clk_enable() is called.
> >> >
> >> > We're after detecting drivers missing calls to clk_prepare(), we're =
not
> >> > after detecting concurrent calls to clk_prepare()/clk_unprepare().
> >>
> >> I hope you mean 'making sure the clock is prepared before it's enabled
> >> ' rather than
> >> 'catching a driver that doesn't do clk_prepare before clk_enable'.
> >> Because, the above implementation still doesn't catch a driver that
> >> doesn't call clk_prepare
> >> but simply uses a clock that happens to have been already prepare'd by
> >> some other
> >> driver or the platform.
> >
> > No, I mean what I said.
> Then, how does that function catch a driver that, say, doesn't do clk_pre=
pare
> but share the clk with another already active driver?

As per the code I just supplied!

> Because you said - "We're after detecting drivers missing calls to
> clk_prepare()"
>=20
> The point is, there is difference between detecting drivers that miss
> the clk_prepare
> and ensuring clk_prepare has been called before any call to
> clk_enable. And making
> that clear helps get rid of lots of confusion/misunderstanding. Uwe
> seems to have
> had similar confusions.

As I said on the 1st February.

> > The only way to do what you're asking is to attach a list of identifiers
> > which have prepared a clock to the struct clk, where each identifier is
> > unique to each driver instance.
> I am not asking what you think.
> In my second last post, I am rather asking the other way around - that
> let us not worry
> about drivers missing the clk_prepare and not try to catch those by the
> new API.

No.  That means we have no way to flag a call to clk_enable on an
unprepared clock, and will lead to unexplained system lockups.  What
I've been suggesting all along is the "best efforts" approach.  I'm
sorry you can't see that, but that's really not my problem.

> > I think that's going completely over the top, and adds needless complex=
ity
> > to drivers, which now have to pass an instance specific cookie into eve=
ry
> > clk API call.
> Exactly.
> All we need is to ensure clk_prepare has been called atleast once before
> any call to clk_enable.

I described this fully in my reply to Stephen Boyd on 1st February,
which is a parent to this sub-thread.

