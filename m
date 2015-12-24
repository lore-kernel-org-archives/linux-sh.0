From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 24 Dec 2015 22:25:40 +0000
Subject: Re: [PATCH 0/2] i2c: proper RuntimePM for the adapter device
Message-Id: <20151224222539.GA1624@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
List-Id: <linux-sh.vger.kernel.org>
References: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
 <CAKfKVtHt8BpakkffRp=_2GUxqK5JO0WCsizCrjtwH5hv+TWvWg@mail.gmail.com>
 <20151224084105.GA1548@katana>
 <CAKfKVtEmsrQT6x2p=Knz836iNXw3vwQyx1M_WJ=GJjVDgBjWFA@mail.gmail.com>
In-Reply-To: <CAKfKVtEmsrQT6x2p=Knz836iNXw3vwQyx1M_WJ=GJjVDgBjWFA@mail.gmail.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I think the below drivers
>=20
> drivers/i2c/busses/i2c-at91.c
> drivers/i2c/busses/i2c-designware-core.c
> drivers/i2c/busses/i2c-designware-platdrv.c
> drivers/i2c/busses/i2c-rcar.c
> drivers/i2c/busses/i2c-sh_mobile.c
> drivers/i2c/busses/i2c-hix5hd2.c
> drivers/i2c/busses/i2c-nomadik.c
> drivers/i2c/busses/i2c-omap.c
> drivers/i2c/busses/i2c-qup.c
> drivers/i2c/busses/i2c-s3c2410.c

They use RuntimePM on their platform device, not on the adapter device
AFAICS.


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWfHDjAAoJEBQN5MwUoCm2+LMQAKxyx3flsxIcA+9jWeZVPiXG
tiSc7Na+HIBGGU2Po+OCC5B57ob8yQTNg3G9MgO5PHaz69ni7CE/zePMw3z6X3Ob
q18k6dd+zPRasZBWfei2/ZSQYx/97X+aTWrfVSZUbS/kCxL7LYc4hQuCRG60NJcl
b44KciNfrji1CdwxSNDwWXyBvtwV4hl7aqMR9g++QbYsHjiii4A/sst3ZxH5A43U
GZjZa7pIAYlBLgEB13rbsfUg0AbTDXvFmx2kFT0ohVjgLaCFREGnQU6ZxFjRvf9k
sDmkpO28d6IBq9mUOBvS2fbapogStvevJi2OLz6dnmUIIbLkNAGEuryGFHY0n4BY
lRgghTVaBunhqLxJFNpYeawUgItLtpf24ImHRA7mLdyvlSlkHSUvbqGr/Mlz2zx3
rnizPuozhWYqIgBXegchbeitTDXDnHVOIagVwhCbJUnDitT38oJBiD4aVeLR9nZ6
p7PsQXVZ14+8He4lgjpA+poMBQltkak/VrNDeIZXiDCt6AgkKPHsg3HLTHvxQDKT
Vz69AsYcntMabUM/Jt8NQ6tluzk8EqTj3Lw6jbP5ZKezYhSNezV/PvfDyg6Ur2mS
IWk/eigOQ+7Mijc6fRL2Xludws2xz8pkkioFNWN8bBlGdDOyMsi3TqGTb5p7XsI7
id5jnmNcg+x7zScSKbma
=1TPs
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
