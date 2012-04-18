From: Wolfram Sang <w.sang@pengutronix.de>
Date: Wed, 18 Apr 2012 14:08:39 +0000
Subject: Re: [PATCH] i2c: i2c-sh_mobile device tree support
Message-Id: <20120418140839.GD19220@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="zbGR4y+acU1DwHSi"
List-Id: <linux-sh.vger.kernel.org>
References: <20120330084402.19597.63655.sendpatchset@w520>
 <20120330084744.GF26543@linux-sh.org>
 <CANqRtoTERUznk7xYr5qHMP4X5cVbvUw9vLZ5X-6YFkmVf69m4Q@mail.gmail.com>
 <20120330090341.GG26543@linux-sh.org>
In-Reply-To: <20120330090341.GG26543@linux-sh.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, arnd@arndb.de, linux-sh@vger.kernel.org, rjw@sisk.pl, ben-linux@fluff.org, khali@linux-fr.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

> > Of course, if you think it is cramping your SH device tree style then
> > we can easily add a "renesas-shmobile-iic" entry as well.
> >=20
> I obviously don't mind if you wish to use the rmobile naming convention
> going forward, as the new parts have obviously dropped with the shmobile
> naming convention, and it's likely you'll even be able to infer different
> capabilities between rmobile vs shmobile. That's not sufficient cause to
> prefer one over the other though, so you're still going to have to keep
> things balanced. Simply having two aliases seems to me to be the easiest
> solution.

"alias" is a second compatible entry here? Is it okay if this is added
with a seperate patch when needed?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+OyucACgkQD27XaX1/VRvGZwCgllydWT6H/C8SndMvA979Gkyw
4j0An1vmbe4Lu1xTJRmKIfQwkxfNGAD/
=paZW
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
