From: Richard Zhao <linuxzsc@gmail.com>
Date: Tue, 11 Jan 2011 11:15:24 +0000
Subject: Re: Locking in the clk API
Message-Id: <AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<201101111744.59712.jeremy.kerr@canonical.com>
	<20110111103929.GN24920@pengutronix.de>
In-Reply-To: <20110111103929.GN24920@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

2011/1/11 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Hi,
>
> On Tue, Jan 11, 2011 at 05:44:59PM +0800, Jeremy Kerr wrote:
>> > I object to this as one of the purposes behind the clk API is to allow
>> > power savings to be made, and unless we can perform clk enable/disable
>> > from atomic contexts, the best you can do is enable the clock when the
>> > device is probed and disable it when it's released.
>> >
>> > [...]
>> >
>> > Sometimes the only point that you know you need the clock enabled is w=
hen
>> > your driver has already been called in an atomic context.
>>
>> .. provided that the enable (and subsequent things that depend on the cl=
ock
>> signal to be valid) can't be deferred; I'm not sure how often this will =
be
>> possible.
>>
>> So, it sounds like the best approach is to provide an atomic clk_enable.=
 I
>> agree with Sascha that the clk_enable and clk_enable_atomic polarity mak=
es the
>> most sense, so how about:
>>
>> int clk_enable(struct clk *clk)
>> {
>> =A0 =A0 =A0 might_sleep();
>>
>> =A0 =A0 =A0 [...]
>> }
>>
>> int clk_enable_atomic(struct clk *clk)
>> {
>> =A0 =A0 =A0 BUG_ON(!(clk->flags & CLK_ATOMIC));
>>
>> =A0 =A0 =A0 [...]
>> }
>>
>> Paul: even though you mention that the atomic clocks are the usual case,=
 I
>> think that this way around illustrates the atomic 'restriction' at the c=
all
>> site more clearly. When the drivers don't care about the atomicity,
>> clk_enable() is fine. When drivers do need an atomic clock,
>> clk_enable_atomic() shows this requirement.
> I agree that we should try to make the clk api easy and consistent. =A0So
> if we can go the atomic way we should in my opinion.
>
> On i.mx the roots in the clk hierarchy are plls, so it would be nice to
> know how long it takes to enable these.
>
> Back when I implemented clk support for ns921x I had a clock that made
> me think that a sleeping implementation would be the way to go. =A0I don't
> remember the exact details. =A0(It was the rtc clk.)
>
> A quick look into Digi's BSP (digiEL-5.0) shows they implemented
> something I suggested earlier here:
>
> =A0 =A0 =A0 =A0static int clk_enable_haslocknchange(struct clk *clk)
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int ret =3D 0;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0assert_spin_locked(&clk_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BUG_ON(!test_bit(CLK_FLAG_CHANGESTATE, &cl=
k->flags));
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (clk->usage++ =3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (clk->parent) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D cl=
k_enable_haslock(clk->parent);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0goto err_enable_parent;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&clk_lock);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (clk->endisable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D cl=
k->endisable(clk, 1);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock(&clk_lock);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_disabl=
e_parent_haslock(clk);
> =A0 =A0 =A0 =A0err_enable_parent:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk->usage=
 =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0static int clk_enable_haslock(struct clk *clk)
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int ret;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0assert_spin_locked(&clk_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (__test_and_set_bit(CLK_FLAG_CHANGESTAT=
E, &clk->flags))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D clk_enable_haslocknchange(clk);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clear_bit(CLK_FLAG_CHANGESTATE, &clk->flag=
s);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0int clk_enable(struct clk *clk)
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&clk_lock, flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D clk_enable_haslock(clk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&clk_lock, flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
>
>
> I think the idea is nice. =A0At least it allows with a single lock to
> implement both, sleeping and atomic clks without the need to mark the
> atomicity in a global flag.
>
> In the meantime Sascha checked on mx51 how long it takes to enable one
> of the three PLLs: 50us. =A0Is this fast enough to accept disabled irqs
> that long?
A well running board will not enable/disable PLLs frequently. It don't
make sense. PLLs are normally disabled on request to enter low power
mode, rather not because all their child clocks are disabled.   So we
don't have to consider the time here.

Thanks
Richard
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Uw=
e Kleine-K=F6nig =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
