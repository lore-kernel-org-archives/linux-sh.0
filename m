From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 11 Mar 2014 17:46:51 +0000
Subject: Re: rcar-i2c: always reads a byte
Message-Id: <20140311174651.GD1179@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="g7w8+K/95kPelPD2"
List-Id: <linux-sh.vger.kernel.org>
References: <531F3686.7050808@codethink.co.uk>
 <20140311164043.GA1179@katana>
 <20140311172421.GC1179@katana>
 <531F488F.10309@codethink.co.uk>
In-Reply-To: <531F488F.10309@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 05:31:59PM +0000, Ben Dooks wrote:
> On 11/03/14 17:24, Wolfram Sang wrote:
> >>or you wait until I posted my IIC enablement series for Lager.
> >
> >I'll post it this evening, forgot to mention that.
>=20
> erm, I already posted patches for i2c on lager.

Yes, for busses 0-3. I'll send patches for busses 4-7. And those two
cores share the same pinmuxing, so you can switch from the current i2c
(rcar) core n to the IIC (sh_mobile) core n+4 easily.


--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTH0wLAAoJEBQN5MwUoCm23KsP/0xG3AH2uJuUgJhsFIigL48w
AoDXlizqBuNL2eeVZpXviEeNBOrF//vw3jX1g9tQSypWEz9Yrm9L46Pp/bn98sOi
i+sJeY3yEwvGLddJ7nJK4CrJ5ixlt+pUqeDScatpHJQ+8wZj8l2vwqegyIS+xMnH
zx1Q332hHhUYr1u0+mJcUkMb/lPpS2cadPqXCzvF1PXV9h1HP58dKOpOBXs+PhRZ
CxTrHLiAIu9rU/tTSUo1SeP9YWG//MoJdo5wEZaHBMFHXSFh/a2ZusAx7sbNyRaJ
nbWER12eNB+zx5+GS4PB4wMy7gPPEKAnVBkY39jWktnRZitnAkoC8SjKZR7kDpXG
iCXyw4f262u2JWRIQAu9TKhjkejjzfWARQc2doAE72eOUOzu3v3flzAmNySqnMEI
TxxmVTWsvKjoXJL7cktwx7+IFA6mcKzNqo9z/kxmK8Ns5ZmMxxj5PVXXN7rpMkIq
saBAxisBLL4i5gTlavJwnqGxqM5qy1npmDIIU7RQmI6KjcwNBOL/RNEZF3Wt3mQK
bToVMvMlK6Noy1A3LVt5fFsTKM8dXZ4Wpnn+FALHwcKd1v3zMwCzyrNxeqnFgBcJ
3wg668XlA6GGp/jC/Xqf1Y0mplJtfNk8zajb5XFGKYaJlCUwKyu6sBtX1BOwW1G6
AWD/0kOFXSsPr7cpGwdS
=IVnB
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
