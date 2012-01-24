From: Felipe Balbi <balbi@ti.com>
Date: Tue, 24 Jan 2012 09:36:28 +0000
Subject: Re: [PATCH v2 2/2] usb: renesas_usbhs: add support for SUDMAC
Message-Id: <20120124093627.GQ27414@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8HhMLSHvAouSipEr"
List-Id: <linux-sh.vger.kernel.org>
References: <4F054522.7000806@renesas.com>
In-Reply-To: <4F054522.7000806@renesas.com>
To: linux-sh@vger.kernel.org


--8HhMLSHvAouSipEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2012 at 03:37:22PM +0900, Shimoda, Yoshihiro wrote:
> The SUDMAC uses 8-bit width only. So, when the driver uses SUDMAC,
> we have to clear the MBW_32.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

applied, thanks

--=20
balbi

--8HhMLSHvAouSipEr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPHnubAAoJEIaOsuA1yqRE+O4P+QHSGuFht0mxfoz1USGEDo2H
bal2KkfS9WPoCTeXFYaltHeY9+xyHyEvbkDYZnPuc5t6BDvbgxynjNJ373QvOxZZ
T+jYYKOfox+b/PfqK1B/gQXnOH/PoFi9PX+QQSIaExF1nJrgA1EaRf/A178QS7zP
QV4g55gGsG27T8kmNz8hXErAFlbbGWaYbhkaELzJSdLwvrPsz1x/4xMu2qZvhXj9
MRsoSFRf8AG3xjgD8HhjQnpbeSvjS89IUjSMSHxqm4NIL/1mJn/MbvjFL42aOGQE
2N7TpYwJoXOJp8SG9aYFMwQUTWz6oJRYtIj2ll9/zNnxhzcQEX9NfQo+x72mCF9y
lyxDECYcEWLEKm4v2T1OHGrASQMwpcecVMstLGodaWxCUNTOJ6sTIJj7KDyzXT97
gwdYx4o6knhzMi0qddG+RecENjPVexl70Iv/1TvvNdBUX8tbS4wP5tYyWgcBjvIp
UabMgs9Kx2hPQEF+4vGYN0Yz7xj5b4VALSQcaSidXasvT542P+blKIWsMAZlRKij
Z6B+eqtTFSiwMF/E+Pim9szTR6vmR0Ensfe5NhApu2djFT9mEtwv3ZSuWGBPD0HI
Aq5a8zCoi2zOyJ3+1KTcqWkPZ73svOwM4e3kpXgvbSDdWUFq9OIHYmr0XAd9OPIF
5tRnWKcPYX9t3wnmlm/G
=vQrG
-----END PGP SIGNATURE-----

--8HhMLSHvAouSipEr--
