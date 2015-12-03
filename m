From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Dec 2015 21:03:39 +0000
Subject: Re: [PATCH] i2c: emev2: add slave support
Message-Id: <20151203210339.GD8509@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SFyWQ0h3ruR435lw"
List-Id: <linux-sh.vger.kernel.org>
References: <1448842558-18654-1-git-send-email-niklas.soderlund@ragnatech.se>
 <1448842558-18654-2-git-send-email-niklas.soderlund@ragnatech.se>
In-Reply-To: <1448842558-18654-2-git-send-email-niklas.soderlund@ragnatech.se>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: linux-i2c@vger.kernel.org, ian.molton@codethink.co.uk, laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, linux-sh@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 01:15:58AM +0100, Niklas S=C3=B6derlund wrote:
> Add I2C slave provider using the generic slave interface.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund@ragnatech.se>

Looks mostly fine. Sparse says:

    SPARSE
drivers/i2c/busses/i2c-emev2.c:267:25: warning: mixing declarations and code
drivers/i2c/busses/i2c-emev2.c:289:25: warning: mixing declarations and code

Please fix.


--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYK4rAAoJEBQN5MwUoCm2+DUP/jdV2s72ywTC2UgciPonA5d8
9LBPPq9p2Guh8rowfTTH+E6//whz1CvIGWRZCzMD+Va5OqSzys2+Uo2vsyzhW3cy
E49T/H25fsz9VMUMMKHFX95FHnJqhow36B2T9lFi4Abqh322Du7kmtaNPNIpzqSW
VvvHaYGjMQQ8NWUHpzEpSTQtxk2JOIm3fl5tIe7ckIAI7YUb+Q9NF75BDNyQhRZ1
+UYc/nGuv2E/KWyLB2Cu6hYboW41QhKCdn2YA34+lffUDNbDb994M5mh0zJZq8ke
0sLT2VCrK+M8NfIFiefchT5hDRk9UXl21JuGvz7NhDNT6+ptRb+wiKsU8NEM6Y8M
qdb7sxQsCsVqC5t7hQqCcdUCjp4d2W+K1EdwQNi2WpQqNnkHxYwR3Tsa+EiYxpNw
9omh9/bBZ5au3m+fWaQ2PCkq2mJaYhIIVxbvTYrNm/VWHdbzPdLMtnP9dtcPKQUF
t+7N9K7BWIv+7hYURlFRmwTqLbuMR85sXdSTMvbFzIB2PPz+LUrJ28hTtqL2u2gY
0PpAJQoucY6df1J8+zt612skbYH4sQ0pMKwa6D4Vvg1tbWNNG3ivjtvMJo8Vdsf6
ik4dUUFYQf6VJu1adeHRYiXczDK5BXb4RFt5bTFnd4RJjPX7PUWOVlNeRcd2CHRu
jsJqCWc+tncEcVhrtikp
=GltJ
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
