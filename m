From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 17 Jun 2015 10:43:27 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: r8a7740: move I2C errata handling into the driver
Message-Id: <20150617104327.GC1517@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="kfjH4zxOES6UT95V"
List-Id: <linux-sh.vger.kernel.org>
References: <1433834080-5630-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1433834080-5630-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2015 at 04:14:38PM +0900, Wolfram Sang wrote:
> This series moves the errata handling from the setup function into the dr=
iver.
> It has been tested that this changeset does not cause a regression on the
> armadillo board we had access to. Unfortunately, this board did not need =
the
> workaround at all, only some revisions of the r8a7740 are affected.
>=20
> After a short discussion with Simon, we agreed this should go via I2C.
>=20
> Wolfram Sang (2):
>   i2c: sh_mobile: add errata workaround
>   ARM: shmobile: r8a7740: remove I2C errata handling
>=20

Applied to for-next, thanks!


--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgU9PAAoJEBQN5MwUoCm2t9AP/RylrCgPlc/HW8KjkbaoOTYg
gxAvFOatDNN37c14dvXxjEokm1RL0QS66tiI12vlEi9S/CoPgf7dwtK/D+ZQGX/E
0dd2LoVld1+hDgIxEQg6xzWJXLZutzDizTBpvC5bjacbvlVOCAwYnXHZHG9uagNb
F2PmvpiKAcBi7yR8dJgpJFgajks9NjcLa2EV40jDqF+mGRJcSa1JatyMjhRPp7l8
HG1IFM/rkvBySszYZYUbpKuY2aFpfh6TjgjuU8e93zeYEfM1RBUSkFwj833B4upA
kR7Galo0o/maRojNauEM7YJRDK4H9hI/WxhIsbDKuBAjhap+ak8g8JcZiRxspRdt
z+g8XOMp8M/SW3PW4A+aZNUSR6F/r59TVeOFk/3rvZjBL8pRm+zJZ9p4pDm1MsWb
GDBv2IiKUgSR12FnfIVkozWStuE1CfBAgg1bBYv9DHUfKkFw1lH8RAYOKyeB0WDR
tcxtkFz+F2TQOzGGmytW/esESmSIxpOdVucDLoopSfbfhNBnqEmhZiRHyad8aoB/
7bbzKYt7wbF/77FLtTIYqiP9onofqryiGY6OGPMo6LJvFL0dcy3ktYxTMYzJJxSf
msg4rs0XoI5/GhR/ktoDrGwRyv4OCVkuDMKy7FzqQ9YvNed3dblraX7rX/zezBjh
1xGjzwMkR5LpRVfMdSdI
=KCSy
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
