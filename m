From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 07 Jul 2015 19:53:13 +0000
Subject: Re: [PATCH 2/5] i2c: emev2: add binding documentation
Message-Id: <20150707195313.GD1572@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8w3uRX/HFJGApMzv"
List-Id: <linux-sh.vger.kernel.org>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
 <2376548.GgBSKQ3Rxq@avalon>
 <20150707194313.GB1572@katana>
 <13947160.RNzBrc1uk4@avalon>
In-Reply-To: <13947160.RNzBrc1uk4@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I follow what is done for the other EMEV2 IP cores currently supported.
> > All cores I checked have PCLK and SCLK but only SCLK is referenced in
> > the DTS.
>=20
> Could you briefly explain what the two clocks are for ? Or point me to th=
e=20
> right documentation ?

PCLK is the APB clock. See R19UH0037EJ1200_SMU.pdf, chapter 4.13.


--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnC4pAAoJEBQN5MwUoCm2n/QP/igouX8vImGwfj1pioeQM3Wq
udBm/UQekeUkkmPBURf9fvxowrheDp2OJeM+eMYciKPes1TLuQQlRmdDNRPjROV/
D9JXSGH8aGuF+V2CLfgPkqI0AH4iOUGLDpaefEM0qxVTkRP3nvYK6SoGL4O6ZogO
mc4MknOJ3zOIl8Yiwkj993OQLPUz3DXEJ1L2JnBS3CE16VQZjYo92v/R5QjriO7k
ZWE8+hE4gKWOtIujmMEoB2glTejxLzhG0gYAqkd939Y6XwAN0S5vi9PrumFWFjbe
e89yBcy+FEq8JA1tMyYznwxgs9+9KC7piXcXT8HC4tDaPLqclnPVBKKuhlHRXIh3
SoJMJPp83mwhO4479kCbbPp6dAJLoRH9WNExT/i4GcaewMQiRSxyzOGTk3meAmmr
wZPXkSEjBkSxko2RKilF4m64+lY44KWkg3bzq34KbuJ/ROwaegN13RYQqvjkMMYF
Au64t/BOIE7tj2znynGgkL6TUssvddco74os9cRl7nUJbrbvG/18yY20WzCsAAYV
DMAtUPjCwp352tYviMFjjzqw6waU2djKRtT3MI1lnGbEbfaVt1SGqy8T2WPKg3qu
sN56TjYHoJKfInT4SR6RTPVdAhpyDYwixc9hL484hiTWYDdrDKVb+c6eYmxN0KEn
qT0rog/4GtXgRcfHJWIx
=Fsfm
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
