From: Wolfram Sang <w.sang@pengutronix.de>
Date: Fri, 16 Nov 2012 08:07:04 +0000
Subject: Re: [PATCH 0/5] i2c-sh_mobile non-urgent changes
Message-Id: <20121116080704.GC8464@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="c3bfwLpm8qysLVxt"
List-Id: <linux-sh.vger.kernel.org>
References: <5087C93F.6080601@renesas.com>
In-Reply-To: <5087C93F.6080601@renesas.com>
To: linux-arm-kernel@lists.infradead.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2012 at 07:55:59PM +0900, Shinya Kuribayashi wrote:
> Hello,
>=20
> This is the first batch to fix the i2c-sh_mobile driver.  As a first
> step, this comprises of the SCL optimization work and a simple fix to
> annoying spurious WAIT interrupt issue; in other words, this does not
> change tx/rx data handling logic.
>=20
> This driver has an architectural problem with send/receive procedures
> and needs a fundamental overhaul.  I've been working on splitting into
> logical chunks, but not yet completed.
>=20
> Patches are prepared against the vanilla v3.6.  I don't have a chance
> to give it a try with v3.6+ kernels myself, but tend to be optimistic
> about that.  I have been cooking these patches over a year, and they
> work perfectly fine with older kernels ..v3.4 so far.

Looks good to me, like the extensive patch descriptions. I am going to
apply it to for-next with patches 2+3 squashed, because after patch 2 we
would have a buggy state otherwise. Let me know if you are not okay with
that.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCl9CgACgkQD27XaX1/VRvmRQCfXzc00CVBZLg+AuZk3OxP0fZO
BksAn3vm5XRoBsn6g+Ygypk60WmSdb5n
=un8/
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
