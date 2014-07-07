From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 07 Jul 2014 06:13:35 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: r7s72100: Remove legacy board support
Message-Id: <20140707061335.GA2862@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
List-Id: <linux-sh.vger.kernel.org>
References: <1404318218-4732-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1404318218-4732-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02, 2014 at 06:23:35PM +0200, Laurent Pinchart wrote:
> Hello,
>=20
> Now that all features supported by the Genmai legacy and reference board =
files
> are supported using DT boot on a multiplatform kernel, remove support for=
 the
> Genmai board code and legacy (non multiplatform) r7s72100 code.
>=20
> This patch set is based on top of and depends on the Genmai MTU2 DT patch
> ("ARM: shmobile: genmai-reference: Enable MTU2 in device tree").

Acked-by: Wolfram Sang <wsa@sang-engineering.com>


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTujqPAAoJEBQN5MwUoCm20+MP/3eFV/gLttFQNLH5WuS5s/ls
B7SpbEf2XO1EIADHmoFcYB4a9drn9/AUkDJrZrYQj45Ipug3IviGo135QdLWXzfk
QHxe4MnFBBwZVw/0ZpONIckxu3sR8AgXgAqe/9n4uw7u+f6YGa6k39ckp7UUqkO+
g8Co/ILLI6GkZVQnJ46z0v7i2SyztzWdtVpK0CCMMb9nv+XpkuDXoPwlS02mcLcZ
EY3q0QdRVi1ntVl2cv8MrDLTAGr+4LQ5/DiJbEXMjI7Isz4xvBe52Z+dFslrVFz/
BhFTa3z3rQvsrzcGWI3VWfU5oomrQflMup9uos9jGW6VRNBOxtcHpo/r5jJ0O1/q
c726/dZW2yXZP0FALs5ynQmB2/mK//YIXlSS3soWu1oiQaolBaXdAzZRaIYGbjHn
8kBcV4bP1bGznXprWk1PUMte81yAsrmwetGHWqwCr0QUXR1Mn23NFjTLd2z9dgij
HI64D5UNWvQl8sUywGJUguTe8QAfGCSLpuBdFot7Jh2ioUYzZfizHrNwMaId/AtK
9I6H28HsksyXRhPL9VavwyZBANTbQfnMx7jVh7wsNgtgeogsx3JaCWS0wCvYzGFu
mHeUwNCZ6cw90PVvnWX6O1bt4Xl69v5/x2Amhm2a2J4iwl5dMnXkM7dqZsxHmVSW
V1JTWZDHQTtETiWYGWWN
=t0xA
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
