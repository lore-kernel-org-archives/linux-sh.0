From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Sep 2014 13:49:10 +0000
Subject: Re: [PATCH 0/4] usb: renesas_usbhs: fixes this driver in gadget mode (part2)
Message-Id: <20140910134910.GC667@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ncSAzJYg3Aa9+CRW"
List-Id: <linux-sh.vger.kernel.org>
References: <53F725E3.4050304@renesas.com>
In-Reply-To: <53F725E3.4050304@renesas.com>
To: linux-sh@vger.kernel.org

--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2014 at 07:33:27PM +0900, Yoshihiro Shimoda wrote:
> If we tested this driver as gadget, some issues below happened:
>  - Oops happened if g_audio.
>  - A usb enumeration may fail if we do insmod during connected the usb ca=
ble.
>  - A transaction will not finish if g_zero.
>  - A usb enumeration may fail after we re-connected the usb cable.
>=20
> This patch serias fixes them.
> This patch serias is based on Felipe's usb.git, testing/fixes branch.
> (commit id: 0b93a4c838fa10370d72f86fe712426ac63804de)

Can you start sending your patches as a thread ? It makes it easier to
find them. If you're already formatting patches to a directory, then all
you have to git send-email the difectory, instead of all files in that.

e.g.:

	$ git format-patch -o patches --cover-letter -4
	$ vim patches/0000-cover-letter*
	$ git send-email --to balbi@ti.com --cc linux-usb@vger.kernel.org \
		patches

With that said, do we need these patches in v3.17 final ? or only v3.18?
It's getting pretty late for v3.17-final...

--=20
balbi

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEFbWAAoJEIaOsuA1yqREewcP/j+JQF4nNuj6XRyfXUW5Dzu+
bpc9LPyGoMVgSrch2nrp2j6iMX7WMhug0CgULc/fNsub8Yd00B3c2pRbj/UnZ2mt
XY4wJU+PAIdOL8znScyEdPpXWia+aPePZSEtAQWT0oGt6kbDvlSziRgwBVGjLHrA
lJNYqN0/jY7khx5jIXcboc9pH1APHlYsyis45E6AbihSsWor83bnQOygJw40aXhg
wEo41pDGlJgyJyht+DWTrZnqrmat8/iN4QRDlZ5hFNDtBUOVRAN2ozpjlDZRYdNa
PHFCdiPQQVjpEkVp5Wel4xXpXS2CyBU8wtrSf2GNnmFSlXsPOuDDr3c4SbLgKw31
y8lz4fqZsNcSNEsNkp/RnGYIuS18SaCQXQvbBs+2msm1lrCtw+6rw5HAYCx9rcw6
phjRrku7RvG+P0q6hBGafNNwBJk3AI5bdSNPqRK0k8a0L3Iy5GFPrr0BODW5Ukmi
YG5bS2pCxmI9IZljr9Kt2d5thd2hzQLqqARDqcbv1YY2HHpOgNge3DWoIqOpfIsl
qzl0yPtAPfAnWUcT2fPmZxhYAs5tG7C2Y5fxPro0cB5tlG32AZrC34/lnCX5Tpfy
LcQIBvNjqZ7MudOKcObEbB+isoIpRBMZIa+OvE9Q97XyyvCtJ9uo32mfxmQFtV9Q
N92C0KsGFdCAnXCjlqkw
=mzTP
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
