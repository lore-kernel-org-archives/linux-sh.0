From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 11 Dec 2014 07:37:27 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141211073727.GA1252@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <CANqRtoTs52ORCqY43OyPJ2ME7BBcQr3+RVGURjteFQAztDSZjg@mail.gmail.com>
 <20141210080155.GA1148@katana>
 <10746939.zT8Pinqvll@avalon>
 <20141210142314.GB8247@katana>
 <20141211050226.GJ16827@intel.com>
In-Reply-To: <20141211050226.GJ16827@intel.com>
To: Vinod Koul <vinod.koul@intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, dmaengine@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I think this is a limitation of driver may not be for HW. The right model=
 for
> dma_chan is to be viewed as SW channels and not the ones of HW (yes that =
is
> how most of the drivers use that, but we can improve upon)
>=20
> If we rework the driver to view dma_chan as SW channels, then you can acc=
ept
> multiple channel requests and accept based on if we are able link the cha=
nnel to
> that peripheral or not.

In my understanding, the DMA driver does exactly that. However, it is
not even loaded at the time the I2C driver wants a channel, so the
dmaengine core defers the probe. That is the problem for optional DMA
channels: we can't know when deferring probe won't help anymore and
don't know when it is time to fall back to PIO.


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUiUm3AAoJEBQN5MwUoCm2ndkP+gPDbBbOcS/Hx5JDPz+xCH6L
KGtMAMTX1nmoOyjedY1Igv1PdvAMyEn6/DQTP3RpeVW01QAfMIDBxXRKDngIIMwu
ehrAlYoe0Z45vAjGMzCGUyJnx1y2EM8LRv0k2nymUw6224AFDOAASHDe25+Esxp1
qldeMa7HBfqt1HqX2SGoocgrlrERHG5cCz1HY4/C+qVkBtbLBfKnMDJtzvYk3leR
sjEM/JVFXtGFOrXdte2rtg4qrmW/qvN1P+D+S7pA/xWO6AM2df/is0flp9utUjzG
stnTn8U1RJRy8Wu+4aXAQcIPo+dCnMv98Z8a5Kk0t0fWpb0wOmkWrwZm3SgMhx6+
ULS9GSQckBC5JWAGR6FqDAqh1/Z9bZS6QtMUysVdixKHBqmKgQAqZimFGU2pmPjW
9ic5xQDfrO10sPnmNx6HLxaNsW/lwkoPjenC6rWqR3zUuhSuxwY8SL+81MlAhskC
GaZ0Bq7PKbg0O0BSEzmdbKdY832yJaKqeO2/VN0LVeepmG0g08fC4W9/mFP6Nbig
N9rjKsKh717+CaxA9npeQiR4qzrBMctbn0mi+XuTujxhwZxv/Mtr+ynFn8WMza63
cVXj77EmFqrcVIZKHJNX+ww51uJibJLb39XtWqQt+30AdzPAAGnQbMmuBkHEu5m3
N63vFokltQT9kp0/4t+s
=wGbu
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
