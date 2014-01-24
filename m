From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 24 Jan 2014 17:11:12 +0000
Subject: Re: [PATCH 3/4] i2c: rcar: do not print error if device nacks transfer
Message-Id: <20140124171112.GD2629@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="N1GIdlSm9i+YlY4t"
List-Id: <linux-sh.vger.kernel.org>
References: <1389982298-23143-1-git-send-email-ben.dooks@codethink.co.uk>
 <1389982298-23143-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389982298-23143-4-git-send-email-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, horms+renesas@verge.net.au, linux-i2c@vger.kernel.org


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2014 at 06:11:37PM +0000, Ben Dooks wrote:
> The i2c-rcar driver currently prints an error message if the master_xfer
> callback fails. However if the bus is being probed then lots of NAKs
> will be generated, causing the output of a number of errors printed.
>=20
> To solve this, disable the print if the error is not -EREMOTEIO.

Basically OK. Yet, according to 'fault-codes" it should be -ENXIO. May
be a good time to fix this as well.

Also, you might want to print for -EIO only? Or do you want to see
-EAGAIN, too?


--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS4p6wAAoJEBQN5MwUoCm2qdIP/2LExIrt+9GbGt0rvEAps+Ho
JmAXCkEpbSTfJde9kKRRjU0p/qxL14uHLlfxaqP3rR5nBNBrXlVVNJThpFEy5IMu
Lcc6/J8RZAso6o456lo3MTAVl0+BijF6q+25cnUxmP6Cr9TSQS7iOdYd+2XKEAv9
14jdU/TjKlq6IRpEbmSONmA34+uIY0iairapJ/Vo5lZ/mKvgR1LxN9ufSSR0sv1p
SfuUZLMhiRAxc7ZJ/0JN4f+DrJK/dUrCDQXEErt2IGiQaVKtzaZ2E7TpECQVFF1l
uwLrNYgjAlTS6HGnfqMITfpbwIzJaDZQdCvQuIh4pT591ejMO+HFWSCHrzUULoB5
USlxvF9e4S/lM4TfdQx+hzVxvuoNHJDtbGEHNIY2fgM1w3tfMnLB9guQL4Koxtm6
tru/+hwT78+zLTm83SG+n1dLQeyslDK9h932Fjq2vKUURXTnGZG6u9LCnAexi7Bf
il9RTJWvhsThpONHkRsRRvr0RNJBEOtiZ50aeMqwPVIV930mTL8TUocHo54uOtk6
Ovv1YfHAMBwnlROSjeesx6MDFGDFSr9sDR14+TLy3Ba2/wx7DF40hCaciw9s+xWl
qohiLuZ/XeMc2O7aUE6NhAquucveF3IUWOcl76WLiAr9SN3Bs9M/E3Tpvuk2J6gi
aNB3neV9dMLXayh2/XbQ
=nnRC
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
