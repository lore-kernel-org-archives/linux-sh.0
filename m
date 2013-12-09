From: Felipe Balbi <balbi@ti.com>
Date: Mon, 09 Dec 2013 19:41:33 +0000
Subject: Re: [PATCH V2] usb: phy: R-Car Gen2: Use usb_add_phy_dev
Message-Id: <20131209194133.GD28441@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SFyWQ0h3ruR435lw"
List-Id: <linux-sh.vger.kernel.org>
References: <1386618033-27670-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386618033-27670-1-git-send-email-valentine.barshak@cogentembedded.com>
To: linux-sh@vger.kernel.org

--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 09, 2013 at 11:40:33PM +0400, Valentine Barshak wrote:
> Use usb_add_phy_dev instead of usb_add_phy, so that devices can
> be bound to the phy. This is needed to set up USB phy for
> some internal PCI USB host controllers on R-Car Gen2.
>=20
> Changes from previous version:
> * Fixed function names in the commit log
>=20
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

Was this a regression on v3.13 or can it wait for v3.14 ?

--=20
balbi

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSphztAAoJEIaOsuA1yqREYMEP/RBvxV0f3tOrxkzDMqwtDw7w
dUF0ivAUC6k0RMGnQ54txJRxbHHKUz/1cFkxvJtTT2LRKkYG5OuW0FDlD+ec4NBI
SMdWS3we6wLDAoANYS3YV7wgfMmbR6I7Yaiy9ynXV3VOwp4t+l2U6hwwmn5q8S2+
dNu1m+WAqJx0/3XQ4AmjVK1P32nPqRhL6031P1oXWiZpw7o+cdhGcs/XEKfBJEXV
z+O+yEN0sGRuwySYi40xAB/bXVRoDUKuRqreIn0v1SlVohZMNpsW52cqUdPJ4aXd
+UQAJ4XUx2ZEFE0Fq0GZUQ4HyZ8mIwSBzbgheuckxpxD+S03CcavmniRWWQ1oPC1
wBZorPJgOcrS1ZIcSR8l+1KLXKFBUoZcwrJbybNhsim6llTUJLGgpO04YU9VmJIW
NlsxWXOGbVnCFvHLd9vz0aMK3tza3KmReSYAIZOnOKjalOb7CwH1nGUdblJaqKcv
uf5LXPcYz2P6xmIoAW8EBzE0LbDeYEZ3Fk3XuR3zBYfGLV+p2QC8Uv+qk8PxVKkK
vypwHtRRga84kwVykP5hLzhLEgjxm1P0zBDynBL1adXfPy2wZ5b3Oosl0Grs6RmP
4kmzCb1YPSgC2ITd6TrQIPZILWkEFtcbilBrDTKnccBi2N1n7kRUjmZUjJvyeLeh
8f9qFaJoUnglP3mqhVpm
=MYvP
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
