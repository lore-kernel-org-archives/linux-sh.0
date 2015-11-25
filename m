From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 25 Nov 2015 06:48:51 +0000
Subject: Re: [PATCH] drm: adv7511: really enable interrupts for EDID detection
Message-Id: <20151125064851.GA1511@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
List-Id: <linux-sh.vger.kernel.org>
References: <1448376627-12255-1-git-send-email-wsa@the-dreams.de>
 <20151124210501.GA1584@katana>
 <CANqRtoTAPU3zni__J2MQR+KK=SUUGYLgHz5j9s04CjEq55s3hg@mail.gmail.com>
In-Reply-To: <CANqRtoTAPU3zni__J2MQR+KK=SUUGYLgHz5j9s04CjEq55s3hg@mail.gmail.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > This has been tackled as well now. The clock for the GPIO controller was
> > off, so no interrupt was passed through.
>=20
> Thanks a lot for your efforts! When you have time, can you please show
> me the patch that fixes that GPIO interrupt problem? I'm asking
> because I may have ran into a similar issue on Gose or Alt.

For Koelsch, this simply meant I reverted Geert's clocks-off patch. But
there is a fundamental problem below: GPIO interrupts described with the
"interrupts" property in DT do not get the underlying GPIO requested.
And if noone else is using the GPIO block, its clock may be turned off.

I have an idea how to fix it, need to check priorities of the other
tasks, though.

BTW, the continous EDID read test on your board is currently at >360000
successful reads, a not a single failure :)


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWVVnTAAoJEBQN5MwUoCm2QrYP/RcD/Iv8ga2J6e5rYF1WB6t3
072J3JgP4RC5rkpMURmLvAijzC0LZxlH3xo5/8JCL+7OSkm/Q6xX0NlGJEC7fG02
62LVGijL0FnjbPHw2ruUbtJXBBSzreKe7eyO9j1eRYGXAWR6pOrO/RdNG0ZjNDPj
CMvt6njCfSTEigeUpLR8ZRv1unkjHpFgUaUblwl/6IphE6CgrSRR0BXhcIe0ofh6
jC3bQHP4LyNEUG9atJxqwDER0mGndIHfv5TNPLHos4EN2MopZdZBHN4tITHGmxH8
Sahfyv8hw0CP7UOM6jjPn2gFfvnELxd3VigBOX3un39sTyJJ2G23ZWB1IFhqXVtC
NMPdx2B/0EVOuwZu5231pFwGmf9VqLtNJyPyB4TYpfrbctsWVZ12i8LuGXrh+JZL
2EkjtmRKzQp3/rV+Ei1QXKx6qG174wP0AnrgPGdMwAg+k5FiGUoSoYmNOAcrwb4L
WuekQrSfiBfC7rgyBF/pC+xAeQs7Qukzy32sG5sUT28nE2bmwvGUJXtumng/fbsu
AQEjJr4TUsBwPtdvkRuC45Jua54V3VoIvwfk/5C9NAjZ0/cTXMbc8LF537tXHtQ5
tep6M0+bryN+xNHL5q31YidyUMYDxmNIoGD6WNMk9J9z3wLp1FWUu75LEMZ7vEiI
CBsjA2I2/fU6lXDZBRBY
=9My7
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
