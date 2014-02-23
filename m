From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 23 Feb 2014 19:29:35 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: fix clock index for i2c5
Message-Id: <2530376.vWT3YDl0Br@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart7258077.sgnhBYOdPK"
List-Id: <linux-sh.vger.kernel.org>
References: <1392844015-18024-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1392844015-18024-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--nextPart7258077.sgnhBYOdPK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Sunday 23 February 2014 13:35:20 Wolfram Sang wrote:
> On Wed, Feb 19, 2014 at 11:39:19PM +0100, Laurent Pinchart wrote:
> > On Wednesday 19 February 2014 22:06:55 Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa@sang-engineering.com>
> > >=20
> > > Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> >=20
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> Ping. This is needed for another series I will send soon.

Simon, I was expecting you to pick this patch up, were you expecting me=
 to=20
gather all clock-related board and dt patches and send you pull request=
s ?

> > > ---
> > >=20
> > >  arch/arm/boot/dts/r8a7791.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/boot/dts/r8a7791.dtsi
> > > b/arch/arm/boot/dts/r8a7791.dtsi index 1ab4f3d..3b2cdc8 100644
> > > --- a/arch/arm/boot/dts/r8a7791.dtsi
> > > +++ b/arch/arm/boot/dts/r8a7791.dtsi
> > > @@ -731,7 +731,7 @@
> > >=20
> > >  =09=09=09#clock-cells =3D <1>;
> > >  =09=09=09renesas,clock-indices =3D <
> > >  =09=09=09=09R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI=
_MOD
> > > -=09=09=09=09R8A7791_CLK_I2C4 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
> > > +=09=09=09=09R8A7791_CLK_I2C5 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
> > >  =09=09=09=09R8A7791_CLK_I2C2 R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
> > >  =09=09=09>;
> > >  =09=09=09
> > >  =09=09=09clock-output-names =3D

=2D-=20
Regards,

Laurent Pinchart

--nextPart7258077.sgnhBYOdPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTCkwfAAoJEIkPb2GL7hl1LGwH/1e0zT3G6QzGZ66UDK82yjm+
i/e7zTIQxEI5W/sBVyLkszT/VRW+cGgM86h3FLzioVVmwS9+k/kOObEWkPCIODfO
ifuRKfQoVX85y7Wb+RNbjhVifXVs2D/ny44u3YOKQkVsttqYmcq3fEGq3HrJDO/o
mKK/DPWqFDIOAmDWfQQHDcDQsBFjK/QG99UgiIgjxXzXj95ZQILv+ssEMf7hex+M
VL7djBzDODQwhA0tpiYbYUIi5WEaIEDO1kDfP6BdXTkQJ8myxru/SPBzB6lWvfzw
N3RtvtyQtmzuIX1WAJkG+jp0rrRPoWQJNUhm0mcIPtkFYapSin6oCR4RbFkDQTc=
=eh7e
-----END PGP SIGNATURE-----

--nextPart7258077.sgnhBYOdPK--

