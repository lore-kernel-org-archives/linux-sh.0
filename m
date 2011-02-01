From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Tue, 01 Feb 2011 15:18:46 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <20110201151846.GD1147@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
In-Reply-To: <20110201143932.GK31216@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 01, 2011 at 02:39:32PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 01, 2011 at 03:18:37PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Feb 01, 2011 at 01:15:12PM +0000, Russell King - ARM Linux wrot=
e:
> > > On Tue, Feb 01, 2011 at 11:54:49AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > Alternatively don't force the sleep in clk_prepare (e.g. by protect=
ing
> > > > prepare_count by a spinlock (probably enable_lock)) and call clk_pr=
epare
> > > > before calling clk->ops->enable?
> > >=20
> > > That's a completely bad idea.  I assume you haven't thought about this
> > > very much.
> > Right, but I thought it a bit further than you did.  Like the following:
> > =20
> > int clk_prepare(struct clk *clk)
> > {
> > 	int ret =3D 0, first;
> > 	unsigned long flags;
> >=20
> > 	spin_lock_irqsave(&clk->enable_lock, flags);
> > 	if (clk->flags & CLK_BUSY) {
> > 		/*=20
> > 		 * this must not happen, please serialize calls to
> > 		 * clk_prepare/clk_enable
> > 		 */
>=20
> How do different drivers serialize calls to clk_prepare?  Are you
> really suggesting that we should have a global mutex somewhere to
> prevent this?
yeah, didn't thought about multiple consumers, so (as Jeremy suggested)
the right thing is to sleep until CLK_BUSY is cleared.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
