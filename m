From: Felipe Balbi <balbi@ti.com>
Date: Tue, 14 Feb 2012 11:46:03 +0000
Subject: Re: [PATCH 2/2 v3] usb: fix renesas_usbhs to not schedule in atomic context
Message-Id: <20120214114602.GE24201@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XIT9+HGZgTFaGwcE"
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1202141134580.443@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1202141134580.443@axis700.grange>
To: linux-sh@vger.kernel.org


--XIT9+HGZgTFaGwcE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2012 at 11:37:21AM +0100, Guennadi Liakhovetski wrote:
> The current renesas_usbhs driver triggers
>=20
> BUG: scheduling while atomic: ksoftirqd/0/3/0x00000102
>=20
> with enabled CONFIG_DEBUG_ATOMIC_SLEEP, by submitting DMA transfers from
> an atomic (tasklet) context, which is not supported by the shdma dmaengine
> driver. Fix it by switching to a work.
>=20
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

applied, thanks

--=20
balbi

--XIT9+HGZgTFaGwcE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOkl6AAoJEIaOsuA1yqREiasP/2PUr8YD4l57IZa50Mw+Jfk3
YWykW///oztjpeSCJao9MJviWrSAC571TWBdqPONyiFpzWpGP67D/hbR/KKu4YG1
WUYa8aJ3uLTT6eeNq+P1PUPVL8EArMKDuo28tV+fOwbNQEwf92U3g3pkGE/01oMf
btJh4YmM9Q3fG1DG9zLtE1TftsUy7rQw94YvDUlwmjIi/ISmxJyJODtx8XGi4vYk
wqwKG1XXSv+jpbzY+4B3n+lGQHlghxkLpykmoCFXOCVHiDdRhgBsemkt5TIqYjrJ
lIZ1w/SrwD2uNyEVBxt1oneulVCbtmOaGynSlGnEGEmXENIWO3ORoMyrXzYdHud/
EtT3fLWIe16cYZ/YQNj9tku8+zhKZcWVMbfxZk1Azf35xSZCcjHwwQWVxAS491g/
atH/ydBcLrtfra4uOGKrfr7wvPwszmr1KpUTVOtI1p+Xi4NTCJIdyXgfRTQUGfdv
jnPVFGxwMVUdizm973jFh1B/7pGZkBkY/ZT4Z9bL2OnHJu23Uv5CPsSCElfxLG8B
025zwzSYgT+RpUJTmSAHS6qZeH0wI9AUq7fFgfXyw/V3UHgMtrZGE9g0QCBl9ohh
vsdkbI/l1SdS2ijA14VM9Xilw6Kru6inwU41rQt2gJ4hUZvDqXcl1chpSS56TEDw
QjmL0akW3E9P3M2pZz/J
=wC/0
-----END PGP SIGNATURE-----

--XIT9+HGZgTFaGwcE--
