From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 03 Jan 2014 15:47:58 +0000
Subject: Re: [PATCH 01/15] i2c: shmobile/rcar: Restrict non-COMPILE_TEST compilation
Message-Id: <20140103154758.GF7132@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JcvBIhDvR6w3jUPA"
List-Id: <linux-sh.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385515117-23664-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2013 at 02:18:23AM +0100, Laurent Pinchart wrote:
> Hardware supported by the i2c sh_mobile and rcar drivers is only found
> on SUPERH or ARCH_SHMOBILE platforms. Restrict non-COMPILE_TEST
> compilation to them.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

Applied to for-next, thanks!


--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSxtuuAAoJEBQN5MwUoCm2ldIP/RbDAXHnGtRtBe35brJ0rvGV
qKPd5y6LtjdJaRdMnh4+5x43gmQzdy7vruBeaaS6b/N3ft3YlymeFOr/Gz/UICNZ
TCdW+MHAq7SiIS6b9NtmWP0Cu4RDqSx7bXq8Oqcviyra0WS9MI3p0lojGMDQ6wNw
fc6zEdxsuRMe7kqNkEGBG7fLghwxh5+t+s6XTp/HJyynJ7Do1EgB0Gr+fyE6m1x5
9EiqykZRpDDv0o9zDvTFBIHcG6gxoGdm/jMRkAuYofmhgm1B5QYIGAd5uZ1Ga/vQ
KFNPp998fqT7BhUChN5M5Ib5gl+gysxVnayD6s5dbyNdFweymq4/Yfk248J4275z
rzSBN/eXlUqE9Ta96dOkcUKJ+SJb9sp4RZVbQoh2zE76B3V79wx7StGVI63vPVEU
FRvNQXQFCvMVLJY4nPvDFBw+sdgc37zBYvGfouMKEFpjM5NsRtr0OHnnvgJddjvX
1/eCtgEb8HuSHBpF2qzhoxXIvQCnJB6Ii599VAUtRsvXSEvoUu7NKk6Vpke2LK5n
CymemXkYvLi7zdacf0ArMPxuqoqMwNfDoA3q2kidf2V0xwWGz30ijU4Un7ROJToK
/gK3uV9rC3YKoYIRq4i6WREO9YP333VPQe7Cdij7KNSzgWaYX1INyyanDNUzpLil
kdphQqEkykftG855fbgi
=PJhw
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--
