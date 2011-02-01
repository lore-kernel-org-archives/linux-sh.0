From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 01 Feb 2011 17:06:37 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <20110201170637.GR31216@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<20110201155344.GF1147@pengutronix.de>
In-Reply-To: <20110201155344.GF1147@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 01, 2011 at 04:53:44PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Feb 01, 2011 at 03:24:58PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 01, 2011 at 04:18:46PM +0100, Uwe Kleine-K=F6nig wrote:
> > > yeah, didn't thought about multiple consumers, so (as Jeremy suggeste=
d)
> > > the right thing is to sleep until CLK_BUSY is cleared.
> >=20
> > A simpler way to write this is:
> >=20
> > int clk_prepare(struct clk *clk)
> > {
> > 	int ret =3D 0;
> >=20
> > 	mutex_lock(&clk->mutex);
> > 	if (clk->prepared =3D 0)
> > 		ret =3D clk->ops->prepare(clk);
> > 	if (ret =3D 0)
> > 		clk->prepared++;
> > 	mutex_unlock(&clk->mutex);
> >=20
> > 	return ret;
> > }
> But you cannot call this in atomic context when you know the clock is
> already prepared.

So?  You're not _supposed_ to call it from any atomic context ever.
