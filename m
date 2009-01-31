From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 31 Jan 2009 16:56:05 +0000
Subject: Re: [PATCH] fix build failure w. gcc-4.3.3
Message-Id: <200901311156.06604.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1569162.vfuJW3OYm6"
List-Id: <linux-sh.vger.kernel.org>
References: <20090130102854.GA13640@roarinelk.homelinux.net>
In-Reply-To: <20090130102854.GA13640@roarinelk.homelinux.net>
To: linux-sh@vger.kernel.org

--nextPart1569162.vfuJW3OYm6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 31 January 2009 03:46:05 Manuel Lauss wrote:
> On Fri, 30 Jan 2009 11:28:54 +0100
>
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> > gcc-4.3.3 likes to have printf() and related functions to have
> > at least 2 arguments when the format string is not a constant:
> >
> > cc1: warnings being treated as error
> > arch/sh/kernel/setup.c: In function 'early_parse_mem':
> > arch/sh/kernel/setup.c:111: error: format not a string literal and no
> > format arguments
>
> Please disregard this patch:  turns out that Gentoo applied a patch
> which unconditionally enables -Wformat-security and produces this
> message.

that's incorrect.  the patch sets format-security on by default, not=20
unconditionally.  having the common kernel itself build with -Wno-format-
security probably is worthwhile.
=2Dmike

--nextPart1569162.vfuJW3OYm6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJhIKmAAoJEEFjO5/oN/WBRHoQAN51jYd2JAjJaz/WfG+iCkj4
htbu1QY/6dvZzHhJZDf7TY2BF61UQGg4uqBci7YodtCFGKWC5DFKX5XxKaMElLG4
hKxdmgVCqwXkg1hT1D5RbjwB6t2lJZfey5DJZG6xTSdNmokT5Gung07SuXSsgwDh
E/Ra+xfv8jPJNTo6FM2gP+3ZKTARHzAXZ5N02V/f/9u5pVnaGeTg9n5OmnKDq/VL
VGmpo9lJ1qOgzcbgG3ela8Y0jXCt367Bv6EsURaSGxlOVpvH/m6NbMc52rOLSz9P
TCo6rKVDc7j5+WRZnMEm32mQY6yPV0HZj6Mn/dUPmni3+/J+j99ngvfxM41nYBWo
apFXFhb6+bxnJvlmUoKWaXoG8ekTAZpIMZM07uy8qYQIPv3XOHoVGiCk7iOfwa6H
beNaZQxUgvN6mj7nHYghIRVxc28yJI9krHN7mXv4+GD86Rhw8/N9UiroZ5x8e0Rn
4yfx8A1AdKwVmdXp179xydhpxyBhRATih56LxXWlnDqIQWR7pJRm8QkaRtS4CCnl
YBw5jC0oGuaG7RZMxgWT21Hbe1JHY2cUitoKeIJ/dSck2zlaOIP5CwiLkGoQSMUD
zxRxd04UEKn5sOxHYx0E8k1IlzJ2wOBQwaNo9J7NhN8pwfZWo4Ynn4aEDP9hyPm/
ZwtdinwwqGtWcZ2eSBGH
=fkdh
-----END PGP SIGNATURE-----

--nextPart1569162.vfuJW3OYm6--
