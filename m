From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 06 Aug 2014 19:04:10 +0000
Subject: Re: [PATCH 0/5] i2c: rcar: add renesas,i2c-rcar-gen1/gen2 in DT compatible
Message-Id: <20140806190410.GC2736@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oTHb8nViIGeoXxdp"
List-Id: <linux-sh.vger.kernel.org>
References: <87silaw7t2.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87silaw7t2.wl%kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux-SH <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2014 at 09:39:27PM -0700, Kuninori Morimoto wrote:
>=20
> Hi Wolfram, Simon
>=20
> These patches add R-Car generatoin level
> DT compatible on i2c-rcar driver and platform.
>=20
> Kuninori Morimoto (5):
>   i2c: rcar: add renesas,i2c-rcar-gen1/gen2 in DT compatible
>   ARM: shmobile: r8a7778: add generation level compatible for i2c
>   ARM: shmobile: r8a7779: add generation level compatible for i2c
>   ARM: shmobile: r8a7790: add generation level compatible for i2c
>   ARM: shmobile: r8a7791: add generation level compatible for i2c

All patches:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Simon: Shall I take patch 1?


--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4nwqAAoJEBQN5MwUoCm2NEoP+wbA+mzQm1EGd0iki4Axmf5h
+PO2QzGo6cR0ned++5gd7dnUK25ui45paRLI4b38R3T6He57KQOuwP021lEl17pQ
B3h1iIsighSVIkD7q1BZNZm0ExPbvH7LX5TFv5CKTVFMnPWEdbVTSZ3mLuJvNxtv
/xB2tTHAdwRPW3Nvu7U/fcdHF5PZVUDzDwr7JF+UM0jnxde4xsxRVzVZlbowSwmL
IU6m0AHK+HMxTqjns+MRBv8tG9GoGVljAUQ/5p5sevkrWHbXCYwMzymi08EaBJ8s
DIFwgL8051PMquYu3e+3DHU9usf2ekDlUqUK7BxncqF/XpvNipIcQipgG9leYme4
/zaE9trwlRqagryRzCtqzz8HH1zQXelR1MV1QNV1waVSw4gpU85Ie7byx+48Fx0i
tWqSem/Jsx8GEju1baZLcJPPgs9HDyVnho9RIe2W3pEzGcx26hepZQJADitMm2I3
D+9xdi1eqBwDEDr7a/ILd5V/txV9RE49BKtpALdC10dy7L3IUgNJlmN0oYryJuwd
W+Sw7QiTpVa4un4k8NJBLUdaJiNVlgidFAInROmXZASUZvGhm4g1qjT9SDJ+Yd55
vlt6XtwilgyTJvf0HcttSR2L0hYXXxqNgltI5mQHVrYnBtnWNTpS5oYfpAXo7MAE
9FpcgBouahzbnhzHs40r
=fwfc
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
