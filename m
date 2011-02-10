From: Richard Zhao <linuxzsc@gmail.com>
Date: Thu, 10 Feb 2011 13:08:00 +0000
Subject: Re: [RFC,PATCH 1/3] Add a common struct clk
Message-Id: <20110210130800.GB3316@richard-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1297233693.242364.862698430999.1.gpush@pororo>
	<4D52F73A.4010707@bluewatersys.com>
	<20110210100319.GB24710@b20223-02.ap.freescale.net>
	<20110210104639.GZ27982@pengutronix.de>
In-Reply-To: <20110210104639.GZ27982@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 10, 2011 at 11:46:39AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Thu, Feb 10, 2011 at 06:03:19PM +0800, Richard Zhao wrote:
> > On Thu, Feb 10, 2011 at 09:21:14AM +1300, Ryan Mallon wrote:
> > > On 02/09/2011 07:41 PM, Jeremy Kerr wrote:
> > >=20
> > > Hi Jeremy,
> > >=20
> > > Couple more comments below.
> > >=20
> > > ~Ryan
> > >=20
> > [...]
> > > > +int clk_enable(struct clk *clk)
> > > > +{
> > > > +     unsigned long flags;
> > > > +     int ret =3D 0;
> > > > +
> > > > +     spin_lock_irqsave(&clk->enable_lock, flags);
> > >=20
> > >         WARN_ON(clk->prepare_count =3D 0); ?
> > >=20
> > > > +     if (clk->enable_count =3D 0 && clk->ops->enable)
> > > > +             ret =3D clk->ops->enable(clk);
> > >=20
> > > Does it make sense to have a clock with no enable function which still
> > > returns success from clk_enable? Do we have any platforms which have
> > > NULL clk_enable functions?
> > >=20
> > > I think that for enable/disable at least we should require platforms =
to
> > > provide functions and oops if they have failed to do so. In the rare
> > > case that a platform doesn't need to do anything for enable/disable t=
hey
> > > can just supply empty functions.
> > It's possible to be NULL. So are set_rate/get_rate.
> > Ideally, if it's NULL:=20
> > prepare/unprepare: only call parent's prepare/unprepare
> > enable/disable: only call parent's enable/disable
> > set_rate: fail
> > get_rate: reture parent's get_rate
> > set_parent: fail
> > get_parent: fail
> I wouldn't hard-code the parents into the generic functions.  But I
> suggest to provide generic callbacks to do this, e.g.
Why? what restriction will it cause to add parent in clk?
Two benifits at least I can see:
1. null ops handle, as I said above.
2. export clock tree to user level for debug. It's very helpfull.

Thanks
Richard
>=20
> clk_get_rate_from_parent(struct clk *c)
> {
> 	struct clk *parent =3D clk_get_parent(c);
>=20
> 	return clk_get_rate(parent);
> }
>=20
> Best regards
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
