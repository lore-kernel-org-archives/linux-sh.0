From: Felipe Balbi <balbi@ti.com>
Date: Tue, 14 Feb 2012 11:45:21 +0000
Subject: Re: [PATCH 1/2 v3] usb: renesas_usbhs: (cosmetic) simplify list operations
Message-Id: <20120214114520.GD24201@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AAi0U5uflHqV1n1C"
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1202141133170.443@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1202141133170.443@axis700.grange>
To: linux-sh@vger.kernel.org


--AAi0U5uflHqV1n1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2012 at 11:37:17AM +0100, Guennadi Liakhovetski wrote:
> list.h already provide helpers to find the first entry and to move list
> nodes to the tail of another list. This patch simply uses those helpers,
> no functional changes.
>=20
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

applied, thanks

--=20
balbi

--AAi0U5uflHqV1n1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOklPAAoJEIaOsuA1yqREGm0P/3znk2QWQ96qu0JM9JLkc72e
FmKetRGZ/dWXUJ7q+/nSFqwaAarj+lnanqZihkC/ti9+OCRtkfhYPpeJ1xWEm7Tr
1x941tJ9POACYZ6pPsnhUKLVC97MPp6OGJRdlvqLANN6t4NkHNqyhRx5L/2c1WUv
8/cLSyYggKQYBcpBCo4TlB/A0cIOSf8TlUU7ogluFp4pf8nYRQzkLJ6UY9X0y3QY
fRFhPQQYT0dd6jNRCJbc8jgOrDzm34s5VhfxUhjFZfGuGmGHq+KMUi70t/jHKTfG
joJUWUV3zBXT04is9h7lMULAvVtEaKyJvI4Ds23hBl11kbxNWmKRUb0f0KwGO8yu
wpqEzTOsHBxqPxfguzDBPcWKvrz16fa+6CE1U1lvSnn4NerD86oG4TyrzSG2WM05
FWLk6km5R08CMLZsERGpql1pc8NyTsD8NcoDCVRqhCaj+26BikOjBBrjYmel+fuQ
ewlpBBK+Ii7FNq8qu5quxJZuNjGC5c2TRWrHklO2AVvdJEom0GF9o5TU3C07AJPX
dBGJSdeYD4tInjuugvHL4GRyIW3MAo67mRY1so1dDSkDw3LeJq3/ro7CYhSDAJns
MRaUKWx+S8bkDSe4PpGZvyt4M9Nym2PloY+GzAybUjpy9iCTdJxSJz4OZmQX48z6
i7Ldg+plZYHnDf19U4gh
=BQiG
-----END PGP SIGNATURE-----

--AAi0U5uflHqV1n1C--
