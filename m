From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Tue, 01 Feb 2011 15:22:03 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <20110201152203.GE1147@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<AANLkTimayMAfr+zA6uO_yUmZqsOLmJ3fiiS696mL_evn@mail.gmail.com>
	<20110201140024.GZ1147@pengutronix.de>
	<20110201151418.GN31216@n2100.arm.linux.org.uk>
In-Reply-To: <20110201151418.GN31216@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 01, 2011 at 03:14:18PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 01, 2011 at 03:00:24PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Feb 01, 2011 at 10:05:56PM +0900, Jassi Brar wrote:
> > > 2011/2/1 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > >=20
> > > .....
> > >=20
> > > > Do you plan to handle the case that clk_enable is called while prep=
are
> > > > isn't completed (considering the special case "not called at all")?
> > > > Maybe BUG_ON(clk->ops->prepare && !clk->prepare_count)?
> > > Sounds better than the second option.
> > >=20
> > > > Alternatively don't force the sleep in clk_prepare (e.g. by protect=
ing
> > > > prepare_count by a spinlock (probably enable_lock)) and call clk_pr=
epare
> > > > before calling clk->ops->enable?
> > > That might result in a driver working on some platforms(those have
> > > atomic clk_prepare)
> > > and not on others(those have sleeping).
> > The first option has the same result.  E.g. on some platforms
> > clk->ops->prepare might be NULL, on others it's not.
>=20
> If clk->ops->prepare is NULL, then clk_prepare() better return success
> as it should mean "no preparation necessary", not "someone didn't
> implement it so its an error".
>=20
> Calling clk->ops->enable() with a spinlock held will ensure that no one
> tries to make that method sleep, so if people want sleeping stuff they
> have to use the clk_prepare() stuff.  It's a self-enforcing API which
> ensures that we don't get sleeping stuff inside clk_enable().
>=20
> And with a check in clk_enable() for a preparation, it helps to ensure
> that drivers do call clk_prepare() before clk_enable() - though it can't
> guarantee it in every case.
Full ack.  (I wonder if you misunderstood me or wanted to put my
statement into more words.  Jassi didn't like that a clk_enable without
a previous clk_prepare worked on some platforms and on others it
doesn't.  With BUG_ON(clk->ops->prepare && !clk->prepare_count) in
clk_enable we have exactly this situation.)

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
