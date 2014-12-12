From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 12 Dec 2014 11:07:35 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141212110735.GA5288@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <2462101.Er8OZg9N24@avalon>
 <20141211214732.GC21482@katana>
 <1729516.HWbfnj3Cpn@avalon>
In-Reply-To: <1729516.HWbfnj3Cpn@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, dmaengine@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Other than that, even if we move to module_init, we reduce the chance of
> > getting a deferred probe, but we do not eliminate it...
>=20
> Sure, but reducing the chance of deferred probe is a good idea in my opin=
ion=20
> :-)

Yes, that's a thing nice to have. It is just, I ought to work on "must
have" tasks first ;)


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUisx3AAoJEBQN5MwUoCm2u/sQAIUvjXAUWxypKRBan83ZC9LM
NkcXX7+vwfVYrnSpHqBUSZ/mY7Wr/oSM04FEgdLd2utgQY5Wr2KjxCDCQZM1laXB
vwNqYqhgHRnRzuAyXUQdFb9jbjmbevYNauCw2A4axrHDiGAK2Q0Xedycv0I/E+FF
qYulL9aqG76Xj62axsUy/HYd25cGStykGqPBWcVu9WkBvgeTRLv8afKwfMeMJBo7
d6ko8D2iSqy+M0FUuQPXs9mmsC5v6Vi9bSWwykUtZUssM7NGWFYruaF21by8H+jg
gMM1ijmZFTDGuXJiPmm4nxY2OjmOV0Od6/zVdD2ZtrnNAnoEOiGTXJm/8z1rVhAs
UZ5hUc4Sbjs0gZOWUoTOvO1as3xLpus33FEMvHH7pnhRf2p3cilMDn7wAAVZYhhY
CUougzXdOco6Ypw5rJ6U0xleiDCvV++RE/e9xbBK4qGKBWNzQfdAUOdeczRrsF37
ZsnhSwH2svjI4AH+7UaQPkl09Tasj1gwGs8KVP7UTRMQfcKQ8BXfKafXejT0b+I8
S6EGgv/tqX1b0895cJKDkvn6pMmWlBRfGlIKDPFYHIj0SoSjoL73MyLzMJ0xSAtb
svKRinNXjGPoD3g0KH9UvLpXojFwc8Q5cmUYb3JY/bwJVEEZ5nWHHrcpJFBU3iUF
ahz1VfAnPHWIH/R1JLKq
=0xc2
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
