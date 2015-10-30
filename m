From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 30 Oct 2015 08:02:10 +0000
Subject: Re: [PATCH v2] i2c: rcar: make sure clocks are on when doing hw init
Message-Id: <20151030080210.GA1589@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
List-Id: <linux-sh.vger.kernel.org>
References: <1446158791-29682-1-git-send-email-wsa@the-dreams.de>
 <1726774.W1OrN54TP1@avalon>
In-Reply-To: <1726774.W1OrN54TP1@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> First of all, I got one kernel panic.

:( I am starting to think i should revert my last i2c-rcar series until
these issues are gone...

> I have also seen different errors:
>=20
> [    1.177690] i2c-rcar e6530000.i2c: error -16 : 0
> [    1.182534] adv7511: probe of 2-0039 failed with error -16
> [    1.188293] i2c-rcar e6530000.i2c: probed
>=20
> -110 occurred as well.

I'd think you always get a -110 somewhere and all later accesses to
the bus will return -16. The bus is stalled.

> This occurred when rebooting the board by pressing the reset button, and =
if I=20

I use the reset button quite frequently, too.

> remember correctly moving from renesas-devel-20151013v2-v4.3-rc5 to renes=
as-
> devel-20151026-v4.3-rc7. Even though it occurred several times in a row I=
=20
> can't seem to reproduce this issue now I'm afraid.

Darn...


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWMyQCAAoJEBQN5MwUoCm2GLkQAIo1fYg5TewQg6Q9CZf/l7Sn
v158KyS2EyX3ssmraZM+FVTToEgOgAiUnKPQD7cPrqFBUakKd+WqfmtS+aOAJwzI
69dLyUgwxudeJ63MSl2y4ToCjtUWNuNCsAVbB1kuaobBXx0MBDo1jfD6uNyjxNtc
MEPDgt8wFXuOjyhBY1VB8mJKlJm1vrcnRrNUW5bSDLWGJKwP711rKhW6OjsDjs7T
lYE/gg/w7c5iyF2qUhGTCE2ghdzVjoV1rq/PRSDvRPOVZ4YKNiV1JbgjCktF7fdP
C+s0O0Do8WaVrPk6e/4bQSqLWRkHdvXxQ2tmYpdBgVJkC2E5+sPm5kH0SGThN4G4
W15MLNdDpUpuVCwXznr5FXPbxWdhcVwlJrpj18pNjJuce763MtCQwmpPQCUH7HL0
NKyg/PXp0a5EO9Q6fl4q4oHuUJlGJoPc2EwXbhAwy/CILJvxOTwXUOpbkbikJN0M
k/W0tRGNzpxtJbhLzex1UFpj2FKSk3BLaSjS0cj8NX+kCEEkfrGmvtp9Yiw7w+7P
zhwAlkLiyshKkLN0PPwZE7q8mF9fnW+smeacTe/pgoZ+KkMzNJ33cwZSr9hCWRd/
s5RhvaRsyHceDUM6Mfm4LJXWmB6A18h77Xrd9GDg2qSBnGQaRLf1x5p2XWHkOIvq
fCP9mFURM1eNgu+BI5EG
=SEQF
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
