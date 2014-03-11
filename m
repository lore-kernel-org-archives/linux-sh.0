From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 11 Mar 2014 11:56:50 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <1551855.ylN84WQiIN@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2108228.ilkLqbBC90"
List-Id: <linux-sh.vger.kernel.org>
References: <5448979.WQPtOb56tW@avalon> <20140310123837.GB7227@katana>
In-Reply-To: <20140310123837.GB7227@katana>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org


--nextPart2108228.ilkLqbBC90
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Monday 10 March 2014 13:38:37 Wolfram Sang wrote:
> > I've recently reviewed a patch adding serial port aliases to the de=
vice
> > tree and would like to pick your brains about a disagreement I had =
with
> > the developer.
>=20
> And here is the developer :)
>=20
> > The SoC includes 8 serial ports. They are all disabled in the SoC .=
dtsi,
> > and enabled selectively by board DT files. As not all serial ports =
are
> > available on all boards, the question was whether to add aliases fo=
r all
> > ports (in the .dtsi in this case) like
> >=20
> >          serial0 =3D &scif0;
> >          serial1 =3D &scif1;
> >          serial2 =3D &scif2;
> >          serial3 =3D &scif3;
> >          serial4 =3D &scif4;
> >          serial5 =3D &scif5;
> >          serial6 =3D &scif6;
> >          serial7 =3D &scif7;
> >=20
> > or to just add aliases for the enabled ports (in the board DT file)=
 like
> >=20
> >          serial0 =3D &scif2;
> >          serial1 =3D &scif3;
> >=20
> > Note the numbering in the latter case: as the board doesn't use ser=
ial
> > ports 0 and 1, hardware ports 2 and 3 become logical ports 0 and 1.=

> >=20
> > I considered that having Linux create ttySC0 and ttySC1 devices for=
 the
> > first two ports of the board, regardless of which hardware ports ar=
e
> > used, is simpler from a user point of view (it allows sharing the s=
ame
> > inittab settings for the console serial port across several boards =
for
> > instance). I'd appreciate feedback on that.
>=20
> First, I don't think this is restricted to serial ports but how to us=
e
> aliases in general. We may decide this or that way, yet we should do =
it
> consistently. Using aliases this way for serial ports and that way fo=
r
> I2C busses will create a mess.
> And currently, I only know of 1:1 mappings for I2C/SPI. So, on the sa=
me
> board, you'll need to open /dev/i2c-2, not /dev/i2c-0.
>=20
> From my experience, things get complicated when stuff gets added and =
the
> numbers go wild:
>=20
>           serial0 =3D &scif2;
>           serial1 =3D &scif3;
>           serial2 =3D &scif6;
>           serial3 =3D &scif0;
>           serial4 =3D &scif7;
>=20
> When debugging here, trying to remember which port to open for the
> terminal, and which number to scan for in the schematics is error-pro=
ne
> and a PITA.
>=20
> Yeah, the drawback is that the console might be at different places
> across boards. I suggest to update inittab at runtime anyhow, since n=
ot
> only the number but also the naming often changes (ttyXYZ to ttyABC).=


Just out of curiosity (as I could use it), do you have a sample impleme=
ntation=20
of dynamic inittab updates ?

=2D-=20
Regards,

Laurent Pinchart

--nextPart2108228.ilkLqbBC90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTHvoIAAoJEIkPb2GL7hl1OLQH/1M49+kRL3Hnnc5mpuOHEQhI
2/EdvYCp8AR5b2SJZkx2emb7dK9FA7FejumwMjHKdv0weo5lWNwINoqF2X1xpICC
2/CtO15tEnV0yB2Bzj8SHMwnKvtho6efXn213kcWUXBjaDhEGW3T/b8WfLFxXQky
ykkhJYd/As9DGTli9UfkLx6+0Q5ZzW6DDOOQMPMyrUnhMfeq/wRKQJHDLcj8nFi+
Mn2fgqfDmYd/tsKG0e+76IS2jsV9QJ7tQ/RvteNBeYr2ATqVN83j9iBBx7QWxECg
cNY1recQX3/6hmyLH5A6Tp3hMc571jTWxwomyoJBIkCyIEzhzSSfDKx0H16lBmM=
=OC9W
-----END PGP SIGNATURE-----

--nextPart2108228.ilkLqbBC90--

