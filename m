From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 07 Mar 2014 16:37:36 +0000
Subject: Re: [PATCH V3 06/12] ARM: shmobile: r7s72100: add scif nodes to dtsi
Message-Id: <14375215.AZLobqST6Y@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4265553.HzsJuCG9lE"
List-Id: <linux-sh.vger.kernel.org>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <1930280.sZNcfhZEL8@avalon> <20140307162510.GF28943@katana>
In-Reply-To: <20140307162510.GF28943@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart4265553.HzsJuCG9lE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Friday 07 March 2014 17:25:10 Wolfram Sang wrote:
> > > diff --git a/arch/arm/boot/dts/r7s72100.dtsi
> > > b/arch/arm/boot/dts/r7s72100.dtsi index 6af5c28c670e..d49afe30c1d=
7
> > > 100644
> > > --- a/arch/arm/boot/dts/r7s72100.dtsi
> > > +++ b/arch/arm/boot/dts/r7s72100.dtsi
> > > @@ -23,6 +23,14 @@
> > >  =09=09i2c1 =3D &i2c1;
> > >  =09=09i2c2 =3D &i2c2;
> > >  =09=09i2c3 =3D &i2c3;
> > > +=09=09serial0 =3D &scif0;
> > > +=09=09serial1 =3D &scif1;
> > > +=09=09serial2 =3D &scif2;
> > > +=09=09serial3 =3D &scif3;
> > > +=09=09serial4 =3D &scif4;
> > > +=09=09serial5 =3D &scif5;
> > > +=09=09serial6 =3D &scif6;
> > > +=09=09serial7 =3D &scif7;
> >=20
> > As port usages is board specific, shouldn't this be moved to the bo=
ard
> > .dts file, with only serial0 =3D &scif2 ?
>=20
> Nope, the intention of these aliases is to have a consistent numberin=
g
> of SCIF cores, similar to platform.dev_id.

But do we want that ? Isn't it better from a user point of view to have=
 ttySC0=20
regardless of whether scif2 or scif3 is used when the board has a singl=
e=20
serial port only ?

=2D-=20
Regards,

Laurent Pinchart

--nextPart4265553.HzsJuCG9lE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTGfXQAAoJEIkPb2GL7hl1nzkH/3kmdAJ00/F6EItE/bj4x7aE
wLDIeIcF1x0PZ+DpBNjGn/EcQg1r85jROKp8tQH3i+DWx0G34CyZHV2rJdQTJigk
qr2F1oJIvxdgVmWc98HKbzVyYKtE0zZoSrRWGz1VQy0xRRj6AWjXRjwi0TNV3AEf
ddFKj1zg0IUBfDkfRSMuaNJ47/3GcZkM5EZSpsJmBf7RB0oPOR68Uk2OsaTaTWH4
INUja9VYDEz+fly/GTmjMyDWGSDyFf7YTCJhRWIBKIpupZPEr4KqeLEZU12j665t
EGxB76C7ljK47MYTpxLgWmqSO0QaFaUIhmUg0yVvQFdBq3J6yjLOo76HdTR7GQo=
=82wZ
-----END PGP SIGNATURE-----

--nextPart4265553.HzsJuCG9lE--

