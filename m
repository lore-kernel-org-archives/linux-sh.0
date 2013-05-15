From: Felipe Balbi <balbi@ti.com>
Date: Wed, 15 May 2013 14:01:51 +0000
Subject: Re: [PATCH v6 9/9] rcar-phy: handle platform data
Message-Id: <20130515140151.GB26183@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="zx4FCpZtqtKETZ7O"
List-Id: <linux-sh.vger.kernel.org>
References: <201304231942.08507.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304231942.08507.sergei.shtylyov@cogentembedded.com>
To: linux-sh@vger.kernel.org

--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 30, 2013 at 11:02:18PM +0400, Sergei Shtylyov wrote:
> >BTW, conversion away from iowrite32() could (should) be part of a
> >separate patch. No need to prevent this one from being applied.
> >
>=20
>    Of course. You mean conversion to plain writel(), right?

right, "away" from iowrite32() ;-)

--=20
balbi

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRk5VPAAoJEIaOsuA1yqREI9wQALYSNXypx0dG3hH1L4c2h6vu
PsKOC5ucJgUZ2LxjC8E+5iLQHiMDtJifyWP3loPzyu1yRpSNvwCY/bD6SFX3eLOA
979iDK/KSp2BiRUIe1ALOerWItwhu2LAp17FLLorpD4zGMuypJ4R6Xd0m5Xh1y3I
3g2Nns6vSi/ToJY3y33HAxVM7233jUQC7aIKNy9Ygi7JauWLNB7A9sbIf92TqjER
8MTsBgeh0ztTmnPkK9wqHRRASm/5BTXcsVTjOT9WRswuiMdWNkRJmkFbx/Cww67N
DHiONKVERRsKHrYpxXI3PVhODbH4/jV1yHtUXihyYx4/+oOo/Q3hGGIPUdwq+zn4
9QNy0JzcrLlqcsN5XKl80jWuw31oabF0j7T+gPYcbTz3BaAfu1xAgNxlrTpsgu+Z
8i8e/DRMZ9qMgjKhXUY3YuLsM9e4CfL88C1sCCDkV6uNnqx/GXFdltKIJPCLQzuA
NYuVuGPVXaNu9rVXd83dAw1ibl6CuaXG3yo4cnUS8Sa5xDjcJKI5Jh438C17UAPs
O2reqh6bWkEMdAGBY+1e4qEv2SRVw3uerIMyfWh+BS0lamNHMj2TxpRe0K4vktZB
f19aQNwvQjQW+crjKba5qVwkUECbfjZ+WLAxgGJiR8rhr+bPnBAd4zoW3WF/CXda
w+PPUDkWAojmis5TiocW
=4ndQ
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
