From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 24 Feb 2014 10:38:32 +0000
Subject: Re: [PATCH 2/4] ARM: shmobile: r8a7791: add IIC(B) clocks to dtsi
Message-Id: <20140224103832.GC4445@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eHhjakXzOLJAF9wJ"
List-Id: <linux-sh.vger.kernel.org>
References: <1389082976-22254-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1389082976-22254-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >  			renesas,clock-indices =3D <
> >  				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1
> >  				R8A7791_CLK_SDHI0 R8A7791_CLK_MMCIF0 R8A7791_CLK_CMT1
> > +				R8A7791_CLK_IIC0 R8A7791_CLK_IIC1
>=20
> That's an arbitrary rule but we've followed it so far, could you please k=
eep=20
> the entries sorted by value as well, here and in patch 3/4 ?

OK, can do. Will create a less easy to parse diff, though. Another
question: What about loosening the 80-char rule and have four values per
line? This suits a 32 bit register much better IMO.

Thanks,

   Wolfram


--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTCyEoAAoJEBQN5MwUoCm2IqoP/i8wsS/Nbw2HOYfgltmPXXZA
tnpG5oLAUsWHj1ONZcq2zYrCLNQ2syNi2WUw4HXI5j9jzta4gdOowWlv/EhJq2az
Bv6890sGt3h7aMBqcNEz8lPvUZSsh7psJE6vooCSk/BP4shiq51LPyzo+DOYocmU
IOJ9CURv1Q7FHKsTKgOXJ1He+HhCyCwbnJWkzEmd9ehZuyXKQRIs2zkZ1f7isNEP
0xvG0bqCeRuAkVoK+CKKX+gjzsB+5rJ2RjTJ8I9SRQgU/ViCwMsM+hQh6KyQ5wY4
+jgk24AgbMXddOS92u+IyntSyG4DKaF8RcJkcyNyCC+TEw/bEmtGnSHrYSExohwM
8qgBc3fOv2WVIZeeps3JWmhOwMxQckEYXAeVO67Yo4OAvgKOBLLEBL5mhzyjh1h3
bWtnhZIV6nvjP2+2+MMxraEl38vPcXedOCyFpUQU4h9H8ulRczEYB/tWVugr9as/
+hR20uQKz914zGeBo0GsmQbKhd/tFh31r27YJw8ZomwjWLZHiB+4DnwbPZvT88v1
7d97+IVTkM0c8W2bJgSJeSdNHbmsNj6lnZaV/PKXGoSbQUP1693aKqlYwH37P7U1
+i6KJ9fhZzaXe3N04uuwn7aP5Nu8BZ2eXXGSJT2CwjcLUWqgSfpRy4aR+l7Lg6nk
kLkSLLEKxMfZXTQJoNpm
=g4va
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
