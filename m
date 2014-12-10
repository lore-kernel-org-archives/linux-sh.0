From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 10 Dec 2014 14:19:12 +0000
Subject: Re: [RFC 0/2] i2c: sh_mobile: don't regress on deferred probing
Message-Id: <20141210141912.GA8247@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
List-Id: <linux-sh.vger.kernel.org>
References: <1418217709-26392-1-git-send-email-wsa@the-dreams.de>
 <CAMuHMdUwsUakz7S_7xCob4__wR-PXcdpZKTGx0i_6ZatDeSvXg@mail.gmail.com>
In-Reply-To: <CAMuHMdUwsUakz7S_7xCob4__wR-PXcdpZKTGx0i_6ZatDeSvXg@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> On Wed, Dec 10, 2014 at 2:21 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > Okay, here is my take on solving the problem found by Geert. I still do=
n't like
> > it much but it is not as bad as I expected it to be ;) Let me know what=
 you
> > think.
>=20
> Thanks, it's indeed less ugly than I would have expected ;-)

:D

> Note that in spi-rspi.c and spi-sh-msiof, any error returned by *_request=
_dma()
> is considered an error, and -EPROBE_DEFER is not handled specially.
> So it won't retry if the DMA engine driver isn't available, but just use =
PIO
> (until unbind/bind).

For historic reasons, i2c-sh_mobile uses subsys_initcall() and at that
time, DMA is never available. Converting to module_init() will just
create its own set of potential regressions :(

> Now we have a nice sample implementation, perhaps I should port it to
> spi-rspi and spi-sh-msiof, too?
>=20
> Let's wait and see for other comments...

Yeah, let's see first...


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUiFZgAAoJEBQN5MwUoCm2Q7sP/1YTHDqpbZaOprideN33fcwy
PJuVEfA8i8o859rmpDi/uNB4/BxKd9QDXTsDlRAbM020NLf5Q/d/JhDQ2AcvXz89
WORrW/PkOKPg4hCJnIRTc9gR+35/l9A2BAP7GmhnfBbLAlMZHdm1H5I1NrMTcWGC
xYtwvvevFDfDdexE5WkRdOvBknYgrYANNTAt6MS1fXTA4K9UsQPhjj0+swCVBirT
uBmNQY8Le9/PHROCd6h0CiQz2gNEosdV+OFKU6GT6Xjc9KoAA6mVa3Bhnp4h6Qzw
V/EcQJz43r2T70zdLo6AFz/0u0B4EtfpuH4u88Wg+C8haNnnkxoU4rIB4U5hnR84
xLPteVQcg9glvc8dwtUO7jwUDYNs/MUK3jewoRZY0T+mbMB0K0TgJ1nwSaVjao5j
TpBp2ZBhAmlzGOAc9/5HUUmKmwLBtWKrFYA1+3bXl/4asU6LyEQEZ2l2MY5nxN5W
MJkaeSlRT/cTplKaFXycN2AIqVGECxH+3pOcCWsd20dCnik77nnEfSA0lZPpr47Y
sC3vG0tiXRSOlGnINWGZuv2M3IUQgNgHRkNMwOasr0UlaM1ZLsf7+2UOwy6/JkPC
CkvFjBByqETCN1/Vk2iTDCfiW/1H6SMHFZGR5RttRwCa5rliWiJjKTUzRpKb+hj7
Gh/9iVcbl3sl8i4FLjuh
=nFbs
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
