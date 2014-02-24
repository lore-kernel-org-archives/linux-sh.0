From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 24 Feb 2014 11:36:40 +0000
Subject: Re: [PATCH 2/4] ARM: shmobile: r8a7791: add IIC(B) clocks to dtsi
Message-Id: <3971243.laxNKgqxOE@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2015249.6eATnK4iHO"
List-Id: <linux-sh.vger.kernel.org>
References: <1389082976-22254-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1389082976-22254-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--nextPart2015249.6eATnK4iHO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Monday 24 February 2014 11:38:32 Wolfram Sang wrote:
> > >  =09=09=09renesas,clock-indices =3D <
> > >  =09=09=09
> > >  =09=09=09=09R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1=

> > >  =09=09=09=09R8A7791_CLK_SDHI0 R8A7791_CLK_MMCIF0 R8A7791_CLK_CMT=
1
> > >=20
> > > +=09=09=09=09R8A7791_CLK_IIC0 R8A7791_CLK_IIC1
> >=20
> > That's an arbitrary rule but we've followed it so far, could you pl=
ease
> > keep the entries sorted by value as well, here and in patch 3/4 ?
>=20
> OK, can do. Will create a less easy to parse diff, though. Another
> question: What about loosening the 80-char rule and have four values =
per
> line? This suits a 32 bit register much better IMO.

I'd be fine with that. There has never been a strict 80-char rule for .=
dts=20
files anyway.

=2D-=20
Regards,

Laurent Pinchart

--nextPart2015249.6eATnK4iHO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTCy7IAAoJEIkPb2GL7hl1MeUH+gIGXlO1iQUqyFR7uYoU3pIV
s6lBMm4F9nm2vo9eGbI/VUhSmwAn5rkRfEa4nFNicBY9aVesvRNqPvQo6Xa7Vkpq
7bjFOIUqbVQKNro41MaThxawYlv7D6SeZl8XghfguhA2M5thI3PXHOfsOOowVEeW
yPA0qhv8sv0IZtjT+A7r/orYSq62WGnYqJLHxvuNYpqE7OCNF58dVxXpoUJ0wXCY
PH0sYTtEh1pNo79Fruh2hQALGrJhjNIQIgKiPIu/wSs0F6mNCU7mAXq1sjHZ+oaX
CUhjJCpNwq/uwNH7gtAj2mSR4TceKksn35YmA0aJHoYF4nJPUxCkcsIsUOaV+VQ=
=Elit
-----END PGP SIGNATURE-----

--nextPart2015249.6eATnK4iHO--

