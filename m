From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Mar 2014 16:25:10 +0000
Subject: Re: [PATCH V3 06/12] ARM: shmobile: r7s72100: add scif nodes to dtsi
Message-Id: <20140307162510.GF28943@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uTRFFR9qmiCqR05s"
List-Id: <linux-sh.vger.kernel.org>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <1394208048-32495-7-git-send-email-wsa@the-dreams.de>
 <1930280.sZNcfhZEL8@avalon>
In-Reply-To: <1930280.sZNcfhZEL8@avalon>
To: linux-arm-kernel@lists.infradead.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > diff --git a/arch/arm/boot/dts/r7s72100.dtsi
> > b/arch/arm/boot/dts/r7s72100.dtsi index 6af5c28c670e..d49afe30c1d7 1006=
44
> > --- a/arch/arm/boot/dts/r7s72100.dtsi
> > +++ b/arch/arm/boot/dts/r7s72100.dtsi
> > @@ -23,6 +23,14 @@
> >  		i2c1 =3D &i2c1;
> >  		i2c2 =3D &i2c2;
> >  		i2c3 =3D &i2c3;
> > +		serial0 =3D &scif0;
> > +		serial1 =3D &scif1;
> > +		serial2 =3D &scif2;
> > +		serial3 =3D &scif3;
> > +		serial4 =3D &scif4;
> > +		serial5 =3D &scif5;
> > +		serial6 =3D &scif6;
> > +		serial7 =3D &scif7;
>=20
> As port usages is board specific, shouldn't this be moved to the board .d=
ts=20
> file, with only serial0 =3D &scif2 ?

Nope, the intention of these aliases is to have a consistent numbering
of SCIF cores, similar to platform.dev_id.


--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTGfLmAAoJEBQN5MwUoCm2LnYP/R+4Om2eS9td5OyiiyNjfTTj
7nYzodQvQVQ8DjoW3lUeH78LulweXvyIZmYITgCudNeMEQ98d9kmT0xm/pbIf9N7
tMUfrUjGWURtmTve2rposK2R2rYurFtIaKangloa93rAy1n91UH7yil2iS/as0g0
JFDkI4UIo05XUNfKD5PLxGTBrFnC3vJJTbs/VYXICB/GegL1ILI/kgLT1N9XOLpX
LFDG4y+aV3HwTC3tfzdcX8K8Hiz+MpTTi3T98izcoIu0EvRwoEuPWT4iOqTvmXUS
t/SiIhpAcXH/7k7cBjkLVSl5mPoFrQogaoRMYxOQm590pl4yI+IK/pstuPVyG0TJ
Hhr0NXWoUlPajCz3EEOB/ckoBwYBYjUSSgMhstNYrLaDX4SFUOOGizSSgEIA9ohs
Y6jXnKCslRqlfka61JTB9phVbnoijaeK3qaC1HIQ2CX/SN2Id8hzI8wl0DNOFPko
oLJB0Nn9y7vPucOEFCriwy8g0qLEchozFB7HgI6rMTewhpBBBeFe0l+omCWzxi69
4l2Ae17Ur5dajtcbtQVvRgAX9Hs5x5vHfjPUfAIr04lXwD0t5f1MIGFOI4GbQJ6M
H3EzrONhfHWeUptK85IVe4f7Cf6dh6Jhss6i+KuxQ0/3u8H/cfJrjDtAbvTvC9lB
hND93PFq5yZ2EIqbrZrw
=AQqV
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
