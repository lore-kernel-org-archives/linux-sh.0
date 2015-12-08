From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 08 Dec 2015 13:03:23 +0000
Subject: Re: [PATCH v2 2/9] i2c: add generic routine to parse DT for timing information
Message-Id: <20151208130323.GB3359@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dTy3Mrz/UPE2dbVg"
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
 <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
 <1449572085.30729.28.camel@linux.intel.com>
In-Reply-To: <1449572085.30729.28.camel@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Too many && use_defaults. What about
>=20
> memset(t, 0, sizeof(*t));
>=20
> device_property_read_u32(dev, "i2c-scl-internal-delay-ns", &t-
> >scl_int_delay_ns);
>=20
> if (!use_defaults)
> =C2=A0return;

I like this! Thanks for the input.


--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZtUbAAoJEBQN5MwUoCm2zeYP/1eVl5nexcSPAmPVD+Lvmc21
xUafI5/pUKIX4QU8PhFfsLdZWEX4cEs8bHEyHCCQoM+aDc9aSkdZMHhcyW03p0Gi
JAiRZdyvqpt8e1aUqkHmXudfi2UbLD8iUPNnfA4ZMz7ifHyuZa39l4I26xOzWuqP
+nQCQph6oaD4+JBrElQh4BHL6ygb4ph/zoHd4Y/1kwviTmnhvjlzk6gqeXWIgRod
efnxVfra6qVVRCkbsYawbHZy4Cl0RYZr3D9Hi9wVAJDQKN2fFUF7Jfe0/l99xKMf
5kbqwkvyjAuX9ELkAmiOChL75hT9OpyrTtguXFOTj0aTzt2ZhxCzzMwIxQhw5plv
oGwV9LvSshU/yxpUpb4+ua9BYFYIts93CJgbS+FMS8zkbCnQEUU/msEhHpNDBWWT
nXwSbvuqKP2cLUqcpcSJnzGeY0A60q2Nt+lTwJA2NYtHLXqq9lddOmRlsFsvBEmm
XyasrHUdV7LCOfWVRhf9QzfiemTHWQhYfqcjtknyuKy/O+AA1kWg/FIJYzULvO1z
goyrXimwB+xF/VIfVrSsYVuJ0j9UGwE72kpMWL1407gd9HLRiJ0WeSU2EufwXHfR
MRTDi+XeKGrONt7L+96Ei6t13C8I63ky70WOwDTpYpziT/tfsxStiWKTpPMAyyCx
wPputZH/H4ebJKKDPWkg
=tYZ7
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
