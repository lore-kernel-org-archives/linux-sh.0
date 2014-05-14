From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 14 May 2014 16:13:30 +0000
Subject: Re: [PATCH] i2c: rcar: bail out on zero length transfers
Message-Id: <20140514161330.GF12911@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Pql/uPZNXIm1JCle"
List-Id: <linux-sh.vger.kernel.org>
References: <1399307781-23614-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1399307781-23614-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2014 at 06:36:21PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> This hardware does not support zero length transfers. Instead, the
> driver does one (random) byte transfers currently with undefined results
> for the slaves. We now bail out.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTc5YqAAoJEBQN5MwUoCm2EOIP/idHo3wJupbW9uR6fy03z4rq
j/HKTbZcbvGD4WN0YpTYA+vvEJlx9wDTQkZYVbSl+zbQdlVnj9vD5kncjLUjUjHd
jKkM9ETkLQhEKg0MrnKNiYLFJLZ0n8MFXHcRu0bVfMvOcl6z2eF+T1q8AHATmgEu
yOx3VSmo7nnje/Y2//RYeNFysENx0tj/vzEa0IbZ+MpgHgZKptpwWDozu53V+eaM
7uU2u7k99aZDua9XWvQlvov319CJcVBfOR/bGNHGy8IT/5cFU/kozs68q4o/RnJd
j+kL6Y1BeX4pdsyRjCsSpXhd8c4T+86+DEVdxTTrypsIKxV36c1OKetNgBeFui4e
5m7X/hE0f8weiW9p+/+a8u5kriE58IIDnmYdErCYLXMIYk4c4CBZac8U+Is3wh7Q
uEzOxYHB0TWh+z9sxEd//asIV5EI81FAYagcOd+9bVCkkJEgNALa3TPt6V4p/IaA
kKHqFxx9WnVUJ7AZan3OtCE1OVwTvlEQ2+ph57F5/7LipEJ2IEQ2h57jg2mDKtvg
UK7T/E3KVANnEfojPpC7Vd7NOcpeK/tbcXs4beVBRl85tjaf8ifyDgsGSJQwLUOR
LbWMlTUQjshX7ISKmkkgqRQVmFRH/IWOJtZQuGhCQRvmz4/nSeCgNK20QJSWiH1K
hwle+CJ+jeazhynSukR/
=/61M
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
