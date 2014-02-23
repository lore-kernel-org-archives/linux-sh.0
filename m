From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 23 Feb 2014 12:35:20 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: fix clock index for i2c5
Message-Id: <20140223123520.GA3936@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
List-Id: <linux-sh.vger.kernel.org>
References: <1392844015-18024-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1392844015-18024-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2014 at 11:39:19PM +0100, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> Thanks for the patch.
>=20
> On Wednesday 19 February 2014 22:06:55 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa@sang-engineering.com>
> >=20
> > Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
>=20
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ping. This is needed for another series I will send soon.

>=20
> > ---
> >  arch/arm/boot/dts/r8a7791.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791=
=2Edtsi
> > index 1ab4f3d..3b2cdc8 100644
> > --- a/arch/arm/boot/dts/r8a7791.dtsi
> > +++ b/arch/arm/boot/dts/r8a7791.dtsi
> > @@ -731,7 +731,7 @@
> >  			#clock-cells =3D <1>;
> >  			renesas,clock-indices =3D <
> >  				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD
> > -				R8A7791_CLK_I2C4 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
> > +				R8A7791_CLK_I2C5 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
> >  				R8A7791_CLK_I2C2 R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
> >=20
> >  			>;
> >=20
> >  			clock-output-names =3D
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTCesIAAoJEBQN5MwUoCm2/9gP/jDDOO1ND7/pW0dNUcfWGce0
RpT60MOW5yR+zmNKl5MU4Qfr494i3kp4qnvpFFU3iRfB8L9juZAlkvXUyZ55k7nO
GRaw/bdi7mLLgwuCDSgx4CINTT3fdAkKqRxs5VNzoMkKlMICZikrSI6DY6TB8Dj9
ZTiUc179jD9n5PfXvG0ZFVh9LFC6KRKh6Kw6Jd9nIQSdnb3KI+zMbwzlwlJzC0Kr
WcII6YMDW5e+ve5yZZnkMhsiw9hl3UUSI5HEOIa2Vt0c7Zm1opofDbia0I+NSp6Z
Ane/1Bjfi/yRmbhVMVdWPcwivZQxJwIaGAfgrqJenjK7ZJ/NuaRCPZJZGNF55PFE
2NEu1bPcfv1cnfUlEcZRsnoJVhR3BrVUFE3qX4glYZGK3uaiLnE0cddzXWS1MXUu
9UOTSGQoSVYaUxKib2kQEPzhd40kSo9QJPB543vMJOdR/Bnz17Igcq+7xTBnljuP
6PkwZlX3g1KSeNlJuD9ldguu1dGyQKmbZ7vDBuKTRtoSAEVXe8CtGYJY1IQhEWFE
fnK4doNghS5emTF80/FJrhDGsdg5GkIaEX+02y1l06C1tdyAkMnon91UBWFS0Fb/
KSaloj/8aHm2SGgFdcAS6BKLgxUgE2WRr6IafWnaxGEZPL385hI7kGWBrI8fGGv2
ZpgWpbgLWBiAfw2E58ac
=hxPb
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
