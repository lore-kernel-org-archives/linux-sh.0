From: Mark Brown <broonie@kernel.org>
Date: Thu, 27 Feb 2014 04:47:02 +0000
Subject: Re: [PATCH v2 0/6] spi: sh-msiof: Add support for R-Car H2 and M2
Message-Id: <20140227044702.GM9383@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LJm8egi4vkexsie5"
List-Id: <linux-sh.vger.kernel.org>
References: <1393323673-2751-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1393323673-2751-1-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Takashi Yoshii <takasi-y@ops.dti.ne.jp>, Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--LJm8egi4vkexsie5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2014 at 11:21:07AM +0100, Geert Uytterhoeven wrote:
>         Hi Mark,
>=20
> This patch series refactors the sh-msiof SPI driver and adds support for
> the MSIOF variant in the Renesas R-Car H2 (r8a7790) and M2 (r8a7791) SoCs.

I applied all these, thanks.  Laurent does make a valid point about the
fallback, though - can you please send a followup patch which addresses
that?

--LJm8egi4vkexsie5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDsNCAAoJELSic+t+oim9hBgP/iHXacMumX0+5zM6aT+wF+x0
jZEEdqxDa1elCmYkhu5s0bFW52qy70qOJ4I+lO43mc5lRx0DpE6F8pbaL3EaH4P9
h4Zkckzy7KczFaKZsp8pU3kLwKVc8uIZp4TAZV6ol/tShP5a7zpoiID6uNp5Mz3+
Zyhll4n9MsXXq9Ja9oM0uOkxiWNq8xtffHj+RXx3I7fcgO+5Z2xQd/ij8LuCjRzT
OiGjA03pP0Tiv4/d8pwA/h8b+VuqJti3paSX/YtJfJTPr4gsmCp2NoHRH1FiS2zL
5+xD/4vLtkR6IFqKudc3psoG/MhEpz2l29Kk1lhdj5+QSyNB057INTGtl3igOcT0
CWdTpdZ6cC4oZ15rlOLe3GJnP2Zfv+17yqWhJw9mPeBZ8L8pLttxLWM/4pdTT5GZ
x+tMB06x87cz735mRxIwMqMTzqy2nJUfWE/FanWfEV2l4GkiN7uqa4XLHuN0M6wp
SoAFkIX5sEfYQptgETkjljZdrho22SW34nlKG+4P0Z57D+F2+ljOmgVt//x7Hn2l
dgSgLqphEDmNOZisW62ooGqNLAHk7Y73Y4QEYsA48kFkLhxDHEXvRUMStdG4m1R9
eHDYxWOW/id5EkjcC+JUWGq40yfnmp5R6gUgii2qOSmvFxWbEh8dmwkYK0XDbCYp
HAEIgPJ7YGKBYCJvBBtx
=mBmY
-----END PGP SIGNATURE-----

--LJm8egi4vkexsie5--
