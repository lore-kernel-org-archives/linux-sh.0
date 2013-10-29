From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 29 Oct 2013 05:03:49 +0000
Subject: Re: [PATCH 06/19] i2c: rcar: Enable the driver on all ARM platforms
Message-Id: <20131029050349.GC2643@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="c3bfwLpm8qysLVxt"
List-Id: <linux-sh.vger.kernel.org>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383004027-25036-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383004027-25036-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2013 at 12:46:54AM +0100, Laurent Pinchart wrote:
> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI and increase build testing coverage.
>=20
> Remove the explicit I2C dependency as the configuration option is
> already unavailable when I2C support is disabled.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSb0G1AAoJEBQN5MwUoCm2yMcP/0wG5MWVFr1oe8cR3fZBCYzd
2frWtA1dhtxCRhMWfjne/hsiMumv348FYjEc6bYWMm8TYMHNIzLO5zmUmeJyi3OU
aznVuUJiDeWTCwkk1EYAGJgT1/CZDjCuO5ED2BneEJ7hoU4Un3xW5t69nS+5ZVio
wAWS4SMkNhlzzUBuszemIxYNOssw/nAoIW5EGXyIFWUQkwzX1BMj6S2DIj96MxXv
fAB6ibUX1RSkOsEMyfwv4C0q6D1oAKxkGUK8SkQ+NSodAH3qVFXqEHAM03/60YOx
Eqj6jwKJQxbIbR87eoyRtJp6j97yXSIhT10wAn8KXZnS7WmwB13/Gr2KLnCTGn0Y
9p0KleqHQxBXE370m35thn8V48SR0sDXtXXiBs08iaa5UQSbWKsafyvw2yxMAONr
3a28B6UpCGVS+KDLh3kPKQc53qsv38TZhr/j9S/b0xQ5tjZEC7gBmQNxiRxDkY0N
zKvSwiQkQsIcDEjHMfOolCrq6Ipzm+YpRa9L1Tiw+gpUJuhqRWVxTJeEQgIr9CME
ZvdfBhj6vNhocRiM/DfKXVv27WqTOfrLNpYnp0idtteG1YA4WjpnCc6gaY4A7NFg
bvRhztP7t8I2r9tEwg1MrLF2UllmneuCBzTcbNTO3S5A9OXzWTldoyzVWJ/mlMUU
VGLJesmJ2Jcp5nzpqtsU
=qpOF
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
