From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 13 Jan 2016 12:55:14 +0000
Subject: Re: [RFC v2 3/4] i2c: mux: demux-pinctrl: add driver
Message-Id: <20160113125514.GE1540@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TD8GDToEDw0WLGOL"
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
 <1452088285-6427-4-git-send-email-wsa@the-dreams.de>
 <CAMuHMdUuiuXPFJQpUB+Y3xF34KnqhzdZ+x-E7zL1ywp=sAQWXg@mail.gmail.com>
In-Reply-To: <CAMuHMdUuiuXPFJQpUB+Y3xF34KnqhzdZ+x-E7zL1ywp=sAQWXg@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +struct i2c_demux_pinctrl_priv {
> > +       int cur_chan;
> > +       int num_chan;
>=20
> This is always positive, so you can make num_chan and a few loop counters
> unsigned.

Nope, sadly not. cur_chan can get a -ERRNO, and the type of num_chan is
defined by the return type of of_count_phandle_with_args().


--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWlkkyAAoJEBQN5MwUoCm2hO0P/i2kkTTF0JhMYJiGLSVxsjTc
7p6IP4eF0m5P3sOo9gXMBRnIX4KnItDkHB6UG26qmrX4NWQOcL41/eVoN5ViCqgE
RhzX687owEW2Wq2SeFnIfF4CxFxEdscdVFqWIZHfbE4Tk90V1n4ON/pyO5CIz3bT
bdbPT4YK3oaxzp9dY3DLdauoPPMmBQRzv+jlqz8AMwRTYfrYIHZF7Qdn62XCxfg/
qKkXjoqQz28OZZU0VYSea/34HUBdQCtKbYqnogzjMCRsczy7IDFB1KMenm3IOz1R
7JYrZyu7HpT4SwFQ47EZ8kIzhh/vMRVJZ/mHxt1Dd7XQ/Rdlb7v3O7wTeV52OQSS
TZgjoAHkQI7radPr0fK05tp2KB7ii8fOB2jaJyX9STICacUhULovkgqzYBLX0JVc
jsow9DyrVE+MWEhAi91FFZ1zRQiyrD9yq8LP0SpFAwBPoRnmQ+CaKGlWsbAhivD4
SzUINhazD9QBpnS3U4GrqUHwD6iq+f5rWSuTkZGoNFIGeaLJXxzpHikQbW1E5GJD
y/OU7/TToyLTJZ3f6knFAbVurvFTASm1PUrEmjgU4/drJpn0gQSK9HHoPmQC/ycj
UerlsqWifabDscrvHP/bMn41z3LjqyMgagGVEhWihnpeoL1gXz/TD0bs9chEEMlQ
SmePXnocnwoxfFRRrUgx
=dqtc
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--
