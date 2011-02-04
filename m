From: Richard Zhao <linuxzsc@gmail.com>
Date: Fri, 04 Feb 2011 09:33:32 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <20110204093332.GA2347@richard-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<20110201155344.GF1147@pengutronix.de>
	<20110201170637.GR31216@n2100.arm.linux.org.uk>
	<20110201193201.GH1147@pengutronix.de>
	<20110201195604.GS31216@n2100.arm.linux.org.uk>
	<4D486B59.6010106@codeaurora.org>
	<20110201204330.GJ1147@pengutronix.de>
In-Reply-To: <20110201204330.GJ1147@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 01, 2011 at 09:43:31PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Tue, Feb 01, 2011 at 12:21:45PM -0800, Saravana Kannan wrote:
> > If the driver is calling clk_prepare() right next to clk_enable()
> > knowing it's been already prepared and will hence be "atomic" (this
> > is actually not true), then by your description, it's pointless to
> > call clk_prepare().
> Well not completely, as it increases the reference count.  The advantage
> would be that clk_enable counts addionally as prepare, so it would be
> impossible to unprepare an enabled clock.  And the other way round an
> unprepared clock would never be enabled.
> =20
> > If you want the driver to call clk_prepare() in atomic context
> > because it will be atomic in most cases -- well, that's wrong. It's
> > either atomic or is NOT atomic. There is no in between. If a call is
> > NOT atomic, it can't be called in atomic context. Long story short,
> > if you expect clk_prepare() to be atomic under any circumstance, it
> > beats the point of introducing clk_prepare().
> Well, with my suggestion it's atomic when certain precondions are given.
> IMHO that's better than "atomic in most cases" because the caller can
> assert that everything goes smooth.
> These preconditions are asserted when the driver writer is careful
> enough to stick to the API.
IMHO, clk_prepare is always called in non-atomic context, so it doesn't mat=
ter
whether it's really atomic or not. We don't have to make it as atomic as
possible.

Thanks
Richard
>=20
> Either my idea is bad or I'm unable to sell it appropriately.  Be it as
> it is, I will stop to make a case for it.
>=20
> Best regards and thanks for your try,
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
