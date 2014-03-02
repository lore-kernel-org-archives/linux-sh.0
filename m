From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 02 Mar 2014 11:59:56 +0000
Subject: Re: [PATCH v3 01/20] clk: shmobile: r8a7779: Add clocks support
Message-Id: <20140302115955.GA4021@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
List-Id: <linux-sh.vger.kernel.org>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
 <20140301135002.GA4307@katana> <3584854.kj2ZbTBvnM@avalon>
In-Reply-To: <3584854.kj2ZbTBvnM@avalon>
To: linux-arm-kernel@lists.infradead.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 02, 2014 at 12:35:50PM +0100, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> On Saturday 01 March 2014 14:50:03 Wolfram Sang wrote:
> > > +	cpg =3D kzalloc(sizeof(*cpg), GFP_KERNEL);
> > > +	clks =3D kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
> > > +	if (cpg =3D=3D NULL || clks =3D=3D NULL) {
> > > +		/* We're leaking memory on purpose, there's no point in cleaning
> > > +		 * up as the system won't boot anyway.
> > > +		 */
> > > +		pr_err("%s: failed to allocate cpg\n", __func__);
> > > +		return;
> > > +	}
> >=20
> > I have problems with this sloppiness. Writing the comment took probably
> > the same time as writing the proper exit path :) On the drawback side,
> > static code checkers will keep reporting this.
>=20
> Then static code checkers should be fixed :-)

How should they know if you 'return'? :) They will know if you BUG().
Which might be the better (read: more descriptive) option which would
save the comment, too.

> > > +	cpg->reg =3D of_iomap(np, 0);
> > > +	if (WARN_ON(cpg->reg =3D=3D NULL))
> > > +		return;
> >=20
> > if (WARN(!cpg->reg, "can't ioremap CPG\n"))
> >=20
> > ?
>=20
> We can probably remove this altogether given that the driver doesn't make=
 use=20
> of the ioremap'ed memory.

Okay. Was still a good place to advertise WARN() over WARN_ON ;)


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTEx07AAoJEBQN5MwUoCm2EwIP/jXCWvUo3RU6EZaZMpBV3Lxf
vYnVNGtCHLGc05eaCI9nHwUtNELVzRZ3FgJ3adqzO8goQidrRAuiDXOhtDPVQdRN
x2PlZMr0BWUOA27OZ/3RKnfGFnOOxoBIePZ0Se0f3pYvT/+PMaX54EOBwcuicu7E
JJvTxlVTXcP0dxGH9TvLphqR2Y6LuoWiiB4Cv16pX5n1PV9TTS8XqQIk1W5iT8h5
1Z/AHLBcSdyu717XNtorqPR/JTUWYZ9w7EQiaL9uSoK5VaOuHNqb/MnUNJ7D5pRW
G8CeS2XfZFagNd+hCCYOiT+FpFfjsXuquAYNUWsVHVKZNhziafoPWwYPCJyAgXzk
4C4YvjJSi/tFP3PIgjDB+7bfwPugHae77PCPzbgv/2tuFawk/CZr00WcYXIyX2cS
88N2Bu8KA1PNNNB9mPgmbYdVUj02jdUq9AYoTrNqGDw17Xt46S4zXeoSGxWgplYi
tsJhEAjjEYRat1IBX/2gjl44iJ25QOBnmlwImQdGDXY8MhU7Ex3mp+dxvs6PBj3Y
VeDmObzi3VVSeGaAinSwV+oW1Fx/qjx29EBJ1wXrf2O1aXzQpFe4f75Kjr7DYz/Y
CoAv9LrdCDO1QRQHAhvjj9vb6MwQRQk3JqY32d4N46jSmK7a33ZgPrTDKw3fxWLo
QPgHP3g7sQDkQgBL2vz+
=97zj
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
