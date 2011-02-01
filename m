From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Tue, 01 Feb 2011 19:32:01 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <20110201193201.GH1147@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<20110201155344.GF1147@pengutronix.de>
	<20110201170637.GR31216@n2100.arm.linux.org.uk>
In-Reply-To: <20110201170637.GR31216@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 01, 2011 at 05:06:37PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 01, 2011 at 04:53:44PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Feb 01, 2011 at 03:24:58PM +0000, Russell King - ARM Linux wrot=
e:
> > > On Tue, Feb 01, 2011 at 04:18:46PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > yeah, didn't thought about multiple consumers, so (as Jeremy sugges=
ted)
> > > > the right thing is to sleep until CLK_BUSY is cleared.
> > >=20
> > > A simpler way to write this is:
> > >=20
> > > int clk_prepare(struct clk *clk)
> > > {
> > > 	int ret =3D 0;
> > >=20
> > > 	mutex_lock(&clk->mutex);
> > > 	if (clk->prepared =3D 0)
> > > 		ret =3D clk->ops->prepare(clk);
> > > 	if (ret =3D 0)
> > > 		clk->prepared++;
> > > 	mutex_unlock(&clk->mutex);
> > >=20
> > > 	return ret;
> > > }
> > But you cannot call this in atomic context when you know the clock is
> > already prepared.
>=20
> So?  You're not _supposed_ to call it from any atomic context ever.
My motivation for a more complicated clk_prepare was to make clk_prepare
atomic when that's possible (i.e. when the clk is already prepared) and
call it before the enable callback in clk_enable.  Then everything
behaves nicely even if clk_enable is called from atomic context provided
that the clock was prepared before (or doesn't need to).

If a driver writer doesn't know that a certain clock might need to sleep
at some point he runs into an atomic might_sleep with your approach and
with mine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
