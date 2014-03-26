From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 26 Mar 2014 07:04:01 +0000
Subject: Re: [PATCH] ARM: shmobile: Include at24.c in shmobile_defconfig
Message-Id: <20140326070401.GC2664@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="E13BgyNx05feLLmH"
List-Id: <linux-sh.vger.kernel.org>
References: <20140326051911.2461.88848.sendpatchset@w520>
In-Reply-To: <20140326051911.2461.88848.sendpatchset@w520>
To: linux-sh@vger.kernel.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2014 at 02:19:11PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
>=20
> The Koelsch board includes an at24-compatible EEPROM hooked up via I2C.
> To increase hardware support enable the driver in the shmobile_defconfig
> multiplatform configuration.
>=20
> Signed-off-by: Magnus Damm <damm@opensource.se>

I would have squashed those two patches, but still:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMnvhAAoJEBQN5MwUoCm2UgsP/RNH7TEkBlYzByHfbpHOkkxb
NyOUNWFQuCnD9Wf7cyMl6lFs7guKuIhxJWco8KSkj8T1gD4lY7WSYxFsrIldIUPC
+gwfOpJo5nzGzrSHOrFsyb7SFgOGs8GR1Bbevuh4a6IlobcQmzKaXvMXpP1rNJZi
VIQzB4iqCRbFMP7jesy35lz8m4OgyUIUObvXUV8YWpKrUOTXRQnEHk0wcaa5cjQ2
gZdp754o2UP9KVHQ2pe1qCjyDDcSpTTiRvyw13ZnQAw61kXNkg+EWUcJtxPzZ8Io
z2M2M2MIdOXSYmY+g3AJ9gpsKJQVXWGLAGU5i8s9kNsvFZ7U8yO18p5T+DPyPfZC
T+NWOR9T/F7d4cpOOgD26WcAEQKZwbQXdBJLjxR3/a0L0jrUhC5ZW0F12CnJEoq0
3IZ+LpITqsgdfhR1EU32r/q7lukFALiuoB9czt1QGt5540nwJkhVQOB57qUB4N7s
B7NW7PY2yBoMqfST+LvjDLH3NCs+HmB8sCzgItFXhkg0PrCbtttHT2spoiivi8mT
3uqoeSiMMOk8dakxj1E8ymJlqzg75kAJ3AOt7XXK7yJdbGbkHr1oiLxM1aWC1W5s
AhN9v9Lkid/UtXbdNjdy+I9Guiqj1Gtv/VGz/fYHxSV3YH8dHHRwNfwRe0wKd95O
qOGue3TQ1d7n5GDx+3ix
=VH0S
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
