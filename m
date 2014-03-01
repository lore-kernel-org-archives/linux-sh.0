From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 01 Mar 2014 14:29:54 +0000
Subject: Re: [PATCH v3 04/20] ARM: shmobile: r8a7779: Add clocks
Message-Id: <20140301142954.GB4307@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="E39vaYmALEf/7YXx"
List-Id: <linux-sh.vger.kernel.org>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1393400016-23433-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2014 at 04:33:20PM +0900, Simon Horman wrote:
> Declare all core and MSTP clocks currently used by r8a7779-based boards.
>=20
> Based on work by Laurent Pinchart for the r8a7790 and r8a7791 SoCs.
>=20
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I wonder if patches 2-4 shouldn't be squashed? I think it would make
reviewing/finding typos easier.


--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTEe7iAAoJEBQN5MwUoCm2H0cQAK1zigOJDBDt0xJ8EL1nwq1F
tr5P4kmWpc2hPh/J6tlM1b1497o6JwGCddpOCnnCqZrYSaQ9rSET7QjRCVoD2fYr
X652ZiFDlLUqfdNUpzCIK7ROJNnc1tRbnOqLmm431yyLo0HVn25XXMy4qkRQ/amN
GPeIaVwY2cBb0umonB/6+jneNh+VZsLY4FRWAWO6Wgi7vbL+6wR5s08Q/+pek2Fg
kWm9uuo/3Yx2RWXrSCwd3YGk+zAVRRiT4BGhi4VN/to+HJ26u2YCR2ufJrope8Qm
REjwRCWcCjWW9FiF80OTna69JSxgR1+24lx/mrO+tgky5GDR2/AIxVgM23y3uc6C
3n4bst0+l8Otb7mxWqyva1EXSifP7WCr1u/0EiFBd8bhFErmjwyXazPiferlVvSl
mGDKyKa/o7YzwzzYCk3NiHlmJp3quDIM/GGtge8M7QfNBSAxOylDLBU5/FGa/M6B
Ibt+KVycA+EvLQFpxgHKRZO/KLhpa5qsikIinN7POEvcvhsZ910gfqmR3SYk/paM
lMFj3nlHH2bIQafVWFADpDg12voeqBHICM2GbhVvK73rAf3si7JX1vHC7x8ISFVg
+Z+L8wm7wZEuho97a6pqSpCvT2V4qY7Lsq+QrE+xwCHKnAM4bg+aNCRMgOgbgmqr
CdElChoPpOYrsyHK5tRs
=d1sH
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
