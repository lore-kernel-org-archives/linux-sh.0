From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 02 Apr 2014 11:51:31 +0000
Subject: Re: [PATCH 0/4] r8a779[01] I2C clocks fixes
Message-Id: <1841728.Xx32bYG3og@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1878821.C7CpjfpsBZ"
List-Id: <linux-sh.vger.kernel.org>
References: <1396350138-26850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396350138-26850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--nextPart1878821.C7CpjfpsBZ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Wednesday 02 April 2014 13:42:20 Wolfram Sang wrote:
> On Tue, Apr 01, 2014 at 01:02:14PM +0200, Laurent Pinchart wrote:
> > Hello,
> >=20
> > The I2C clocks select an incorrect parent on r8a7790 and r8a7791, b=
oth in
> > the legacy C code and in DT. This patch set fixes that.
> >=20
> > Laurent Pinchart (4):
> >   ARM: shmobile: r8a7790: Fix the I2C clocks parents in legacy code=

> >   ARM: shmobile: r8a7791: Fix the I2C clocks parents in legacy code=

> >   ARM: shmobile: r8a7790: Fix the I2C clocks parents in DT
> >   ARM: shmobile: r8a7791: Fix the I2C clocks parents in DT
>=20
> Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>

Thank you.

> CC on I2C patches would be appreciated.

Sure, sorry for having forgotten.

=2D-=20
Regards,

Laurent Pinchart

--nextPart1878821.C7CpjfpsBZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTO/nZAAoJEIkPb2GL7hl15RAH/ifx2rmDQDqTHcMqNmwhwO0t
Oy72Zg7vK18IhzDmHBmFsJJ2dXOiP6GBbqDaYGnFtZB5fYI2ZEjLY0YUzlZB+8Ez
3GUyzZeBr4KBUPKHT7yvnNnpt2Uc0t1sGKVFKi5vb4V+ELO2jspPY/TxaTOEwrH+
1YPjYlPy35sb1Bqnmqd1OvoBwHehtrLHqQMG6Y07p7Ook7oN9ZrTlyuk+NMBZyzC
a4XwFFNLx9w6r0Sy+CJd5noRj2IqUeWUUpFORY8xOANHkOoMiMyiVJN2kwh2mj+T
fQA2JKmme+QGH51RcPRlru0UGe7UbNxkz+OiGgvLPz5sKieMnYI3qM+OR1KZ+5k=
=Mjee
-----END PGP SIGNATURE-----

--nextPart1878821.C7CpjfpsBZ--

