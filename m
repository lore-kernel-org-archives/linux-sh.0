From: Felipe Balbi <balbi@ti.com>
Date: Mon, 27 Apr 2015 19:45:03 +0000
Subject: Re: [PATCH] usb: phy: rcar-gen2-usb: Fix USBHS_UGSTS_LOCK value
Message-Id: <20150427194503.GA25136@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
List-Id: <linux-sh.vger.kernel.org>
References: <1427973754-4868-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1427973754-4868-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: linux-sh@vger.kernel.org

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 02, 2015 at 08:22:34PM +0900, Yoshihiro Shimoda wrote:
> According to the technical update (No. TN-RCS-B011A/E), the UGSTS LOCK
> bit location is bit 8, not bits 9 and 8. So, this patch fixes the
> USBHS_UGSTS_LOCK value.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

this doesn't apply to v4.1-rc1, if it's still needed, please rebase.

--=20
balbi

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVPpG/AAoJEIaOsuA1yqREDvAQALP+v5AbHVi3DTYqAIPeAXg1
HK4t0UbfbTIN+o9F3QH+ngYOVWqRbvwusr0cQMFdTp8edKMuXruZIW7bu+yX7b1+
Mpv4tHIlm/MbADQDM8r09wzxOVZbWApXfRkX/1mkP5IASZD5SG69yRtyWpvdiGBh
mDw+g6A9/60i+TzhfOjitzi3emZ9tLD7lilBiylWgkGL+xOmkpxg0/vMmUlJvZ0Z
MEI55fXtA+As5FqN4CbBkan9TKmk+kfB3F3LKCKuSujMc6KylB/pgP7K/I4LqwPw
XLegGDJMksTMNwztSrqUFu+O3ylWy44rd2Y0Jjw/YjloOW76eGOJXZXpm7l3OE6k
TAufe8jgCwWzOfZ8XyGlEAXcdJPCxyJUzk3CDupwv4CwDMbFG44kfTmpRz1Js0yB
GoZns5++KoJJf5qGHy+FKJSvYFHHNgZhOp/rweLLquwcgH7/XMaPxRmx32LLb6Rc
K7L9KTuE2jp91RPmVL2AUsHEDHSAJAHTrMtp2emX+mq2lofpTCCOVfhfd407mS0H
wEAtsyymS9ehTE+gPDzVuBY8fkkuZa+GvHw2ZvzBEIXv9NsFEOJK9obBnqllav/z
gI5W4Tu73LzgbrC3VptrsPwxp8y3NAZlYxiddvxnIdZvtH2bCpbfy0LYG62xxAma
qvep2hisMOBonXuN6d5x
=gY3A
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
