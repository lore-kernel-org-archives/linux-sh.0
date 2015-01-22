From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 22 Jan 2015 14:23:49 +0000
Subject: Re: [PATCH] i2c: slave-eeprom: fix boundary check when using sysfs
Message-Id: <20150122142349.GC3413@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2/5bycvrmDh4d1IB"
List-Id: <linux-sh.vger.kernel.org>
References: <1421684575-6679-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1421684575-6679-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 05:22:55PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Due to a copy&paste error, the last byte of the shared memory was not
> accessible via sysfs.
>=20
> Reported-by: Debora Grosse <debora@mds.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwQf0AAoJEBQN5MwUoCm2Y2sQALAnL0i8Eq8SwgWHTG2FNHKB
Oz2HaTcw/g+xPMxIjJccxZrhPMQ/2y1LwbkMk8Df+jCNwpKWXJu3kKuubH2xqbFN
zb+LNho9bdAT2uhgSBLOQKkZMs1b3Pkxyh3gNFRACgICjRRjPyETRSaZrOhfYWR9
KO8Ly6H6EeCf4lUzgh3Z4gDwj/xuaFJ81Cd0bdIqjPYe81B2feG6HKROP/c/4OKh
a10L05nFqpBCUAHsERTag1qi6BdgivVzp/V6SbkuwNzABgNVF2PUYhX/sQTSRB8u
+c9MUmQSz2eO4wGDBvo8o/83GzbqpaMleiyFRO4qEOI2tE5FXI/qbXAXSnYPzLBs
U6lkADl6NVAr0o6EE9oQ96mMUwhnzq6077ph4q0ifwufQDBtiygvUanmht+co4Qo
6LfZVRTswawgVDsLKUOdiNPgA6rCMVjtJRE4pwhAAX00/Wtktl1MYncTp9NqGKSn
s+notoWzg8Ujno2hrT8vjhwJ0CsCmMdEPJ7Z8sxXU6PQ55VeTFBxVkUHnCk8q5jC
a7lel8ow1FIFVMQz/ZIgodxMzzvg6Sricozv/IUKJkpSz10AzV2Z3dM5IriQwZef
/w9D8GqRyQPqyqLuFGoTjc9dwkF9we3g7uXv9JFQ0uduUunUK89CXMX1PlQTg/hS
GnKndcGjmY+ppJE0zM+e
=SyrN
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
