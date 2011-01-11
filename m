From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 11 Jan 2011 10:47:09 +0000
Subject: Re: Locking in the clk API
Message-Id: <20110111104709.GB11039@n2100.arm.linux.org.uk>
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

On Tue, Jan 11, 2011 at 11:39:29AM +0100, Uwe Kleine-K=F6nig wrote:
> A quick look into Digi's BSP (digiEL-5.0) shows they implemented
> something I suggested earlier here:
>=20
> 	static int clk_enable_haslocknchange(struct clk *clk)
> 	{
> 		int ret =3D 0;
>=20
> 		assert_spin_locked(&clk_lock);
> 		BUG_ON(!test_bit(CLK_FLAG_CHANGESTATE, &clk->flags));
>=20
> 		if (clk->usage++ =3D 0) {
> 			if (clk->parent) {
> 				ret =3D clk_enable_haslock(clk->parent);
> 				if (ret)
> 					goto err_enable_parent;
> 			}
>=20
> 			spin_unlock(&clk_lock);
>=20
> 			if (clk->endisable)
> 				ret =3D clk->endisable(clk, 1);
>=20
> 			spin_lock(&clk_lock);
>=20
> 			if (ret) {
> 				clk_disable_parent_haslock(clk);
> 	err_enable_parent:
> 				clk->usage =3D 0;
> 			}
> 		}
>=20
> 		return ret;
> 	}
>=20
> 	static int clk_enable_haslock(struct clk *clk)
> 	{
> 		int ret;
> 		assert_spin_locked(&clk_lock);
> 		if (__test_and_set_bit(CLK_FLAG_CHANGESTATE, &clk->flags))
> 			return -EBUSY;
>=20
> 		ret =3D clk_enable_haslocknchange(clk);
>=20
> 		clear_bit(CLK_FLAG_CHANGESTATE, &clk->flags);
>=20
> 		return ret;
> 	}
>=20
> 	int clk_enable(struct clk *clk)
> 	{
> 		...
> 		spin_lock_irqsave(&clk_lock, flags);
> 		ret =3D clk_enable_haslock(clk);
> 		spin_unlock_irqrestore(&clk_lock, flags);
> 		return ret;
> 	}
>=20
>=20
> I think the idea is nice.  At least it allows with a single lock to
> implement both, sleeping and atomic clks without the need to mark the
> atomicity in a global flag.

It doesn't.  clk_enable() here can still end up trying to sleep when
it's called from IRQ context - the code doesn't solve that.  All it
means is that the intermediate code doesn't care whether clk->endisable
ends up sleeping or not.

What it does do is return -EBUSY if there are two concurrent attempts
to enable the same clock.  How many drivers today deal sanely with
such an error from clk_enable(), and how many would just fail their
probe() call on such an occurance?
